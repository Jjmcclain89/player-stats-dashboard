'use client';

import React, { useEffect, useState, useMemo, useTransition, useRef } from 'react';
import { useVirtualizer } from '@tanstack/react-virtual';
import { PlayerStats, PlayerDataStructure, Player, FilterOptions, AllEvent } from '@/components/shared/types';
import { applyFilters } from '@/components/shared/rankingUtils';
import { SearchBar, normalizeText } from '@/components/SearchBar';
import playerDataJson from '@/data/data.json';

interface PlayerWithRankings {
  playerId: string;
  player_info: { full_name: string };
  stats: PlayerStats;
  rankings: {
    events: number; day2s: number; in_contentions: number; top8s: number;
    overall_win_pct: number; constructed_win_pct: number; day1_win_pct: number;
    day2_win_pct: number; day3_win_pct: number; limited_win_pct: number;
    drafts: number; winning_drafts: number; trophy_drafts: number; '5streaks': number;
  };
}

const STAT_CONFIGS = [
  { key: 'events', label: 'Total Events', isPercentage: false },
  { key: 'top8s', label: 'Top 8s', isPercentage: false },
  { key: 'in_contentions', label: 'In Contentions', isPercentage: false },
  { key: 'day2s', label: 'Day 2s', isPercentage: false },
  { key: 'overall_win_pct', label: 'Overall Win %', isPercentage: true },
  { key: 'constructed_win_pct', label: 'Constructed Win %', isPercentage: true },
  { key: 'limited_win_pct', label: 'Limited Win %', isPercentage: true },
  { key: 'day1_win_pct', label: 'Day 1 Win %', isPercentage: true },
  { key: 'day2_win_pct', label: 'Day 2 Win %', isPercentage: true },
  { key: 'day3_win_pct', label: 'Day 3 Win %', isPercentage: true },
  { key: 'drafts', label: 'Total Drafts', isPercentage: false },
  { key: 'trophy_drafts', label: 'Trophy Drafts', isPercentage: false },
  { key: 'winning_drafts', label: 'Winning Drafts', isPercentage: false },
  { key: '5streaks', label: '5+ Win Streaks', isPercentage: false },
];

const RECORD_KEYS: Record<string, (s: PlayerStats) => string> = {
  overall_win_pct: (s) => `${s.overall_wins?.value ?? 0}-${s.overall_losses?.value ?? 0}-${s.overall_draws?.value ?? 0}`,
  constructed_win_pct: (s) => `${s.constructed_wins?.value ?? 0}-${s.constructed_losses?.value ?? 0}-${s.constructed_draws?.value ?? 0}`,
  limited_win_pct: (s) => `${s.limited_wins?.value ?? 0}-${s.limited_losses?.value ?? 0}-${s.limited_draws?.value ?? 0}`,
  day1_win_pct: (s) => `${s.day1_wins?.value ?? 0}-${s.day1_losses?.value ?? 0}-${s.day1_draws?.value ?? 0}`,
  day2_win_pct: (s) => `${s.day2_wins?.value ?? 0}-${s.day2_losses?.value ?? 0}-${s.day2_draws?.value ?? 0}`,
  day3_win_pct: (s) => `${s.day3_wins?.value ?? 0}-${s.day3_losses?.value ?? 0}-${s.day3_draws?.value ?? 0}`,
};

// Computed once at module load — never triggers re-renders
const BASE_PLAYERS: Player[] = Object.entries(
  (playerDataJson as unknown as PlayerDataStructure).players
).map(([id, playerData]) => ({ id, fullName: playerData.player_info.full_name, data: playerData }));

const SORTED_EVENTS: AllEvent[] = Object.values(
  (playerDataJson as unknown as PlayerDataStructure).events
).sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

const ROW_HEIGHT = 45;

export default function PlayerListPage() {
  const [sortConfig, setSortConfig] = useState<{ key: string; direction: 'asc' | 'desc' }>({ key: 'events', direction: 'desc' });
  const [hoveredCol, setHoveredCol] = useState<number | null>(null);
  const [isMounted, setIsMounted] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [showDropdown, setShowDropdown] = useState(false);
  const [filters, setFilters] = useState<FilterOptions>({});
  const [focusedPlayerId, setFocusedPlayerId] = useState<string | null>(null);

  // Two-state pattern: dropdown updates instantly, heavy computation deferred
  const [displayEventName, setDisplayEventName] = useState('all');
  const [selectedEventName, setSelectedEventName] = useState('all');
  const [isPending, startTransition] = useTransition();

  const scrollContainerRef = useRef<HTMLDivElement>(null);
  const tableRef = useRef<HTMLTableElement>(null);
  const topScrollRef = useRef<HTMLDivElement>(null);
  const [tableWidth, setTableWidth] = useState(3000);

  const handleEventChange = (newEvent: string) => {
    setDisplayEventName(newEvent);
    setSearchTerm('');
    setFocusedPlayerId(null);
    startTransition(() => { setSelectedEventName(newEvent); });
  };

  // Event-filtered players (base list never recomputed)
  const allPlayers = useMemo((): Player[] => {
    if (selectedEventName === 'all') return BASE_PLAYERS;
    const qualKey = selectedEventName.toLowerCase() + '_qualification';
    return BASE_PLAYERS.filter((p) => {
      const hasResult = Object.values(p.data.events).some((e) => e.event_code === selectedEventName);
      const hasQual = p.data.player_info[qualKey] === true;
      return hasResult || hasQual;
    });
  }, [selectedEventName]);

  const filteredPlayerPool = useMemo(() => applyFilters(allPlayers, filters), [allPlayers, filters]);

  const searchFilteredPlayers = useMemo(() => {
    if (!searchTerm) return [];
    const q = normalizeText(searchTerm);
    return filteredPlayerPool.filter((p) => normalizeText(p.fullName).includes(q));
  }, [filteredPlayerPool, searchTerm]);

  const exactMatchPlayer = useMemo(() => {
    if (!searchTerm) return null;
    const q = normalizeText(searchTerm);
    return filteredPlayerPool.find((p) => normalizeText(p.fullName) === q) ?? null;
  }, [filteredPlayerPool, searchTerm]);

  const rankingsMap = useMemo(() => {
    const map = new Map<string, Map<string, number>>();
    STAT_CONFIGS.forEach(({ key }) => {
      const statKey = key as keyof PlayerStats;
      const sorted = filteredPlayerPool
        .map((p) => ({ id: p.id, value: p.data.stats[statKey]?.value ?? 0 }))
        .sort((a, b) => b.value - a.value);
      const ranks = new Map<string, number>();
      let rank = 1;
      for (let i = 0; i < sorted.length; i++) {
        if (i > 0 && sorted[i].value !== sorted[i - 1].value) rank = i + 1;
        ranks.set(sorted[i].id, rank);
      }
      map.set(key, ranks);
    });
    return map;
  }, [filteredPlayerPool]);

  const playersWithRankings = useMemo((): PlayerWithRankings[] =>
    filteredPlayerPool.map((p) => {
      const rankings = {} as PlayerWithRankings['rankings'];
      STAT_CONFIGS.forEach(({ key }) => {
        rankings[key as keyof PlayerWithRankings['rankings']] = rankingsMap.get(key)?.get(p.id) ?? 999;
      });
      return { playerId: p.id, player_info: { full_name: p.fullName }, stats: p.data.stats, rankings };
    }),
  [filteredPlayerPool, rankingsMap]);

  const sortedPlayers = useMemo(() => {
    return [...playersWithRankings].sort((a, b) => {
      const { key, direction } = sortConfig;
      if (key === 'name') {
        const cmp = a.player_info.full_name.localeCompare(b.player_info.full_name);
        return direction === 'asc' ? cmp : -cmp;
      }
      const statKey = key as keyof PlayerStats;
      const av = a.stats[statKey]?.value ?? 0;
      const bv = b.stats[statKey]?.value ?? 0;
      return direction === 'asc' ? av - bv : bv - av;
    });
  }, [playersWithRankings, sortConfig]);

  // Competition ranking (1224) based on current sort
  const playerRanks = useMemo(() => {
    const ranks = new Map<string, number>();
    for (let i = 0; i < sortedPlayers.length; i++) {
      const player = sortedPlayers[i];
      if (i === 0) { ranks.set(player.playerId, 1); continue; }
      const prev = sortedPlayers[i - 1];
      if (sortConfig.key === 'name') {
        ranks.set(player.playerId, i + 1);
      } else {
        const statKey = sortConfig.key as keyof PlayerStats;
        const prevVal = prev.stats[statKey]?.value ?? 0;
        const currVal = player.stats[statKey]?.value ?? 0;
        ranks.set(player.playerId, currVal === prevVal ? ranks.get(prev.playerId)! : i + 1);
      }
    }
    return ranks;
  }, [sortedPlayers, sortConfig.key]);

  // Row virtualizer — vertical scroll is on scrollContainerRef
  const rowVirtualizer = useVirtualizer({
    count: sortedPlayers.length,
    getScrollElement: () => scrollContainerRef.current,
    estimateSize: () => ROW_HEIGHT,
    overscan: 8,
  });

  useEffect(() => { setIsMounted(true); }, []);

  useEffect(() => {
    if (exactMatchPlayer) setFocusedPlayerId(exactMatchPlayer.id);
    else if (!searchTerm) setFocusedPlayerId(null);
  }, [exactMatchPlayer, searchTerm]);

  // Scroll to focused player via virtualizer index
  useEffect(() => {
    if (focusedPlayerId && isMounted) {
      const idx = sortedPlayers.findIndex((p) => p.playerId === focusedPlayerId);
      if (idx !== -1) rowVirtualizer.scrollToIndex(idx, { align: 'center', behavior: 'smooth' } as any);
    }
  }, [focusedPlayerId, isMounted, sortedPlayers, rowVirtualizer]);

  // Measure table width for the top phantom scrollbar
  useEffect(() => {
    if (tableRef.current) setTableWidth(tableRef.current.scrollWidth);
  }, [sortedPlayers]);

  // Sync horizontal scrollbars (top phantom ↔ main container)
  useEffect(() => {
    const top = topScrollRef.current;
    const main = scrollContainerRef.current;
    if (!top || !main) return;
    const syncTop = () => { if (main.scrollLeft !== top.scrollLeft) main.scrollLeft = top.scrollLeft; };
    const syncMain = () => { if (top.scrollLeft !== main.scrollLeft) top.scrollLeft = main.scrollLeft; };
    top.addEventListener('scroll', syncTop);
    main.addEventListener('scroll', syncMain);
    return () => { top.removeEventListener('scroll', syncTop); main.removeEventListener('scroll', syncMain); };
  }, []);

  function handleSort(key: string) {
    setSortConfig((prev) => ({
      key,
      direction: prev.key === key && prev.direction === 'desc' ? 'asc' : 'desc',
    }));
  }

  const virtualItems = rowVirtualizer.getVirtualItems();
  const totalSize = rowVirtualizer.getTotalSize();
  const paddingTop = virtualItems[0]?.start ?? 0;
  const paddingBottom = totalSize - (virtualItems[virtualItems.length - 1]?.end ?? 0);

  const selectedEventLabel = displayEventName === 'all' ? 'All Players' : displayEventName;

  return (
    <div className="min-h-screen bg-gray-50 py-8">
      <style>{`
        .pl-row:hover .pl-name { background-color: rgb(219,234,254) !important; }
        .pl-row:hover .pl-stat { background-color: rgb(219,234,254) !important; }
      `}</style>

      <div className="w-full px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="mb-4">
          <div className="mb-4 flex flex-col sm:flex-row sm:items-center sm:gap-6">
            <h1 className="text-3xl font-bold text-gray-900 flex items-center gap-3">
              {selectedEventLabel}
              {isPending && (
                <span className="inline-block w-4 h-4 border-2 border-gray-400 border-t-blue-500 rounded-full animate-spin" />
              )}
            </h1>
            <div className="mt-3 sm:mt-0">
              <select
                value={displayEventName}
                onChange={(e) => handleEventChange(e.target.value)}
                className="px-3 py-2 border border-gray-300 rounded-lg text-sm text-gray-900 bg-white shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              >
                <option value="all">All Players</option>
                {SORTED_EVENTS.map((ev) => (
                  <option key={ev.id} value={ev.name}>{ev.name}</option>
                ))}
              </select>
            </div>
          </div>

          <SearchBar
            searchTerm={searchTerm}
            onSearchChange={(value) => { setSearchTerm(value); if (!value) setFocusedPlayerId(null); }}
            onPlayerSelect={(player) => { setSearchTerm(player.fullName); setShowDropdown(false); setFocusedPlayerId(player.id); }}
            filteredPlayers={searchFilteredPlayers}
            showDropdown={showDropdown}
            onShowDropdownChange={setShowDropdown}
            filters={filters}
            onFiltersChange={setFilters}
            totalPlayers={allPlayers.length}
            filteredPlayerCount={filteredPlayerPool.length}
            showEclToggle={false}
          />
        </div>

        {/* Top phantom scrollbar */}
        <div
          ref={topScrollRef}
          className="overflow-x-auto overflow-y-hidden bg-gray-100 border border-gray-300 rounded mb-1"
          style={{ height: 16 }}
        >
          <div style={{ width: tableWidth, height: 1 }} />
        </div>

        {/* Virtualized table — this div is the vertical scroll container */}
        <div
          ref={scrollContainerRef}
          className={`bg-white rounded-lg shadow-sm overflow-auto transition-opacity ${isPending ? 'opacity-60' : ''}`}
          style={{ height: 'calc(100vh - 260px)', minHeight: 400 }}
        >
          <table ref={tableRef} className="w-full text-sm border-collapse">
            <thead className="bg-gray-100 sticky top-0 z-20">
              <tr>
                <th className="px-2 py-3 text-center font-semibold text-gray-900 sticky left-0 bg-gray-100 z-30 w-10 border-b border-r border-gray-200">
                  #
                </th>
                <th
                  className="px-3 py-3 text-left font-semibold text-gray-900 sticky bg-gray-100 z-30 cursor-pointer w-40 border-b border-r border-gray-200"
                  style={{ left: 40 }}
                  onClick={() => handleSort('name')}
                >
                  <div className="flex items-center gap-2">
                    Player Name
                    {sortConfig.key === 'name' && <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>}
                  </div>
                </th>
                {STAT_CONFIGS.map(({ key, label }, colIdx) => (
                  <th
                    key={key}
                    className={`px-3 py-3 text-center font-semibold text-gray-900 cursor-pointer whitespace-nowrap border-b border-r border-gray-200 transition-colors ${hoveredCol === colIdx ? 'bg-blue-100' : 'bg-gray-100'}`}
                    onClick={() => handleSort(key)}
                  >
                    <div className="flex items-center justify-center gap-1">
                      {label}
                      {sortConfig.key === key && <span className="text-xs">{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>}
                    </div>
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {paddingTop > 0 && (
                <tr style={{ height: paddingTop }}>
                  <td colSpan={STAT_CONFIGS.length + 2} />
                </tr>
              )}

              {virtualItems.map((virtualItem) => {
                const player = sortedPlayers[virtualItem.index];
                const isFocused = player.playerId === focusedPlayerId;
                const isEven = virtualItem.index % 2 === 0;
                const bg = isFocused ? 'rgb(220,252,231)' : (isEven ? 'white' : 'rgb(249,250,251)');

                return (
                  <tr key={player.playerId} className="pl-row" style={{ height: ROW_HEIGHT }}>
                    <td
                      className="pl-name px-2 py-2 text-center text-gray-500 font-medium sticky left-0 z-10 border-r border-b border-gray-200 w-10"
                      style={{ backgroundColor: bg }}
                    >
                      {playerRanks.get(player.playerId)}
                    </td>
                    <td
                      className="pl-name px-3 py-2 font-medium text-gray-900 sticky z-10 border-r border-b border-gray-200 w-40"
                      style={{ backgroundColor: bg, left: 40 }}
                    >
                      {player.player_info.full_name}
                    </td>
                    {STAT_CONFIGS.map(({ key, isPercentage }, colIdx) => {
                      const statKey = key as keyof PlayerStats;
                      const value = player.stats[statKey]?.value ?? 0;
                      const rank = player.rankings[key as keyof PlayerWithRankings['rankings']];
                      const record = RECORD_KEYS[key]?.(player.stats) ?? '';
                      const rankColor =
                        rank === 1 ? 'text-yellow-600 font-bold' :
                        rank === 2 ? 'text-gray-500 font-semibold' :
                        rank === 3 ? 'text-orange-600 font-semibold' : 'text-gray-500';
                      const suffix = rank === 1 ? 'st' : rank === 2 ? 'nd' : rank === 3 ? 'rd' : 'th';
                      const cellBg = isFocused ? 'rgb(220,252,231)' : (hoveredCol === colIdx ? 'rgb(219,234,254)' : undefined);

                      return (
                        <td
                          key={key}
                          className="pl-stat px-3 py-2 text-center text-gray-900 whitespace-nowrap border-r border-b border-gray-200 transition-colors"
                          style={{ backgroundColor: cellBg }}
                          onMouseEnter={() => isMounted && setHoveredCol(colIdx)}
                          onMouseLeave={() => isMounted && setHoveredCol(null)}
                        >
                          <span className="font-bold">{isPercentage ? `${(value as number).toFixed(1)}%` : String(value)}</span>{' '}
                          {record && <span className="text-gray-700">{record} </span>}
                          <span className={rankColor}>({rank}{suffix})</span>
                        </td>
                      );
                    })}
                  </tr>
                );
              })}

              {paddingBottom > 0 && (
                <tr style={{ height: paddingBottom }}>
                  <td colSpan={STAT_CONFIGS.length + 2} />
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {sortedPlayers.length === 0 && !isPending && (
          <div className="text-center py-12 text-gray-500">No players found.</div>
        )}
      </div>
    </div>
  );
}

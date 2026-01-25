'use client';

import React, { useEffect, useState, useMemo } from 'react';
import { PlayerData, PlayerStats, PlayerInfo, PlayerDataStructure, Player, FilterOptions } from '@/components/shared/types';
import { calculatePlayerRank, applyFilters } from '@/components/shared/rankingUtils';
import { SearchBar, normalizeText } from '@/components/SearchBar';
import playerDataJson from '@/data/data.json';

interface PlayerWithRankings extends PlayerData {
  playerId: string;
  rankings: {
    events: number;
    day2s: number;
    in_contentions: number;
    top8s: number;
    overall_win_pct: number;
    constructed_win_pct: number;
    day1_win_pct: number;
    day2_win_pct: number;
    day3_win_pct: number;
    limited_win_pct: number;
    drafts: number;
    winning_drafts: number;
    trophy_drafts: number;
    '5streaks': number;
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

const HeaderCell = React.memo(({
  colKey,
  label,
  idx,
  hoveredCol,
  sortConfig,
  onSort
}: {
  colKey: string;
  label: string;
  idx: number;
  hoveredCol: number | null;
  sortConfig: any;
  onSort: (key: string) => void;
}) => (
  <th
    className={`px-3 py-3 text-center font-semibold text-gray-900 cursor-pointer transition-colors border-r border-gray-200 ${
      hoveredCol === idx ? 'bg-blue-100' : ''
    }`}
    onClick={() => onSort(colKey)}
  >
    <div className="flex items-center justify-center gap-1">
      {label}
      {sortConfig?.key === colKey && (
        <span className="text-xs">{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
      )}
    </div>
  </th>
));

HeaderCell.displayName = 'HeaderCell';

export default function CurrentTournamentPage() {
  const [sortConfig, setSortConfig] = useState<{
    key: string;
    direction: 'asc' | 'desc';
  } | null>({ key: 'events', direction: 'desc' });
  const tableRef = React.useRef<HTMLTableElement>(null);
  const [tableWidth, setTableWidth] = React.useState(3000);
  const [hoveredCol, setHoveredCol] = React.useState<number | null>(null);
  const [isMounted, setIsMounted] = React.useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [showDropdown, setShowDropdown] = useState(false);
  const [filters, setFilters] = useState<FilterOptions>({});
  const [focusedPlayerId, setFocusedPlayerId] = useState<string | null>(null);
  const rowRefs = React.useRef<Map<string, HTMLTableRowElement>>(new Map());

  // Get all ECL qualified players as Player type
  const allQualifiedPlayers = useMemo(() => {
    const data = playerDataJson as unknown as PlayerDataStructure;
    return Object.entries(data.players)
      .filter(([_, player]) => player.player_info.ecl_qualification === true)
      .map(([id, playerData]) => ({
        id,
        fullName: playerData.player_info.full_name,
        data: playerData,
      }));
  }, []);

  // Apply filters to get filtered player pool
  const filteredPlayerPool = useMemo(() => {
    return applyFilters(allQualifiedPlayers, filters);
  }, [allQualifiedPlayers, filters]);

  // Apply search filter for dropdown suggestions only
  const searchFilteredPlayers = useMemo(() => {
    if (!searchTerm) return [];
    const normalizedSearch = normalizeText(searchTerm);
    return filteredPlayerPool.filter((player) =>
      normalizeText(player.fullName).includes(normalizedSearch)
    );
  }, [filteredPlayerPool, searchTerm]);

  // Find exact match player for focusing
  const exactMatchPlayer = useMemo(() => {
    if (!searchTerm) return null;
    const normalizedSearch = normalizeText(searchTerm);
    return filteredPlayerPool.find((player) =>
      normalizeText(player.fullName) === normalizedSearch
    );
  }, [filteredPlayerPool, searchTerm]);

  // Calculate rankings based on the full filtered player pool (not affected by search)
  const rankingsMap = useMemo(() => {
    const rankings = new Map<string, Map<string, number>>();

    STAT_CONFIGS.forEach(({ key }) => {
      const statKey = key as keyof PlayerStats;

      // Get all players from the filtered pool (not search filtered) with valid values, sorted
      const sorted = filteredPlayerPool
        .map(player => ({
          id: player.id,
          value: player.data.stats[statKey]?.value ?? 0,
        }))
        .filter(item => item.value !== null && item.value !== undefined)
        .sort((a, b) => b.value - a.value);

      // Assign ranks (handling ties)
      const playerRanks = new Map<string, number>();
      let currentRank = 1;
      for (let i = 0; i < sorted.length; i++) {
        if (i > 0 && sorted[i].value !== sorted[i - 1].value) {
          currentRank = i + 1;
        }
        playerRanks.set(sorted[i].id, currentRank);
      }

      rankings.set(key, playerRanks);
    });

    return rankings;
  }, [filteredPlayerPool]);

  useEffect(() => {
    setIsMounted(true);
  }, []);

  // Update focused player when exact match is found
  useEffect(() => {
    if (exactMatchPlayer) {
      setFocusedPlayerId(exactMatchPlayer.id);
    } else if (searchTerm === '') {
      setFocusedPlayerId(null);
    }
  }, [exactMatchPlayer, searchTerm]);

  // Scroll to focused player row
  useEffect(() => {
    if (focusedPlayerId && isMounted) {
      const rowElement = rowRefs.current.get(focusedPlayerId);
      if (rowElement) {
        rowElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }
    }
  }, [focusedPlayerId, isMounted]);

  // All players are displayed (search doesn't filter anymore, just focuses)
  const playersToDisplay = useMemo(() => {
    return filteredPlayerPool;
  }, [filteredPlayerPool]);

  // Build final data with rankings for players to display
  const qualifiedPlayers = useMemo(() => {
    const playersWithRankings: PlayerWithRankings[] = playersToDisplay.map(player => {
      const rankings: PlayerWithRankings['rankings'] = {} as any;

      STAT_CONFIGS.forEach(({ key }) => {
        const playerRanks = rankingsMap.get(key);
        rankings[key as keyof PlayerWithRankings['rankings']] = playerRanks?.get(player.id) ?? 999;
      });

      return {
        ...player.data,
        playerId: player.id,
        rankings,
      };
    });

    return playersWithRankings;
  }, [playersToDisplay, rankingsMap]);

  useEffect(() => {
    // Update the top scrollbar width to match the table width
    if (tableRef.current) {
      setTableWidth(tableRef.current.scrollWidth);
    }
  }, [qualifiedPlayers]);

  function handleSort(key: string) {
    let direction: 'asc' | 'desc' = 'desc';
    if (sortConfig && sortConfig.key === key && sortConfig.direction === 'desc') {
      direction = 'asc';
    }
    setSortConfig({ key, direction });
  }

  const sortedPlayers = [...qualifiedPlayers].sort((a, b) => {
    if (!sortConfig) return 0;

    const { key, direction } = sortConfig;

    let aValue: number;
    let bValue: number;

    if (key === 'name') {
      return direction === 'asc'
        ? a.player_info.full_name.localeCompare(b.player_info.full_name)
        : b.player_info.full_name.localeCompare(a.player_info.full_name);
    } else if (key.startsWith('rank_')) {
      const statKey = key.replace('rank_', '') as keyof PlayerWithRankings['rankings'];
      aValue = a.rankings[statKey] ?? 999;
      bValue = b.rankings[statKey] ?? 999;
    } else {
      const statKey = key as keyof PlayerStats;
      aValue = a.stats[statKey]?.value ?? 0;
      bValue = b.stats[statKey]?.value ?? 0;
    }

    if (direction === 'asc') {
      return aValue - bValue;
    } else {
      return bValue - aValue;
    }
  });

  function formatValue(value: number, isPercentage: boolean): string {
    if (isPercentage) {
      return `${value.toFixed(1)}%`;
    }
    return value.toString();
  }

  function getRankingSuffix(rank: number): string {
    if (rank === 1) return 'st';
    if (rank === 2) return 'nd';
    if (rank === 3) return 'rd';
    return 'th';
  }

  const handleSearchChange = (value: string) => {
    setSearchTerm(value);
    if (!value) {
      setFocusedPlayerId(null);
    }
  };

  const handlePlayerSelect = (player: Player) => {
    setSearchTerm(player.fullName);
    setShowDropdown(false);
    setFocusedPlayerId(player.id);
  };

  const handleFiltersChange = (newFilters: FilterOptions) => {
    setFilters(newFilters);
  };

  return (
    <div className="min-h-screen bg-gray-50 py-8">
      <style>{`
        /* Highlight player name when hovering any stat cell in that row */
        tr:has(.stat-cell:hover) .player-name-cell {
          background-color: rgb(219, 234, 254) !important;
        }

        /* Highlight hovered cell itself */
        .stat-cell:hover {
          background-color: rgb(219, 234, 254) !important;
        }
      `}</style>
      <div className="w-full px-4 sm:px-6 lg:px-8">
        <div className="mb-8 mx-auto">
          <div className="mb-4">
            <h1 className="text-3xl font-bold text-gray-900 mb-2">
              Lorwyn Eclipse - Qualified Players
            </h1>
          </div>

          {/* Search and Filters */}
          <SearchBar
            searchTerm={searchTerm}
            onSearchChange={handleSearchChange}
            onPlayerSelect={handlePlayerSelect}
            filteredPlayers={searchFilteredPlayers}
            showDropdown={showDropdown}
            onShowDropdownChange={setShowDropdown}
            filters={filters}
            onFiltersChange={handleFiltersChange}
            totalPlayers={allQualifiedPlayers.length}
            filteredPlayerCount={filteredPlayerPool.length}
            showEclToggle={false}
          />
        </div>

        <div className="bg-white rounded-lg shadow-sm overflow-hidden">
          {/* Top scrollbar */}
          <div 
            className="overflow-x-auto overflow-y-hidden"
            onScroll={(e) => {
              const target = e.target as HTMLDivElement;
              const tableContainer = target.nextElementSibling as HTMLDivElement;
              if (tableContainer) {
                tableContainer.scrollLeft = target.scrollLeft;
              }
            }}
          >
            <div style={{ width: 'max-content', height: '1px' }}>
              {/* Invisible spacer to create scrollbar width */}
              <div style={{ width: `${tableWidth}px` }}></div>
            </div>
          </div>
          
          {/* Table with bottom scrollbar */}
          <div 
            className="overflow-x-auto"
            onScroll={(e) => {
              const target = e.target as HTMLDivElement;
              const topScrollbar = target.previousElementSibling as HTMLDivElement;
              if (topScrollbar) {
                topScrollbar.scrollLeft = target.scrollLeft;
              }
            }}
          >
            <table ref={tableRef} className="w-full text-sm">
              <thead className="bg-gray-100 border-b border-gray-200">
                <tr>
                  <th
                    className="px-3 py-3 text-left font-semibold text-gray-900 sticky left-0 bg-gray-100 z-10 cursor-pointer transition-colors w-40 border-r border-gray-200"
                    onClick={() => handleSort('name')}
                  >
                    <div className="flex items-center gap-2">
                      Player Name
                      {sortConfig?.key === 'name' && (
                        <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                      )}
                    </div>
                  </th>
                  {STAT_CONFIGS.map(({ key, label }, idx) => (
                    <HeaderCell
                      key={key}
                      colKey={key}
                      label={label}
                      idx={idx}
                      hoveredCol={hoveredCol}
                      sortConfig={sortConfig}
                      onSort={handleSort}
                    />
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {sortedPlayers.map((player, idx) => {
                  const isFocused = player.playerId === focusedPlayerId;
                  return (
                    <tr
                      key={player.playerId}
                      ref={(el) => {
                        if (el) {
                          rowRefs.current.set(player.playerId, el);
                        } else {
                          rowRefs.current.delete(player.playerId);
                        }
                      }}
                      className={`transition-colors duration-300 ${
                        isFocused ? 'bg-green-100' : (idx % 2 === 0 ? 'bg-white' : 'bg-gray-50')
                      }`}
                    >
                      <td
                        className="player-name-cell px-3 py-3 font-medium text-gray-900 sticky left-0 z-10 transition-colors w-40 border-r border-gray-200"
                        style={{
                          backgroundColor: isFocused
                            ? 'rgb(220, 252, 231)' // green-100
                            : (idx % 2 === 0 ? 'white' : 'rgb(249, 250, 251)')
                        }}
                      >
                        {player.player_info.full_name}
                      </td>
                    {STAT_CONFIGS.map(({ key, isPercentage }, colIdx) => {
                      const statKey = key as keyof PlayerStats;
                      const rankKey = key as keyof PlayerWithRankings['rankings'];
                      const value = player.stats[statKey]?.value ?? 0;
                      const rank = player.rankings[rankKey];

                      // Determine if this stat needs a record displayed
                      const needsRecord = [
                        'overall_win_pct',
                        'constructed_win_pct',
                        'limited_win_pct',
                        'day1_win_pct',
                        'day2_win_pct',
                        'day3_win_pct'
                      ].includes(key);

                      // Get the corresponding record field
                      let record = '';
                      if (needsRecord) {
                        // For day1, day2, day3 - calculate from wins/losses/draws
                        if (key === 'day1_win_pct') {
                          const wins = player.stats.day1_wins?.value ?? 0;
                          const losses = player.stats.day1_losses?.value ?? 0;
                          const draws = player.stats.day1_draws?.value ?? 0;
                          record = `${wins}-${losses}-${draws}`;
                        } else if (key === 'day2_win_pct') {
                          const wins = player.stats.day2_wins?.value ?? 0;
                          const losses = player.stats.day2_losses?.value ?? 0;
                          const draws = player.stats.day2_draws?.value ?? 0;
                          record = `${wins}-${losses}-${draws}`;
                        } else if (key === 'day3_win_pct') {
                          const wins = player.stats.day3_wins?.value ?? 0;
                          const losses = player.stats.day3_losses?.value ?? 0;
                          const draws = player.stats.day3_draws?.value ?? 0;
                          record = `${wins}-${losses}-${draws}`;
                        } else {
                          // For overall, constructed, limited - use the record field from stats
                          const recordKey = key.replace('_win_pct', '_record') as keyof PlayerStats;
                          record = player.stats[recordKey]?.value ?? '';
                        }
                      }

                      return (
                        <td
                          key={key}
                          className={`stat-cell px-3 py-3 text-center text-gray-900 transition-colors whitespace-nowrap border-r border-gray-200`}
                          onMouseEnter={() => isMounted && setHoveredCol(colIdx)}
                          onMouseLeave={() => isMounted && setHoveredCol(null)}
                        >
                          <span className="font-bold">{formatValue(value, isPercentage)}</span>{' '}
                          {needsRecord && record && (
                            <span className="text-gray-700">{record} </span>
                          )}
                          <span className={`${
                            rank === 1 ? 'text-yellow-600 font-bold' :
                            rank === 2 ? 'text-gray-500 font-semibold' :
                            rank === 3 ? 'text-orange-600 font-semibold' :
                            'text-gray-500'
                          }`}>
                            ({rank}{getRankingSuffix(rank)})
                          </span>
                        </td>
                      );
                    })}
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>

        {qualifiedPlayers.length === 0 && (
          <div className="text-center py-12 text-gray-500">
            No qualified players found for the current tournament.
          </div>
        )}
      </div>
    </div>
  );
}
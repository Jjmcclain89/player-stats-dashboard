'use client';

import React, { useEffect, useState, useMemo } from 'react';
import { PlayerData, PlayerStats, PlayerInfo, PlayerDataStructure, Player } from '@/components/shared/types';
import { calculatePlayerRank } from '@/components/shared/rankingUtils';
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

  useEffect(() => {
    setIsMounted(true);
  }, []);

  const qualifiedPlayers = useMemo(() => {
    const data = playerDataJson as unknown as PlayerDataStructure;

    // Filter qualified players and convert to Player type
    const qualified: Player[] = Object.entries(data.players)
      .filter(([_, player]) => player.player_info.ecl_qualification === true)
      .map(([id, playerData]) => ({
        id,
        fullName: playerData.player_info.full_name,
        data: playerData,
      }));

    // Pre-calculate rankings for all stats (more efficient)
    const rankingsMap = new Map<string, Map<string, number>>();

    STAT_CONFIGS.forEach(({ key }) => {
      const statKey = key as keyof PlayerStats;

      // Get all players with valid values, sorted
      const sorted = qualified
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

      rankingsMap.set(key, playerRanks);
    });

    // Build players with rankings
    const playersWithRankings: PlayerWithRankings[] = qualified.map(player => {
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
  }, []);

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
      return `${value.toFixed(2)}%`;
    }
    return value.toString();
  }

  function getRankingSuffix(rank: number): string {
    if (rank === 1) return 'st';
    if (rank === 2) return 'nd';
    if (rank === 3) return 'rd';
    return 'th';
  }

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
        <div className="mb-8">
          <div className="mb-4">
            <h1 className="text-4xl font-bold text-gray-900 mb-2">
              Lorwyn Eclipse - Qualified Players
            </h1>
            <p className="text-gray-600">
              {qualifiedPlayers.length} qualified players
            </p>
          </div>
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
                {sortedPlayers.map((player, idx) => (
                  <tr 
                    key={player.playerId}
                    className={idx % 2 === 0 ? 'bg-white' : 'bg-gray-50'}
                  >
                    <td
                      className="player-name-cell px-3 py-3 font-medium text-gray-900 sticky left-0 z-10 transition-colors w-40 border-r border-gray-200"
                      style={{ backgroundColor: idx % 2 === 0 ? 'white' : 'rgb(249, 250, 251)' }}
                    >
                      {player.player_info.full_name}
                    </td>
                    {STAT_CONFIGS.map(({ key, isPercentage }, colIdx) => {
                      const statKey = key as keyof PlayerStats;
                      const rankKey = key as keyof PlayerWithRankings['rankings'];
                      const value = player.stats[statKey]?.value ?? 0;
                      const rank = player.rankings[rankKey];

                      return (
                        <td
                          key={key}
                          className={`stat-cell px-3 py-3 text-center text-gray-900 transition-colors whitespace-nowrap border-r border-gray-200`}
                          onMouseEnter={() => isMounted && setHoveredCol(colIdx)}
                          onMouseLeave={() => isMounted && setHoveredCol(null)}
                        >
                          {formatValue(value, isPercentage)}{' '}
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
                ))}
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
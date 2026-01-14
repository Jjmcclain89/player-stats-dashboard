'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
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
    winning_drafts_pct: number;
    trophy_drafts: number;
    '5streaks': number;
  };
}

const STAT_CONFIGS = [
  { key: 'events', label: 'Total Events', isPercentage: false },
  { key: 'in_contentions', label: 'In Contentions', isPercentage: false },
  { key: 'overall_win_pct', label: 'Overall Win %', isPercentage: true },
  { key: 'constructed_win_pct', label: 'Constructed Win %', isPercentage: true },
  { key: 'day2_win_pct', label: 'Day 2 Win %', isPercentage: true },
  { key: 'day2s', label: 'Day 2s', isPercentage: false },
  { key: 'top8s', label: 'Top 8s', isPercentage: false },
  { key: 'limited_win_pct', label: 'Limited Win %', isPercentage: true },
  { key: 'day1_win_pct', label: 'Day 1 Win %', isPercentage: true },
  { key: 'day3_win_pct', label: 'Day 3 Win %', isPercentage: true },
  { key: 'drafts', label: 'Total Drafts', isPercentage: false },
  { key: 'winning_drafts_pct', label: 'Winning Drafts %', isPercentage: true },
  { key: 'trophy_drafts', label: 'Trophy Drafts', isPercentage: false },
  { key: '5streaks', label: '5+ Win Streaks', isPercentage: false },
];

export default function CurrentTournamentPage() {
  const [qualifiedPlayers, setQualifiedPlayers] = useState<PlayerWithRankings[]>([]);
  const [loading, setLoading] = useState(true);
  const [sortConfig, setSortConfig] = useState<{
    key: string;
    direction: 'asc' | 'desc';
  } | null>({ key: 'events', direction: 'desc' });

  useEffect(() => {
    async function loadData() {
      try {
        const data = playerDataJson as unknown as PlayerDataStructure;
        
        console.log('Total players in data:', Object.keys(data.players).length);
        
        // Check first few players to see their ecl_qualification status
        const samplePlayers = Object.entries(data.players).slice(0, 5);
        console.log('Sample players:', samplePlayers.map(([id, p]) => ({
          id,
          name: p.player_info?.full_name,
          ecl_qualification: p.player_info?.ecl_qualification
        })));
        
        // Filter qualified players and convert to Player type
        const qualified: Player[] = Object.entries(data.players)
          .filter(([_, player]) => player.player_info.ecl_qualification === true)
          .map(([id, playerData]) => ({
            id,
            fullName: playerData.player_info.full_name,
            data: playerData,
          }));

        console.log('Qualified players found:', qualified.length);

        // Calculate rankings for each player using the shared utility
        const playersWithRankings: PlayerWithRankings[] = qualified.map(player => {
          const rankings: PlayerWithRankings['rankings'] = {} as any;
          
          STAT_CONFIGS.forEach(({ key }) => {
            const rankData = calculatePlayerRank(qualified, player, key);
            rankings[key as keyof PlayerWithRankings['rankings']] = rankData?.rank ?? 999;
          });

          return {
            ...player.data,
            playerId: player.id,
            rankings,
          };
        });
        
        setQualifiedPlayers(playersWithRankings);
        setLoading(false);
      } catch (error) {
        console.error('Error loading data:', error);
        setLoading(false);
      }
    }

    loadData();
  }, []);

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

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-xl text-gray-600">Loading tournament data...</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 py-8 px-4">
      <div className="max-w-[1800px] mx-auto">
        <div className="mb-8">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h1 className="text-4xl font-bold text-gray-900 mb-2">
                Pro Tour ECL - Qualified Players
              </h1>
              <p className="text-gray-600">
                {qualifiedPlayers.length} qualified players
              </p>
            </div>
            <Link 
              href="/"
              className="px-4 py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition-colors"
            >
              ← Back to Dashboard
            </Link>
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-sm overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="bg-gray-100 border-b border-gray-200">
                <tr>
                  <th 
                    className="px-4 py-3 text-left font-semibold text-gray-900 sticky left-0 bg-gray-100 z-10 cursor-pointer hover:bg-gray-200"
                    onClick={() => handleSort('name')}
                  >
                    <div className="flex items-center gap-2">
                      Player Name
                      {sortConfig?.key === 'name' && (
                        <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                      )}
                    </div>
                  </th>
                  {STAT_CONFIGS.map(({ key, label }) => (
                    <React.Fragment key={key}>
                      <th 
                        className="px-3 py-3 text-center font-semibold text-gray-900 cursor-pointer hover:bg-gray-200"
                        onClick={() => handleSort(key)}
                      >
                        <div className="flex items-center justify-center gap-1">
                          {label}
                          {sortConfig?.key === key && (
                            <span className="text-xs">{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                          )}
                        </div>
                      </th>
                      <th 
                        className="px-3 py-3 text-center font-semibold text-gray-600 bg-gray-50 cursor-pointer hover:bg-gray-200"
                        onClick={() => handleSort(`rank_${key}`)}
                      >
                        <div className="flex items-center justify-center gap-1">
                          Rank
                          {sortConfig?.key === `rank_${key}` && (
                            <span className="text-xs">{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                          )}
                        </div>
                      </th>
                    </React.Fragment>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {sortedPlayers.map((player, idx) => (
                  <tr 
                    key={player.playerId}
                    className={idx % 2 === 0 ? 'bg-white' : 'bg-gray-50'}
                  >
                    <td className="px-4 py-3 font-medium text-gray-900 sticky left-0 z-10" 
                        style={{ backgroundColor: idx % 2 === 0 ? 'white' : 'rgb(249, 250, 251)' }}>
                      {player.player_info.full_name}
                    </td>
                    {STAT_CONFIGS.map(({ key, isPercentage }) => {
                      const statKey = key as keyof PlayerStats;
                      const rankKey = key as keyof PlayerWithRankings['rankings'];
                      const value = player.stats[statKey]?.value ?? 0;
                      const rank = player.rankings[rankKey];
                      
                      return (
                        <React.Fragment key={key}>
                          <td className="px-3 py-3 text-center text-gray-900">
                            {formatValue(value, isPercentage)}
                          </td>
                          <td className="px-3 py-3 text-center bg-gray-50 text-gray-700">
                            <span className={`inline-block ${
                              rank === 1 ? 'text-yellow-600 font-bold' :
                              rank === 2 ? 'text-gray-500 font-semibold' :
                              rank === 3 ? 'text-orange-600 font-semibold' :
                              ''
                            }`}>
                              {rank}{getRankingSuffix(rank)}
                            </span>
                          </td>
                        </React.Fragment>
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
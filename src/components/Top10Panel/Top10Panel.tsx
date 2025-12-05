// Top10Panel/Top10Panel.tsx
import React, { useMemo } from 'react';
import { Player, PlayerDataStructure, FilterOptions } from '../shared/types';
import { getStatDisplayName } from '../shared/utils';
import {
  sortPlayers,
  calculatePlayerRank,
  applyFilters,
  isRankableStat,
} from '../shared/rankingUtils';

interface Top10PanelProps {
  selectedStat: string | null;
  selectedPlayer: Player | null;
  playerData: PlayerDataStructure;
  filters: FilterOptions;
  onPlayerSelect: (playerName: string) => void;
}

const Top10Panel: React.FC<Top10PanelProps> = ({
  selectedStat,
  selectedPlayer,
  playerData,
  filters,
  onPlayerSelect,
}) => {
  // Extract all players into an array
  const allPlayers = useMemo(() => {
    return Object.entries(playerData.players).map(([key, data]) => ({
      id: key,
      fullName: data.player_info.full_name,
      data: data,
    }));
  }, [playerData]);

  // Apply filters to get filtered player pool
  const filteredPlayers = useMemo(() => {
    return applyFilters(allPlayers, filters);
  }, [allPlayers, filters]);

  // Sort filtered players and take top 10
  const top10Players = useMemo(() => {
    if (!selectedStat || !isRankableStat(selectedStat)) {
      return [];
    }
    const sortedPlayers = sortPlayers(filteredPlayers, selectedStat);
    return sortedPlayers.slice(0, 10);
  }, [filteredPlayers, selectedStat]);

  // Calculate selected player's rank
  const playerRankInfo = useMemo(() => {
    if (!selectedPlayer || !selectedStat) return null;
    return calculatePlayerRank(filteredPlayers, selectedPlayer, selectedStat);
  }, [filteredPlayers, selectedPlayer, selectedStat]);

  // Placeholder content component for consistent height
  const PlaceholderContent: React.FC<{ visible?: boolean }> = ({
    visible = false,
  }) => (
    <div className={`space-y-1 ${visible ? '' : 'invisible'}`}>
      {Array.from({ length: 10 }, (_, i) => (
        <div
          key={i}
          className='flex justify-between items-center py-1 px-3 bg-gray-50 rounded border-l-4 border-blue-500'
        >
          <div className='flex items-center gap-2'>
            <span className='font-bold text-gray-600 w-6 text-sm'>
              #{i + 1}
            </span>
            <span className='force-black-text font-medium text-sm'>
              Player Name Here
            </span>
          </div>
          <span className='force-black-text font-bold text-sm'>100</span>
        </div>
      ))}
    </div>
  );

  const PlaceholderPlayerRank: React.FC<{ visible?: boolean }> = ({
    visible = false,
  }) => (
    <>
      <div
        className={`border-t border-gray-200 my-4 ${visible ? '' : 'invisible'}`}
      ></div>
      <div
        className={`bg-yellow-50 border-l-4 border-yellow-500 py-1 px-3 rounded ${
          visible ? '' : 'invisible'
        }`}
      >
        <div className='flex justify-between items-center'>
          <div className='flex items-center gap-4'>
            <span className='font-bold text-yellow-700 w-6 text-sm pr-5'>
              #50
            </span>
            <span className='force-black-text font-medium text-sm'>
              Your Player Name
            </span>
          </div>
          <span className='force-black-text font-bold text-sm'>50</span>
        </div>
      </div>
    </>
  );

  if (!selectedStat) {
    return (
      <div className='bg-white rounded-lg shadow-md p-6 h-full flex flex-col'>
        <h3 className='text-lg font-bold mb-4 force-black-text'>
          Top 10 Rankings
        </h3>
        <p className='text-gray-500 text-center'>
          Select a stat to view rankings
        </p>
        <PlaceholderContent />
        <PlaceholderPlayerRank />
      </div>
    );
  }

  if (!isRankableStat(selectedStat)) {
    return (
      <div className='bg-white rounded-lg shadow-md p-6 h-full flex flex-col'>
        <h3 className='text-lg font-bold mb-4 force-black-text'>
          {getStatDisplayName(selectedStat)}
        </h3>
        <p className='text-gray-500 text-center'>
          No rankings available for this stat
        </p>
        <PlaceholderContent />
        <PlaceholderPlayerRank />
      </div>
    );
  }

  return (
    <div className='bg-white rounded-lg shadow-md p-6 h-full flex flex-col'>
      {/* Header */}
      <div className='flex items-center justify-between mb-4'>
        <h3 className='text-lg font-bold force-black-text'>
          Top 10: {getStatDisplayName(selectedStat)}
        </h3>
      </div>

      {/* Rankings List */}
      {top10Players.length === 0 ? (
        <p className='text-gray-500 text-center text-sm'>
          No players match the current filters
        </p>
      ) : (
        <div className='space-y-1'>
          {top10Players.map((player, index) => {
            const rank = calculatePlayerRank(top10Players, player, selectedStat)?.rank;
            const isSelectedPlayer = selectedPlayer?.fullName === player.fullName;
            const statValue = player.data.stats[selectedStat as keyof typeof player.data.stats].value;
            
            return (
              <div
                key={player.id}
                onClick={() => onPlayerSelect(player.fullName)}
                className={`flex justify-between items-center py-1 px-3 rounded border-l-4 cursor-pointer transition-colors ${
                  isSelectedPlayer
                    ? 'bg-yellow-50 border-yellow-500 hover:bg-yellow-100'
                    : 'bg-gray-50 border-blue-500 hover:bg-gray-100'
                }`}
              >
                <div className='flex items-center gap-2'>
                  <span className={`font-bold w-6 text-sm ${
                    isSelectedPlayer ? 'text-yellow-700' : 'text-gray-600'
                  }`}>
                    #{rank}
                  </span>
                  <span className='force-black-text font-medium text-sm'>
                    {player.fullName}
                  </span>
                </div>
                <span className='force-black-text font-bold text-sm'>
                  {selectedStat.includes('pct')
                    ? `${statValue}%`
                    : statValue}
                </span>
              </div>
            );
          })}
        </div>
      )}

      {/* Player Personal Rank Section */}
      {selectedPlayer && playerRankInfo && (
        <>
          <div className='border-t border-gray-200 my-4'></div>
          <div className='bg-yellow-50 border-l-4 border-yellow-500 py-1 px-3 rounded'>
            <div className='flex justify-between items-center'>
              <div className='flex items-center gap-4'>
                <span className='font-bold text-yellow-700 w-6 text-sm pr-5'>
                  #{playerRankInfo.rank}
                </span>
                <span className='force-black-text font-medium text-sm'>
                  {selectedPlayer.fullName}
                </span>
              </div>
              <span className='force-black-text font-bold text-sm'>
                {selectedStat.includes('pct')
                  ? `${
                      selectedPlayer.data.stats[
                        selectedStat as keyof typeof selectedPlayer.data.stats
                      ].value
                    }%`
                  : selectedPlayer.data.stats[
                      selectedStat as keyof typeof selectedPlayer.data.stats
                    ].value}
              </span>
            </div>
          </div>
          <p className='text-xs text-gray-500 mt-2 text-center'>
            Ranked {playerRankInfo.rank} of {playerRankInfo.totalPlayers} players
          </p>
        </>
      )}
    </div>
  );
};

export default Top10Panel;
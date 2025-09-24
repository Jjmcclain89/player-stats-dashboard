// Top10Panel/Top10Panel.tsx
import React from 'react';
import { Player, PlayerDataStructure, Top10Entry } from '../shared/types';
import { getStatDisplayName } from '../shared/utils';

interface Top10PanelProps {
  selectedStat: string | null;
  selectedPlayer: Player | null;
  playerData: PlayerDataStructure;
}

const Top10Panel: React.FC<Top10PanelProps> = ({
  selectedStat,
  selectedPlayer,
  playerData,
}) => {
  // Placeholder content component for consistent height
  const PlaceholderContent: React.FC<{ visible?: boolean }> = ({ visible = false }) => (
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

  const PlaceholderPlayerRank: React.FC<{ visible?: boolean }> = ({ visible = false }) => (
    <>
      <div className={`border-t border-gray-200 my-4 ${visible ? '' : 'invisible'}`}></div>
      <div className={`bg-yellow-50 border-l-4 border-yellow-500 py-1 px-3 rounded ${visible ? '' : 'invisible'}`}>
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
      <div className='bg-white rounded-lg shadow-md p-6 h-fit'>
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

  if (!(playerData.top_10 as any)[selectedStat]) {
    return (
      <div className='bg-white rounded-lg shadow-md p-6 h-fit'>
        <h3 className='text-lg font-bold mb-4 force-black-text'>
          {getStatDisplayName(selectedStat)}
        </h3>
        <p className='text-gray-500 text-center'>
          No top 10 available for this stat
        </p>
        <PlaceholderContent />
        <PlaceholderPlayerRank />
      </div>
    );
  }

  const top10Data = (playerData.top_10 as any)[selectedStat];
  const rankings = Object.values(top10Data) as Top10Entry[];

  // Get the selected player's rank for this stat
  const playerRank = selectedPlayer?.data?.stats?.[selectedStat as keyof typeof selectedPlayer.data.stats]?.rank;
  const playerStatValue = selectedPlayer?.data?.stats?.[selectedStat as keyof typeof selectedPlayer.data.stats]?.value;

  return (
    <div className='bg-white rounded-lg shadow-md p-6 h-fit'>
      <h3 className='text-lg font-bold mb-4 force-black-text'>
        Top 10: {getStatDisplayName(selectedStat)}
      </h3>
      <div className='space-y-1'>
        {rankings.map((entry: Top10Entry) => (
          <div
            key={entry.rank}
            className='flex justify-between items-center py-1 px-3 bg-gray-50 rounded border-l-4 border-blue-500'
          >
            <div className='flex items-center gap-2'>
              <span className='font-bold text-gray-600 w-6 text-sm'>
                #{entry.rank}
              </span>
              <span className='force-black-text font-medium text-sm'>
                {entry.player_full_name}
              </span>
            </div>
            <span className='force-black-text font-bold text-sm'>
              {selectedStat.includes('pct')
                ? `${entry.stat_value}%`
                : entry.stat_value}
            </span>
          </div>
        ))}
      </div>

      {/* Player Personal Rank Section */}
      {selectedPlayer && playerRank && (
        <>
          <div className='border-t border-gray-200 my-4'></div>
          <div className='bg-yellow-50 border-l-4 border-yellow-500 py-1 px-3 rounded'>
            <div className='flex justify-between items-center'>
              <div className='flex items-center gap-4'>
                <span className='font-bold text-yellow-700 w-6 text-sm pr-5'>
                  #{playerRank}
                </span>
                <span className='force-black-text font-medium text-sm'>
                  {selectedPlayer.fullName}
                </span>
              </div>
              <span className='force-black-text font-bold text-sm'>
                {selectedStat.includes('pct')
                  ? `${playerStatValue}%`
                  : playerStatValue}
              </span>
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default Top10Panel;
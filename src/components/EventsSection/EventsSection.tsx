// EventsSection/EventsSection.tsx
import React, { useState, useEffect } from 'react';
import EventsTableView from './EventsTableView';
import EventsCardView from './EventsCardView';
import { Player } from '../shared/types';
import playerDataJson from '../../data/data.json';
import { PlayerDataStructure } from '../shared/types';

interface EventsSectionProps {
  selectedPlayer: Player;
}

const EventsSection: React.FC<EventsSectionProps> = ({ selectedPlayer }) => {
  const [richMode, setRichMode] = useState(false);
  const [seasonSort, setSeasonSort] = useState<'recent' | 'oldest'>('recent');

  // Load richMode preference from localStorage on mount
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const savedRichMode = localStorage.getItem('richMode');
      if (savedRichMode !== null) {
        setRichMode(savedRichMode === 'true');
      }
    }
  }, []);

  // Save richMode preference to localStorage whenever it changes
  const handleToggleRichMode = () => {
    const newRichMode = !richMode;
    setRichMode(newRichMode);

    if (typeof window !== 'undefined') {
      localStorage.setItem('richMode', newRichMode.toString());
    }
  };

  const events = Object.values(selectedPlayer.data.events);
  const playerData = playerDataJson as unknown as PlayerDataStructure;

  return (
    <div className='bg-white rounded-lg shadow-md p-6'>
      <div className='flex justify-between items-center mb-6'>
        <div className='flex items-center gap-4'>
          <h3 className='text-xl font-bold force-black-text'>Events History</h3>

          {/* Sort Buttons - Only show in card view */}
          {!richMode && (
            <div className='flex gap-2'>
              <button
                onClick={() => setSeasonSort('recent')}
                className={`px-3 py-1 text-sm rounded-md font-medium transition-colors ${
                  seasonSort === 'recent'
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
                }`}
              >
                Newest First
              </button>
              <button
                onClick={() => setSeasonSort('oldest')}
                className={`px-3 py-1 text-sm rounded-md font-medium transition-colors ${
                  seasonSort === 'oldest'
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
                }`}
              >
                Oldest First
              </button>
            </div>
          )}
        </div>

        {/* Rich Mode Toggle */}
        <div className='flex items-center gap-3'>
          <span className='text-sm font-medium force-black-text'>
            Rich Mode
          </span>
          <button
            onClick={handleToggleRichMode}
            className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 ${
              richMode ? 'bg-blue-600' : 'bg-gray-300'
            }`}
            role='switch'
            aria-checked={richMode}
          >
            <span
              className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                richMode ? 'translate-x-6' : 'translate-x-1'
              }`}
            />
          </button>
        </div>
      </div>

      {/* Conditional Rendering: Table vs Cards */}
      {richMode ? (
        <EventsTableView events={events} />
      ) : (
        <EventsCardView
          playerEvents={selectedPlayer.data.events}
          allEvents={playerData.events}
          seasonSort={seasonSort}
        />
      )}
    </div>
  );
};

export default EventsSection;
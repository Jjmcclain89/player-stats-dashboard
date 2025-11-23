// EventsSection/EventsSection.tsx
import React, { useState, useEffect } from 'react';
import EventCard from './EventCard';
import { Player } from '../shared/types';
import { formatDate, abbreviateFormat, abbreviateEvent, formatFinish } from '../shared/utils';

interface EventsSectionProps {
  selectedPlayer: Player;
}

const EventsSection: React.FC<EventsSectionProps> = ({ selectedPlayer }) => {
  const [richMode, setRichMode] = useState(false);

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

  return (
    <div className='bg-white rounded-lg shadow-md p-6'>
      <div className='flex justify-between items-center mb-6'>
        <h3 className='text-xl font-bold force-black-text'>Events History</h3>
        
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

      {/* Conditional Rendering: Cards vs Table */}
      {richMode ? 
        // Table View
        <div className='overflow-x-auto'>
          <table className='w-full border-collapse border'>
            <thead>
              <tr className='bg-gray-200 border'>
                <th className='px-2 py-1 border-b border-r font-semibold text-left force-black-text whitespace-nowrap text-xs'>Event</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>Frmt</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>Ev#</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>Rank</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>Summary</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>Deck</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D2</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>T8</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>LtW</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>LtL</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>LtD</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>#</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>+</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>-</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>🏆</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>0W</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>CnW</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>CnL</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>CnD</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>OvW</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>OvL</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>OvD</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D1W</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D1L</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D1D</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D2W</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D2L</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D2D</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>Con</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D3W</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D3L</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>D3D</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>WSt</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>LSt</th>
                <th className='px-2 py-1 border-b border-r font-semibold text-center force-black-text whitespace-nowrap text-xs'>5+St</th>
              </tr>
            </thead>
            <tbody>
              {events.map((event, index) => (
                <>
                <tr key={index} className='hover:bg-gray-50'>
                  <td className='px-2 py-1 border-l border-b border-t-gray-800 border-t-8 border-r force-black-text font-medium whitespace-nowrap  text-xs'>{abbreviateEvent(event.event_code)}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{abbreviateFormat(event.format)}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.event_id}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text font-medium whitespace-nowrap text-xs'>{event.finish}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap text-xs'>{event.summary || '-'}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap text-xs'>{event.deck || '-'}</td>
                  <td className={`px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap text-xs ${event.day2 ? 'bg-green-100' : ''}`}>{event.day2 ? '✓' : ''}</td>
                  <td className={`px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap text-xs ${event.top8 ? 'bg-green-100' : ''}`}>{event.top8 ? '✓' : ''}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.limited_wins}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.limited_losses}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.limited_draws}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.num_drafts}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.positive_drafts}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.negative_drafts}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.trophy_drafts}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.no_win_drafts}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.constructed_wins}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.constructed_losses}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.constructed_draws}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.overall_wins}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.overall_losses}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.overall_draws}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day1_wins}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day1_losses}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day1_draws}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day2_wins}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day2_losses}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day2_draws}</td>
                  <td className={`px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap text-xs ${event.in_contention ? 'bg-green-100' : ''}`}>{event.in_contention ? '✓' : ''}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day3_wins}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day3_losses}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.day3_draws}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.win_streak}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.loss_streak}</td>
                  <td className='px-2 py-1 border-b border-t-gray-800 border-t-8 border-r text-center force-black-text whitespace-nowrap  text-xs'>{event.streak5}</td>
                </tr>
                <tr>
                  <td className='px-2 py-1 border-l border-b-gray-800 border-b-8 border-r force-black-text whitespace-nowrap text-xs'>Notes</td>
                  <td colSpan={34} className='px-2 py-1 border-b-gray-800 border-b-8 border-r force-black-text whitespace-nowrap text-xs'>{event.notes || '-'}</td>
                </tr>
              </>
              ))}
            </tbody>
          </table>
        </div>
       : (
        // Card View
        <div className='grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4'>
          {events.map((event, index) => (
            <EventCard key={index} event={event} />
          ))}
        </div>
      )}
    </div>
  );
};

export default EventsSection;
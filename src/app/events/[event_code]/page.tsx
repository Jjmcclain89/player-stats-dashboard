'use client';

import React, { useState, useEffect } from 'react';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { ArrowLeft } from 'lucide-react';
import playerDataJson from '../../../data/data.json';
import { PlayerDataStructure } from '../../../components/shared/types';
import { getEventResults, EventDetails } from '../../../components/shared/eventUtils';

const EventPageClient = () => {
  const params = useParams();
  const router = useRouter();
  const eventCode = params.event_code as string;
  const [eventDetails, setEventDetails] = useState<EventDetails | null>(null);
  const [loading, setLoading] = useState(true);
  const [playerData] = useState(playerDataJson as unknown as PlayerDataStructure);

  const handleBackClick = () => {
    router.push('/');
  };

  const handlePlayerClick = (playerId: string, playerName: string) => {
    // Find the full player data
    const fullPlayerData = playerData.players[playerId];
    if (fullPlayerData) {
      const player = {
        id: playerId,
        fullName: playerName,
        data: fullPlayerData,
      };
      
      // Save to localStorage
      if (typeof window !== 'undefined') {
        localStorage.setItem('selectedPlayer', JSON.stringify(player));
      }
      
      // Navigate to home page
      router.push('/');
    }
  };

  useEffect(() => {
    if (eventCode && playerData) {
      const results = getEventResults(playerData, eventCode);
      setEventDetails(results);
      setLoading(false);
    }
  }, [eventCode, playerData]);

  if (loading) {
    return (
      <div className='min-h-screen bg-gray-50 p-6'>
        <div className='max-w-6xl mx-auto'>
          <div className='bg-white rounded-lg shadow-md p-6'>
            <p className='text-gray-600'>Loading event details...</p>
          </div>
        </div>
      </div>
    );
  }

  if (!eventDetails) {
    return (
      <div className='min-h-screen bg-gray-50 p-6'>
        <style
          dangerouslySetInnerHTML={{
            __html: `
              .force-black-text {
                color: #000000 !important;
              }
            `,
          }}
        />
        <div className='max-w-6xl mx-auto'>
          {/* Back Button */}
          <button
            onClick={handleBackClick}
            className='inline-flex items-center gap-2 mb-6 px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 hover:text-gray-900 transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent'
          >
            <ArrowLeft className='w-4 h-4' />
            Back to Player Stats
          </button>

          <h1 className='text-3xl font-bold mb-8 force-black-text'>
            Event Not Found
          </h1>
          
          <div className='bg-white rounded-lg shadow-md p-6'>
            <p className='text-gray-600'>
              No results found for event: <strong>{eventCode}</strong>
            </p>
            <p className='text-sm text-gray-500 mt-2'>
              This event may not exist or may not have any recorded results.
            </p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className='min-h-screen bg-gray-50 p-6'>
      <style
        dangerouslySetInnerHTML={{
          __html: `
            .force-black-text {
              color: #000000 !important;
            }
          `,
        }}
      />
      <div className='max-w-6xl mx-auto'>
        {/* Back Button */}
        <button
          onClick={handleBackClick}
          className='inline-flex items-center gap-2 mb-6 px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 hover:text-gray-900 transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent'
        >
          <ArrowLeft className='w-4 h-4' />
          Back to Player Stats
        </button>

        <h1 className='text-3xl font-bold mb-8 force-black-text'>
          {eventDetails.eventCode} - Event Results
        </h1>
        
        {/* Combined Results Section */}
        <div className='bg-white rounded-lg shadow-md p-6'>
          <div className='grid grid-cols-1 md:grid-cols-3 gap-4 mb-6'>
            <div>
              <p className='text-sm text-gray-500'>Format</p>
              <p className='text-lg font-semibold force-black-text'>{eventDetails.format}</p>
            </div>
            <div>
              <p className='text-sm text-gray-500'>Date</p>
              <p className='text-lg font-semibold force-black-text'>{eventDetails.date}</p>
            </div>
            <div>
              <p className='text-sm text-gray-500'>Total Players</p>
              <p className='text-lg font-semibold force-black-text'>{eventDetails.totalPlayers}</p>
            </div>
          </div>

          <h2 className='text-xl font-bold mb-6 force-black-text'>
            Final Standings
          </h2>
          
          <div className='overflow-x-auto'>
            <table className='w-full border-collapse border border-gray-200'>
              <thead>
                <tr className='bg-gray-50'>
                  <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                    Finish
                  </th>
                  <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                    Player
                  </th>
                  <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                    Deck
                  </th>
                  <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                    Record
                  </th>
                </tr>
              </thead>
              <tbody>
                {eventDetails.results.map((result, index) => (
                  <tr 
                    key={`${result.playerId}-${result.finish}`}
                    className={index % 2 === 0 ? 'bg-white' : 'bg-gray-50'}
                  >
                    <td className='px-4 py-3 border border-gray-200'>
                      <span className='font-semibold force-black-text'>
                        {result.finish === 1 && '🏆 '}
                        {result.finish >= 2 && result.finish <= 8 && '🥉 '}
                        {result.finish}{result.finish === 1 ? 'st' : 
                          result.finish === 2 ? 'nd' : 
                          result.finish === 3 ? 'rd' : 'th'}
                      </span>
                    </td>
                    <td className='px-4 py-3 border border-gray-200'>
                      <button
                        onClick={() => handlePlayerClick(result.playerId, result.playerName)}
                        className='force-black-text font-medium text-left hover:text-blue-600 hover:underline cursor-pointer transition-colors'
                      >
                        {result.playerName}
                      </button>
                    </td>
                    <td className='px-4 py-3 border border-gray-200'>
                      <span className='force-black-text'>
                        {result.deck}
                      </span>
                    </td>
                    <td className='px-4 py-3 border border-gray-200'>
                      <span className='force-black-text text-sm'>
                        {result.record || '-'}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
};

export default EventPageClient;
'use client';

import React, { useState, useEffect } from 'react';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { ArrowLeft } from 'lucide-react';
import playerDataJson from '../../../data/data.json';
import { PlayerDataStructure } from '../../../components/shared/types';
import { getEventResults, EventDetails } from '../../../components/shared/eventUtils';
import { abbreviateFormat } from '../../../components/shared/utils';

const EventPageClient = () => {
  const params = useParams();
  const router = useRouter();
  const eventCode = params.event_code as string;
  const [eventDetails, setEventDetails] = useState<EventDetails | null>(null);
  const [loading, setLoading] = useState(true);
  const [playerData] = useState(playerDataJson as unknown as PlayerDataStructure);
  const [richMode, setRichMode] = useState(false);
  const contentRef = React.useRef<HTMLDivElement>(null);
  const scrollbarRef = React.useRef<HTMLDivElement>(null);

  // Load rich mode state from localStorage on mount
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const savedRichMode = localStorage.getItem('eventPageRichMode');
      if (savedRichMode !== null) {
        setRichMode(savedRichMode === 'true');
      }
    }
  }, []);

  // Save rich mode state to localStorage when it changes
  const handleRichModeToggle = (checked: boolean) => {
    setRichMode(checked);
    if (typeof window !== 'undefined') {
      localStorage.setItem('eventPageRichMode', checked.toString());
    }
  };

  // Sync scrollbar with content
  useEffect(() => {
    if (!richMode || !contentRef.current || !scrollbarRef.current) return;

    const content = contentRef.current;
    const scrollbar = scrollbarRef.current;

    const handleContentScroll = () => {
      if (scrollbar) {
        scrollbar.scrollLeft = content.scrollLeft;
      }
    };

    const handleScrollbarScroll = () => {
      if (content) {
        content.scrollLeft = scrollbar.scrollLeft;
      }
    };

    content.addEventListener('scroll', handleContentScroll);
    scrollbar.addEventListener('scroll', handleScrollbarScroll);

    // Set scrollbar width to match content scroll width
    const updateScrollbarWidth = () => {
      if (scrollbar.firstElementChild) {
        (scrollbar.firstElementChild as HTMLElement).style.width = `${content.scrollWidth}px`;
      }
    };
    updateScrollbarWidth();

    return () => {
      content.removeEventListener('scroll', handleContentScroll);
      scrollbar.removeEventListener('scroll', handleScrollbarScroll);
    };
  }, [richMode, eventDetails]);

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
    <>
      <div ref={contentRef} className={`min-h-screen bg-gray-50 p-6 ${richMode ? 'overflow-x-auto' : ''}`}>
      <style
        dangerouslySetInnerHTML={{
          __html: `
            .force-black-text {
              color: #000000 !important;
            }
            .notes-cell {
              max-width: 300px;
            }
          `,
        }}
      />
      
      <div className={richMode ? 'min-w-max' : 'max-w-6xl mx-auto'}>
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

          {/* Header with Rich Mode Toggle */}
          <div className='flex items-center gap-4 mb-6'>
            <h2 className='text-xl font-bold force-black-text'>
              Final Standings
            </h2>
            
            {/* Rich Mode Toggle */}
            <label className='flex items-center cursor-pointer'>
              <span className='mr-2 text-sm font-medium force-black-text'>Rich Mode</span>
              <div className='relative'>
                <input
                  type='checkbox'
                  checked={richMode}
                  onChange={(e) => handleRichModeToggle(e.target.checked)}
                  className='sr-only'
                />
                <div className={`block w-14 h-8 rounded-full transition-colors ${richMode ? 'bg-blue-600' : 'bg-gray-300'}`}></div>
                <div className={`absolute left-1 top-1 bg-white w-6 h-6 rounded-full transition-transform ${richMode ? 'transform translate-x-6' : ''}`}></div>
              </div>
            </label>
          </div>
          
          <div>
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
                  <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                    Notes
                  </th>
                  {richMode && (
                    <>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        Ltd Rec
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        # Drafts
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        + Drafts
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        - Drafts
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        🏆s
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        0W Drafts
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        Cn Rec
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        D1 Rec
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        D2 Rec
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        D3 Rec
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        Win St
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        Loss St
                      </th>
                      <th className='px-4 py-3 text-left font-semibold force-black-text border border-gray-200'>
                        5+ St
                      </th>
                    </>
                  )}
                </tr>
              </thead>
              <tbody>
                {eventDetails.results.map((result, index) => {
                  return (
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
                          className='text-blue-600 font-medium text-left hover:text-blue-800 hover:underline cursor-pointer transition-colors'
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
                      <td className={`px-4 py-3 border border-gray-200 ${richMode? 'notes-cell':''}`}>
                        <div className='force-black-text text-sm overflow-hidden'>
                          {result.notes || '-'}
                        </div>
                      </td>
                      {richMode && (
                        <>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {`${result.limited_wins || 0}-${result.limited_losses || 0}-${result.limited_draws || 0}`}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {result.num_drafts || 0}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {result.positive_drafts || 0}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {result.negative_drafts || 0}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {result.trophy_drafts || 0}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {result.no_win_drafts || 0}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {`${result.constructed_wins || 0}-${result.constructed_losses || 0}-${result.constructed_draws || 0}`}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {`${result.day1_wins || 0}-${result.day1_losses || 0}-${result.day1_draws || 0}`}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {`${result.day2_wins || 0}-${result.day2_losses || 0}-${result.day2_draws || 0}`}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {`${result.day3_wins || 0}-${result.day3_losses || 0}-${result.day3_draws || 0}`}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {result.win_streak || 0}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {result.loss_streak || 0}
                            </span>
                          </td>
                          <td className='px-4 py-3 border border-gray-200'>
                            <span className='force-black-text text-sm'>
                              {result.streak5 || 0}
                            </span>
                          </td>
                        </>
                      )}
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
      
      {/* Custom Floating Scrollbar */}
      {richMode && (
        <div
          ref={scrollbarRef}
          className='fixed bottom-0 left-0 right-0 overflow-x-auto overflow-y-hidden bg-gray-200 border-t-2 border-gray-400'
          style={{ 
            height: '20px',
            zIndex: 9998
          }}
        >
          <div style={{ height: '1px' }}></div>
        </div>
      )}
    </>
  );
};

export default EventPageClient;
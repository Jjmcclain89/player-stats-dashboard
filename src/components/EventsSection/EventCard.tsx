// EventsSection/EventCard.tsx
import React, { useState, useRef, useEffect } from 'react';
import Link from 'next/link';
import { Event, AllEvent } from '../shared/types';
import { formatDate, abbreviateFormat, formatFinish, getFormatHeaderColor } from '../shared/utils';

interface EventCardProps {
  event: AllEvent;
  playerEvent?: Event;
  participated: boolean;
}

const EventCard: React.FC<EventCardProps> = ({ event, playerEvent, participated }) => {
  const eventLink = `/events/${encodeURIComponent(event.name)}`;
  const [showTooltip, setShowTooltip] = useState(false);
  const [lineClamp, setLineClamp] = useState(10);
  const notesRef = useRef<HTMLDivElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);

  // Dynamically calculate line clamp based on available space
  useEffect(() => {
    if (containerRef.current && playerEvent?.notes) {
      const availableHeight = containerRef.current.clientHeight;
      const lineHeight = 20; // approximate line height for text-sm
      const maxLines = Math.floor(availableHeight / lineHeight);
      setLineClamp(Math.max(1, maxLines));
    }
  }, [playerEvent?.notes]);

  // If player didn't participate, show grayed out card
  if (!participated) {
    return (
      <Link href={eventLink} className='block relative' style={{ aspectRatio: '1/1' }}>
        <div className='bg-gray-100 border border-gray-300 rounded-lg shadow-sm w-full h-full flex flex-col opacity-50'>
          {/* Header */}
          <div
            className={`px-3 py-2 border-b border-gray-300 rounded-t-lg ${getFormatHeaderColor(
              event.format
            )}`}
          >
            <div className='flex items-center justify-between'>
              <h4 className='text-base font-bold force-black-text'>
                {event.name}
              </h4>
            </div>
          </div>

          {/* Did Not Play Message */}
          <div className='flex-1 flex items-center justify-center'>
            <span className='text-gray-500 font-medium'>Did not play</span>
          </div>
        </div>
      </Link>
    );
  }

  // Player participated - show normal card with player event data
  return (
    <Link href={eventLink} className='block relative' style={{ aspectRatio: '1/1' }}>
      <div className='bg-white border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition-shadow w-full h-full cursor-pointer flex flex-col'>
        {/* Header */}
        <div
          className={`px-3 py-2 border-b border-gray-200 rounded-t-lg ${getFormatHeaderColor(
            event.format
          )}`}
        >
          <div className='flex items-center justify-between'>
            <h4 className='text-base font-bold force-black-text line-clamp-1'>
              {event.name}
            </h4>
            <div className='flex items-center gap-3 flex-shrink-0'>
              {playerEvent?.record && (
                <span className='force-black-text font-medium text-sm pr-4 line-clamp-1'>
                  {playerEvent.record}
                </span>
              )}
              {playerEvent?.finish && (
                <span className='force-black-text font-medium text-sm line-clamp-1'>
                  {Number(playerEvent.finish) === 1 && '🏆 '}
                  {Number(playerEvent.finish) >= 2 && Number(playerEvent.finish) <= 8 && '🥉 '}
                  {formatFinish(playerEvent.finish)}
                </span>
              )}
            </div>
          </div>
        </div>

        {/* Deck Section with Format and Date */}
        <div className='px-3 py-2 border-b border-gray-200'>
          <div className='flex justify-between items-start'>
            <div className='flex-1'>
              <div className='text-xs text-gray-500 uppercase tracking-wide mb-1'>
                Deck
              </div>
              <div className='text-sm font-medium force-black-text'>
                {playerEvent?.deck || 'No deck'}
              </div>
            </div>
            <div className='text-right ml-3'>
              <div className='text-sm font-medium force-black-text'>
                {abbreviateFormat(event.format)}
              </div>
              <div className='text-xs text-gray-600'>
                {formatDate(event.date)}
              </div>
            </div>
          </div>
        </div>

        {/* Notes Section */}
        <div className='px-3 py-2 flex-1 flex flex-col min-h-0'>
          <div className='text-xs text-gray-500 uppercase tracking-wide mb-1'>
            Notes
          </div>
          <div ref={containerRef} className='relative flex-1 overflow-hidden'>
            <div
              ref={notesRef}
              className='text-sm force-black-text'
              style={{
                overflow: 'hidden',
                display: '-webkit-box',
                WebkitBoxOrient: 'vertical',
                WebkitLineClamp: lineClamp,
              }}
              onMouseEnter={() => playerEvent?.notes && setShowTooltip(true)}
              onMouseLeave={() => setShowTooltip(false)}
            >
              {playerEvent?.notes || 'No notes'}
            </div>
          </div>
        </div>
      </div>

      {/* Tooltip - rendered at Link level to avoid overflow clipping */}
      {showTooltip && playerEvent?.notes && (
        <div className='absolute z-50 bottom-0 left-0 right-0 p-3 bg-gray-900 text-white text-sm rounded-lg shadow-lg pointer-events-none'>
          <div className='whitespace-pre-wrap break-words'>
            {playerEvent.notes}
          </div>
        </div>
      )}
    </Link>
  );
};

export default EventCard;
// EventsSection/EventCard.tsx
import React from 'react';
import Link from 'next/link';
import { Event } from '../shared/types';
import { formatDate, abbreviateFormat, formatFinish, getFormatHeaderColor } from '../shared/utils';

interface EventCardProps {
  event: Event;
}

const EventCard: React.FC<EventCardProps> = ({ event }) => {
  const eventLink = `/events/${encodeURIComponent(event.event_code)}`;

  return (
    <Link href={eventLink} className='block'>
      <div className='bg-white border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition-shadow w-full cursor-pointer'>
        {/* Header */}
        <div
          className={`px-3 py-2 border-b border-gray-200 rounded-t-lg ${getFormatHeaderColor(
            event.format
          )}`}
        >
          <div className='flex items-center justify-between'>
            <h4 className='text-base font-bold force-black-text'>
              {event.event_code}
            </h4>
            <div className='flex items-center gap-3'>
              {event.record && (
                <span className='force-black-text font-medium text-sm pr-4'>
                  {event.record}
                </span>
              )}
              {event.finish && (
                <span className='force-black-text font-medium text-sm'>
                  {formatFinish(event.finish)}
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
                {event.deck || 'No deck'}
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
        <div className='px-3 py-2'>
          <div className='text-xs text-gray-500 uppercase tracking-wide mb-1'>
            Notes
          </div>
          <div className='text-sm force-black-text line-clamp-2 min-h-[2.5rem]'>
            {event.notes || 'No notes'}
            {!event.notes && (
              <div className='invisible'>
                This is invisible placeholder text to ensure
                consistent card height when there are no notes
                present in the event data.
              </div>
            )}
          </div>
        </div>
      </div>
    </Link>
  );
};

export default EventCard;
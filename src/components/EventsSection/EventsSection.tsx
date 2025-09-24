// EventsSection/EventsSection.tsx
import React from 'react';
import EventCard from './EventCard';
import { Player } from '../shared/types';

interface EventsSectionProps {
  selectedPlayer: Player;
}

const EventsSection: React.FC<EventsSectionProps> = ({ selectedPlayer }) => {
  return (
    <div className='bg-white rounded-lg shadow-md p-6'>
      <h3 className='text-xl font-bold mb-6 force-black-text'>
        Events History
      </h3>

      <div className='grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4'>
        {Object.values(selectedPlayer.data.events).map((event, index) => (
          <EventCard key={index} event={event} />
        ))}
      </div>
    </div>
  );
};

export default EventsSection;
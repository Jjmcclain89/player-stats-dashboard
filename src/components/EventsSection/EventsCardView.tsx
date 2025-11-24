// EventsSection/EventsCardView.tsx
import React from 'react';
import EventCard from './EventCard';
import { Event } from '../shared/types';

interface EventsCardViewProps {
  events: Event[];
}

const EventsCardView: React.FC<EventsCardViewProps> = ({ events }) => {
  return (
    <div className='grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4'>
      {events.map((event, index) => (
        <EventCard key={index} event={event} />
      ))}
    </div>
  );
};

export default EventsCardView;
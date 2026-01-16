// EventsSection/EventsCardView.tsx
import React, { useMemo } from 'react';
import EventCard from './EventCard';
import { Event, AllEvent } from '../shared/types';

interface EventsCardViewProps {
  playerEvents: { [key: string]: Event };
  allEvents: { [key: string]: AllEvent };
  seasonSort: 'recent' | 'oldest';
}

interface EventWithStatus {
  event: AllEvent;
  playerEvent?: Event;
  participated: boolean;
}

interface Season {
  year: string;
  events: EventWithStatus[];
}

const EventsCardView: React.FC<EventsCardViewProps> = ({ playerEvents, allEvents, seasonSort }) => {
  // Organize events by season/year
  const seasons = useMemo(() => {
    // Convert allEvents object to array and sort by date
    const allEventsArray = Object.values(allEvents).sort((a, b) =>
      new Date(a.date).getTime() - new Date(b.date).getTime()
    );

    // Remove the most recent event (currently happening)
    const eventsToShow = allEventsArray.slice(0, -1);

    // Group events by year
    const eventsByYear: { [year: string]: EventWithStatus[] } = {};

    eventsToShow.forEach((event) => {
      const year = new Date(event.date).getFullYear().toString();

      if (!eventsByYear[year]) {
        eventsByYear[year] = [];
      }

      // Check if player participated in this event
      const playerEvent = Object.values(playerEvents).find(
        (pe) => pe.event_code === event.name
      );

      eventsByYear[year].push({
        event,
        playerEvent,
        participated: !!playerEvent,
      });
    });

    // Convert to Season array
    const seasonsArray: Season[] = Object.entries(eventsByYear)
      .map(([year, events]) => ({
        year,
        // Events within each season are always sorted old to new
        events: events.sort((a, b) =>
          new Date(a.event.date).getTime() - new Date(b.event.date).getTime()
        ),
      }))
      // Sort seasons based on seasonSort prop
      .sort((a, b) =>
        seasonSort === 'recent'
          ? parseInt(b.year) - parseInt(a.year)  // Most recent first
          : parseInt(a.year) - parseInt(b.year)  // Oldest first
      );

    return seasonsArray;
  }, [allEvents, playerEvents, seasonSort]);

  return (
    <div className='space-y-8'>
      {seasons.map((season) => (
        <div key={season.year}>
          {/* Season Header */}
          <h4 className='text-lg font-bold force-black-text mb-4'>
            Season '{season.year.slice(2)}
          </h4>

          {/* Events Grid */}
          <div className='grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4'>
            {season.events.map((eventWithStatus) => (
              <div key={eventWithStatus.event.id} className='max-w-sm mx-auto w-full'>
                <EventCard
                  event={eventWithStatus.event}
                  playerEvent={eventWithStatus.playerEvent}
                  participated={eventWithStatus.participated}
                />
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
};

export default EventsCardView;
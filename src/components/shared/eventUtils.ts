// components/shared/eventUtils.ts
import { PlayerDataStructure } from './types';

export interface EventResult {
  playerName: string;
  playerId: string;
  deck: string;
  finish: number;
  record?: string;
  notes?: string;
  format: string;
  date: string;
}

export interface EventDetails {
  eventCode: string;
  format: string;
  date: string;
  results: EventResult[];
  totalPlayers: number;
}

export const getEventResults = (
  playerData: PlayerDataStructure,
  eventCode: string
): EventDetails | null => {
  const results: EventResult[] = [];
  let eventFormat = '';
  let eventDate = '';
  let actualEventCode = '';

  // Convert search term to lowercase for case-insensitive matching
  const searchEventCode = eventCode.toLowerCase();

  // Go through all players and their events to find matches
  Object.entries(playerData.players).forEach(([playerId, playerInfo]) => {
    Object.values(playerInfo.events).forEach((event) => {
      // Case-insensitive comparison
      if (event.event_code.toLowerCase() === searchEventCode) {
        // Store event metadata (format and date should be same across all entries)
        if (!eventFormat) {
          eventFormat = event.format;
          eventDate = event.date;
          actualEventCode = event.event_code; // Store the actual event code from data
        }

        // Only add if we have a valid finish position
        if (event.finish && !isNaN(Number(event.finish))) {
          results.push({
            playerName: playerInfo.player_info.full_name,
            playerId: playerId,
            deck: event.deck || 'Unknown Deck',
            finish: Number(event.finish),
            record: event.record,
            notes: event.notes,
            format: event.format,
            date: event.date,
          });
        }
      }
    });
  });

  if (results.length === 0) {
    return null; // Event not found
  }

  // Sort results by finish position (1st, 2nd, 3rd, etc.)
  results.sort((a, b) => a.finish - b.finish);

  return {
    eventCode: actualEventCode, // Use the actual event code from the data
    format: eventFormat,
    date: eventDate,
    results,
    totalPlayers: results.length,
  };
};

// Helper function to get all unique event codes from the data
export const getAllEventCodes = (playerData: PlayerDataStructure): string[] => {
  const eventCodes = new Set<string>();

  Object.values(playerData.players).forEach((playerInfo) => {
    Object.values(playerInfo.events).forEach((event) => {
      eventCodes.add(event.event_code);
    });
  });

  return Array.from(eventCodes).sort();
};
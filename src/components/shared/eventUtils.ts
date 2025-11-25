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
  // Add all the missing statistical fields (making them optional to handle undefined)
  event_id?: number;
  summary?: string;
  day2?: boolean;
  top8?: boolean;
  in_contention?: boolean;
  limited_wins?: number;
  limited_losses?: number;
  limited_draws?: number;
  constructed_wins?: number;
  constructed_losses?: number;
  constructed_draws?: number;
  overall_wins?: number;
  overall_losses?: number;
  overall_draws?: number;
  day1_wins?: number;
  day1_losses?: number;
  day1_draws?: number;
  day2_wins?: number;
  day2_losses?: number;
  day2_draws?: number;
  day3_wins?: number;
  day3_losses?: number;
  day3_draws?: number;
  num_drafts?: number;
  positive_drafts?: number;
  negative_drafts?: number;
  trophy_drafts?: number;
  no_win_drafts?: number;
  win_streak?: number;
  loss_streak?: number;
  streak5?: number;
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
            // Add all the statistical fields
            event_id: event.event_id,
            summary: event.summary,
            day2: event.day2,
            top8: event.top8,
            in_contention: event.in_contention,
            limited_wins: event.limited_wins,
            limited_losses: event.limited_losses,
            limited_draws: event.limited_draws,
            constructed_wins: event.constructed_wins,
            constructed_losses: event.constructed_losses,
            constructed_draws: event.constructed_draws,
            overall_wins: event.overall_wins,
            overall_losses: event.overall_losses,
            overall_draws: event.overall_draws,
            day1_wins: event.day1_wins,
            day1_losses: event.day1_losses,
            day1_draws: event.day1_draws,
            day2_wins: event.day2_wins,
            day2_losses: event.day2_losses,
            day2_draws: event.day2_draws,
            day3_wins: event.day3_wins,
            day3_losses: event.day3_losses,
            day3_draws: event.day3_draws,
            num_drafts: event.num_drafts,
            positive_drafts: event.positive_drafts,
            negative_drafts: event.negative_drafts,
            trophy_drafts: event.trophy_drafts,
            no_win_drafts: event.no_win_drafts,
            win_streak: event.win_streak,
            loss_streak: event.loss_streak,
            streak5: event.streak5,
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
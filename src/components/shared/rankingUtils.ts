// shared/rankingUtils.ts
import { Player, Top10Entry, FilterOptions } from './types';

/**
 * Apply filters to the player pool
 */
export const applyFilters = (
  players: Player[],
  filters: FilterOptions
): Player[] => {
  return players.filter((player) => {
    const stats = player.data.stats;

    // Min events filter
    if (filters.minEvents !== undefined && stats.events.value < filters.minEvents) {
      return false;
    }

    // Min Day 2s filter
    if (filters.minDay2s !== undefined && stats.day2s.value < filters.minDay2s) {
      return false;
    }

    // Max events filter
    if (filters.maxEvents !== undefined && stats.events.value > filters.maxEvents) {
      return false;
    }

    // Min Top 8s filter
    if (filters.minTop8s !== undefined && stats.top8s.value < filters.minTop8s) {
      return false;
    }

    // Has Top 8 filter (at least one Top 8)
    if (filters.hasTop8 && stats.top8s.value === 0) {
      return false;
    }

    // Worlds Players Only filter
    if (filters.worldsPlayersOnly && !player.data.player_info.wc31_qualification) {
      return false;
    }

    // Format filter - check if player has played any events in the specified formats
    if (filters.formats && filters.formats.length > 0) {
      const playerFormats = Object.values(player.data.events).map((event) => event.format);
      const hasMatchingFormat = filters.formats.some((format) =>
        playerFormats.includes(format)
      );
      if (!hasMatchingFormat) {
        return false;
      }
    }

    // Date range filters
    if (filters.startDate || filters.endDate) {
      const playerDates = Object.values(player.data.events).map((event) => event.date);
      
      if (filters.startDate) {
        const hasEventAfterStart = playerDates.some(
          (date) => date >= filters.startDate!
        );
        if (!hasEventAfterStart) {
          return false;
        }
      }
      
      if (filters.endDate) {
        const hasEventBeforeEnd = playerDates.some(
          (date) => date <= filters.endDate!
        );
        if (!hasEventBeforeEnd) {
          return false;
        }
      }
    }

    return true;
  });
};

/**
 * Calculate Top 10 rankings for a given stat from a filtered player pool
 */
export const calculateTop10 = (
  players: Player[],
  statKey: string
): Top10Entry[] => {
  // Filter out players without valid stat values and sort
  const rankedPlayers = players
    .filter((player) => {
      const statValue = player.data.stats[statKey as keyof typeof player.data.stats]?.value;
      return statValue !== null && statValue !== undefined;
    })
    .map((player) => ({
      player_id: player.id,
      player_full_name: player.fullName,
      stat_value: player.data.stats[statKey as keyof typeof player.data.stats].value,
    }))
    .sort((a, b) => {
      // For percentage stats and numeric stats, sort descending (higher is better)
      if (typeof a.stat_value === 'number' && typeof b.stat_value === 'number') {
        return b.stat_value - a.stat_value;
      }
      return 0;
    });

  // Take top 10 and assign ranks
  return rankedPlayers.slice(0, 10).map((player, index) => ({
    rank: index + 1,
    player_full_name: player.player_full_name,
    player_id: player.player_id,
    stat_value: player.stat_value,
  }));
};

/**
 * Calculate a player's rank within the filtered pool for a specific stat
 */
export const calculatePlayerRank = (
  players: Player[],
  selectedPlayer: Player,
  statKey: string
): { rank: number; totalPlayers: number } | null => {
  if (!selectedPlayer || !statKey) return null;

  const playerStatValue = selectedPlayer.data.stats[statKey as keyof typeof selectedPlayer.data.stats]?.value;
  if (playerStatValue === null || playerStatValue === undefined) return null;

  // Get all players with valid values for this stat, sorted
  const rankedPlayers = players
    .filter((player) => {
      const statValue = player.data.stats[statKey as keyof typeof player.data.stats]?.value;
      return statValue !== null && statValue !== undefined;
    })
    .map((player) => ({
      player_id: player.id,
      stat_value: player.data.stats[statKey as keyof typeof player.data.stats].value,
    }))
    .sort((a, b) => {
      if (typeof a.stat_value === 'number' && typeof b.stat_value === 'number') {
        return b.stat_value - a.stat_value;
      }
      return 0;
    });

  // Find the selected player's rank
  const playerIndex = rankedPlayers.findIndex((p) => p.player_id === selectedPlayer.id);

  if (playerIndex < 0) return null;

  return {
    rank: playerIndex + 1,
    totalPlayers: rankedPlayers.length,
  };
};

/**
 * Get list of all stats that can be ranked
 */
export const getRankableStats = (): string[] => {
  return [
    'events',
    'day2s',
    'in_contentions',
    'top8s',
    'overall_wins',
    'overall_win_pct',
    'limited_wins',
    'limited_win_pct',
    'constructed_wins',
    'constructed_win_pct',
    'day1_win_pct',
    'day2_win_pct',
    'day3_win_pct',
    'drafts',
    'winning_drafts_pct',
    'trophy_drafts',
    '5streaks',
  ];
};

/**
 * Check if a stat key is rankable (has numeric values)
 */
export const isRankableStat = (statKey: string): boolean => {
  return getRankableStats().includes(statKey);
};
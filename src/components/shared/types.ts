// shared/types.ts
export interface PlayerInfo {
  first_name?: string;
  last_name?: string;
  full_name: string;
  ecl_qualification?: boolean;
}

export interface StatValue {
  value: any;
  rank?: number | null;
}

export interface PlayerStats {
  events: StatValue;
  day2s: StatValue;
  in_contentions: StatValue;
  top8s: StatValue;
  overall_wins: StatValue;
  overall_losses: StatValue;
  overall_draws: StatValue;
  overall_win_pct: StatValue;
  limited_wins: StatValue;
  limited_losses: StatValue;
  limited_draws: StatValue;
  limited_win_pct: StatValue;
  constructed_wins: StatValue;
  constructed_losses: StatValue;
  constructed_draws: StatValue;
  constructed_win_pct: StatValue;
  day1_wins: StatValue;
  day1_losses: StatValue;
  day1_draws: StatValue;
  day1_win_pct: StatValue;
  day2_wins: StatValue;
  day2_losses: StatValue;
  day2_draws: StatValue;
  day2_win_pct: StatValue;
  day3_wins: StatValue;
  day3_losses: StatValue;
  day3_draws: StatValue;
  day3_win_pct: StatValue;
  drafts: StatValue;
  winning_drafts: StatValue;
  losing_drafts: StatValue;
  winning_drafts_pct: StatValue;
  trophy_drafts: StatValue;
  '5streaks': StatValue;
  overall_record: StatValue;
  limited_record: StatValue;
  constructed_record: StatValue;
  top8_record: StatValue;
}

export interface Event {
  event_code: string;
  event_id?: number;
  date: string;
  format: string;
  deck?: string;
  notes?: string;
  record?: string;
  finish?: number;
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

export interface PlayerData {
  player_info: PlayerInfo;
  stats: PlayerStats;
  events: { [key: string]: Event };
}

export interface Player {
  id: string;
  fullName: string;
  data: PlayerData;
}

// New type for calculated top 10 entries
export interface Top10Entry {
  rank: number;
  player_full_name: string;
  player_id: string;
  stat_value: any;
}

// Updated data structure without pre-calculated top_10
export interface PlayerDataStructure {
  players: { [key: string]: PlayerData };
  // top_10 field removed - will be calculated dynamically
}

// Filter options for player pool
export interface FilterOptions {
  minEvents?: number;
  minDay2s?: number;
  maxEvents?: number;
  minTop8s?: number;
  hasTop8?: boolean;
  EclPlayersOnly?: boolean;
  formats?: string[];
  startDate?: string;
  endDate?: string;
}
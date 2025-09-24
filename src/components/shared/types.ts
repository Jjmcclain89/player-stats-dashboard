// shared/types.ts
export interface PlayerInfo {
  first_name?: string;
  last_name?: string;
  full_name: string;
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
  format: string;
  date: string;
  deck?: string;
  record?: string;
  finish?: string | number;
  notes?: string;
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

export interface Top10Entry {
  rank: number;
  player_full_name: string;
  stat_value: any;
}

export interface PlayerDataStructure {
  players: { [key: string]: PlayerData };
  top_10: { [key: string]: { [key: string]: Top10Entry } };
}
// shared/utils.ts

// Format date function
export const formatDate = (dateString: string): string => {
  if (!dateString) return '-';

  try {
    const date = new Date(dateString);
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    const month = months[date.getMonth()];
    const day = date.getDate();
    const year = date.getFullYear().toString().slice(-2);

    return `${month} '${year}`;
  } catch (error) {
    return dateString;
  }
};

// Format abbreviation function
export const abbreviateFormat = (format: string): string => {
  if (!format) return '-';
  const formatMap: { [key: string]: string } = {
    Standard: 'STD',
    Modern: 'MOD',
    Pioneer: 'PIO',
  };
  return formatMap[format] || format.substring(0, 3).toUpperCase();
};

// Event abbreviation function
export const abbreviateEvent = (event: string): string => {
  if (!event) return '-';
  return event.substring(0, 4).toUpperCase();
};

// Format finish with ordinal suffix
export const formatFinish = (finish: string | number): string => {
  if (!finish) return '';
  const num = parseInt(finish.toString());
  if (isNaN(num)) return finish.toString();

  const suffix = (num: number): string => {
    const lastDigit = num % 10;
    const lastTwoDigits = num % 100;

    if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
      return 'th';
    }

    switch (lastDigit) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  };

  return `${num}${suffix(num)} place`;
};

// Get display name for stat
export const getStatDisplayName = (statKey: string): string => {
  const displayNames: { [key: string]: string } = {
    events: 'Total Events',
    day2s: 'Day 2s',
    in_contentions: 'In Contentions',
    top8s: 'Top 8s',
    overall_wins: 'Overall Wins',
    overall_losses: 'Overall Losses',
    overall_draws: 'Overall Draws',
    overall_win_pct: 'Overall Win %',
    limited_wins: 'Limited Wins',
    limited_losses: 'Limited Losses',
    limited_draws: 'Limited Draws',
    limited_win_pct: 'Limited Win %',
    constructed_wins: 'Constructed Wins',
    constructed_losses: 'Constructed Losses',
    constructed_draws: 'Constructed Draws',
    constructed_win_pct: 'Constructed Win %',
    day1_wins: 'Day 1 Wins',
    day1_losses: 'Day 1 Losses',
    day1_draws: 'Day 1 Draws',
    day1_win_pct: 'Day 1 Win %',
    day2_wins: 'Day 2 Wins',
    day2_losses: 'Day 2 Losses',
    day2_draws: 'Day 2 Draws',
    day2_win_pct: 'Day 2 Win %',
    day3_wins: 'Day 3 Wins',
    day3_losses: 'Day 3 Losses',
    day3_draws: 'Day 3 Draws',
    day3_win_pct: 'Day 3 Win %',
    drafts: 'Total Drafts',
    winning_drafts: 'Winning Drafts',
    losing_drafts: 'Losing Drafts',
    winning_drafts_pct: 'Winning Drafts %',
    trophy_drafts: 'Trophy Drafts',
    '5streaks': '5+ Win Streaks',
    overall_record: 'Overall Record',
    limited_record: 'Limited Record',
    constructed_record: 'Constructed Record',
    top8_record: 'Top 8 Record',
  };
  return displayNames[statKey] || statKey;
};

// Get header color based on format
export const getFormatHeaderColor = (format: string): string => {
  const formatColors: { [key: string]: string } = {
    Standard: 'bg-blue-100',
    Modern: 'bg-green-100',
    Pioneer: 'bg-red-100',
  };
  return formatColors[format] || 'bg-gray-50';
};
// StatsTable/StatsTable.tsx
import React from 'react';
import StatRow from './StatRow';
import { Player } from '../shared/types';

interface StatsTableProps {
  selectedPlayer: Player;
  selectedStat: string | null;
  onStatSelect: (statKey: string) => void;
}

const StatsTable: React.FC<StatsTableProps> = ({
  selectedPlayer,
  selectedStat,
  onStatSelect,
}) => {
  return (
    <div className='bg-white rounded-lg shadow-md p-6 flex-grow'>
      <h2 className='text-xl font-bold mb-6 force-black-text'>
        Overall Statistics
      </h2>

      <div className='overflow-x-auto'>
        <table className='w-full border-collapse border border-gray-200'>
          <tbody>
            <StatRow
              stat1={{
                label: 'Total Events',
                value: selectedPlayer.data.stats.events.value,
                key: 'events',
              }}
              stat2={{
                label: 'Day 2s',
                value: selectedPlayer.data.stats.day2s.value,
                key: 'day2s',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
            <StatRow
              stat1={{
                label: 'In Contentions',
                value: selectedPlayer.data.stats.in_contentions.value,
                key: 'in_contentions',
              }}
              stat2={{
                label: 'Top 8s',
                value: selectedPlayer.data.stats.top8s.value,
                key: 'top8s',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
            <StatRow
              stat1={{
                label: 'Overall Record',
                value: selectedPlayer.data.stats.overall_record.value,
                key: 'overall_record',
              }}
              stat2={{
                label: 'Overall Win %',
                value: `${selectedPlayer.data.stats.overall_win_pct.value}%`,
                key: 'overall_win_pct',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
            <StatRow
              stat1={{
                label: 'Limited Record',
                value: selectedPlayer.data.stats.limited_record.value,
                key: 'limited_record',
              }}
              stat2={{
                label: 'Limited Win %',
                value: `${selectedPlayer.data.stats.limited_win_pct.value}%`,
                key: 'limited_win_pct',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
            <StatRow
              stat1={{
                label: 'Constructed Record',
                value: selectedPlayer.data.stats.constructed_record.value,
                key: 'constructed_record',
              }}
              stat2={{
                label: 'Constructed Win %',
                value: `${selectedPlayer.data.stats.constructed_win_pct.value}%`,
                key: 'constructed_win_pct',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
            <StatRow
              stat1={{
                label: 'Day 1 Win %',
                value: `${selectedPlayer.data.stats.day1_win_pct.value}%`,
                key: 'day1_win_pct',
              }}
              stat2={{
                label: 'Day 2 Win %',
                value: `${selectedPlayer.data.stats.day2_win_pct.value}%`,
                key: 'day2_win_pct',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
            <StatRow
              stat1={{
                label: 'Day 3 Win %',
                value: `${selectedPlayer.data.stats.day3_win_pct.value}%`,
                key: 'day3_win_pct',
              }}
              stat2={{
                label: 'Top 8 Record',
                value: selectedPlayer.data.stats.top8_record.value,
                key: 'top8_record',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
            <StatRow
              stat1={{
                label: 'Total Drafts',
                value: selectedPlayer.data.stats.drafts.value,
                key: 'drafts',
              }}
              stat2={{
                label: 'Winning Drafts %',
                value: `${selectedPlayer.data.stats.winning_drafts_pct.value}%`,
                key: 'winning_drafts_pct',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
            <StatRow
              stat1={{
                label: 'Trophy Drafts',
                value: selectedPlayer.data.stats.trophy_drafts.value,
                key: 'trophy_drafts',
              }}
              stat2={{
                label: '5+ Win Streaks',
                value: selectedPlayer.data.stats['5streaks'].value,
                key: '5streaks',
              }}
              selectedStat={selectedStat}
              onStatSelect={onStatSelect}
            />
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default StatsTable;
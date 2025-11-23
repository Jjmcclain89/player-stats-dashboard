// StatsTable/StatsTable.tsx
import React from 'react';
import StatRow from './StatRow';
import RecordRow from './RecordRow';
import { Player } from '../shared/types';
import { calculatePlayerRank, applyFilters } from '../shared/rankingUtils';

interface StatsTableProps {
  selectedPlayer: Player | null;
  selectedStat: string | null;
  onStatSelect: (statKey: string) => void;
  allPlayers: Player[];
  filters: any;
}

const StatsTable: React.FC<StatsTableProps> = ({
  selectedPlayer,
  selectedStat,
  onStatSelect,
  allPlayers,
  filters,
}) => {
  // Helper to safely get stat value
  const getStatValue = (statPath: string) => {
    if (!selectedPlayer) return '-';
    const keys = statPath.split('.');
    let value: any = selectedPlayer.data.stats;
    for (const key of keys) {
      value = value?.[key];
    }
    return value?.value ?? '-';
  };

  // Helper to get rank for a stat by calculating from filtered player pool
  const getRank = (statKey: string): number | null => {
    if (!selectedPlayer) return null;
    const filteredPlayers = applyFilters(allPlayers, filters);
    const rankInfo = calculatePlayerRank(filteredPlayers, selectedPlayer, statKey);
    return rankInfo?.rank ?? null;
  };

  return (
    <div className='bg-white rounded-lg shadow-md p-6 flex-grow space-y-6 h-full flex flex-col'>
      {/* Rankable Stats Section */}
      <div>
        <h2 className='text-xl font-bold mb-4 force-black-text'>
          Ranked Statistics
        </h2>

        <div className='overflow-x-auto'>
          <table className='w-full border-collapse border border-gray-200'>
            <tbody>
              <StatRow
                stat1={{
                  label: 'Total Events',
                  value: getStatValue('events'),
                  key: 'events',
                  rank: getRank('events'),
                }}
                stat2={{
                  label: 'Day 2s',
                  value: getStatValue('day2s'),
                  key: 'day2s',
                  rank: getRank('day2s'),
                }}
                selectedStat={selectedStat}
                onStatSelect={onStatSelect}
              />
              <StatRow
                stat1={{
                  label: 'In Contentions',
                  value: getStatValue('in_contentions'),
                  key: 'in_contentions',
                  rank: getRank('in_contentions'),
                }}
                stat2={{
                  label: 'Top 8s',
                  value: getStatValue('top8s'),
                  key: 'top8s',
                  rank: getRank('top8s'),
                }}
                selectedStat={selectedStat}
                onStatSelect={onStatSelect}
              />
              <StatRow
                stat1={{
                  label: 'Overall Win %',
                  value: selectedPlayer ? `${getStatValue('overall_win_pct')}%` : '-',
                  key: 'overall_win_pct',
                  rank: getRank('overall_win_pct'),
                }}
                stat2={{
                  label: 'Limited Win %',
                  value: selectedPlayer ? `${getStatValue('limited_win_pct')}%` : '-',
                  key: 'limited_win_pct',
                  rank: getRank('limited_win_pct'),
                }}
                selectedStat={selectedStat}
                onStatSelect={onStatSelect}
              />
              <StatRow
                stat1={{
                  label: 'Constructed Win %',
                  value: selectedPlayer ? `${getStatValue('constructed_win_pct')}%` : '-',
                  key: 'constructed_win_pct',
                  rank: getRank('constructed_win_pct'),
                }}
                stat2={{
                  label: 'Day 1 Win %',
                  value: selectedPlayer ? `${getStatValue('day1_win_pct')}%` : '-',
                  key: 'day1_win_pct',
                  rank: getRank('day1_win_pct'),
                }}
                selectedStat={selectedStat}
                onStatSelect={onStatSelect}
              />
              <StatRow
                stat1={{
                  label: 'Day 2 Win %',
                  value: selectedPlayer ? `${getStatValue('day2_win_pct')}%` : '-',
                  key: 'day2_win_pct',
                  rank: getRank('day2_win_pct'),
                }}
                stat2={{
                  label: 'Day 3 Win %',
                  value: selectedPlayer ? `${getStatValue('day3_win_pct')}%` : '-',
                  key: 'day3_win_pct',
                  rank: getRank('day3_win_pct'),
                }}
                selectedStat={selectedStat}
                onStatSelect={onStatSelect}
              />
              <StatRow
                stat1={{
                  label: 'Total Drafts',
                  value: getStatValue('drafts'),
                  key: 'drafts',
                  rank: getRank('drafts'),
                }}
                stat2={{
                  label: 'Winning Drafts %',
                  value: selectedPlayer ? `${getStatValue('winning_drafts_pct')}%` : '-',
                  key: 'winning_drafts_pct',
                  rank: getRank('winning_drafts_pct'),
                }}
                selectedStat={selectedStat}
                onStatSelect={onStatSelect}
              />
              <StatRow
                stat1={{
                  label: 'Trophy Drafts',
                  value: getStatValue('trophy_drafts'),
                  key: 'trophy_drafts',
                  rank: getRank('trophy_drafts'),
                }}
                stat2={{
                  label: '5+ Win Streaks',
                  value: selectedPlayer ? getStatValue('5streaks') : '-',
                  key: '5streaks',
                  rank: getRank('5streaks'),
                }}
                selectedStat={selectedStat}
                onStatSelect={onStatSelect}
              />
            </tbody>
          </table>
        </div>
      </div>

      {/* Non-Rankable Stats Section */}
      <div>
        <h2 className='text-xl font-bold mb-4 force-black-text'>
          Records
        </h2>

        <div className='overflow-x-auto'>
          <table className='w-full border-collapse border border-gray-200'>
            <tbody>
              <RecordRow
                record1={{
                  label: 'Overall Record',
                  value: getStatValue('overall_record'),
                }}
                record2={{
                  label: 'Limited Record',
                  value: getStatValue('limited_record'),
                }}
              />
              <RecordRow
                record1={{
                  label: 'Constructed Record',
                  value: getStatValue('constructed_record'),
                }}
                record2={{
                  label: 'Top 8 Record',
                  value: getStatValue('top8_record'),
                }}
              />
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default StatsTable;
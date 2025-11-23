// StatsTable/StatRow.tsx
import React, { useState } from 'react';

interface StatRowProps {
  stat1: { label: string; value: any; key: string; rank?: number | null };
  stat2?: { label: string; value: any; key: string; rank?: number | null };
  selectedStat: string | null;
  onStatSelect: (statKey: string) => void;
  showRank?: boolean;
}

const StatRow: React.FC<StatRowProps> = ({
  stat1,
  stat2,
  selectedStat,
  onStatSelect,
  showRank = true,
}) => {
  const [hoveredStat, setHoveredStat] = useState<string | null>(null);

  // Helper to format rank with ordinal suffix
  const formatRank = (rank: number | null | undefined): string => {
    if (!rank) return '-';
    
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

    return `${rank}${suffix(rank)}`;
  };

  const renderStatCell = (stat: { label: string; value: any; key: string; rank?: number | null }) => (
    <div
      className={`flex cursor-pointer ${
        selectedStat === stat.key
          ? 'bg-blue-100 force-blue-text'
          : hoveredStat === stat.key
          ? 'bg-blue-50 force-black-text'
          : 'force-black-text'
      }`}
      onClick={() => onStatSelect(stat.key)}
      onMouseEnter={() => setHoveredStat(stat.key)}
      onMouseLeave={() => setHoveredStat(null)}
    >
      <div className={`px-3 py-2 border-b text-left font-medium ${showRank ? 'w-1/2' : 'w-1/2'} border-r text-sm whitespace-nowrap overflow-hidden text-ellipsis`}>
        {stat.label}
      </div>
      <div className={`px-3 py-2 border-b text-left ${showRank ? 'w-1/4 border-r' : 'w-1/2'} text-sm`}>
        {stat.value}
      </div>
      {showRank && (
        <div className='px-3 py-2 border-b text-center w-1/4 border-r text-sm text-gray-500'>
          {formatRank(stat.rank)}
        </div>
      )}
    </div>
  );

  return (
    <tr className='flex flex-col lg:flex-row lg:table-row'>
      <td colSpan={2} className='p-0 w-full lg:w-auto'>
        {renderStatCell(stat1)}
      </td>
      {stat2 ? (
        <td colSpan={2} className='p-0 w-full lg:w-auto'>
          {renderStatCell(stat2)}
        </td>
      ) : (
        <td
          colSpan={2}
          className='hidden lg:table-cell px-3 py-2 border-b text-left force-black-text'
        ></td>
      )}
    </tr>
  );
};

export default StatRow;
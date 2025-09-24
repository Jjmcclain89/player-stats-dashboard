// StatsTable/StatRow.tsx
import React, { useState } from 'react';

interface StatRowProps {
  stat1: { label: string; value: any; key: string };
  stat2?: { label: string; value: any; key: string };
  selectedStat: string | null;
  onStatSelect: (statKey: string) => void;
}

const StatRow: React.FC<StatRowProps> = ({
  stat1,
  stat2,
  selectedStat,
  onStatSelect,
}) => {
  const [hoveredStat, setHoveredStat] = useState<string | null>(null);

  const renderStatCell = (stat: { label: string; value: any; key: string }) => (
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
      <div className='px-3 py-2 border-b text-left font-medium w-1/2 border-r'>
        {stat.label}
      </div>
      <div className='px-3 py-2 border-b text-left w-1/2'>
        {stat.value}
      </div>
    </div>
  );

  return (
    <tr>
      <td colSpan={2} className='p-0'>
        {renderStatCell(stat1)}
      </td>
      {stat2 ? (
        <td colSpan={2} className='p-0'>
          {renderStatCell(stat2)}
        </td>
      ) : (
        <td
          colSpan={2}
          className='px-3 py-2 border-b text-left force-black-text'
        ></td>
      )}
    </tr>
  );
};

export default StatRow;
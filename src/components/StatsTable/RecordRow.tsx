// StatsTable/RecordRow.tsx
import React from 'react';

interface RecordRowProps {
  record1: { label: string; value: string };
  record2?: { label: string; value: string };
}

const formatLabel = (label: string) => {
  return label.replace("Record", "");
}

const RecordRow: React.FC<RecordRowProps> = ({ record1, record2 }) => {
  return (
    <tr className='flex flex-col lg:flex-row lg:table-row'>
      <td className='px-3 py-2 border-b text-left font-medium text-sm force-black-text w-full lg:w-1/4 border-r'>
        {formatLabel(record1.label)}
      </td>
      <td className='px-3 py-2 border-b text-left text-sm force-black-text w-full lg:w-1/4 border-r'>
        {record1.value}
      </td>
      {record2 ? (
        <>
          <td className='px-3 py-2 border-b text-left font-medium text-sm force-black-text w-full lg:w-1/4 border-r'>
            {formatLabel(record2.label)}
          </td>
          <td className='px-3 py-2 border-b text-left text-sm force-black-text w-full lg:w-1/4 border-r'>
            {record2.value}
          </td>
        </>
      ) : (
        <>
          <td className='hidden lg:table-cell px-3 py-2 border-b force-black-text lg:w-1/4 border-r'></td>
          <td className='hidden lg:table-cell px-3 py-2 border-b force-black-text lg:w-1/4 border-r'></td>
        </>
      )}
    </tr>
  );
};

export default RecordRow;
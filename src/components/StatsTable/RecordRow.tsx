// StatsTable/RecordRow.tsx
import React from 'react';

interface RecordRowProps {
  record1: { label: string; value: string };
  record2?: { label: string; value: string };
}

const RecordRow: React.FC<RecordRowProps> = ({ record1, record2 }) => {
  return (
    <tr className='flex flex-col lg:flex-row lg:table-row'>
      <td className='px-3 py-2 border-b text-left font-medium text-sm force-black-text w-full lg:w-1/4'>
        {record1.label}
      </td>
      <td className='px-3 py-2 border-b text-left text-sm force-black-text w-full lg:w-1/4'>
        {record1.value}
      </td>
      {record2 ? (
        <>
          <td className='px-3 py-2 border-b text-left font-medium text-sm force-black-text w-full lg:w-1/4'>
            {record2.label}
          </td>
          <td className='px-3 py-2 border-b text-left text-sm force-black-text w-full lg:w-1/4'>
            {record2.value}
          </td>
        </>
      ) : (
        <>
          <td className='hidden lg:table-cell px-3 py-2 border-b force-black-text lg:w-1/4'></td>
          <td className='hidden lg:table-cell px-3 py-2 border-b force-black-text lg:w-1/4'></td>
        </>
      )}
    </tr>
  );
};

export default RecordRow;
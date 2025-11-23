// StatsTable/RecordRow.tsx
import React from 'react';

interface RecordRowProps {
  record1: { label: string; value: string };
  record2?: { label: string; value: string };
}

const RecordRow: React.FC<RecordRowProps> = ({ record1, record2 }) => {
  return (
    <tr>
      <td className='px-3 py-2 border-b text-left font-medium text-sm force-black-text w-1/4 border-r'>
        {record1.label}
      </td>
      <td className='px-3 py-2 border-b text-left text-sm force-black-text w-1/4 border-r'>
        {record1.value}
      </td>
      {record2 ? (
        <>
          <td className='px-3 py-2 border-b text-left font-medium text-sm force-black-text w-1/4 border-r'>
            {record2.label}
          </td>
          <td className='px-3 py-2 border-b text-left text-sm force-black-text w-1/4 border-r'>
            {record2.value}
          </td>
        </>
      ) : (
        <>
          <td className='px-3 py-2 border-b force-black-text w-1/4'></td>
          <td className='px-3 py-2 border-b force-black-text w-1/4'></td>
        </>
      )}
    </tr>
  );
};

export default RecordRow;
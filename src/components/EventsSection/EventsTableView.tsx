// EventsSection/EventsTableView.tsx
import React, { useState, useMemo, useRef, useEffect } from 'react';
import Link from 'next/link';
import { Event } from '../shared/types';
import { abbreviateFormat, abbreviateEvent } from '../shared/utils';

interface EventsTableViewProps {
  events: Event[];
}

type SortField = keyof Event | null;
type SortDirection = 'asc' | 'desc';

interface SortableHeaderProps {
  field: keyof Event;
  label: string;
  align?: 'left' | 'center';
  sortField: SortField;
  sortDirection: SortDirection;
  onSort: (field: keyof Event) => void;
  columnIndex: number;
  hoveredColumn: number | null;
}

const SortableHeader: React.FC<SortableHeaderProps> = ({ 
  field, 
  label, 
  align = 'center',
  sortField, 
  sortDirection, 
  onSort,
  columnIndex,
  hoveredColumn
}) => {
  const isActive = sortField === field;
  const isHovered = hoveredColumn === columnIndex;
  const textAlign = align === 'left' ? 'text-left' : 'text-center';
  
  // Create tooltip text from field name: capitalize and replace underscores with spaces
  const tooltipText = field
    .split('_')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
  
  return (
    <th 
      className={`px-2 py-1 border-b border-r font-semibold force-black-text whitespace-nowrap text-xs cursor-pointer hover:bg-gray-300 select-none ${textAlign} relative group transition-colors ${isHovered ? 'bg-blue-200' : ''}`}
      onClick={() => onSort(field)}
      title={tooltipText}
    >
      {label}
      <span className='ml-1'>
        {isActive ? (sortDirection === 'asc' ? '↑' : '↓') : <span className='text-gray-400'>↕</span>}
      </span>
      
      {/* Tooltip */}
      <div className='absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-2 py-1 bg-gray-800 text-white text-xs rounded whitespace-nowrap opacity-0 group-hover:opacity-100 pointer-events-none transition-opacity duration-200 z-10'>
        {tooltipText}
        <div className='absolute top-full left-1/2 -translate-x-1/2 -mt-1 border-4 border-transparent border-t-gray-800'></div>
      </div>
    </th>
  );
};

interface TableCellProps {
  children: React.ReactNode;
  align?: 'left' | 'center';
  extraClasses?: string;
  isFirstColumn?: boolean;
  columnIndex?: number;
  onMouseEnter?: (index: number) => void;
  onMouseLeave?: () => void;
}

const TableCell: React.FC<TableCellProps> = ({ 
  children, 
  align = 'center', 
  extraClasses = '',
  isFirstColumn = false,
  columnIndex,
  onMouseEnter,
  onMouseLeave
}) => {
  const textAlign = align === 'left' ? 'text-left' : 'text-center';
  const borderLeft = isFirstColumn ? 'border-l' : '';
  
  const handleMouseEnter = () => {
    if (columnIndex !== undefined && onMouseEnter) {
      onMouseEnter(columnIndex);
    }
  };
  
  return (
    <td 
      className={`px-2 py-1 border-b border-t-gray-800 border-t-8 border-r force-black-text whitespace-nowrap text-xs ${textAlign} ${borderLeft} ${extraClasses}`}
      onMouseEnter={handleMouseEnter}
      onMouseLeave={onMouseLeave}
    >
      {children}
    </td>
  );
};

const EventsTableView: React.FC<EventsTableViewProps> = ({ events }) => {
  const [sortField, setSortField] = useState<SortField>(null);
  const [sortDirection, setSortDirection] = useState<SortDirection>('asc');
  const [hoveredColumn, setHoveredColumn] = useState<number | null>(null);
  const [tableWidth, setTableWidth] = useState(0);
  
  const topScrollRef = useRef<HTMLDivElement>(null);
  const tableScrollRef = useRef<HTMLDivElement>(null);
  const tableRef = useRef<HTMLTableElement>(null);

  // Update table width whenever it changes
  useEffect(() => {
    const updateWidth = () => {
      if (tableRef.current) {
        setTableWidth(tableRef.current.scrollWidth);
      }
    };

    updateWidth();
    window.addEventListener('resize', updateWidth);
    
    // Use a slight delay to ensure table is rendered
    const timer = setTimeout(updateWidth, 100);
    
    return () => {
      window.removeEventListener('resize', updateWidth);
      clearTimeout(timer);
    };
  }, [events, sortField, sortDirection]);

  // Sync scrolling between top and table scrollbars
  useEffect(() => {
    const topScroll = topScrollRef.current;
    const tableScroll = tableScrollRef.current;
    
    if (!topScroll || !tableScroll) return;

    const handleTopScroll = () => {
      if (tableScroll.scrollLeft !== topScroll.scrollLeft) {
        tableScroll.scrollLeft = topScroll.scrollLeft;
      }
    };

    const handleTableScroll = () => {
      if (topScroll.scrollLeft !== tableScroll.scrollLeft) {
        topScroll.scrollLeft = tableScroll.scrollLeft;
      }
    };

    topScroll.addEventListener('scroll', handleTopScroll);
    tableScroll.addEventListener('scroll', handleTableScroll);

    return () => {
      topScroll.removeEventListener('scroll', handleTopScroll);
      tableScroll.removeEventListener('scroll', handleTableScroll);
    };
  }, []);

  const handleSort = (field: keyof Event) => {
    if (sortField === field) {
      // Toggle direction if same field
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    } else {
      // New field, default to ascending
      setSortField(field);
      setSortDirection('asc');
    }
  };

  const sortedEvents = useMemo(() => {
    if (!sortField) return events;

    return [...events].sort((a, b) => {
      const aValue = a[sortField];
      const bValue = b[sortField];

      // Handle null/undefined values
      if (aValue == null && bValue == null) return 0;
      if (aValue == null) return 1;
      if (bValue == null) return -1;

      // Compare values
      let comparison = 0;
      if (typeof aValue === 'string' && typeof bValue === 'string') {
        comparison = aValue.localeCompare(bValue);
      } else if (typeof aValue === 'number' && typeof bValue === 'number') {
        comparison = aValue - bValue;
      } else if (typeof aValue === 'boolean' && typeof bValue === 'boolean') {
        comparison = (aValue === bValue) ? 0 : aValue ? 1 : -1;
      } else {
        comparison = String(aValue).localeCompare(String(bValue));
      }

      return sortDirection === 'asc' ? comparison : -comparison;
    });
  }, [events, sortField, sortDirection]);

  return (
    <div>
      {/* Top scrollbar - only shows when table overflows */}
      <div 
        ref={topScrollRef}
        className='overflow-x-auto overflow-y-hidden bg-gray-100 border border-gray-300 rounded'
        style={{ height: '16px' }}
      >
        <div style={{ width: `${tableWidth}px`, height: '1px' }}></div>
      </div>

      {/* Main table with scrollbar */}
      <div ref={tableScrollRef} className='overflow-x-auto mt-2'>
        <table ref={tableRef} className='w-full border-collapse border'>
          <thead>
            <tr className='bg-gray-200 border'>
              <SortableHeader field='event_code' label='Event' align='left' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={0} hoveredColumn={hoveredColumn} />
              <SortableHeader field='format' label='Frmt' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={1} hoveredColumn={hoveredColumn} />
              <SortableHeader field='event_id' label='Ev#' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={2} hoveredColumn={hoveredColumn} />
              <SortableHeader field='finish' label='Rank' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={3} hoveredColumn={hoveredColumn} />
              <SortableHeader field='summary' label='Summary' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={4} hoveredColumn={hoveredColumn} />
              <SortableHeader field='deck' label='Deck' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={5} hoveredColumn={hoveredColumn} />
              <SortableHeader field='day2' label='D2s' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={6} hoveredColumn={hoveredColumn} />
              <SortableHeader field='in_contention' label='InCont' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={28} hoveredColumn={hoveredColumn} />
              <SortableHeader field='top8' label='T8s' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={7} hoveredColumn={hoveredColumn} />
              <SortableHeader field='overall_wins' label='Record' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={19} hoveredColumn={hoveredColumn} />
              <SortableHeader field='limited_wins' label='Ltd Rec' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={8} hoveredColumn={hoveredColumn} />
              <SortableHeader field='num_drafts' label='# dfts' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={11} hoveredColumn={hoveredColumn} />
              <SortableHeader field='positive_drafts' label='+ dfts' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={12} hoveredColumn={hoveredColumn} />
              <SortableHeader field='negative_drafts' label='- dfts' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={13} hoveredColumn={hoveredColumn} />
              <SortableHeader field='trophy_drafts' label='🏆s' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={14} hoveredColumn={hoveredColumn} />
              <SortableHeader field='no_win_drafts' label='0W dfts' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={15} hoveredColumn={hoveredColumn} />
              <SortableHeader field='constructed_wins' label='Cn Rec' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={16} hoveredColumn={hoveredColumn} />
              <SortableHeader field='day1_wins' label='D1 Rec' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={22} hoveredColumn={hoveredColumn} />
              <SortableHeader field='day2_wins' label='D2 Rec' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={25} hoveredColumn={hoveredColumn} />
              <SortableHeader field='day3_wins' label='D3 Rec' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={29} hoveredColumn={hoveredColumn} />
              <SortableHeader field='win_streak' label='WSt' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={32} hoveredColumn={hoveredColumn} />
              <SortableHeader field='loss_streak' label='LSt' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={33} hoveredColumn={hoveredColumn} />
              <SortableHeader field='streak5' label='5+St' sortField={sortField} sortDirection={sortDirection} onSort={handleSort} columnIndex={34} hoveredColumn={hoveredColumn} />
            </tr>
          </thead>
          <tbody>
            {sortedEvents.map((event, index) => (
              <React.Fragment key={index}>
                <tr className='hover:bg-gray-50'>
                  <TableCell isFirstColumn align='left' extraClasses='font-medium bg-blue-100' columnIndex={0} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>
                    <Link 
                      href={`/events/${event.event_code}`}
                      className='text-blue-600 hover:text-blue-800 hover:underline'
                    >
                      {abbreviateEvent(event.event_code)}
                    </Link>
                  </TableCell>
                  <TableCell columnIndex={1} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{abbreviateFormat(event.format)}</TableCell>
                  <TableCell columnIndex={2} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.event_id}</TableCell>
                  <TableCell extraClasses='font-medium' columnIndex={3} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.finish}</TableCell>
                  <TableCell columnIndex={4} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.summary || '-'}</TableCell>
                  <TableCell columnIndex={5} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.deck || '-'}</TableCell>
                  <TableCell extraClasses={event.day2 ? 'bg-green-100' : ''} columnIndex={6} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.day2 ? '✓' : ''}</TableCell>
                  <TableCell extraClasses={event.top8 ? 'bg-green-100' : ''} columnIndex={7} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.top8 ? '✓' : ''}</TableCell>
                  <TableCell extraClasses={event.in_contention ? 'bg-green-100' : ''} columnIndex={28} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.in_contention ? '✓' : ''}</TableCell>
                  <TableCell columnIndex={19} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.record}</TableCell>
                  <TableCell columnIndex={8} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{`${event.limited_wins}-${event.limited_losses}-${event.limited_draws}`}</TableCell>
                  <TableCell columnIndex={11} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.num_drafts}</TableCell>
                  <TableCell columnIndex={12} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.positive_drafts}</TableCell>
                  <TableCell columnIndex={13} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.negative_drafts}</TableCell>
                  <TableCell columnIndex={14} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.trophy_drafts}</TableCell>
                  <TableCell columnIndex={15} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.no_win_drafts}</TableCell>
                  <TableCell columnIndex={16} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{`${event.constructed_wins}-${event.constructed_losses}-${event.constructed_draws}`}</TableCell>
                  <TableCell columnIndex={22} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{`${event.day1_wins}-${event.day1_losses}-${event.day1_draws}`}</TableCell>
                  <TableCell columnIndex={25} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{`${event.day2_wins}-${event.day2_losses}-${event.day2_draws}`}</TableCell>
                  <TableCell columnIndex={29} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{`${event.day3_wins}-${event.day3_losses}-${event.day3_draws}`}</TableCell>
                  <TableCell columnIndex={32} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.win_streak}</TableCell>
                  <TableCell columnIndex={33} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.loss_streak}</TableCell>
                  <TableCell columnIndex={34} onMouseEnter={setHoveredColumn} onMouseLeave={() => setHoveredColumn(null)}>{event.streak5}</TableCell>
                </tr>
                <tr>
                  <td className='px-2 py-1 border-l border-b-gray-800 border-b-8 border-r force-black-text whitespace-nowrap text-xs'>Notes</td>
                  <td colSpan={34} className='px-2 py-1 border-b-gray-800 border-b-8 border-r force-black-text whitespace-nowrap text-xs'>{event.notes || '-'}</td>
                </tr>
              </React.Fragment>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default EventsTableView;
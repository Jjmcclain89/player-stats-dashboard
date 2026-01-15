// TournamentSearchBar.tsx - Simplified search bar for tournament page (no ECL toggle)
import React from 'react';
import { Search, X } from 'lucide-react';
import { Player, FilterOptions } from '../shared/types';

interface TournamentSearchBarProps {
  searchTerm: string;
  onSearchChange: (value: string) => void;
  onPlayerSelect: (player: Player) => void;
  filteredPlayers: Player[];
  showDropdown: boolean;
  onShowDropdownChange: (show: boolean) => void;
  filters: FilterOptions;
  onFiltersChange: (filters: FilterOptions) => void;
  totalPlayers: number;
  filteredPlayerCount: number;
}

export const normalizeText = (text: string): string => {
  return text
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();
};

const TournamentSearchBar: React.FC<TournamentSearchBarProps> = ({
  searchTerm,
  onSearchChange,
  onPlayerSelect,
  filteredPlayers,
  showDropdown,
  onShowDropdownChange,
  filters,
  onFiltersChange,
  totalPlayers,
  filteredPlayerCount,
}) => {
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    onSearchChange(e.target.value);
    onShowDropdownChange(true);
  };

  const handlePlayerSelect = (player: Player) => {
    onPlayerSelect(player);
    onShowDropdownChange(false);
  };

  const handleFilterChange = (newFilters: Partial<FilterOptions>) => {
    onFiltersChange({ ...filters, ...newFilters });
  };

  const clearFilters = () => {
    onFiltersChange({});
    onSearchChange('');
  };

  const hasActiveFilters = Object.keys(filters).length > 0 || searchTerm !== '';

  return (
    <div className='bg-white rounded-lg shadow-md p-4 mb-6' style={{ width: 'fit-content' }}>
      <div className='relative'>
        {/* Horizontal layout: Search bar and filters (no ECL toggle) */}
        <div className='flex items-center gap-3'>
          {/* Search Bar */}
          <div className='relative' style={{ width: '200px' }}>
            <Search className='absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5' />
            <input
              type='text'
              value={searchTerm}
              onChange={handleInputChange}
              onFocus={() => onShowDropdownChange(true)}
              onBlur={() => setTimeout(() => onShowDropdownChange(false), 200)}
              placeholder='Search player...'
              className='w-full pl-10 pr-9 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent force-black-text'
            />
            {searchTerm && (
              <button
                onClick={() => onSearchChange('')}
                className='absolute right-2 top-1/2 transform -translate-y-1/2 text-red-500 hover:text-red-700 transition-colors'
              >
                <X className='w-4 h-4' />
              </button>
            )}
          </div>

          {/* Min Events */}
          <div className='flex items-center gap-2'>
            <label className='text-sm font-medium text-gray-700 whitespace-nowrap'>
              Min Events
            </label>
            <input
              type='number'
              min='0'
              value={filters.minEvents ?? ''}
              onChange={(e) =>
                handleFilterChange({
                  minEvents: e.target.value ? parseInt(e.target.value) : undefined,
                })
              }
              className='w-20 px-3 py-2.5 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent'
              placeholder='Any'
              style={{ color: '#000000' }}
            />
          </div>

          {/* Min Day 2s */}
          <div className='flex items-center gap-2'>
            <label className='text-sm font-medium text-gray-700 whitespace-nowrap'>
              Min Day 2s
            </label>
            <input
              type='number'
              min='0'
              value={filters.minDay2s ?? ''}
              onChange={(e) =>
                handleFilterChange({
                  minDay2s: e.target.value ? parseInt(e.target.value) : undefined,
                })
              }
              className='w-20 px-3 py-2.5 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent'
              placeholder='Any'
              style={{ color: '#000000' }}
            />
          </div>

          {/* Min Top 8s */}
          <div className='flex items-center gap-2'>
            <label className='text-sm font-medium text-gray-700 whitespace-nowrap'>
              Min Top 8s
            </label>
            <input
              type='number'
              min='0'
              value={filters.minTop8s ?? ''}
              onChange={(e) =>
                handleFilterChange({
                  minTop8s: e.target.value ? parseInt(e.target.value) : undefined,
                })
              }
              className='w-20 px-3 py-2.5 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent'
              placeholder='Any'
              style={{ color: '#000000' }}
            />
          </div>

          {/* Player Count */}
          <div className='ml-auto text-sm text-gray-600 whitespace-nowrap'>
            {filteredPlayerCount} players
          </div>

          {/* Clear Filters Button */}
          {hasActiveFilters && (
            <button
              onClick={clearFilters}
              className='px-3 py-2.5 text-sm text-blue-600 hover:text-blue-800 hover:bg-blue-50 rounded-lg transition-colors flex items-center gap-1 whitespace-nowrap'
            >
              <X className='w-4 h-4' />
              Clear
            </button>
          )}
        </div>

        {/* Player Dropdown */}
        {showDropdown && filteredPlayers.length > 0 && (
          <div className='absolute z-50 left-0 mt-1 bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto' style={{ maxWidth: '400px' }}>
            {filteredPlayers.map((player) => (
              <div
                key={player.id}
                onClick={() => handlePlayerSelect(player)}
                className='px-4 py-3 hover:bg-blue-50 cursor-pointer border-b last:border-b-0 force-black-text'
              >
                {player.fullName}
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default TournamentSearchBar;

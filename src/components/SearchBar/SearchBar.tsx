// SearchBar/SearchBar.tsx
import React, { useState } from 'react';
import { Search, Filter, X } from 'lucide-react';
import { Player, FilterOptions } from '../shared/types';

interface SearchBarProps {
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

// Helper function to normalize text by removing accents - EXPORTED
export const normalizeText = (text: string): string => {
  return text
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();
};

const SearchBar: React.FC<SearchBarProps> = ({
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
  const [showFilters, setShowFilters] = useState(true);

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
  };

  const hasActiveFilters = Object.keys(filters).length > 0;

  return (
    <div className='bg-white rounded-lg shadow-md p-6 mb-8 h-full flex flex-col'>
      <div className='relative flex-shrink-0'>
        {/* Search Bar with Filter Button */}
        <div className='flex items-center gap-2'>
          <div className='flex-1 relative'>
            <Search className='absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5' />
            <input
              type='text'
              value={searchTerm}
              onChange={handleInputChange}
              onFocus={() => onShowDropdownChange(true)}
              placeholder='Search for a player...'
              className='w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent force-black-text'
            />
          </div>

          {/* Filter Toggle Button */}
          <button
            onClick={() => setShowFilters(!showFilters)}
            className={`p-3 rounded-lg transition-colors ${
              hasActiveFilters
                ? 'bg-blue-100 text-blue-600 hover:bg-blue-200'
                : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
            }`}
            title='Filter player pool'
          >
            <Filter className='w-5 h-5' />
          </button>
        </div>

        {/* Player Dropdown */}
        {showDropdown && filteredPlayers.length > 0 && (
          <div className='absolute z-10 w-full mt-1 bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto'>
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

        {/* Filter Panel */}
        {showFilters && (
          <div className='mt-4 p-4 bg-gray-50 rounded-lg border border-gray-200'>
            <div className='flex items-center justify-between mb-3'>
              <h4 className='text-sm font-semibold force-black-text'>
                Filter Player Pool
              </h4>
              {hasActiveFilters && (
                <button
                  onClick={clearFilters}
                  className='text-xs text-blue-600 hover:text-blue-800 flex items-center gap-1'
                >
                  <X className='w-3 h-3' />
                  Clear All
                </button>
              )}
            </div>

            <div className='space-y-3'>
              {/* Worlds Mode Toggle */}
              <div
                onClick={() =>
                  handleFilterChange({
                    EclPlayersOnly: !filters.EclPlayersOnly || undefined,
                  })
                }
                className='flex items-center justify-between cursor-pointer'
              >
                <span className={`font-medium text-base ${
                  filters.EclPlayersOnly ? 'text-purple-600' : 'text-gray-700'
                }`}>
                  ECL Players Only
                </span>
                
                {/* Toggle Switch */}
                <div className='relative'>
                  <div
                    className={`w-12 h-6 rounded-full transition-colors ${
                      filters.EclPlayersOnly ? 'bg-purple-600' : 'bg-gray-300'
                    }`}
                  >
                    <div
                      className={`absolute top-0.5 left-0.5 w-5 h-5 rounded-full transition-transform bg-white ${
                        filters.EclPlayersOnly
                          ? 'translate-x-6'
                          : 'translate-x-0'
                      }`}
                    />
                  </div>
                </div>
              </div>

              {/* Min Events, Day 2s, Top 8s - All on one line */}
              <div className='grid grid-cols-3 gap-2'>
                <div>
                  <label className='block text-xs font-medium text-gray-700 mb-1'>
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
                    className='w-full px-2 py-1 text-sm border border-gray-300 rounded focus:ring-2 focus:ring-blue-500 focus:border-transparent'
                    placeholder='Any'
                    style={{ color: '#000000' }}
                    
                  />
                </div>

                <div>
                  <label className='block text-xs font-medium text-gray-700 mb-1'>
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
                    className='w-full px-2 py-1 text-sm border border-gray-300 rounded focus:ring-2 focus:ring-blue-500 focus:border-transparent'
                    placeholder='Any'
                    style={{ color: '#000000' }}
                  />
                </div>

                <div>
                  <label className='block text-xs font-medium text-gray-700 mb-1'>
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
                    className='w-full px-2 py-1 text-sm border border-gray-300 rounded focus:ring-2 focus:ring-blue-500 focus:border-transparent'
                    placeholder='Any'
                    style={{ color: '#000000' }}
                  />
                </div>
              </div>
            </div>

            {/* Filter Info */}
            <div className='mt-3 pt-3 border-t border-gray-200'>
              <p className='text-xs text-gray-600 text-right'>
                {filteredPlayerCount} players
              </p>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default SearchBar;
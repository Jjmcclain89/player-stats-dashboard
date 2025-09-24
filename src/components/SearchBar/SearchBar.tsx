// SearchBar/SearchBar.tsx
import React, { useState } from 'react';
import { Search } from 'lucide-react';
import { Player } from '../shared/types';

interface SearchBarProps {
  searchTerm: string;
  onSearchChange: (value: string) => void;
  onPlayerSelect: (player: Player) => void;
  filteredPlayers: Player[];
  showDropdown: boolean;
  onShowDropdownChange: (show: boolean) => void;
}

const SearchBar: React.FC<SearchBarProps> = ({
  searchTerm,
  onSearchChange,
  onPlayerSelect,
  filteredPlayers,
  showDropdown,
  onShowDropdownChange,
}) => {
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    onSearchChange(e.target.value);
    onShowDropdownChange(true);
  };

  const handlePlayerSelect = (player: Player) => {
    onPlayerSelect(player);
    onShowDropdownChange(false);
  };

  return (
    <div className='bg-white rounded-lg shadow-md p-6 mb-8'>
      <div className='relative'>
        <div className='flex items-center'>
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

        {/* Dropdown */}
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
      </div>
    </div>
  );
};

export default SearchBar;
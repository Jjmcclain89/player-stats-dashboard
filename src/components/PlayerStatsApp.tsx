'use client';

import React, { useState, useMemo, useEffect } from 'react';
import playerDataJson from '../data/data.json';
import { SearchBar } from './SearchBar';
import { StatsTable } from './StatsTable';
import { EventsSection } from './EventsSection';
import { Top10Panel } from './Top10Panel';
import { Player, PlayerDataStructure } from './shared/types';

const PlayerStatsApp = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedPlayer, setSelectedPlayer] = useState<Player | null>(null);
  const [showDropdown, setShowDropdown] = useState(false);
  const [selectedStat, setSelectedStat] = useState<string | null>(null);
  const [playerData] = useState(playerDataJson as unknown as PlayerDataStructure);

  // Extract all players for autocomplete
  const players = useMemo(() => {
    return Object.entries(playerData.players).map(([key, data]) => ({
      id: key,
      fullName: data.player_info.full_name,
      data: data,
    }));
  }, [playerData]);

  // Filter players based on search term
  const filteredPlayers = useMemo(() => {
    if (!searchTerm) return [];
    return players.filter((player) =>
      player.fullName.toLowerCase().includes(searchTerm.toLowerCase())
    );
  }, [players, searchTerm]);

  const handlePlayerSelect = (player: Player) => {
    setSelectedPlayer(player);
    setSearchTerm(player.fullName);
    setShowDropdown(false);
    
    // Save selected player to localStorage
    if (typeof window !== 'undefined') {
      localStorage.setItem('selectedPlayer', JSON.stringify(player));
    }
  };

  const handleSearchChange = (value: string) => {
    setSearchTerm(value);
    if (!value) {
      setSelectedPlayer(null);
      // Clear localStorage when search is cleared
      if (typeof window !== 'undefined') {
        localStorage.removeItem('selectedPlayer');
      }
    }
  };

  // Load selected player and stat from localStorage on mount
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const savedPlayer = localStorage.getItem('selectedPlayer');
      const savedStat = localStorage.getItem('selectedStat');
      
      if (savedPlayer) {
        try {
          const player = JSON.parse(savedPlayer);
          setSelectedPlayer(player);
          setSearchTerm(player.fullName);
        } catch (error) {
          console.error('Error loading saved player:', error);
          localStorage.removeItem('selectedPlayer');
        }
      }
      
      if (savedStat) {
        setSelectedStat(savedStat);
      }
    }
  }, []);

  const handleStatSelect = (statKey: string) => {
    if (selectedStat !== statKey) {
      setSelectedStat(statKey);
      
      // Save selected stat to localStorage
      if (typeof window !== 'undefined') {
        localStorage.setItem('selectedStat', statKey);
      }
    }
  };

  return (
    <div className='min-h-screen bg-gray-50 p-6'>
      <style
        dangerouslySetInnerHTML={{
          __html: `
            .force-black-text {
              color: #000000 !important;
            }
            .force-blue-text {
              color: #2563eb !important;
            }
            .line-clamp-2 {
              display: -webkit-box;
              -webkit-line-clamp: 2;
              -webkit-box-orient: vertical;
              overflow: hidden;
            }
          `,
        }}
      />
      <div className='max-w-7xl mx-auto'>
        <h1 className='text-3xl font-bold mb-8 force-black-text'>
          Player Stats Dashboard
        </h1>

        {/* Search Section */}
        <SearchBar
          searchTerm={searchTerm}
          onSearchChange={handleSearchChange}
          onPlayerSelect={handlePlayerSelect}
          filteredPlayers={filteredPlayers}
          showDropdown={showDropdown}
          onShowDropdownChange={setShowDropdown}
        />

        {/* Player Data Display */}
        {selectedPlayer && (
          <div className='space-y-6'>
            {/* Stats Table with Side Panel */}
            <div className='flex gap-6'>
              <StatsTable
                selectedPlayer={selectedPlayer}
                selectedStat={selectedStat}
                onStatSelect={handleStatSelect}
              />

              {/* Top 10 Side Panel */}
              <div className='w-80'>
                <Top10Panel
                  selectedStat={selectedStat}
                  selectedPlayer={selectedPlayer}
                  playerData={playerData}
                />
              </div>
            </div>

            {/* Events Cards Section */}
            <EventsSection selectedPlayer={selectedPlayer} />
          </div>
        )}
      </div>
    </div>
  );
};

export default PlayerStatsApp;
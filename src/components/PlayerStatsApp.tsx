'use client';

import React, { useState, useMemo, useEffect } from 'react';
import Link from 'next/link';
import playerDataJson from '../data/data.json';
import { SearchBar, normalizeText } from './SearchBar';
import { StatsTable } from './StatsTable';
import { EventsSection } from './EventsSection';
import { Top10Panel } from './Top10Panel';
import { Player, PlayerDataStructure, FilterOptions } from './shared/types';
import { applyFilters } from './shared/rankingUtils';

const PlayerStatsApp = () => {
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedPlayer, setSelectedPlayer] = useState<Player | null>(null);
    const [showDropdown, setShowDropdown] = useState(false);
    const [selectedStat, setSelectedStat] = useState<string | null>(null);
    const [filters, setFilters] = useState<FilterOptions>({});
    const [playerData] = useState(
        playerDataJson as unknown as PlayerDataStructure
    );

    // Extract all players for autocomplete
    const players = useMemo(() => {
        return Object.entries(playerData.players).map(([key, data]) => ({
            id: key,
            fullName: data.player_info.full_name,
            data: data,
        }));
    }, [playerData]);

    // Apply filters to get filtered player pool
    const filteredPlayerPool = useMemo(() => {
        return applyFilters(players, filters);
    }, [players, filters]);

    // Filter players based on search term (from the filtered pool) with accent-insensitive matching
    const searchFilteredPlayers = useMemo(() => {
        if (!searchTerm) return [];
        const normalizedSearch = normalizeText(searchTerm);
        return filteredPlayerPool.filter((player) =>
            normalizeText(player.fullName).includes(normalizedSearch)
        );
    }, [filteredPlayerPool, searchTerm]);

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

    const handleFiltersChange = (newFilters: FilterOptions) => {
        setFilters(newFilters);
    };

    const handleTop10PlayerSelect = (playerName: string) => {
        // Find the player by name
        const player = players.find((p) => p.fullName === playerName);
        if (player) {
            setSelectedPlayer(player);
            setSearchTerm(player.fullName);

            // Save to localStorage
            if (typeof window !== 'undefined') {
                localStorage.setItem('selectedPlayer', JSON.stringify(player));
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
            <div className='mx-10'>
                <div className='flex items-center justify-between mb-8'>
                    <h1 className='text-3xl font-bold force-black-text'>
                        Player Stats Dashboard
                    </h1>
                    <Link 
                        href="/current_tournament"
                        className='px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors'
                    >
                        View ECL Page
                    </Link>
                </div>

                {/* Top section with sidebar and main content */}
                <div className='flex flex-col lg:flex-row gap-6 mb-6 lg:items-stretch'>
                    {/* Left Sidebar - Search and Filters */}
                    <div className='w-full lg:w-80 flex-shrink-0'>
                        <SearchBar
                            searchTerm={searchTerm}
                            onSearchChange={handleSearchChange}
                            onPlayerSelect={handlePlayerSelect}
                            filteredPlayers={searchFilteredPlayers}
                            showDropdown={showDropdown}
                            onShowDropdownChange={setShowDropdown}
                            filters={filters}
                            onFiltersChange={handleFiltersChange}
                            totalPlayers={players.length}
                            filteredPlayerCount={filteredPlayerPool.length}
                        />
                    </div>

                    {/* Main Content Area */}
                    <div className='flex-1 flex flex-col lg:flex-row gap-6'>
                        <StatsTable
                            selectedPlayer={selectedPlayer}
                            selectedStat={selectedStat}
                            onStatSelect={handleStatSelect}
                            allPlayers={players}
                            filters={filters}
                        />

                        {/* Top 10 Side Panel */}
                        <div className='w-full lg:w-80 flex-shrink-0'>
                            <Top10Panel
                                selectedStat={selectedStat}
                                selectedPlayer={selectedPlayer}
                                playerData={playerData}
                                filters={filters}
                                onPlayerSelect={handleTop10PlayerSelect}
                            />
                        </div>
                    </div>
                </div>

                {/* Events Section - Full width at bottom */}
                {selectedPlayer && (
                    <EventsSection selectedPlayer={selectedPlayer} />
                )}
            </div>
        </div>
    );
};

export default PlayerStatsApp;
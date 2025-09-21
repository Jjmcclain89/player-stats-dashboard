"use client";

import React, { useState, useMemo, useEffect } from 'react';
import { Search } from 'lucide-react';

const PlayerStatsApp = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedPlayer, setSelectedPlayer] = useState<any>(null);
  const [showDropdown, setShowDropdown] = useState(false);
  const [playerData, setPlayerData] = useState<any>({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Load data from JSON file
  useEffect(() => {
    const loadData = async () => {
      try {
        const response = await fetch('/data/data.json');
        if (!response.ok) {
          throw new Error('Failed to load data');
        }
        const data = await response.json();
        setPlayerData(data);
        setLoading(false);
      } catch (err: any) {
        setError(err.message);
        setLoading(false);
      }
    };

    loadData();
  }, []);

  // Extract all players for autocomplete
  const players = useMemo(() => {
    return Object.entries(playerData).map(([key, data]: [string, any]) => ({
      id: key,
      fullName: data.player_info.full_name,
      data: data
    }));
  }, [playerData]);

  // Filter players based on search term
  const filteredPlayers = useMemo(() => {
    if (!searchTerm) return [];
    return players.filter(player => 
      player.fullName.toLowerCase().includes(searchTerm.toLowerCase())
    );
  }, [players, searchTerm]);

  const handlePlayerSelect = (player: any) => {
    setSelectedPlayer(player);
    setSearchTerm(player.fullName);
    setShowDropdown(false);
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
    setShowDropdown(true);
    if (!e.target.value) {
      setSelectedPlayer(null);
    }
  };

  const StatRow = ({ label, value }: { label: string; value: any }) => (
    <tr className="hover:bg-gray-50">
      <td className="px-4 py-2 border-b text-left">{label}</td>
      <td className="px-4 py-2 border-b text-right">{value}</td>
    </tr>
  );

  const EventRow = ({ event }: { event: any }) => (
    <tr className="hover:bg-gray-50">
      <td className="px-4 py-2 border-b text-center">{event.event_number}</td>
      <td className="px-4 py-2 border-b text-center">{event.date}</td>
      <td className="px-4 py-2 border-b text-center">{event.format}</td>
      <td className="px-4 py-2 border-b text-center">{event.deck}</td>
      <td className="px-4 py-2 border-b text-center">{event.event_code}</td>
      <td className="px-4 py-2 border-b text-center">{event.notes || '-'}</td>
    </tr>
  );

  // Show loading state
  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Loading player data...</p>
        </div>
      </div>
    );
  }

  // Show error state
  if (error) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <p className="text-red-600 mb-4">Error loading data: {error}</p>
          <p className="text-gray-600">Make sure your data.json file is in the data/ directory</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-3xl font-bold text-gray-900 mb-8">Player Stats Dashboard</h1>
        
        {/* Search Section */}
        <div className="bg-white rounded-lg shadow-md p-6 mb-8">
          <div className="relative">
            <div className="flex items-center">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5" />
              <input
                type="text"
                value={searchTerm}
                onChange={handleInputChange}
                onFocus={() => setShowDropdown(true)}
                placeholder="Search for a player..."
                className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              />
            </div>
            
            {/* Dropdown */}
            {showDropdown && filteredPlayers.length > 0 && (
              <div className="absolute z-10 w-full mt-1 bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                {filteredPlayers.map((player) => (
                  <div
                    key={player.id}
                    onClick={() => handlePlayerSelect(player)}
                    className="px-4 py-3 hover:bg-blue-50 cursor-pointer border-b last:border-b-0"
                  >
                    {player.fullName}
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

        {/* Player Data Display */}
        {selectedPlayer && (
          <div className="space-y-8">
            <div className="bg-white rounded-lg shadow-md p-6">
              <h2 className="text-2xl font-bold text-gray-900 mb-6">
                {selectedPlayer.data.player_info.full_name} - Overall Statistics
              </h2>
              
              {/* Stats Table */}
              <div className="overflow-x-auto">
                <table className="w-full border-collapse border border-gray-200">
                  <tbody>
                    <StatRow label="Total Events" value={selectedPlayer.data.stats.events} />
                    <StatRow label="Day 2s" value={selectedPlayer.data.stats.day2s} />
                    <StatRow label="In Contentions" value={selectedPlayer.data.stats.in_contentions} />
                    <StatRow label="Top 8s" value={selectedPlayer.data.stats.top8s} />
                    <StatRow label="Overall Record" value={selectedPlayer.data.stats.overall_record} />
                    <StatRow label="Overall Win %" value={`${selectedPlayer.data.stats.overall_win_pct}%`} />
                    <StatRow label="Limited Record" value={selectedPlayer.data.stats.limited_record} />
                    <StatRow label="Limited Win %" value={`${selectedPlayer.data.stats.limited_win_pct}%`} />
                    <StatRow label="Constructed Record" value={selectedPlayer.data.stats.constructed_record} />
                    <StatRow label="Constructed Win %" value={`${selectedPlayer.data.stats.constructed_win_pct}%`} />
                    <StatRow label="Day 1 Win %" value={`${selectedPlayer.data.stats.day1_win_pct}%`} />
                    <StatRow label="Day 2 Win %" value={`${selectedPlayer.data.stats.day2_win_pct}%`} />
                    <StatRow label="Day 3 Win %" value={`${selectedPlayer.data.stats.day3_win_pct}%`} />
                    <StatRow label="Top 8 Record" value={selectedPlayer.data.stats.top8_record} />
                    <StatRow label="Total Drafts" value={selectedPlayer.data.stats.drafts} />
                    <StatRow label="Winning Drafts %" value={`${selectedPlayer.data.stats.winning_drafts_pct}%`} />
                    <StatRow label="Trophy Drafts" value={selectedPlayer.data.stats.trophy_drafts} />
                    <StatRow label="5+ Win Streaks" value={selectedPlayer.data.stats["5streaks"]} />
                    <StatRow label="Longest Win Streak" value={selectedPlayer.data.stats.longest_win_streak || 'N/A'} />
                    <StatRow label="Longest Loss Streak" value={selectedPlayer.data.stats.longest_loss_streak || 'N/A'} />
                  </tbody>
                </table>
              </div>
            </div>

            {/* Events Table */}
            <div className="bg-white rounded-lg shadow-md p-6">
              <h3 className="text-xl font-bold text-gray-900 mb-6">Events History</h3>
              
              <div className="overflow-x-auto">
                <table className="w-full border-collapse border border-gray-200">
                  <thead>
                    <tr className="bg-gray-100">
                      <th className="px-4 py-3 border-b font-semibold text-center">Event #</th>
                      <th className="px-4 py-3 border-b font-semibold text-center">Date</th>
                      <th className="px-4 py-3 border-b font-semibold text-center">Format</th>
                      <th className="px-4 py-3 border-b font-semibold text-center">Deck</th>
                      <th className="px-4 py-3 border-b font-semibold text-center">Event Code</th>
                      <th className="px-4 py-3 border-b font-semibold text-center">Notes</th>
                    </tr>
                  </thead>
                  <tbody>
                    {Object.values(selectedPlayer.data.events).map((event: any, index: number) => (
                      <EventRow key={index} event={event} />
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default PlayerStatsApp;

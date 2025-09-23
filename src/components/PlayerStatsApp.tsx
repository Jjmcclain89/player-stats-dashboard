'use client';

import React, { useState, useMemo } from 'react';
import { Search } from 'lucide-react';
import playerDataJson from '../data/data.json'; // Import JSON

// ---- Types ----

// A single event entry (inside a player)
type PlayerEvent = {
  event_code: string;
  event_id: number;
  date: string;
  format: string;
  deck: string;
  notes: string;
  finish: number;
};

// The stats block inside a player
type PlayerStats = {
  events: number;
  day2s: number;
  in_contentions: number;
  top8s: number;
  overall_wins: number;
  overall_losses: number;
  overall_draws: number;
  // add other stats if you have more
};

// A single player entry
type PlayerEntry = {
  player: {
    first_name: string;
    last_name: string;
    full_name: string;
  };
  events: Record<string, PlayerEvent>; // <-- FIX: object keyed by entry_X
  stats: PlayerStats;
};

// The "Top 10" structures
type Top10Entry = {
  rank: number;
  player_full_name: string;
  stat_value: number;
};

type Top10Category = Record<string, Top10Entry>; // keys "1".."10"

type Top10Data = Record<string, Top10Category>; // keys are stat names

// Whole dataset
interface PlayerData {
  players: Record<string, PlayerEntry>; // keys "entry_81", "entry_82", ...
  top_10: Top10Data;
}

// ---- Component ----
const PlayerStatsApp = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedPlayer, setSelectedPlayer] = useState<{
    id: string;
    fullName: string;
    data: PlayerEntry;
  } | null>(null);
  const [showDropdown, setShowDropdown] = useState(false);
  const [selectedStat, setSelectedStat] = useState<string | null>(null);

  // Cast JSON into our typed structure
  const [playerData] = useState<PlayerData>(playerDataJson as PlayerData);

  // List of stats that have top 10 rankings
  const statsWithTop10 = [
    'events', 'day2s', 'in_contentions', 'top8s', 'overall_wins',
    'overall_losses', 'overall_draws', 'overall_win_pct', 'limited_wins',
    'limited_losses', 'limited_draws', 'limited_win_pct', 'constructed_wins',
    'constructed_losses', 'constructed_draws', 'constructed_win_pct',
    'day1_wins', 'day1_losses', 'day1_draws', 'day1_win_pct', 'day2_wins',
    'day2_losses', 'day2_draws', 'day2_win_pct', 'day3_wins', 'day3_losses',
    'day3_draws', 'day3_win_pct', 'drafts', 'winning_drafts', 'losing_drafts',
    'winning_drafts_pct', 'trophy_drafts', '5streaks'
  ];

  // Extract all players for autocomplete
  const players = useMemo(() => {
    return Object.entries(playerData.players).map(([key, data]) => ({
      id: key,
      fullName: data.player.full_name,
      data,
    }));
  }, [playerData]);

  // Filter players based on search term
  const filteredPlayers = useMemo(() => {
    if (!searchTerm) return [];
    return players.filter((player) =>
      player.fullName.toLowerCase().includes(searchTerm.toLowerCase())
    );
  }, [players, searchTerm]);

  // Format date function
  const formatDate = (dateString: string) => {
    if (!dateString) return '-';
    try {
      const date = new Date(dateString);
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return `${months[date.getMonth()]} '${date.getFullYear().toString().slice(-2)}`;
    } catch {
      return dateString;
    }
  };

  // Format abbreviation function
  const abbreviateFormat = (format: string) => {
    if (!format) return '-';
    return format.charAt(0).toUpperCase();
  };

  const handlePlayerSelect = (player: {
    id: string;
    fullName: string;
    data: PlayerEntry;
  }) => {
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

  const handleStatSelect = (statKey: string) => {
    setSelectedStat(selectedStat === statKey ? null : statKey);
  };

  // Get display name for stat
  const getStatDisplayName = (statKey: string) => {
    const displayNames: Record<string, string> = {
      'events': 'Total Events',
      'day2s': 'Day 2s',
      'in_contentions': 'In Contentions',
      'top8s': 'Top 8s',
      'overall_wins': 'Overall Wins',
      'overall_losses': 'Overall Losses',
      'overall_draws': 'Overall Draws',
      'overall_win_pct': 'Overall Win %',
      'limited_wins': 'Limited Wins',
      'limited_losses': 'Limited Losses',
      'limited_draws': 'Limited Draws',
      'limited_win_pct': 'Limited Win %',
      'constructed_wins': 'Constructed Wins',
      'constructed_losses': 'Constructed Losses',
      'constructed_draws': 'Constructed Draws',
      'constructed_win_pct': 'Constructed Win %',
      'day1_wins': 'Day 1 Wins',
      'day1_losses': 'Day 1 Losses',
      'day1_draws': 'Day 1 Draws',
      'day1_win_pct': 'Day 1 Win %',
      'day2_wins': 'Day 2 Wins',
      'day2_losses': 'Day 2 Losses',
      'day2_draws': 'Day 2 Draws',
      'day2_win_pct': 'Day 2 Win %',
      'day3_wins': 'Day 3 Wins',
      'day3_losses': 'Day 3 Losses',
      'day3_draws': 'Day 3 Draws',
      'day3_win_pct': 'Day 3 Win %',
      'drafts': 'Total Drafts',
      'winning_drafts': 'Winning Drafts',
      'losing_drafts': 'Losing Drafts',
      'winning_drafts_pct': 'Winning Drafts %',
      'trophy_drafts': 'Trophy Drafts',
      '5streaks': '5+ Win Streaks'
    };
    return displayNames[statKey] || statKey;
  };

  // ---- Components ----
  const StatRow = ({
    stat1,
    stat2,
  }: {
    stat1: { label: string; value: any; key: string };
    stat2?: { label: string; value: any; key: string };
  }) => (
    <tr className='hover:bg-gray-50'>
      <td
        className={`px-3 py-2 border-b text-left font-medium w-1/4 cursor-pointer ${selectedStat === stat1.key
          ? 'bg-blue-100 force-blue-text'
          : 'force-black-text hover:bg-blue-50'
          }`}
        onClick={() => handleStatSelect(stat1.key)}
      >
        {stat1.label}
      </td>
      <td className='px-3 py-2 border-b text-left force-black-text w-1/4 border-r'>
        {stat1.value}
      </td>
      {stat2 ? (
        <>
          <td
            className={`px-3 py-2 border-b text-left font-medium w-1/4 cursor-pointer ${selectedStat === stat2.key
              ? 'bg-blue-100 force-blue-text'
              : 'force-black-text hover:bg-blue-50'
              }`}
            onClick={() => handleStatSelect(stat2.key)}
          >
            {stat2.label}
          </td>
          <td className='px-3 py-2 border-b text-left force-black-text w-1/4'>
            {stat2.value}
          </td>
        </>
      ) : (
        <>
          <td className='px-3 py-2 border-b text-left force-black-text w-1/4'></td>
          <td className='px-3 py-2 border-b text-left force-black-text w-1/4'></td>
        </>
      )}
    </tr>
  );

  const EventRow = ({ event }: { event: PlayerEvent }) => (
    <tr className='hover:bg-gray-50'>
      <td className='px-2 py-2 border-b text-center force-black-text'>
        {event.event_code}
      </td>
      <td className='px-2 py-2 border-b text-center force-black-text text-sm w-28'>
        {formatDate(event.date)}
      </td>
      <td className='px-2 py-2 border-b text-center force-black-text w-12'>
        {abbreviateFormat(event.format)}
      </td>
      <td className='px-2 py-2 border-b text-center force-black-text'>
        {event.deck}
      </td>
      <td className='px-2 py-2 border-b text-center force-black-text'>
        {event.notes || '-'}
      </td>
    </tr>
  );

  const Top10Panel = () => {
    if (!selectedStat || !(selectedStat in playerData.top_10)) {
      return (
        <div className='bg-white rounded-lg shadow-md p-6 h-fit'>
          <h3 className='text-lg font-bold mb-4 force-black-text'>
            {selectedStat ? getStatDisplayName(selectedStat) : 'Top 10 Rankings'}
          </h3>
          <p className='text-gray-500 text-center'>
            {selectedStat
              ? 'No top 10 available for this stat'
              : 'Select a stat to view rankings'}
          </p>
        </div>
      );
    }

    const top10Data = playerData.top_10[selectedStat];
    const rankings = Object.values(top10Data);

    return (
      <div className='bg-white rounded-lg shadow-md p-6 h-fit'>
        <h3 className='text-lg font-bold mb-4 force-black-text'>
          Top 10: {getStatDisplayName(selectedStat)}
        </h3>
        <div className='space-y-2'>
          {rankings.map((entry) => (
            <div
              key={entry.rank}
              className='flex justify-between items-center py-2 px-3 bg-gray-50 rounded border-l-4 border-blue-500'
            >
              <div className='flex items-center gap-3'>
                <span className='font-bold text-gray-600 w-6'>
                  #{entry.rank}
                </span>
                <span className='force-black-text font-medium'>
                  {entry.player_full_name}
                </span>
              </div>
              <span className='force-black-text font-bold'>
                {selectedStat.includes('pct')
                  ? `${entry.stat_value}%`
                  : entry.stat_value}
              </span>
            </div>
          ))}
        </div>
      </div>
    );
  };

  // ---- Render ----
  return (
    <div className='min-h-screen bg-gray-50 p-6'>
      <style
        dangerouslySetInnerHTML={{
          __html: `
          .force-black-text { color: #000000 !important; }
          .force-blue-text { color: #2563eb !important; }
        `,
        }}
      />
      <div className='max-w-7xl mx-auto'>
        <h1 className='text-3xl font-bold mb-8 force-black-text'>
          Player Stats Dashboard
        </h1>

        {/* Search Section */}
        <div className='bg-white rounded-lg shadow-md p-6 mb-8 max-w-4xl'>
          <div className='relative'>
            <div className='flex items-center'>
              <Search className='absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5' />
              <input
                type='text'
                value={searchTerm}
                onChange={handleInputChange}
                onFocus={() => setShowDropdown(true)}
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

        {/* Player Data Display */}
        {selectedPlayer && (
          <div className='space-y-6'>
            {/* Stats Table with Side Panel */}
            <div className='flex gap-6'>
              {/* Stats Table */}
              <div className='bg-white rounded-lg shadow-md p-6 flex-grow'>
                <h2 className='text-xl font-bold mb-6 force-black-text'>
                  Overall Statistics
                </h2>
                {/* Table omitted for brevity — keep your StatRow setup here */}
              </div>

              {/* Top 10 Side Panel */}
              <div className='w-80'>
                <Top10Panel />
              </div>
            </div>

            {/* Events Table */}
            <div className='bg-white rounded-lg shadow-md p-6'>
              <h3 className='text-xl font-bold mb-6 force-black-text'>
                Events History
              </h3>
              <div className='overflow-x-auto'>
                <table className='w-full border-collapse border border-gray-200'>
                  <thead>
                    <tr className='bg-gray-100'>
                      <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>Event Code</th>
                      <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>Date</th>
                      <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>Format</th>
                      <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>Deck</th>
                      <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>Notes</th>
                    </tr>
                  </thead>
                  <tbody>
                    {Object.values(selectedPlayer.data.events).map((event, index) => (
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

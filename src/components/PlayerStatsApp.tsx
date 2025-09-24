'use client';

import React, { useState, useMemo, useEffect } from 'react';
import { Search } from 'lucide-react';
import playerDataJson from '../data/data.json'; // Import the JSON

const PlayerStatsApp = () => {
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedPlayer, setSelectedPlayer] = useState<any>(null);
    const [showDropdown, setShowDropdown] = useState(false);
    const [selectedStat, setSelectedStat] = useState<string | null>(null);
    const [playerData] = useState(playerDataJson); // Use imported data directly

    // Extract all players for autocomplete
    const players = useMemo(() => {
        return Object.entries(playerData.players).map(
            ([key, data]: [string, any]) => ({
                id: key,
                fullName: data.player_info.full_name,
                data: data,
            })
        );
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
            const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

            const month = months[date.getMonth()];
            const day = date.getDate();
            const year = date.getFullYear().toString().slice(-2);

            return `${month} '${year}`;
        } catch (error) {
            return dateString;
        }
    };

    // Format abbreviation function
    const abbreviateFormat = (format: string) => {
        if (!format) return '-';
        const formatMap: { [key: string]: string } = {
            "Standard": "STD",
            "Modern": "MOD",
            "Pioneer": "PIO",
        };
        return formatMap[format] || format.substring(0, 3).toUpperCase();
    };

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

    const handleStatSelect = (statKey: string) => {
        if (selectedStat !== statKey) {
            setSelectedStat(statKey);
        }
    };

    // Get display name for stat
    const getStatDisplayName = (statKey: string) => {
        const displayNames: { [key: string]: string } = {
            events: 'Total Events',
            day2s: 'Day 2s',
            in_contentions: 'In Contentions',
            top8s: 'Top 8s',
            overall_wins: 'Overall Wins',
            overall_losses: 'Overall Losses',
            overall_draws: 'Overall Draws',
            overall_win_pct: 'Overall Win %',
            limited_wins: 'Limited Wins',
            limited_losses: 'Limited Losses',
            limited_draws: 'Limited Draws',
            limited_win_pct: 'Limited Win %',
            constructed_wins: 'Constructed Wins',
            constructed_losses: 'Constructed Losses',
            constructed_draws: 'Constructed Draws',
            constructed_win_pct: 'Constructed Win %',
            day1_wins: 'Day 1 Wins',
            day1_losses: 'Day 1 Losses',
            day1_draws: 'Day 1 Draws',
            day1_win_pct: 'Day 1 Win %',
            day2_wins: 'Day 2 Wins',
            day2_losses: 'Day 2 Losses',
            day2_draws: 'Day 2 Draws',
            day2_win_pct: 'Day 2 Win %',
            day3_wins: 'Day 3 Wins',
            day3_losses: 'Day 3 Losses',
            day3_draws: 'Day 3 Draws',
            day3_win_pct: 'Day 3 Win %',
            drafts: 'Total Drafts',
            winning_drafts: 'Winning Drafts',
            losing_drafts: 'Losing Drafts',
            winning_drafts_pct: 'Winning Drafts %',
            trophy_drafts: 'Trophy Drafts',
            '5streaks': '5+ Win Streaks',
            overall_record: 'Overall Record',
            limited_record: 'Limited Record',
            constructed_record: 'Constructed Record',
            top8_record: 'Top 8 Record',
        };
        return displayNames[statKey] || statKey;
    };

    const StatRow = ({
        stat1,
        stat2,
    }: {
        stat1: { label: string; value: any; key: string };
        stat2?: { label: string; value: any; key: string };
    }) => {
        const [hoveredStat, setHoveredStat] = useState<string | null>(null);

        return (
            <tr>
                <td colSpan={2} className="p-0">
                    <div
                        className={`flex cursor-pointer ${
                            selectedStat === stat1.key
                                ? 'bg-blue-100 force-blue-text'
                                : hoveredStat === stat1.key
                                ? 'bg-blue-50 force-black-text'
                                : 'force-black-text'
                        }`}
                        onClick={() => handleStatSelect(stat1.key)}
                        onMouseEnter={() => setHoveredStat(stat1.key)}
                        onMouseLeave={() => setHoveredStat(null)}
                    >
                        <div className="px-3 py-2 border-b text-left font-medium w-1/2 border-r">
                            {stat1.label}
                        </div>
                        <div className="px-3 py-2 border-b text-left w-1/2">
                            {stat1.value}
                        </div>
                    </div>
                </td>
                {stat2 ? (
                    <td colSpan={2} className="p-0">
                        <div
                            className={`flex cursor-pointer ${
                                selectedStat === stat2.key
                                    ? 'bg-blue-100 force-blue-text'
                                    : hoveredStat === stat2.key
                                    ? 'bg-blue-50 force-black-text'
                                    : 'force-black-text'
                            }`}
                            onClick={() => handleStatSelect(stat2.key)}
                            onMouseEnter={() => setHoveredStat(stat2.key)}
                            onMouseLeave={() => setHoveredStat(null)}
                        >
                            <div className="px-3 py-2 border-b text-left font-medium w-1/2">
                                {stat2.label}
                            </div>
                            <div className="px-3 py-2 border-b text-left w-1/2">
                                {stat2.value}
                            </div>
                        </div>
                    </td>
                ) : (
                    <td colSpan={2} className='px-3 py-2 border-b text-left force-black-text'></td>
                )}
            </tr>
        );
    };

    const EventRow = ({ event }: { event: any }) => (
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

    // Top 10 Panel Component
    const Top10Panel = () => {
        if (!selectedStat) {
            return (
                <div className='bg-white rounded-lg shadow-md p-6 h-fit'>
                    <h3 className='text-lg font-bold mb-4 force-black-text'>
                        Top 10 Rankings
                    </h3>
                    <p className='text-gray-500 text-center'>
                        Select a stat to view rankings
                    </p>
                </div>
            );
        }

        if (!(playerData.top_10 as any)[selectedStat]) {
            return (
                <div className='bg-white rounded-lg shadow-md p-6 h-fit'>
                    <h3 className='text-lg font-bold mb-4 force-black-text'>
                        {getStatDisplayName(selectedStat)}
                    </h3>
                    <p className='text-gray-500 text-center'>
                        No top 10 available for this stat
                    </p>
                </div>
            );
        }

        const top10Data = (playerData.top_10 as any)[selectedStat];
        const rankings = Object.values(top10Data) as any[];

        // Get the selected player's rank for this stat
        const playerRank = selectedPlayer?.data?.stats?.[selectedStat]?.rank;
        const playerStatValue =
            selectedPlayer?.data?.stats?.[selectedStat]?.value;

        return (
            <div className='bg-white rounded-lg shadow-md p-6 h-fit'>
                <h3 className='text-lg font-bold mb-4 force-black-text'>
                    Top 10: {getStatDisplayName(selectedStat)}
                </h3>
                <div className='space-y-1'>
                    {rankings.map((entry: any) => (
                        <div
                            key={entry.rank}
                            className='flex justify-between items-center py-1 px-3 bg-gray-50 rounded border-l-4 border-blue-500'
                        >
                            <div className='flex items-center gap-2'>
                                <span className='font-bold text-gray-600 w-6 text-sm'>
                                    #{entry.rank}
                                </span>
                                <span className='force-black-text font-medium text-sm'>
                                    {entry.player_full_name}
                                </span>
                            </div>
                            <span className='force-black-text font-bold text-sm'>
                                {selectedStat.includes('pct')
                                    ? `${entry.stat_value}%`
                                    : entry.stat_value}
                            </span>
                        </div>
                    ))}
                </div>

                {/* Player Personal Rank Section */}
                {selectedPlayer && playerRank && (
                    <>
                        <div className='border-t border-gray-200 my-4'></div>
                        <div className='bg-yellow-50 border-l-4 border-yellow-500 py-1 px-3 rounded'>
                            <div className='flex justify-between items-center'>
                                <div className='flex items-center gap-4'>
                                    <span className='font-bold text-yellow-700 w-6 text-sm pr-5'>
                                        #{playerRank}
                                    </span>
                                    <span className='force-black-text font-medium text-sm'>
                                        {selectedPlayer.fullName}
                                    </span>
                                </div>
                                <span className='force-black-text font-bold text-sm'>
                                    {selectedStat.includes('pct')
                                        ? `${playerStatValue}%`
                                        : playerStatValue}
                                </span>
                            </div>
                        </div>
                    </>
                )}
            </div>
        );
    };
    
    // HTML Render
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
                `,
                }}
            />
            <div className='max-w-7xl mx-auto'>
                <h1 className='text-3xl font-bold mb-8 force-black-text'>
                    Player Stats Dashboard
                </h1>

                {/* Search Section */}
                <div className='bg-white rounded-lg shadow-md p-6 mb-8'>
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
                                        onClick={() =>
                                            handlePlayerSelect(player)
                                        }
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

                                <div className='overflow-x-auto'>
                                    <table className='w-full border-collapse border border-gray-200'>
                                        <tbody>
                                            <StatRow
                                                stat1={{
                                                    label: 'Total Events',
                                                    value: selectedPlayer.data
                                                        .stats.events.value,
                                                    key: 'events',
                                                }}
                                                stat2={{
                                                    label: 'Day 2s',
                                                    value: selectedPlayer.data
                                                        .stats.day2s.value,
                                                    key: 'day2s',
                                                }}
                                            />
                                            <StatRow
                                                stat1={{
                                                    label: 'In Contentions',
                                                    value: selectedPlayer.data
                                                        .stats.in_contentions
                                                        .value,
                                                    key: 'in_contentions',
                                                }}
                                                stat2={{
                                                    label: 'Top 8s',
                                                    value: selectedPlayer.data
                                                        .stats.top8s.value,
                                                    key: 'top8s',
                                                }}
                                            />
                                            <StatRow
                                                stat1={{
                                                    label: 'Overall Record',
                                                    value: selectedPlayer.data
                                                        .stats.overall_record
                                                        .value,
                                                    key: 'overall_record',
                                                }}
                                                stat2={{
                                                    label: 'Overall Win %',
                                                    value: `${selectedPlayer.data.stats.overall_win_pct.value}%`,
                                                    key: 'overall_win_pct',
                                                }}
                                            />
                                            <StatRow
                                                stat1={{
                                                    label: 'Limited Record',
                                                    value: selectedPlayer.data
                                                        .stats.limited_record
                                                        .value,
                                                    key: 'limited_record',
                                                }}
                                                stat2={{
                                                    label: 'Limited Win %',
                                                    value: `${selectedPlayer.data.stats.limited_win_pct.value}%`,
                                                    key: 'limited_win_pct',
                                                }}
                                            />
                                            <StatRow
                                                stat1={{
                                                    label: 'Constructed Record',
                                                    value: selectedPlayer.data
                                                        .stats
                                                        .constructed_record
                                                        .value,
                                                    key: 'constructed_record',
                                                }}
                                                stat2={{
                                                    label: 'Constructed Win %',
                                                    value: `${selectedPlayer.data.stats.constructed_win_pct.value}%`,
                                                    key: 'constructed_win_pct',
                                                }}
                                            />
                                            <StatRow
                                                stat1={{
                                                    label: 'Day 1 Win %',
                                                    value: `${selectedPlayer.data.stats.day1_win_pct.value}%`,
                                                    key: 'day1_win_pct',
                                                }}
                                                stat2={{
                                                    label: 'Day 2 Win %',
                                                    value: `${selectedPlayer.data.stats.day2_win_pct.value}%`,
                                                    key: 'day2_win_pct',
                                                }}
                                            />
                                            <StatRow
                                                stat1={{
                                                    label: 'Day 3 Win %',
                                                    value: `${selectedPlayer.data.stats.day3_win_pct.value}%`,
                                                    key: 'day3_win_pct',
                                                }}
                                                stat2={{
                                                    label: 'Top 8 Record',
                                                    value: selectedPlayer.data
                                                        .stats.top8_record
                                                        .value,
                                                    key: 'top8_record',
                                                }}
                                            />
                                            <StatRow
                                                stat1={{
                                                    label: 'Total Drafts',
                                                    value: selectedPlayer.data
                                                        .stats.drafts.value,
                                                    key: 'drafts',
                                                }}
                                                stat2={{
                                                    label: 'Winning Drafts %',
                                                    value: `${selectedPlayer.data.stats.winning_drafts_pct.value}%`,
                                                    key: 'winning_drafts_pct',
                                                }}
                                            />
                                            <StatRow
                                                stat1={{
                                                    label: 'Trophy Drafts',
                                                    value: selectedPlayer.data
                                                        .stats.trophy_drafts
                                                        .value,
                                                    key: 'trophy_drafts',
                                                }}
                                                stat2={{
                                                    label: '5+ Win Streaks',
                                                    value: selectedPlayer.data
                                                        .stats['5streaks']
                                                        .value,
                                                    key: '5streaks',
                                                }}
                                            />
                                        </tbody>
                                    </table>
                                </div>
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
                                            <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>
                                                Event Code
                                            </th>
                                            <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>
                                                Date
                                            </th>
                                            <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>
                                                Format
                                            </th>
                                            <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>
                                                Deck
                                            </th>
                                            <th className='px-2 py-2 border-b font-semibold text-center force-black-text'>
                                                Notes
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {Object.values(
                                            selectedPlayer.data.events
                                        ).map((event: any, index: number) => (
                                            <EventRow
                                                key={index}
                                                event={event}
                                            />
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
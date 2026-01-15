'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useState, useEffect } from 'react';
import { Menu, X, ChevronDown } from 'lucide-react';
import playerDataJson from '../../data/data.json';
import { getAllEventCodes } from '../shared/eventUtils';
import { PlayerDataStructure } from '../shared/types';

const Navigation = () => {
  const pathname = usePathname();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isEventsDropdownOpen, setIsEventsDropdownOpen] = useState(false);
  const [eventCodes, setEventCodes] = useState<string[]>([]);

  useEffect(() => {
    const playerData = playerDataJson as unknown as PlayerDataStructure;
    const codes = getAllEventCodes(playerData);
    setEventCodes(codes);
  }, []);

  const isActive = (path: string) => pathname === path;
  const isEventPage = pathname?.startsWith('/events/');

  const navLinks = [
    { href: '/', label: 'Player Stats Dashboard' },
    { href: '/current_tournament', label: 'Lorwyn Eclipse' },
  ];

  return (
    <nav className="sticky top-0 z-50 bg-slate-800 text-white shadow-lg">
      <div className="w-full px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Desktop Navigation */}
          <div className="hidden md:flex md:items-center md:space-x-8">
            {navLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className={`px-3 py-2 rounded-md text-sm font-medium transition-colors ${
                  isActive(link.href)
                    ? 'bg-slate-900 text-white'
                    : 'text-slate-300 hover:bg-slate-700 hover:text-white'
                }`}
              >
                {link.label}
              </Link>
            ))}

            {/* Events Dropdown */}
            <div className="relative">
              <button
                onClick={() => setIsEventsDropdownOpen(!isEventsDropdownOpen)}
                onMouseEnter={() => setIsEventsDropdownOpen(true)}
                className={`px-3 py-2 rounded-md text-sm font-medium transition-colors flex items-center gap-1 ${
                  isEventPage
                    ? 'bg-slate-900 text-white'
                    : 'text-slate-300 hover:bg-slate-700 hover:text-white'
                }`}
              >
                Events
                <ChevronDown className="w-4 h-4" />
              </button>

              {isEventsDropdownOpen && (
                <div
                  className="absolute left-0 mt-2 w-48 bg-slate-700 rounded-md shadow-lg py-1 max-h-96 overflow-y-auto"
                  onMouseLeave={() => setIsEventsDropdownOpen(false)}
                >
                  {eventCodes.map((eventCode) => (
                    <Link
                      key={eventCode}
                      href={`/events/${eventCode}`}
                      className={`block px-4 py-2 text-sm transition-colors ${
                        pathname === `/events/${eventCode}`
                          ? 'bg-slate-900 text-white'
                          : 'text-slate-300 hover:bg-slate-600 hover:text-white'
                      }`}
                      onClick={() => setIsEventsDropdownOpen(false)}
                    >
                      {eventCode}
                    </Link>
                  ))}
                </div>
              )}
            </div>
          </div>

          {/* Mobile menu button */}
          <button
            onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
            className="md:hidden inline-flex items-center justify-center p-2 rounded-md text-slate-300 hover:text-white hover:bg-slate-700 transition-colors"
          >
            {isMobileMenuOpen ? (
              <X className="h-6 w-6" />
            ) : (
              <Menu className="h-6 w-6" />
            )}
          </button>
        </div>
      </div>

      {/* Mobile Navigation */}
      {isMobileMenuOpen && (
        <div className="md:hidden bg-slate-700">
          <div className="px-2 pt-2 pb-3 space-y-1">
            {navLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className={`block px-3 py-2 rounded-md text-base font-medium transition-colors ${
                  isActive(link.href)
                    ? 'bg-slate-900 text-white'
                    : 'text-slate-300 hover:bg-slate-600 hover:text-white'
                }`}
                onClick={() => setIsMobileMenuOpen(false)}
              >
                {link.label}
              </Link>
            ))}

            {/* Mobile Events Section */}
            <div>
              <button
                onClick={() => setIsEventsDropdownOpen(!isEventsDropdownOpen)}
                className={`w-full text-left px-3 py-2 rounded-md text-base font-medium transition-colors flex items-center justify-between ${
                  isEventPage
                    ? 'bg-slate-900 text-white'
                    : 'text-slate-300 hover:bg-slate-600 hover:text-white'
                }`}
              >
                Events
                <ChevronDown
                  className={`w-4 h-4 transition-transform ${
                    isEventsDropdownOpen ? 'rotate-180' : ''
                  }`}
                />
              </button>

              {isEventsDropdownOpen && (
                <div className="pl-4 mt-1 space-y-1">
                  {eventCodes.map((eventCode) => (
                    <Link
                      key={eventCode}
                      href={`/events/${eventCode}`}
                      className={`block px-3 py-2 rounded-md text-sm transition-colors ${
                        pathname === `/events/${eventCode}`
                          ? 'bg-slate-900 text-white'
                          : 'text-slate-300 hover:bg-slate-600 hover:text-white'
                      }`}
                      onClick={() => {
                        setIsMobileMenuOpen(false);
                        setIsEventsDropdownOpen(false);
                      }}
                    >
                      {eventCode}
                    </Link>
                  ))}
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </nav>
  );
};

export default Navigation;

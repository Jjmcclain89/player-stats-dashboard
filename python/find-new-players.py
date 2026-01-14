#!/usr/bin/env python3
"""
Check which players from a CSV are not yet in the database.
CSV should have two columns: First, Last (no headers)
Includes fuzzy matching to detect potential matches with similar names.
"""

import csv
import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import os


def check_player_exists(cur, first_name: str, last_name: str) -> bool:
    """
    Check if a player exists in the database (exact match).
    Returns True if exists, False otherwise.
    """
    cur.execute("""
        SELECT id FROM players 
        WHERE first_name = %s AND last_name = %s
    """, (first_name, last_name))
    
    return cur.fetchone() is not None


def find_similar_players(cur, first_name: str, last_name: str):
    """
    Find players with similar names using multiple strategies:
    1. ILIKE case-insensitive matching
    2. unaccent for accent-insensitive matching
    3. Same last name with similar first name (one contains the other)
    
    Returns list of tuples: (id, first_name, last_name, match_type)
    """
    similar_players = []
    
    # Try case-insensitive match on first name
    cur.execute("""
        SELECT id, first_name, last_name 
        FROM players 
        WHERE first_name ILIKE %s AND last_name = %s
    """, (first_name, last_name))
    
    results = cur.fetchall()
    for row in results:
        similar_players.append((*row, 'case-insensitive first name'))
    
    # Try case-insensitive match on last name
    cur.execute("""
        SELECT id, first_name, last_name 
        FROM players 
        WHERE first_name = %s AND last_name ILIKE %s
    """, (first_name, last_name))
    
    results = cur.fetchall()
    for row in results:
        if row not in [p[:3] for p in similar_players]:
            similar_players.append((*row, 'case-insensitive last name'))
    
    # Try case-insensitive match on both
    cur.execute("""
        SELECT id, first_name, last_name 
        FROM players 
        WHERE first_name ILIKE %s AND last_name ILIKE %s
    """, (first_name, last_name))
    
    results = cur.fetchall()
    for row in results:
        if row not in [p[:3] for p in similar_players]:
            similar_players.append((*row, 'case-insensitive both names'))
    
    # Try with unaccent if available
    try:
        cur.execute("""
            SELECT id, first_name, last_name 
            FROM players 
            WHERE unaccent(first_name) ILIKE unaccent(%s) 
              AND unaccent(last_name) ILIKE unaccent(%s)
        """, (first_name, last_name))
        
        results = cur.fetchall()
        for row in results:
            if row not in [p[:3] for p in similar_players]:
                similar_players.append((*row, 'accent-insensitive'))
    except psycopg2.errors.UndefinedFunction:
        # unaccent extension not available, skip
        pass
    
    # NEW: Find all players with same last name and check if first names contain each other
    cur.execute("""
        SELECT id, first_name, last_name 
        FROM players 
        WHERE last_name = %s
    """, (last_name,))
    
    same_last_name_players = cur.fetchall()
    for player_id, db_first, db_last in same_last_name_players:
        # Skip if already in similar_players
        if (player_id, db_first, db_last) in [p[:3] for p in similar_players]:
            continue
        
        # Check if one first name contains the other (case-insensitive)
        first_lower = first_name.lower()
        db_first_lower = db_first.lower()
        
        if first_lower in db_first_lower or db_first_lower in first_lower:
            # Determine which contains which for the message
            if first_lower in db_first_lower and first_lower != db_first_lower:
                match_msg = f"same last name, '{db_first}' contains '{first_name}'"
            elif db_first_lower in first_lower and first_lower != db_first_lower:
                match_msg = f"same last name, '{first_name}' contains '{db_first}'"
            else:
                # They're equal (case-insensitive) but different case
                match_msg = "same last name, case difference in first name"
            
            similar_players.append((player_id, db_first, db_last, match_msg))
    
    return similar_players


def main():
    if len(sys.argv) < 2:
        print("Usage: python check_new_players.py <db_connection_string>")
        print("\nThe script will read from 'richmond-qs.csv' in the same directory.")
        print("\nExample:")
        print("  python check_new_players.py 'dbname=mtg user=postgres'")
        sys.exit(1)
    
    # Hardcoded CSV file path - must be in same directory as script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    csv_file = os.path.join(script_dir, 'richmond-qs.csv')
    
    db_conn_string = sys.argv[1]
    
    # Check if CSV exists
    if not os.path.exists(csv_file):
        print(f"Error: Could not find 'richmond-qs.csv' in {script_dir}", file=sys.stderr)
        sys.exit(1)
    
    print(f"Reading CSV: {csv_file}", file=sys.stderr)
    print("", file=sys.stderr)
    
    # Connect to database
    try:
        conn = psycopg2.connect(db_conn_string)
        cur = conn.cursor()
        print("Connected to database successfully", file=sys.stderr)
        
        # Check if unaccent extension is available
        cur.execute("""
            SELECT EXISTS(
                SELECT 1 FROM pg_extension WHERE extname = 'unaccent'
            )
        """)
        has_unaccent = cur.fetchone()[0]
        if has_unaccent:
            print("✓ unaccent extension is available", file=sys.stderr)
        else:
            print("⚠ unaccent extension not available (accent matching disabled)", file=sys.stderr)
            print("  To enable: CREATE EXTENSION unaccent;", file=sys.stderr)
        
        print("", file=sys.stderr)
    except Exception as e:
        print(f"Error connecting to database: {e}", file=sys.stderr)
        sys.exit(1)
    
    try:
        new_players = []
        existing_players = []
        new_with_similar = []
        
        # Read and check CSV
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.reader(f)
            
            for row in reader:
                if len(row) < 2:
                    continue
                
                first_name = row[0].strip()
                last_name = row[1].strip()
                
                if not first_name or not last_name:
                    continue
                
                if check_player_exists(cur, first_name, last_name):
                    existing_players.append((first_name, last_name))
                else:
                    # Player doesn't exist with exact match
                    new_players.append((first_name, last_name))
                    
                    # Check for similar matches
                    similar = find_similar_players(cur, first_name, last_name)
                    if similar:
                        new_with_similar.append((first_name, last_name, similar))
        
        # Print results
        print("="*70)
        print("RESULTS")
        print("="*70)
        print()
        
        # First show all new players
        if new_players:
            print(f"NEW PLAYERS (not in database - exact match): {len(new_players)}")
            print("-" * 70)
            for first, last in sorted(new_players, key=lambda x: (x[1], x[0])):
                print(f"  {first} {last}")
            print()
        else:
            print("NEW PLAYERS: None")
            print()
        
        # Then show which of those new players have potential matches
        if new_with_similar:
            print(f"POTENTIAL MATCHES (from new players list): {len(new_with_similar)}")
            print("-" * 70)
            for first, last, similar_list in sorted(new_with_similar, key=lambda x: (x[1], x[0])):
                print(f"\n  {first} {last}")
                for player_id, db_first, db_last, match_type in similar_list:
                    print(f"    -> {db_first} {db_last} (ID: {player_id}) [{match_type}]")
            print()
        else:
            print("POTENTIAL MATCHES: None")
            print()
        
        # Show existing players
        if existing_players:
            print(f"EXISTING PLAYERS (already in database - exact match): {len(existing_players)}")
            print("-" * 70)
            for first, last in sorted(existing_players, key=lambda x: (x[1], x[0])):
                print(f"  {first} {last}")
            print()
        
        print(f"Total players in CSV: {len(new_players) + len(existing_players)}")
        
        # Summary
        print()
        print("="*70)
        print("SUMMARY")
        print("="*70)
        print(f"New players (no exact match): {len(new_players)}")
        print(f"  - With potential similar matches: {len(new_with_similar)}")
        print(f"  - No similar matches found: {len(new_players) - len(new_with_similar)}")
        print(f"Existing players (exact match): {len(existing_players)}")
    
    except Exception as e:
        print(f"\nError processing CSV: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)
    
    finally:
        cur.close()
        conn.close()


if __name__ == '__main__':
    main()
#!/usr/bin/env python3
"""
Import MTG Pro Tour results from CSV to PostgreSQL database.
Handles event and player creation, with dry-run mode for testing.
"""

import csv
import sys
import psycopg2
from datetime import datetime
from typing import Optional, Dict, Tuple


def parse_date(date_str: str) -> str:
    """Convert date string from DD/M/YYYY to YYYY-MM-DD format."""
    try:
        dt = datetime.strptime(date_str, '%d/%m/%Y')
        return dt.strftime('%Y-%m-%d')
    except ValueError:
        print(f"Warning: Could not parse date '{date_str}'", file=sys.stderr)
        return date_str


def safe_int(value, default=0) -> int:
    """Safely convert value to int, return default if empty or invalid."""
    if value == '' or value is None:
        return default
    try:
        return int(value)
    except ValueError:
        return default


def safe_bool(value) -> bool:
    """Convert value to boolean (1 -> True, 0 -> False)."""
    return bool(safe_int(value, 0))


def get_or_create_event(cur, event_name: str, event_date: str, event_format: str, event_id: int, dry_run: bool = False) -> int:
    """
    Get existing event or create new one.
    Returns the event ID.
    """
    # Check if event exists
    cur.execute("""
        SELECT id FROM events 
        WHERE name = %s AND date = %s AND format = %s
    """, (event_name, event_date, event_format))
    
    result = cur.fetchone()
    if result:
        print(f"  Event '{event_name}' already exists (ID: {result[0]})", file=sys.stderr)
        return result[0]
    
    # Event doesn't exist, create it
    sql = cur.mogrify("""
        INSERT INTO events (id, name, date, format)
        VALUES (%s, %s, %s, %s)
        RETURNING id
    """, (event_id, event_name, event_date, event_format))
    
    if dry_run:
        print(f"\n-- Create Event SQL:")
        print(sql.decode('utf-8'))
        return event_id
    else:
        cur.execute(sql)
        new_id = cur.fetchone()[0]
        print(f"  Created new event '{event_name}' (ID: {new_id})", file=sys.stderr)
        return new_id


def get_or_create_player(cur, first_name: str, last_name: str, dry_run: bool = False) -> int:
    """
    Get existing player or create new one.
    Returns the player ID.
    """
    # Check if player exists
    cur.execute("""
        SELECT id FROM players 
        WHERE first_name = %s AND last_name = %s
    """, (first_name, last_name))
    
    result = cur.fetchone()
    if result:
        print(f"  Player '{first_name} {last_name}' already exists (ID: {result[0]})", file=sys.stderr)
        return result[0]
    
    # Player doesn't exist, create them
    sql = cur.mogrify("""
        INSERT INTO players (first_name, last_name)
        VALUES (%s, %s)
        RETURNING id
    """, (first_name, last_name))
    
    if dry_run:
        print(f"\n-- Create Player SQL:")
        print(sql.decode('utf-8'))
        return 9999  # Placeholder ID for dry run
    else:
        cur.execute(sql)
        new_id = cur.fetchone()[0]
        print(f"  Created new player '{first_name} {last_name}' (ID: {new_id})", file=sys.stderr)
        return new_id


def insert_result(cur, event_id: int, player_id: int, row: Dict, dry_run: bool = False) -> None:
    """
    Insert a result record.
    """
    sql = cur.mogrify("""
        INSERT INTO results (
            player_id, event_id, day2, top8,
            limited_wins, limited_losses, limited_draws,
            num_drafts, positive_drafts, negative_drafts, trophy_drafts, no_win_drafts,
            constructed_wins, constructed_losses, constructed_draws,
            overall_wins, overall_losses, overall_draws, overall_record,
            day1_wins, day1_losses, day1_draws,
            day2_wins, day2_losses, day2_draws,
            day3_wins, day3_losses, day3_draws,
            in_contention, win_streak, loss_streak, streak5,
            finish, summary, team, deck, notes
        ) VALUES (
            %s, %s, %s, %s,
            %s, %s, %s,
            %s, %s, %s, %s, %s,
            %s, %s, %s,
            %s, %s, %s, %s,
            %s, %s, %s,
            %s, %s, %s,
            %s, %s, %s,
            %s, %s, %s, %s,
            %s, %s, %s, %s, %s
        )
    """, (
        player_id, event_id, row['day2'], row['top8'],
        row['limited_wins'], row['limited_losses'], row['limited_draws'],
        row['num_drafts'], row['positive_drafts'], row['negative_drafts'], 
        row['trophy_drafts'], row['no_win_drafts'],
        row['constructed_wins'], row['constructed_losses'], row['constructed_draws'],
        row['overall_wins'], row['overall_losses'], row['overall_draws'], row['overall_record'],
        row['day1_wins'], row['day1_losses'], row['day1_draws'],
        row['day2_wins'], row['day2_losses'], row['day2_draws'],
        row['day3_wins'], row['day3_losses'], row['day3_draws'],
        row['in_contention'], row['win_streak'], row['loss_streak'], row['streak5'],
        row['finish'], row['summary'], row['team'], row['deck'], row['notes']
    ))
    
    if dry_run:
        print(f"\n-- Insert Result SQL:")
        print(sql.decode('utf-8'))
    else:
        cur.execute(sql)
        print(f"  Inserted result for player ID {player_id} at event ID {event_id}", file=sys.stderr)


def process_csv_row(cur, row: Dict, dry_run: bool = False) -> None:
    """Process a single CSV row."""
    # Parse event data
    event_name = row['Event'].strip()
    event_date = parse_date(row['Event Date'].strip())
    event_format = row['Format of Event'].strip()
    event_id = safe_int(row['Event #'])
    
    # Parse player data
    first_name = row['First'].strip()
    last_name = row['Last'].strip()
    
    # Get or create event
    actual_event_id = get_or_create_event(cur, event_name, event_date, event_format, event_id, dry_run)
    
    # Get or create player
    player_id = get_or_create_player(cur, first_name, last_name, dry_run)
    
    # Parse result data
    result_data = {
        'day2': safe_bool(row['Day 2']),
        'top8': safe_bool(row['Top 8']),
        'limited_wins': safe_int(row['Limited Wins']),
        'limited_losses': safe_int(row['Limited Loses']),
        'limited_draws': safe_int(row['Limited Draws']),
        'num_drafts': safe_int(row['Drafts']),
        'positive_drafts': safe_int(row['Positive Record']),
        'negative_drafts': safe_int(row['Losing Record']),
        'trophy_drafts': safe_int(row['# of Trophy']),
        'no_win_drafts': safe_int(row['0-3']),
        'constructed_wins': safe_int(row['Constructed Wins']),
        'constructed_losses': safe_int(row['Constructed Loses']),
        'constructed_draws': safe_int(row['Constructed Draws']),
        'overall_wins': safe_int(row['Overall Wins']),
        'overall_losses': safe_int(row['Overall Loses']),
        'overall_draws': safe_int(row['Overall Draws']),
        'overall_record': row['Overall Record'].strip(),
        'day1_wins': safe_int(row['D1 W']),
        'day1_losses': safe_int(row['D1 L']),
        'day1_draws': safe_int(row['D1 D']),
        'day2_wins': safe_int(row['D2 W']),
        'day2_losses': safe_int(row['D2 L']),
        'day2_draws': safe_int(row['D2 D']),
        'day3_wins': safe_int(row['D3 W']),
        'day3_losses': safe_int(row['D3 L']),
        'day3_draws': safe_int(row['D3 D']),
        'in_contention': safe_bool(row['In contention']),
        'win_streak': safe_int(row['W Streak']),
        'loss_streak': safe_int(row['L Streak']),
        'streak5': safe_int(row['5 win St']),
        'finish': safe_int(row['Rank']),
        'summary': row['Summary'].strip(),
        'team': row['Team'].strip() if row['Team'].strip() else None,
        'deck': row['Deck'].strip(),
        'notes': row.get('Notes', '').strip() if row.get('Notes', '').strip() else None
    }
    
    # Insert result
    insert_result(cur, actual_event_id, player_id, result_data, dry_run)


def main():
    if len(sys.argv) < 2:
        print("Usage: python import_results.py <db_connection_string> [--dry-run] [--limit N]")
        print("\nThe script will read from 'data.csv' in the same directory.")
        print("\nExamples:")
        print("  # Dry run - print SQL for first row only")
        print("  python import_results.py 'dbname=mtg user=postgres' --dry-run")
        print()
        print("  # Process all rows")
        print("  python import_results.py 'dbname=mtg user=postgres'")
        print()
        print("  # Process first 10 rows")
        print("  python import_results.py 'dbname=mtg user=postgres' --limit 10")
        sys.exit(1)
    
    # Hardcoded CSV file path - must be in same directory as script
    import os
    script_dir = os.path.dirname(os.path.abspath(__file__))
    csv_file = os.path.join(script_dir, 'data.csv')
    
    db_conn_string = sys.argv[1]
    
    # Parse optional flags
    dry_run = '--dry-run' in sys.argv
    limit = None
    if '--limit' in sys.argv:
        limit_idx = sys.argv.index('--limit')
        if limit_idx + 1 < len(sys.argv):
            limit = int(sys.argv[limit_idx + 1])
    
    # Default to 1 row for dry run
    if dry_run and limit is None:
        limit = 1
    
    print(f"Processing CSV: {csv_file}", file=sys.stderr)
    print(f"Dry run: {dry_run}", file=sys.stderr)
    print(f"Limit: {limit if limit else 'None'}", file=sys.stderr)
    print("", file=sys.stderr)
    
    # Connect to database
    try:
        conn = psycopg2.connect(db_conn_string)
        cur = conn.cursor()
        print("Connected to database successfully", file=sys.stderr)
    except Exception as e:
        print(f"Error connecting to database: {e}", file=sys.stderr)
        sys.exit(1)
    
    try:
        # Read and process CSV
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            
            rows_processed = 0
            for row in reader:
                rows_processed += 1
                
                print(f"\n{'='*60}", file=sys.stderr)
                print(f"Processing row {rows_processed}: {row['First']} {row['Last']}", file=sys.stderr)
                print(f"{'='*60}", file=sys.stderr)
                
                process_csv_row(cur, row, dry_run)
                
                if limit and rows_processed >= limit:
                    print(f"\nReached limit of {limit} rows", file=sys.stderr)
                    break
        
        if not dry_run:
            conn.commit()
            print(f"\n✓ Successfully imported {rows_processed} result(s)", file=sys.stderr)
        else:
            print(f"\n✓ Dry run complete - processed {rows_processed} row(s)", file=sys.stderr)
            print("  (No changes were made to the database)", file=sys.stderr)
    
    except Exception as e:
        conn.rollback()
        print(f"\n✗ Error processing CSV: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)
    
    finally:
        cur.close()
        conn.close()


if __name__ == '__main__':
    main()
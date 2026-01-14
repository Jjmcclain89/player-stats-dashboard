#!/usr/bin/env python3
"""
Add notable qualifications for players from CSV.
Creates new players if they don't exist, then adds notable_qualifications records.
CSV should have two columns: First, Last (no headers)
"""

import csv
import sys
import psycopg2
import os


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
        return result[0]
    
    # Player doesn't exist, create them
    if dry_run:
        sql = cur.mogrify("""
            INSERT INTO players (first_name, last_name)
            VALUES (%s, %s)
            RETURNING id
        """, (first_name, last_name))
        print(f"-- Would create player: {sql.decode('utf-8')}")
        return 9999  # Placeholder for dry run
    else:
        cur.execute("""
            INSERT INTO players (first_name, last_name)
            VALUES (%s, %s)
            RETURNING id
        """, (first_name, last_name))
        new_id = cur.fetchone()[0]
        print(f"  Created new player: {first_name} {last_name} (ID: {new_id})", file=sys.stderr)
        return new_id


def check_qualification_exists(cur, player_id: int, event_id: int) -> bool:
    """
    Check if a notable_qualification already exists for this player and event.
    """
    cur.execute("""
        SELECT id FROM notable_qualifications
        WHERE player_id = %s AND event_id = %s
    """, (player_id, event_id))
    
    return cur.fetchone() is not None


def add_notable_qualification(cur, player_id: int, event_id: int, dry_run: bool = False) -> None:
    """
    Add a notable_qualification record.
    """
    if check_qualification_exists(cur, player_id, event_id):
        print(f"  Qualification already exists for player_id={player_id}, event_id={event_id}", file=sys.stderr)
        return
    
    if dry_run:
        sql = cur.mogrify("""
            INSERT INTO notable_qualifications (player_id, event_id)
            VALUES (%s, %s)
        """, (player_id, event_id))
        print(f"-- Would add qualification: {sql.decode('utf-8')}")
    else:
        cur.execute("""
            INSERT INTO notable_qualifications (player_id, event_id)
            VALUES (%s, %s)
        """, (player_id, event_id))
        print(f"  Added qualification for player_id={player_id}, event_id={event_id}", file=sys.stderr)


def main():
    if len(sys.argv) < 2:
        print("Usage: python add_notable_qualifications.py <db_connection_string> [--dry-run]")
        print("\nThe script will read from 'richmond-qs.csv' in the same directory.")
        print("Event ID is hardcoded as 13.")
        print("\nExamples:")
        print("  # Dry run - print SQL without executing")
        print("  python add_notable_qualifications.py 'dbname=mtg user=postgres' --dry-run")
        print()
        print("  # Execute for real")
        print("  python add_notable_qualifications.py 'dbname=mtg user=postgres'")
        sys.exit(1)
    
    # Hardcoded values
    script_dir = os.path.dirname(os.path.abspath(__file__))
    csv_file = os.path.join(script_dir, 'richmond-qs.csv')
    event_id = 13
    
    db_conn_string = sys.argv[1]
    dry_run = '--dry-run' in sys.argv
    
    # Check if CSV exists
    if not os.path.exists(csv_file):
        print(f"Error: Could not find 'richmond-qs.csv' in {script_dir}", file=sys.stderr)
        sys.exit(1)
    
    print(f"Reading CSV: {csv_file}", file=sys.stderr)
    print(f"Event ID: {event_id}", file=sys.stderr)
    print(f"Dry run: {dry_run}", file=sys.stderr)
    print("", file=sys.stderr)
    
    # Connect to database
    try:
        conn = psycopg2.connect(db_conn_string)
        cur = conn.cursor()
        print("Connected to database successfully", file=sys.stderr)
        print("", file=sys.stderr)
    except Exception as e:
        print(f"Error connecting to database: {e}", file=sys.stderr)
        sys.exit(1)
    
    try:
        players_processed = 0
        players_created = 0
        qualifications_added = 0
        qualifications_skipped = 0
        
        # Read and process CSV
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.reader(f)
            
            for row in reader:
                if len(row) < 2:
                    continue
                
                first_name = row[0].strip()
                last_name = row[1].strip()
                
                if not first_name or not last_name:
                    continue
                
                players_processed += 1
                print(f"\n{'='*70}", file=sys.stderr)
                print(f"Processing: {first_name} {last_name}", file=sys.stderr)
                print(f"{'='*70}", file=sys.stderr)
                
                # Get or create player
                player_existed = True
                cur.execute("""
                    SELECT id FROM players 
                    WHERE first_name = %s AND last_name = %s
                """, (first_name, last_name))
                result = cur.fetchone()
                
                if result:
                    player_id = result[0]
                    print(f"  Player exists (ID: {player_id})", file=sys.stderr)
                else:
                    player_id = get_or_create_player(cur, first_name, last_name, dry_run)
                    players_created += 1
                    player_existed = False
                
                # Add notable qualification
                if check_qualification_exists(cur, player_id, event_id):
                    print(f"  Qualification already exists - skipping", file=sys.stderr)
                    qualifications_skipped += 1
                else:
                    add_notable_qualification(cur, player_id, event_id, dry_run)
                    qualifications_added += 1
        
        if not dry_run:
            conn.commit()
            print(f"\n{'='*70}", file=sys.stderr)
            print("✓ Successfully completed!", file=sys.stderr)
            print(f"{'='*70}", file=sys.stderr)
        else:
            print(f"\n{'='*70}", file=sys.stderr)
            print("✓ Dry run complete - no changes made", file=sys.stderr)
            print(f"{'='*70}", file=sys.stderr)
        
        print(f"\nSummary:", file=sys.stderr)
        print(f"  Players processed: {players_processed}", file=sys.stderr)
        print(f"  New players created: {players_created}", file=sys.stderr)
        print(f"  Qualifications added: {qualifications_added}", file=sys.stderr)
        print(f"  Qualifications skipped (already exist): {qualifications_skipped}", file=sys.stderr)
    
    except Exception as e:
        conn.rollback()
        print(f"\n✗ Error processing: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)
    
    finally:
        cur.close()
        conn.close()


if __name__ == '__main__':
    main()
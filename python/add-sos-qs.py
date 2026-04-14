#!/usr/bin/env python3
"""
Create PT SOS event and add notable qualifications from CSV.
CSV must have headers: First, Last, Invitation Source
Place the CSV as 'sos-qs.csv' in the same directory as this script.
"""

import csv
import sys
import psycopg2
import os

EVENT_ID = 14
EVENT_NAME = 'SOS'
EVENT_DATE = '2026-05-01'
EVENT_FORMAT = 'Standard'

DB_CONN = 'postgresql://postgres:postgres@localhost:5432/mtg-history'


def get_or_create_event(cur, dry_run: bool = False) -> None:
    cur.execute("SELECT id FROM events WHERE id = %s", (EVENT_ID,))
    if cur.fetchone():
        print(f"  Event '{EVENT_NAME}' (ID: {EVENT_ID}) already exists", file=sys.stderr)
        return

    sql = cur.mogrify("""
        INSERT INTO events (id, name, date, format)
        VALUES (%s, %s, %s, %s)
    """, (EVENT_ID, EVENT_NAME, EVENT_DATE, EVENT_FORMAT))

    if dry_run:
        print(f"-- Would create event: {sql.decode('utf-8')}")
    else:
        cur.execute(sql)
        print(f"  Created event '{EVENT_NAME}' (ID: {EVENT_ID})", file=sys.stderr)


def get_or_create_player(cur, first_name: str, last_name: str, dry_run: bool = False) -> int:
    cur.execute("""
        SELECT id FROM players
        WHERE unaccent(lower(first_name)) = unaccent(lower(%s))
          AND unaccent(lower(last_name))  = unaccent(lower(%s))
    """, (first_name, last_name))

    result = cur.fetchone()
    if result:
        return result[0]

    sql = cur.mogrify("""
        INSERT INTO players (first_name, last_name)
        VALUES (%s, %s)
        RETURNING id
    """, (first_name, last_name))

    if dry_run:
        print(f"-- Would create player: {sql.decode('utf-8')}")
        return 9999
    else:
        cur.execute(sql)
        new_id = cur.fetchone()[0]
        print(f"  Created new player: {first_name} {last_name} (ID: {new_id})", file=sys.stderr)
        return new_id


def add_notable_qualification(cur, player_id: int, dry_run: bool = False) -> bool:
    cur.execute("""
        SELECT id FROM notable_qualifications
        WHERE player_id = %s AND event_id = %s
    """, (player_id, EVENT_ID))

    if cur.fetchone():
        print(f"  Qualification already exists - skipping", file=sys.stderr)
        return False

    sql = cur.mogrify("""
        INSERT INTO notable_qualifications (player_id, event_id)
        VALUES (%s, %s)
    """, (player_id, EVENT_ID))

    if dry_run:
        print(f"-- Would add qualification: {sql.decode('utf-8')}")
    else:
        cur.execute(sql)
        print(f"  Added qualification for player_id={player_id}", file=sys.stderr)
    return True


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    csv_file = os.path.join(script_dir, 'sos-qs.csv')
    dry_run = '--dry-run' in sys.argv
    new_players_only = '--new-players-only' in sys.argv

    if not os.path.exists(csv_file):
        print(f"Error: Could not find 'sos-qs.csv' in {script_dir}", file=sys.stderr)
        sys.exit(1)

    print(f"Reading CSV: {csv_file}", file=sys.stderr)
    print(f"Event: {EVENT_NAME} (ID: {EVENT_ID}, {EVENT_DATE}, {EVENT_FORMAT})", file=sys.stderr)
    print(f"Dry run: {dry_run}", file=sys.stderr)
    if new_players_only:
        print("Mode: new players only", file=sys.stderr)
    print("", file=sys.stderr)

    try:
        conn = psycopg2.connect(DB_CONN)
        cur = conn.cursor()
        print("Connected to database successfully", file=sys.stderr)
        print("", file=sys.stderr)
    except Exception as e:
        print(f"Error connecting to database: {e}", file=sys.stderr)
        sys.exit(1)

    try:
        # Create event first
        print("=" * 70, file=sys.stderr)
        print("Creating event...", file=sys.stderr)
        get_or_create_event(cur, dry_run)

        players_processed = 0
        players_created = 0
        qualifications_added = 0
        qualifications_skipped = 0

        with open(csv_file, 'r', encoding='utf-8-sig') as f:
            reader = csv.DictReader(f)

            for row in reader:
                first_name = row['First'].strip()
                last_name = row['Last'].strip()

                if not first_name or not last_name:
                    continue

                players_processed += 1
                if not new_players_only:
                    print(f"\n{'=' * 70}", file=sys.stderr)
                    print(f"Processing: {first_name} {last_name}", file=sys.stderr)

                cur.execute("""
                    SELECT id FROM players
                    WHERE unaccent(lower(first_name)) = unaccent(lower(%s))
                      AND unaccent(lower(last_name))  = unaccent(lower(%s))
                """, (first_name, last_name))
                result = cur.fetchone()

                if result:
                    player_id = result[0]
                    if not new_players_only:
                        print(f"  Player exists (ID: {player_id})", file=sys.stderr)
                else:
                    players_created += 1
                    if new_players_only:
                        print(f"{first_name} {last_name}")
                        continue
                    player_id = get_or_create_player(cur, first_name, last_name, dry_run)

                if not new_players_only:
                    added = add_notable_qualification(cur, player_id, dry_run)
                    if added:
                        qualifications_added += 1
                    else:
                        qualifications_skipped += 1

        if not dry_run:
            conn.commit()

        print(f"\n{'=' * 70}", file=sys.stderr)
        print("✓ Dry run complete - no changes made" if dry_run else "✓ Successfully completed!", file=sys.stderr)
        print(f"\nSummary:", file=sys.stderr)
        print(f"  Players processed:                    {players_processed}", file=sys.stderr)
        print(f"  New players created:                  {players_created}", file=sys.stderr)
        print(f"  Qualifications added:                 {qualifications_added}", file=sys.stderr)
        print(f"  Qualifications skipped (duplicates):  {qualifications_skipped}", file=sys.stderr)

    except Exception as e:
        conn.rollback()
        print(f"\n✗ Error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)

    finally:
        cur.close()
        conn.close()


if __name__ == '__main__':
    main()

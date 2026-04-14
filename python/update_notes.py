#!/usr/bin/env python3
"""
Update the notes field on result records from alldata.csv.
Matches by player name (accent-insensitive) and event id.
CSV has a junk first row; headers are on row 2.
"""

import csv
import sys
import psycopg2
import os

DB_CONN = 'postgresql://postgres:postgres@localhost:5432/mtg-history'


def find_result(cur, first_name: str, last_name: str, event_id: int):
    cur.execute("""
        SELECT r.id, r.notes
        FROM results r
        JOIN players p ON p.id = r.player_id
        WHERE unaccent(lower(p.first_name)) = unaccent(lower(%s))
          AND unaccent(lower(p.last_name))  = unaccent(lower(%s))
          AND r.event_id = %s
    """, (first_name, last_name, event_id))
    return cur.fetchone()


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    csv_file = os.path.join(script_dir, 'alldata.csv')
    dry_run = '--dry-run' in sys.argv
    not_in_db = '--not-in-db' in sys.argv

    if not os.path.exists(csv_file):
        print(f"Error: Could not find 'alldata.csv' in {script_dir}", file=sys.stderr)
        sys.exit(1)

    print(f"Reading CSV: {csv_file}", file=sys.stderr)
    print(f"Dry run: {dry_run}", file=sys.stderr)
    print("", file=sys.stderr)

    try:
        conn = psycopg2.connect(DB_CONN)
        cur = conn.cursor()
        print("Connected to database successfully", file=sys.stderr)
    except Exception as e:
        print(f"Error connecting to database: {e}", file=sys.stderr)
        sys.exit(1)

    try:
        updated = 0
        skipped_no_change = 0
        skipped_not_found = 0
        skipped_blank_notes = 0

        with open(csv_file, 'r', encoding='utf-8-sig') as f:
            # Skip the junk first row, use second row as headers
            next(f)
            reader = csv.DictReader(f)

            for row in reader:
                first_name = row['First'].strip()
                last_name = row['Last'].strip()
                event_id_str = row['Event #'].strip()
                new_notes = row['Notes'].strip()

                if not first_name or not last_name or not event_id_str:
                    continue

                event_id = int(event_id_str)

                # Skip rows with no notes — nothing to update
                if not new_notes:
                    skipped_blank_notes += 1
                    continue

                result = find_result(cur, first_name, last_name, event_id)

                if not result:
                    skipped_not_found += 1
                    if not not_in_db:
                        print(f"  NOT FOUND: {first_name} {last_name} event {event_id}", file=sys.stderr)
                    else:
                        print(f"{first_name} {last_name} (event {event_id})")
                    continue

                result_id, current_notes = result

                if current_notes == new_notes:
                    skipped_no_change += 1
                    continue

                if dry_run and not not_in_db:
                    print(f"  WOULD UPDATE: {first_name} {last_name} event {event_id}")
                    print(f"    old: {current_notes!r}")
                    print(f"    new: {new_notes!r}")
                elif not dry_run:
                    cur.execute("""
                        UPDATE results SET notes = %s WHERE id = %s
                    """, (new_notes, result_id))

                updated += 1

        if not dry_run:
            conn.commit()

        print(f"\n{'=' * 60}", file=sys.stderr)
        print("✓ Dry run complete - no changes made" if dry_run else "✓ Done!", file=sys.stderr)
        print(f"\nSummary:", file=sys.stderr)
        print(f"  Updated:               {updated}", file=sys.stderr)
        print(f"  Skipped (no change):   {skipped_no_change}", file=sys.stderr)
        print(f"  Skipped (blank notes): {skipped_blank_notes}", file=sys.stderr)
        print(f"  Not found in DB:       {skipped_not_found}", file=sys.stderr)

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

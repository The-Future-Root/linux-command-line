#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 9 check
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 09-text-editors); require_area "$AREA"
cd "$AREA" || exit 1
echo "Checking $PWD"
expect "bakery.conf opens at 07:00" 'grep -qx "open=07:00" bakery.conf && ! grep -q "open=08:00" bakery.conf' "Change the line open=08:00 to open=07:00."
expect "the debug line is gone" '! grep -q "^debug" bakery.conf' "Delete the whole line debug=true. In nano, Ctrl+K cuts the line the cursor is on. In vim, dd."
expect "the last line is city=Leeds" '[ "$(tail -n 1 bakery.conf)" = "city=Leeds" ]' "Add city=Leeds as a new line at the end."
expect "the other settings are unchanged" 'grep -qx "name=Rosie'"'"'s Bakery" bakery.conf && grep -qx "close=15:00" bakery.conf && grep -qx "max_order=20" bakery.conf && [ "$(grep -c . bakery.conf)" -eq 6 ]' "Run setup.sh to start again if something else changed."
expect "notes.txt has 3 lines" '[ -f notes.txt ] && [ "$(grep -c . notes.txt)" -eq 3 ]' "Make notes.txt in the editor, write three lines, and save it."
expect "notes.txt was saved with a final new line" '[ -f notes.txt ] && [ "$(tail -c 1 notes.txt | od -An -c | tr -d " ")" = "\n" ]' "Press Enter after the last line before saving. (nano and vim normally add it for you.)"
finish

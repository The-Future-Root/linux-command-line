#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 8 check: runs your backup.sh in a scratch copy of the practice folder.
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 08-shell-scripting); require_area "$AREA"
cd "$AREA" || exit 1
echo "Checking $PWD/backup.sh"
expect "backup.sh starts with #!/usr/bin/env bash (or #!/bin/bash)" 'head -n 1 backup.sh | grep -Eq "^#!(/usr/bin/env bash|/bin/bash)"' "The first line tells the system which program runs the script."
expect "backup.sh is executable" '[ -x backup.sh ]' "chmod +x backup.sh"
if [ ! -x backup.sh ]; then finish; fi
T=$(mktemp -d)
cp -R backup.sh recipes "$T"/
cd "$T" || exit 1
TODAY=$(date +%F)
./backup.sh recipes > out.txt 2> err.txt; code=$?
expect "./backup.sh recipes exits with 0" '[ "$code" -eq 0 ]' "The script should finish with success when the folder exists. Look at what it prints when you run it."
expect "it copies recipes to backups/recipes-$TODAY" '[ -f "backups/recipes-$TODAY/croissant.txt" ] && [ -f "backups/recipes-$TODAY/bread/sourdough.txt" ]' "Use \$(date +%F) for the date, mkdir -p backups, then cp -r \"\$folder\" \"backups/\$folder-\$today\"."
expect "it prints: Backed up 3 files from recipes to backups/recipes-$TODAY" '[ "$(cat out.txt)" = "Backed up 3 files from recipes to backups/recipes-$TODAY" ]' "Count the files with find \"\$folder\" -type f | wc -l. On a Mac, add | tr -d \" \" to remove spaces."
rm -rf backups
./backup.sh > out.txt 2> err.txt; code=$?
expect "with no folder given, it exits with 1" '[ "$code" -eq 1 ]' "Check [ \$# -eq 0 ], print the usage line, then exit 1."
expect "...and prints Usage: ./backup.sh FOLDER as an error" 'grep -q "Usage: ./backup.sh FOLDER" err.txt && [ ! -s out.txt ]' "Send it to standard error: echo \"Usage: ./backup.sh FOLDER\" >&2"
./backup.sh no-such-folder > out.txt 2> err.txt; code=$?
expect "with a folder that doesn't exist, it exits with 2" '[ "$code" -eq 2 ]' "Check [ ! -d \"\$folder\" ], print an error, then exit 2."
expect "...and prints No such folder: no-such-folder as an error" 'grep -q "No such folder: no-such-folder" err.txt && [ ! -d backups/no-such-folder-$TODAY ]' "echo \"No such folder: \$folder\" >&2, before making any backup."
cd "$AREA" && rm -rf "$T"
finish

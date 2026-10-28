#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 6 check
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 06-processes); require_area "$AREA"
cd "$AREA" || exit 1
PID=$(cat .pid 2>/dev/null)
ls /no-such-folder >/dev/null 2>&1; LS_CODE=$?
echo "Checking $PWD"
expect "1: the PID of bakery-backup.sh" '[ "$(answer 1)" = "$PID" ]' "ps aux | grep bakery-backup shows it. The PID is the number in the second column."
expect "bakery-backup.sh has been stopped" '! kill -0 "$PID"' "kill followed by the PID sends it the TERM signal, which asks it to stop."
expect "2: the exit code of a grep that finds nothing" '[ "$(answer 2)" = "1" ]' "Run grep zzz notes.txt, then echo \$? straight after it."
expect "3: the exit code of ls on a folder that doesn't exist" '[ "$(answer 3)" = "$LS_CODE" ]' "Run ls /no-such-folder, then echo \$?."
expect "4: the signal number of KILL" '[ "$(answer 4)" = "9" ]' "kill -l lists the signals and their numbers."
finish

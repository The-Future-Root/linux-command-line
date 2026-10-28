#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 4 check
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 04-pipes-and-redirection); require_area "$AREA"
cd "$AREA" || exit 1
LOG=logs/access.log
echo "Checking $PWD/reports"
expect "reports/not-found.txt holds every 404 line" 'same_as reports/not-found.txt "grep \"\\\" 404 \" $LOG"' "grep '\" 404 ' logs/access.log > reports/not-found.txt"
expect "reports/pages.txt lists each page once, A to Z" 'same_as reports/pages.txt "cut -d\" \" -f7 $LOG | sort -u"' "The path is the 7th space-separated field: cut -d' ' -f7, then sort -u (or sort | uniq)."
expect "reports/status-counts.txt counts each status, most common first" 'same_as reports/status-counts.txt "cut -d\" \" -f9 $LOG | sort | uniq -c | sort -rn"' "The status is field 9. uniq -c only counts lines next to each other, so sort before it, then sort -rn after."
expect "reports/top-addresses.txt shows the 5 busiest addresses with counts" 'same_as reports/top-addresses.txt "cut -d\" \" -f1 $LOG | sort | uniq -c | sort -rn | head -n 5"' "Like status-counts, with field 1 and | head -n 5 at the end."
expect "reports/summary.txt line 1 is the number of requests" '[ "$(sed -n 1p reports/summary.txt | tidy)" = "345" ]' "wc -l < logs/access.log > reports/summary.txt (the < stops wc printing the file name)."
expect "reports/summary.txt line 2 is the number of 404s" '[ "$(sed -n 2p reports/summary.txt | tidy)" = "54" ] && [ "$(wc -l < reports/summary.txt | tidy)" = "2" ]' "Add the second line with >>, not >, which would replace the first: grep -c '\" 404 ' logs/access.log >> reports/summary.txt"
expect "reports/listing.txt has the normal output of ls" 'grep -q access.log reports/listing.txt && ! grep -qi "no such" reports/listing.txt' "ls logs no-such-folder > reports/listing.txt 2> reports/errors.txt"
expect "reports/errors.txt has the error message" 'grep -q no-such-folder reports/errors.txt' "Errors go to stream 2. Send them to a file with 2>."
finish

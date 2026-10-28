#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 3 check
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 03-viewing-and-searching); require_area "$AREA"
cd "$AREA" || exit 1
echo "Checking $PWD/answers.txt"
expect "1: requests in access.log" '[ "$(answer 1)" = "345" ]' "wc -l server/logs/access.log counts the lines; each line is one request."
expect "2: requests that got a 404" '[ "$(answer 2)" = "54" ]' "grep -c counts matching lines. Search for \" 404 \", with the spaces, so you don't match 404 elsewhere in a line."
expect "3: the time of the first request" '[ "$(answer 3)" = "07:00:08" ]' "head -n 1 shows the first line. Write the time as HH:MM:SS."
expect "4: the address that made the last request" '[ "$(answer 4)" = "192.0.2.44" ]' "tail -n 1 shows the last line. The address is the first thing on it."
expect "5: the page that mentions gluten-free" 'case "$(answer 5)" in server/site/menu/specials.html|site/menu/specials.html|./server/site/menu/specials.html|menu/specials.html|specials.html) true;; *) false;; esac' "grep -r searches every file in a folder: grep -r gluten-free server/site"
expect "6: the number of .html files under server/site" '[ "$(answer 6)" = "5" ]' "find server/site -name \"*.html\" lists them. Count them, or add | wc -l."
expect "7: error.log lines that mention a timeout, in any case" '[ "$(answer 7)" = "2" ]' "grep -i ignores case. Add -c to count."
finish

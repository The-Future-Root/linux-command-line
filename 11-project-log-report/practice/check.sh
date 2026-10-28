#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 11 check: runs your log-report.sh on both logs, and on bad input.
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 11-project-log-report); require_area "$AREA"
cd "$AREA" || exit 1
echo "Checking $PWD/log-report.sh"

# What the report should say, worked out here with the same tools
expected() {
  local log="$1" top="${2:-3}"
  echo "Report for $log"
  echo "Requests: $(wc -l < "$log")"
  echo "Visitors: $(cut -d' ' -f1 "$log" | sort -u | wc -l)"
  echo "Not found (404): $(cut -d' ' -f9 "$log" | grep -c '^404$')"
  echo "Server errors (5xx): $(cut -d' ' -f9 "$log" | grep -c '^5')"
  echo "Requests by hour:"
  cut -d: -f2 "$log" | sort | uniq -c
  echo "Top $top pages:"
  cut -d' ' -f7 "$log" | sort | uniq -c | sort -rn | head -n "$top"
}
same_report() { [ "$(./log-report.sh "$@" 2>/dev/null | tidy)" = "$(expected "$@" | tidy)" ]; }

expect "log-report.sh is executable and starts with a shebang" '[ -x log-report.sh ] && head -n 1 log-report.sh | grep -q "^#!"' "chmod +x log-report.sh"
if [ ! -x log-report.sh ]; then finish; fi
expect "the report for logs/saturday.log is right" 'same_report logs/saturday.log' "Run ./log-report.sh logs/saturday.log and compare it, line by line, with the example in the README."
expect "the report for logs/sunday.log is right" 'same_report logs/sunday.log' "It must work out everything from the file it's given: nothing can be typed in."
expect "./log-report.sh logs/sunday.log 5 shows the top 5 pages" 'same_report logs/sunday.log 5' "Use \${2:-3}: the second argument, or 3 if there isn't one."
./log-report.sh > /dev/null 2> err.txt; code=$?
expect "with no log file given, it exits with 1 and prints the usage" '[ "$code" -eq 1 ] && grep -q "Usage: ./log-report.sh LOGFILE \[N\]" err.txt' "echo \"Usage: ./log-report.sh LOGFILE [N]\" >&2, then exit 1."
./log-report.sh logs/monday.log > /dev/null 2> err.txt; code=$?
expect "with a file that doesn't exist, it exits with 2" '[ "$code" -eq 2 ] && grep -q "No such file: logs/monday.log" err.txt' "Check [ -f \"\$log\" ] first: echo \"No such file: \$log\" >&2, then exit 2."
rm -f err.txt
finish

# Solution: 11. Project: a log report

Run these inside `~/practice/linux-command-line/11-project-log-report`.

```bash
cat > log-report.sh <<'END'
#!/usr/bin/env bash
# log-report.sh LOGFILE [N]: summarise a web server access log, with the top N pages (default 3)
set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "Usage: ./log-report.sh LOGFILE [N]" >&2
  exit 1
fi

log="$1"
top="${2:-3}"

if [ ! -f "$log" ]; then
  echo "No such file: $log" >&2
  exit 2
fi

# count_status PATTERN: how many requests have a status matching PATTERN
count_status() {
  cut -d' ' -f9 "$log" | grep -c "$1" || true
}

echo "Report for $log"
echo "Requests: $(wc -l < "$log" | tr -d ' ')"
echo "Visitors: $(cut -d' ' -f1 "$log" | sort -u | wc -l | tr -d ' ')"
echo "Not found (404): $(count_status '^404$')"
echo "Server errors (5xx): $(count_status '^5')"
echo "Requests by hour:"
cut -d: -f2 "$log" | sort | uniq -c
echo "Top $top pages:"
cut -d' ' -f7 "$log" | sort | uniq -c | sort -rn | head -n "$top"
END

chmod +x log-report.sh
./log-report.sh logs/saturday.log
./log-report.sh logs/sunday.log 5
```

Notes:

- `${2:-3}` means "the second argument, or `3` if there isn't one". It's the shell's way of giving a default value.
- With `set -e`, a `grep -c` that finds nothing would stop the whole script, because `grep` exits with 1 when nothing matches, even though it prints `0`. `|| true` in `count_status` keeps it going. That's the kind of surprise lesson 8 warned about.
- The hour is the second field when each line is split at colons: `[14/Mar/2026:09:15:02` gives `09`. The fields are counted from the start of the line, and the first colon comes after the date.
- `tr -d ' '` removes the extra spaces that `wc` adds on macOS. The rest of the output keeps `uniq -c`'s spacing, which differs slightly between systems; the check ignores spacing.

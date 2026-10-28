#!/usr/bin/env bash
# Lesson 6 lab: a "backup" program left running in the background, to find and stop.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
OLD="$(area 06-processes)/.pid"
if [ -f "$OLD" ]; then kill "$(cat "$OLD")" 2>/dev/null || true; fi
AREA=$(new_area 06-processes) || exit 1
cd "$AREA"
cat > bakery-backup.sh <<'SH'
#!/usr/bin/env bash
# A pretend backup that never finishes. It writes a line every 2 seconds.
# (As a safety net, it stops by itself after an hour.)
end=$((SECONDS + 3600))
while [ "$SECONDS" -lt "$end" ]; do
  echo "$(date '+%H:%M:%S') still backing up..." >> backup.log
  sleep 2
done
SH
chmod +x bakery-backup.sh
printf 'Sourdough loaf\nCroissant\n' > notes.txt
nohup ./bakery-backup.sh > /dev/null 2>&1 &
echo $! > .pid
answers_file 4
ready "$AREA"

# Solution: 8. Shell scripting

Run these inside `~/practice/linux-command-line/08-shell-scripting`.

```bash
cat > backup.sh <<'END'
#!/usr/bin/env bash
# backup.sh FOLDER: copy FOLDER into backups/FOLDER-YYYY-MM-DD
set -u

if [ "$#" -eq 0 ]; then
  echo "Usage: ./backup.sh FOLDER" >&2
  exit 1
fi

folder="$1"
if [ ! -d "$folder" ]; then
  echo "No such folder: $folder" >&2
  exit 2
fi

today=$(date +%F)
destination="backups/$folder-$today"
mkdir -p backups
cp -r "$folder" "$destination"

count=$(find "$folder" -type f | wc -l | tr -d ' ')
echo "Backed up $count files from $folder to $destination"
END

chmod +x backup.sh
./backup.sh recipes
./backup.sh || echo "exit code: $?"
./backup.sh nowhere || echo "exit code: $?"
```

(The `|| echo` parts let you see the exit codes. They aren't part of the script.)

How it works:

- `"$#"` is the number of arguments. With none, the script prints how to use it and stops with exit code 1.
- `>&2` sends a message to standard error, where error messages belong (lesson 4). That way, if someone saves the output with `>`, the errors still show on screen.
- `[ ! -d "$folder" ]` is true when the folder doesn't exist. The script checks this **before** making anything, so a mistake never leaves a half-made backup.
- `$(date +%F)` gives today's date as `2026-03-14`, which sorts correctly by name.
- `tr -d ' '` removes the spaces that `wc` adds on a Mac. On Linux it does nothing.
- `set -u` makes the script stop if it ever uses a variable that was never set, which catches typos like `$foldr`.

Run it twice on the same day and `cp -r` copies into the existing backup, putting a second copy inside it. A good next step is to check `[ -e "$destination" ]` first and refuse, or add the time with `date +%F-%H%M`.

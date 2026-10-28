#!/usr/bin/env bash
# Shared helpers for the practice labs. Each lesson's setup.sh and check.sh source this file.
# Practice folders live under ~/practice/linux-command-line/, never inside this course folder.

PRACTICE_ROOT="${PRACTICE_ROOT:-$HOME/practice/linux-command-line}"
# The lesson's practice folder, recorded before any script changes directory
LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
MARKER=".practice-area"

# Create (or recreate) an empty practice folder. Only folders this course made are ever removed.
new_area() {
  local dir="$PRACTICE_ROOT/$1"
  if [ -e "$dir" ]; then
    if [ -f "$dir/$MARKER" ]; then
      chmod -R u+rwx "$dir" 2>/dev/null
      rm -rf "$dir"
    else
      echo "Stopping: $dir already exists and wasn't made by this course. Move it away and run setup again." >&2
      exit 1
    fi
  fi
  mkdir -p "$dir"
  touch "$dir/$MARKER"
  echo "$dir"
}

area() { echo "$PRACTICE_ROOT/$1"; }

require_area() {
  if [ ! -f "$1/$MARKER" ]; then echo "No practice area at $1. Run setup.sh first." >&2; exit 1; fi
}

# A file's permissions as three digits, like 644, on Linux (GNU stat) and macOS (BSD stat)
perm_of() {
  stat -c '%a' "$1" 2>/dev/null || stat -f '%Lp' "$1"
}

# The answer written after "N:" in answers.txt, with spaces trimmed from both ends
answer() {
  sed -n "s/^$1:[[:space:]]*//p" answers.txt 2>/dev/null | head -n 1 | sed 's/[[:space:]]*$//'
}

# check.sh helpers: print a line per check and remember failures.
# expect takes the condition as a string and evaluates it, so a check reads as one line:
#   expect "What should be true" 'some shell test' "Hint shown when it fails"
FAILS=0
pass() { printf '  \033[32mPASS\033[0m  %s\n' "$1"; }
fail() { printf '  \033[31mFAIL\033[0m  %s\n' "$1"; [ -n "$2" ] && printf '        %s\n' "$2"; FAILS=$((FAILS + 1)); }
expect() { if eval "$2" >/dev/null 2>&1; then pass "$1"; else fail "$1" "$3"; fi; }
finish() {
  echo
  if [ "$FAILS" -eq 0 ]; then echo "All checks passed. Nice work."; exit 0
  else echo "$FAILS check(s) failed. Read the hints above, fix them, and run check.sh again."; exit 1; fi
}

# End of setup.sh: tell the learner where to go and how to check their work
ready() {
  local dir="$1" here="$LAB_DIR"
  echo "Practice folder ready."
  echo
  echo "  Go there:      cd \"$dir\""
  echo "  When done:     bash \"$here/check.sh\""
  echo "  Start over:    bash \"$here/setup.sh\""
}

# An answers.txt with numbered blank lines, for questions answered by running commands
answers_file() {
  local count="$1" i
  : > answers.txt
  for i in $(seq 1 "$count"); do echo "$i: " >> answers.txt; done
}

# Print a file or command output with spaces tidied: no leading or trailing spaces, single spaces inside.
# Used to compare outputs that different systems pad differently (for example, uniq -c and wc).
tidy() { sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/[[:space:]][[:space:]]*/ /g'; }

# True if a file holds the same lines as the output of a command, ignoring spacing differences
same_as() {
  local file="$1"; shift
  [ -f "$file" ] && [ "$(tidy < "$file")" = "$(eval "$*" | tidy)" ]
}

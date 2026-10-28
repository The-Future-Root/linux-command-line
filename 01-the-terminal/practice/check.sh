#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 1 check
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 01-the-terminal); require_area "$AREA"
cd "$AREA" || exit 1
echo "Checking $PWD/answers.txt"
expect "1: your username" '[ "$(answer 1)" = "$(id -un)" ]' "Run whoami and copy what it prints."
expect "2: the full path of the practice folder" '[ "$(answer 2)" = "$AREA" ] || [ "$(answer 2)" = "$(pwd -P)" ]' "Run pwd inside the practice folder and copy the whole line, starting with /."
expect "3: the number of lines in welcome.txt" '[ "$(answer 3)" = "7" ]' "Run wc -l welcome.txt. The first number is the line count."
expect "4: the name of the kernel" '[ "$(answer 4)" = "$(uname -s)" ]' "Run uname and copy the word it prints."
expect "5: the ls option for human-readable sizes" 'case "$(answer 5)" in -h|--human-readable|"-lh"|"ls -lh"|"ls -h") true;; *) false;; esac' "Look through ls --help (or man ls) for \"human-readable\". The answer is an option, starting with -."
finish

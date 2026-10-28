#!/usr/bin/env bash
# Lesson 1 lab: a folder with a welcome note and an answers file.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 01-the-terminal) || exit 1
cd "$AREA"
cat > welcome.txt <<'TXT'
Welcome to the command line.
Every command you type is a small program.
Most of them do one job, and do it well.
You'll learn to combine them in lesson 4.
Press the up arrow to bring back your last command.
Press Tab to finish a long name for you.
Type clear, or press Ctrl+L, to tidy the screen.
TXT
answers_file 5
ready "$AREA"

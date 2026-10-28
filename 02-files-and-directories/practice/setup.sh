#!/usr/bin/env bash
# Lesson 2 lab: a messy downloads folder to tidy up.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 02-files-and-directories) || exit 1
D="$AREA/downloads"
mkdir -p "$D/old-stuff"
cd "$D"
for n in 1 2 3; do printf 'JPEG image %s\n' "$n" > "beach-$n.jpg"; done
printf 'JPEG image\n' > "birthday-cake.jpg"
printf 'Invoice: March, 3 sourdough loaves\n' > invoice-march.pdf
printf 'Invoice: April, 2 croissants\n' > invoice-april.pdf
printf 'Ring the plumber\nRenew passport\n' > todo.txt
printf 'Ideas for the garden\n' > notes.txt
printf 'Month,Spent\nJanuary,1240\n' > "budget 2026.csv"
printf 'Draft report\n' > "report (copy).txt"
printf 'Draft report\n' > report.txt
printf 'theme=dark\n' > .settings
ready "$D"

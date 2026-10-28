#!/usr/bin/env bash
# Lesson 8 lab: write backup.sh, a script that backs up a folder.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 08-shell-scripting) || exit 1
cd "$AREA"
mkdir -p recipes/bread
printf 'Sourdough: flour, water, salt, starter\n' > recipes/bread/sourdough.txt
printf 'Croissant: flour, butter, yeast, milk\n' > recipes/croissant.txt
printf 'Cinnamon roll: flour, sugar, cinnamon\n' > recipes/cinnamon-roll.txt
printf '#!/usr/bin/env bash\n# backup.sh FOLDER: copy FOLDER into backups/FOLDER-YYYY-MM-DD\n' > backup.sh
ready "$AREA"

#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 7 check
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 07-environment-variables); require_area "$AREA"
cd "$AREA" || exit 1
echo "Checking $PWD"
# Load env.sh in a fresh, clean shell, the way a new terminal would
loaded() { env -i HOME="$HOME" PATH="/usr/bin:/bin" bash -c 'cd "$1" && source ./env.sh >/dev/null 2>&1 && eval "$2"' _ "$AREA" "$1"; }
expect "env.sh exports BAKERY_CITY=Leeds" '[ "$(loaded "printenv BAKERY_CITY")" = "Leeds" ]' "Add the line: export BAKERY_CITY=Leeds (without export, programs you run can't see it)."
expect "env.sh puts the bin folder on PATH" '[ "$(loaded "command -v bakery-hours")" = "$AREA/bin/bakery-hours" ]' "Add: export PATH=\"\$PATH:$AREA/bin\" (use the full path, or \$PWD/bin if you always source it from this folder)."
expect "bakery-hours runs by name, and prints Leeds" '[ "$(loaded "bakery-hours")" = "Open 7am to 3pm in Leeds" ]' "Both lines above are needed for this one."
expect "PATH still has the normal folders" '[ -n "$(loaded "command -v ls")" ]' "Keep \$PATH at the start of the new value: PATH=\"\$PATH:...\". Writing PATH=\"$AREA/bin\" on its own loses every other folder."
expect "env.sh defines the alias ll for ls -l" 'loaded "alias ll" | grep -q "ls -l"' "Add: alias ll='"'"'ls -l'"'"'"
expect "1: your home folder" '[ "$(answer 1)" = "$HOME" ]' "echo \$HOME"
expect "2: your login shell" '[ "$(answer 2)" = "${SHELL:-none}" ]' "echo \$SHELL"
expect "3: where the ls program is" '[ -n "$(answer 3)" ] && [ "$(answer 3)" -ef "$(command -v ls)" ]' "which ls prints its full path."
finish

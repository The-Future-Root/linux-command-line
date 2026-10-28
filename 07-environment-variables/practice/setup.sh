#!/usr/bin/env bash
# Lesson 7 lab: a bin folder with a small program, and an env.sh file to write.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 07-environment-variables) || exit 1
cd "$AREA"
mkdir bin
cat > bin/bakery-hours <<'SH'
#!/usr/bin/env bash
# Prints the opening hours for the bakery in the city named by BAKERY_CITY.
if [ -z "$BAKERY_CITY" ]; then
  echo "BAKERY_CITY isn't set, so I don't know which bakery you mean." >&2
  exit 1
fi
echo "Open 7am to 3pm in $BAKERY_CITY"
SH
chmod +x bin/bakery-hours
printf '# Settings for the bakery tools. Load them with:  source env.sh\n' > env.sh
answers_file 3
ready "$AREA"

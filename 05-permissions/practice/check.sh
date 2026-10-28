#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 5 check
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 05-permissions); require_area "$AREA"
cd "$AREA/website" || exit 1
echo "Checking $PWD"
expect "deploy.sh can be run: 755 (rwxr-xr-x)" '[ "$(perm_of deploy.sh)" = "755" ]' "chmod 755 deploy.sh, or chmod +x deploy.sh"
expect "you ran ./deploy.sh, so live/ has the 2 published files" '[ -f live/index.html ] && [ -f live/style.css ]' "Run it with ./deploy.sh from the website folder."
expect "the public files are 644 (rw-r--r--)" '[ "$(perm_of public/index.html)" = "644" ] && [ "$(perm_of public/style.css)" = "644" ]' "Everyone may read them, but only you should change them: chmod 644 public/*"
expect "the secrets folder is 700 (rwx------)" '[ "$(perm_of secrets)" = "700" ]' "chmod 700 secrets: only you can open it."
expect "secrets/api-key.txt is 600 (rw-------)" '[ "$(perm_of secrets/api-key.txt)" = "600" ]' "chmod 600 secrets/api-key.txt: only you can read or change it."
expect "prices-final.csv is read-only for everyone: 444 (r--r--r--)" '[ "$(perm_of prices-final.csv)" = "444" ]' "chmod 444 prices-final.csv"
finish

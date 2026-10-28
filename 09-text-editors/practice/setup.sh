#!/usr/bin/env bash
# Lesson 9 lab: a settings file to edit in the terminal.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 09-text-editors) || exit 1
cd "$AREA"
cat > bakery.conf <<'CONF'
# Settings for the bakery's ordering website
name=Rosie's Bakery
open=08:00
close=15:00
debug=true
max_order=20
CONF
ready "$AREA"

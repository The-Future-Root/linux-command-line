#!/usr/bin/env bash
# Lesson 4 lab: build reports from a web server's access log.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 04-pipes-and-redirection) || exit 1
mkdir -p "$AREA/logs" "$AREA/reports"
cp "$LAB_DIR/../../data/access.log" "$AREA/logs/access.log"
ready "$AREA"

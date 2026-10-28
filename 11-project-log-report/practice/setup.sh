#!/usr/bin/env bash
# Lesson 11 project: write log-report.sh, which summarises a web server log.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 11-project-log-report) || exit 1
cd "$AREA"
mkdir logs
cp "$LAB_DIR/../../data/access.log" logs/saturday.log
cp "$LAB_DIR/../../data/access-2.log" logs/sunday.log
printf '#!/usr/bin/env bash\n# log-report.sh LOGFILE [N]: summarise a web server access log, with the top N pages (default 3)\n' > log-report.sh
ready "$AREA"

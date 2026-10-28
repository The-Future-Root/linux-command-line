#!/usr/bin/env bash
# Lesson 3 lab: a copy of a small web server's files and logs to investigate.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 03-viewing-and-searching) || exit 1
S="$AREA/server"
mkdir -p "$S/logs" "$S/site/menu" "$S/site/about" "$S/site/static"
cp "$LAB_DIR/../../data/access.log" "$S/logs/access.log"
cat > "$S/logs/error.log" <<'LOG'
2026-03-14 08:12:40 [warn] slow response from payments service (2.8s)
2026-03-14 09:03:11 [error] /order/confirm: payments service TIMEOUT after 5s
2026-03-14 09:47:52 [info] cache cleared
2026-03-14 10:15:09 [error] /order/confirm: payments service timeout after 5s
2026-03-14 10:15:10 [warn] retrying payment for order 1182
2026-03-14 10:58:31 [error] /order/confirm: database connection refused
2026-03-14 11:20:02 [warn] disk 81% full on /var
2026-03-14 11:41:09 [warn] 25 failed requests to /wp-login.php from 192.0.2.44
LOG
cd "$S/site"
printf '<h1>Rosie'"'"'s Bakery</h1>\n<p>Fresh bread every morning.</p>\n' > index.html
printf '<h1>Menu</h1>\n<ul><li>Sourdough loaf</li><li>Croissant</li><li>Cinnamon roll</li></ul>\n' > menu/index.html
printf '<h1>This week</h1>\n<p>New: a gluten-free seeded loaf, Fridays only.</p>\n' > menu/specials.html
printf '<h1>About us</h1>\n<p>Baking since 2009.</p>\n' > about/index.html
printf '<h1>Jobs</h1>\n<p>We are hiring a weekend baker.</p>\n' > about/jobs.html
printf 'body { font-family: sans-serif; }\n' > static/style.css
printf 'User-agent: *\nDisallow: /admin\n' > robots.txt
cd "$AREA"
answers_file 7
ready "$AREA"

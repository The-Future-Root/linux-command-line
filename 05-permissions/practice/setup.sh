#!/usr/bin/env bash
# Lesson 5 lab: a small website project whose permissions need fixing.
source "$(dirname "$0")/../../scripts/lab.sh"
set -e
AREA=$(new_area 05-permissions) || exit 1
P="$AREA/website"
mkdir -p "$P/public" "$P/secrets"
cd "$P"
printf '<h1>Rosie'"'"'s Bakery</h1>\n' > public/index.html
printf 'body { font-family: sans-serif; }\n' > public/style.css
printf 'PAYMENT_API_KEY=sk_test_not_a_real_key_123\n' > secrets/api-key.txt
printf 'Item,Price\nSourdough loaf,6.00\nCroissant,3.00\n' > prices-final.csv
cat > deploy.sh <<'SH'
#!/usr/bin/env bash
# Pretend to publish the website: copy public/ into a folder called live/.
mkdir -p live
cp public/* live/
echo "Deployed $(ls live | wc -l | tr -d ' ') files to live/"
SH
chmod 666 public/index.html public/style.css secrets/api-key.txt prices-final.csv
chmod 644 deploy.sh
chmod 777 secrets
ready "$P"

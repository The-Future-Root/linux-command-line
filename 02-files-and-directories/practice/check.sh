#!/usr/bin/env bash
# shellcheck disable=SC2016  # conditions are single-quoted strings that expect evaluates later
# Lesson 2 check
source "$(dirname "$0")/../../scripts/lab.sh"
AREA=$(area 02-files-and-directories); require_area "$AREA"
cd "$AREA/downloads" 2>/dev/null || { echo "The downloads folder is missing. Run setup.sh to start again."; exit 1; }
echo "Checking $PWD"
expect "photos/ holds the 4 .jpg files" '[ -d photos ] && [ "$(ls photos/*.jpg 2>/dev/null | wc -l)" -eq 4 ]' "mkdir photos, then mv *.jpg photos/"
expect "no .jpg files are left in downloads" '! ls ./*.jpg >/dev/null 2>&1' "Move every .jpg into photos/."
expect "documents/invoices/ holds both invoices" '[ -f documents/invoices/invoice-march.pdf ] && [ -f documents/invoices/invoice-april.pdf ]' "mkdir -p documents/invoices makes both folders at once. Then mv invoice-*.pdf documents/invoices/"
expect "documents/notes/ holds todo.txt and notes.txt" '[ -f documents/notes/todo.txt ] && [ -f documents/notes/notes.txt ] && [ ! -e todo.txt ] && [ ! -e notes.txt ]' "Make documents/notes and move the two .txt notes into it."
expect "budget 2026.csv is renamed budget-2026.csv" '[ -f budget-2026.csv ] && [ ! -e "budget 2026.csv" ]' "Put quotes round a name with a space: mv \"budget 2026.csv\" budget-2026.csv"
expect "the duplicate report is deleted, the original kept" '[ ! -e "report (copy).txt" ] && [ -f report.txt ]' "rm \"report (copy).txt\", with the quotes."
expect "the empty old-stuff folder is gone" '[ ! -e old-stuff ]' "rmdir old-stuff removes an empty folder."
expect "documents-backup is a full copy of documents" '[ -f documents-backup/invoices/invoice-march.pdf ] && [ -f documents-backup/notes/todo.txt ] && [ -f documents/notes/todo.txt ]' "cp -r documents documents-backup copies a folder and everything inside it."
expect "the hidden .settings file is still there" '[ -f .settings ]' "Run setup.sh to start again if it was deleted."
finish

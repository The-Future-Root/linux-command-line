# Solution: 2. Files and directories

Run these inside `~/practice/linux-command-line/02-files-and-directories/downloads`.

```bash
ls -la

mkdir photos
mv *.jpg photos/

mkdir -p documents/invoices documents/notes
mv invoice-*.pdf documents/invoices/
mv todo.txt notes.txt documents/notes/

mv "budget 2026.csv" budget-2026.csv
rm "report (copy).txt"
rmdir old-stuff

cp -r documents documents-backup

ls -R
```

`ls -la` at the start shows the hidden `.settings` file, which plain `ls` doesn't.

`*.jpg` is expanded by the shell into the four photo names before `mv` runs, so `mv` gets `beach-1.jpg beach-2.jpg beach-3.jpg birthday-cake.jpg photos/`. When `mv` gets several files, the last argument must be a folder.

`mkdir -p` makes `documents` as well as the folders inside it, in one go, and doesn't complain if they already exist.

The quotes around `"budget 2026.csv"` and `"report (copy).txt"` keep each name together. Without them, the shell would split the name at the space into two separate arguments. You could also escape the space with a backslash: `budget\ 2026.csv`. Pressing Tab after typing `bud` fills in the escaped name for you.

`ls -R` at the end lists every folder and what's in it, so you can see the result.

# Solution: 3. Viewing and searching

Run these inside `~/practice/linux-command-line/03-viewing-and-searching`.

```bash
wc -l server/logs/access.log
grep -c '" 404 ' server/logs/access.log
head -n 1 server/logs/access.log
tail -n 1 server/logs/access.log
grep -rl gluten-free server/site
find server/site -name "*.html" | wc -l
grep -ci timeout server/logs/error.log
```

Then write the answers into `answers.txt`:

```bash
printf '1: 345\n2: 54\n3: 07:00:08\n4: 192.0.2.44\n5: server/site/menu/specials.html\n6: 5\n7: 2\n' > answers.txt
```

A few notes:

- Question 2: the status code comes straight after the closing quote of the request, so `'" 404 '` only matches the status, not a 404 that happens to appear in a page name or a size. Plain `grep -c 404` gives the same answer here, but it's a good habit.
- Question 5: `-r` searches every file under a folder, and `-l` prints just the names of matching files instead of the matching lines.
- Question 7: one line says `TIMEOUT` and one says `timeout`. Without `-i`, you'd only count one.

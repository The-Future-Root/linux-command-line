# Solution: 4. Pipes and redirection

Run these inside `~/practice/linux-command-line/04-pipes-and-redirection`.

```bash
grep '" 404 ' logs/access.log > reports/not-found.txt

cut -d' ' -f7 logs/access.log | sort -u > reports/pages.txt

cut -d' ' -f9 logs/access.log | sort | uniq -c | sort -rn > reports/status-counts.txt

cut -d' ' -f1 logs/access.log | sort | uniq -c | sort -rn | head -n 5 > reports/top-addresses.txt

wc -l < logs/access.log > reports/summary.txt
grep -c '" 404 ' logs/access.log >> reports/summary.txt

ls logs no-such-folder > reports/listing.txt 2> reports/errors.txt || true

cat reports/status-counts.txt reports/top-addresses.txt reports/summary.txt
```

(`|| true` is only there so this solution can run as one script: `ls` reports a failure because one of its folders doesn't exist, which is exactly what this step needs. Typed by hand, leave it out.)

The finished reports look like this:

```
$ cat reports/status-counts.txt
    288 200
     54 404
      3 500
$ cat reports/top-addresses.txt
     41 198.51.100.4
     39 198.51.100.23
     37 192.0.2.44
     33 203.0.113.5
     32 203.0.113.64
$ cat reports/summary.txt
345
54
```

`192.0.2.44` is the bot that tried `/wp-login.php` 25 times. On a Mac, `wc` and `uniq -c` pad numbers with a few more spaces; the check ignores that.

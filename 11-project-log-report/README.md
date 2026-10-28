# 11. Project: a log report

Time to put the course together. You'll write `log-report.sh`, a script that reads a web server's access log and prints a summary: how busy the site was, how many requests failed, when the visitors came, and which pages they wanted. It's the kind of small tool people really write, and run every morning, or every hour from a scheduler.

```
$ ./log-report.sh logs/saturday.log
Report for logs/saturday.log
Requests: 345
Visitors: 14
Not found (404): 54
Server errors (5xx): 3
Requests by hour:
     79 07
     77 08
     79 09
     66 10
     44 11
Top 3 pages:
     66 /
     56 /static/logo.png
     50 /menu
```

That's real output from the finished script, on a Saturday morning's log from the bakery's website.

## What it uses

| From | You'll use |
|---|---|
| Lesson 3 | `wc -l`, `grep -c` |
| Lesson 4 | `cut`, `sort`, `uniq -c`, `head`, pipes, `$( )` |
| Lesson 6 | exit codes |
| Lesson 7 | variables and quoting |
| Lesson 8 | arguments, `if`, functions, `>&2`, `exit`, `set -euo pipefail` |

Each log line looks like this (lesson 4 explains the fields):

```
203.0.113.5 - - [14/Mar/2026:07:00:08 +0000] "GET /static/logo.png HTTP/1.1" 200 18422 "-" "Mozilla/5.0 ..."
```

## The specification

Run the setup script, from the course folder:

```bash
bash 11-project-log-report/practice/setup.sh
```

The practice folder has `logs/saturday.log` and `logs/sunday.log`, and a `log-report.sh` with just a shebang and a comment. Finish the script so that `./log-report.sh LOGFILE [N]` prints exactly these lines, in this order:

| Line | How to work it out |
|---|---|
| `Report for LOGFILE` | the name it was given |
| `Requests: ...` | the number of lines |
| `Visitors: ...` | the number of **different** addresses (field 1) |
| `Not found (404): ...` | requests with status `404` (field 9) |
| `Server errors (5xx): ...` | requests with any status starting with `5` |
| `Requests by hour:` then one line per hour | the count for each hour, in the format `uniq -c` gives, earliest hour first. The hour is the second field if you split the line at `:`. |
| `Top N pages:` then N lines | the N most requested pages (field 7) with their counts, busiest first. `N` is the second argument, or 3 if there isn't one. |

And when something's wrong:

- With no arguments: print `Usage: ./log-report.sh LOGFILE [N]` to standard error, and exit with 1.
- If the file doesn't exist: print `No such file: LOGFILE` to standard error, and exit with 2.

Make it executable, then try it:

```bash
./log-report.sh logs/saturday.log
./log-report.sh logs/sunday.log 5
./log-report.sh; echo $?
./log-report.sh logs/monday.log; echo $?
```

Then run `check.sh`, as `setup.sh` showed you. It runs your script on both logs, with and without `N`, and with bad input, and compares the results. It ignores differences in spacing, because `uniq -c` and `wc` pad numbers differently on Linux and macOS.

## Building it

Don't write it all at once. A good order:

1. The argument checks and `exit`s. Test them first; they're quick.
2. The `Report for` and `Requests` lines.
3. One more line at a time, running the script after each one.

Work each pipeline out at the prompt first, on the real log, then paste it into the script with `"$log"` in place of the file name.

<details>
<summary>Hints</summary>

- `log="$1"` and `top="${2:-3}"`. `${2:-3}` means "the second argument, or 3 if there isn't one".
- Visitors: `cut -d' ' -f1 "$log" | sort -u | wc -l`.
- Statuses: `cut -d' ' -f9 "$log" | grep -c '^404$'`, and `'^5'` for any 5xx. If you use `set -e`, a `grep -c` that finds nothing stops the script; add `|| true`.
- Hours: `cut -d: -f2 "$log" | sort | uniq -c`.
- Top pages: the "count and rank" pipeline from lesson 4, ending `| head -n "$top"`.
- On a Mac, `wc` puts spaces before its numbers: `| tr -d ' '` removes them.

</details>

The full answer is in [solutions/11-project-log-report.md](../solutions/11-project-log-report.md).

## Take it further

- Add `Busiest hour: 07 (79 requests)`. How should it decide between two hours with the same count?
- Show the 5 addresses with the most `404`s. That's how you'd spot the bot hammering `/wp-login.php`.
- Accept several log files, `./log-report.sh logs/*.log`, and print a report for each, with a `for` loop over `"$@"`.
- Run it automatically every morning with `cron`: `crontab -e`, then a line like `0 7 * * * /home/alex/bin/log-report.sh /var/log/nginx/access.log > /home/alex/report.txt`.

## What you've learned

That's the whole course. You can move around a Linux system, manage files, read and search logs, combine tools with pipes, control permissions and processes, configure your environment, edit files on a server, install software, and write scripts that automate the lot. These skills transfer directly to servers, cloud machines, Docker containers, and the Mac terminal. Good next steps are `ssh` (logging in to another computer), `cron` and `systemd` (running things on a schedule, or as a service), and `awk` and `sed`, two small languages for transforming text that pick up where `cut` and `grep` leave off.

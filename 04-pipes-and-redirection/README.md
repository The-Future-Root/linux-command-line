# 4. Pipes and redirection

Each command-line tool does one small job. The real power comes from connecting them: the output of one becomes the input of the next. In a single line you can answer questions like "which five addresses sent the most requests to our website today?". No spreadsheet, no program, just tools you already have. This lesson shows how.

## Three streams

Every command has three streams of data connected to it:

| Stream | Number | Normally goes to |
|---|---|---|
| **standard input** (stdin) | 0 | the keyboard |
| **standard output** (stdout) | 1 | the terminal |
| **standard error** (stderr) | 2 | the terminal |

Normal results go to standard output, and error messages go to standard error. Both show up in the terminal, mixed together, which is why you don't usually notice there are two. But you can send each one somewhere different.

## Redirecting output to a file: > and >>

`>` sends a command's output into a file instead of the terminal:

```
$ echo 'Sourdough loaf' > menu.txt
$ echo 'Croissant' >> menu.txt
$ cat menu.txt
Sourdough loaf
Croissant
$ echo 'Bagel' > menu.txt
$ cat menu.txt
Bagel
```

- `>` creates the file, or **replaces everything in it** if it exists.
- `>>` adds to the end of the file.

That difference matters: one `>` where you meant `>>` wipes the file. There's no warning.

## Redirecting errors: 2>

```
$ ls logs nope
ls: cannot access 'nope': No such file or directory
logs:
access.log
$ ls logs nope 2> errors.txt
logs:
access.log
$ cat errors.txt
ls: cannot access 'nope': No such file or directory
```

`2>` redirects stream 2, the errors, leaving the normal output on the screen. Some useful forms:

| You write | Means |
|---|---|
| `command > out.txt 2> err.txt` | results in one file, errors in another |
| `command 2> /dev/null` | throw the errors away. `/dev/null` is a special file that discards anything written to it. |
| `command > all.txt 2>&1` | both into one file. `2>&1` means "send errors wherever output is going". |

## Input from a file: <

`<` feeds a file into a command's standard input. Most commands can open files themselves, so you need it less often, but it changes the output of some:

```
$ wc -l logs/access.log
345 logs/access.log
$ wc -l < logs/access.log
345
```

With `<`, `wc` reads from its input and doesn't know the file's name, so it prints just the number, which is handy in scripts.

## Pipes: |

A **pipe**, `|`, connects the standard output of one command to the standard input of the next:

```
$ cut -d' ' -f9 logs/access.log | sort | uniq -c
    288 200
     54 404
      3 500
```

```mermaid
%%{init: {"theme": "base", "themeVariables": {"fontSize": "18px", "lineColor": "#64748b", "edgeLabelBackground": "#f8fafc", "primaryTextColor": "#111827", "textColor": "#111827"}, "flowchart": {"nodeSpacing": 20, "rankSpacing": 34, "padding": 12}}}%%
flowchart LR
    F["access.log<br/>345 lines"]:::blue --> C["cut -f9<br/>just the<br/>status codes"]:::amber -- "pipe" --> S["sort<br/>same codes<br/>together"]:::amber -- "pipe" --> U["uniq -c<br/>count each<br/>group"]:::amber --> O["288 200<br/>54 404<br/>3 500"]:::green
    classDef blue fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#0f172a
    classDef amber fill:#fef3c7,stroke:#d97706,stroke-width:2px,color:#0f172a
    classDef green fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#0f172a
    linkStyle default stroke-width:2px
```

Each command does one step, and passes its result on. The data flows through without being saved anywhere in between. Only the last command's output reaches the screen. (Errors still go to the screen from every step, because a pipe only carries standard output.)

## Tools that work well in pipes

Each line of the access log looks like this:

```
203.0.113.5 - - [14/Mar/2026:07:00:08 +0000] "GET /static/logo.png HTTP/1.1" 200 18422 "-" "Mozilla/5.0 ..."
```

Split at the spaces, field 1 is the visitor's address, field 7 is the page, and field 9 is the status code.

| Tool | Does | Example |
|---|---|---|
| `cut -d' ' -f1,7` | keeps some fields: `-d` sets the separator, `-f` picks the fields | `203.0.113.5 /static/logo.png` |
| `sort` | sorts lines A to Z. `-n` sorts as numbers, `-r` reverses, `-u` drops repeats. | |
| `uniq` | removes repeated lines that are **next to each other**. `-c` counts them. | |
| `head`, `tail` | keep the first or last lines | |
| `grep` | keeps matching lines (lesson 3) | |
| `wc -l` | counts lines | |
| `tr 'a-z' 'A-Z'` | replaces characters, here making text upper case | `ROSIE BAKERY` |
| `tee file` | saves a copy to a file **and** passes it on down the pipe | |

### Why sort comes before uniq

`uniq` only compares each line with the one before it. Without `sort`, you get a count for each run of identical lines, which isn't what you want:

```
$ cut -d' ' -f9 logs/access.log | uniq -c | head -n 4
      2 200
      1 404
      8 200
      1 500
```

So the pattern is almost always `sort | uniq -c`, and then `sort -rn` to put the biggest counts first. Here are the three most requested pages:

```
$ cut -d' ' -f7 logs/access.log | sort | uniq -c | sort -rn | head -n 3
     66 /
     56 /static/logo.png
     50 /menu
```

That "count and rank" pipeline is worth memorising. Swap the field number and you can rank anything.

### Building a pipeline step by step

Don't try to write a long pipeline in one go. Start with the first command and look at its output (add `| head` if it's long). Then add the next step, run it again, and look. Press the up arrow to bring back the line and add to it. You always know what each step is doing.

## Putting output inside a command: $( )

`$(command)` runs a command and drops its output into another command, as if you'd typed it:

```
$ echo "There were $(wc -l < logs/access.log) requests"
There were 345 requests
```

This is called **command substitution**, and it's used a lot in scripts (lesson 8).

## Practice: reports from a web log

Run the setup script, from the course folder:

```bash
bash 04-pipes-and-redirection/practice/setup.sh
```

The practice folder has `logs/access.log` (a day of requests to the bakery's website) and an empty `reports` folder. Make each report with one command line, from the practice folder:

1. `reports/not-found.txt`: every line from the log with a `404` status.
2. `reports/pages.txt`: every page that was requested (field 7), each listed once, A to Z.
3. `reports/status-counts.txt`: how many times each status code appears, most common first, in the format `uniq -c` gives.
4. `reports/top-addresses.txt`: the 5 addresses (field 1) that made the most requests, with their counts, busiest first.
5. `reports/summary.txt`: two lines. The first is the total number of requests, just the number. The second is the number of `404` responses, added with a second command.
6. Run `ls logs no-such-folder`, with the normal output going to `reports/listing.txt` and the error going to `reports/errors.txt`.

Then run `check.sh`, as `setup.sh` showed you.

<details>
<summary>Hints</summary>

- 1: `grep '" 404 ' logs/access.log > reports/not-found.txt`.
- 2: `cut -d' ' -f7 logs/access.log | sort -u`, then redirect it.
- 3 and 4: the "count and rank" pipeline above, with field 9 or field 1. For 4, end it with `head -n 5`.
- 5: `wc -l < logs/access.log > reports/summary.txt`, then the `grep -c` from lesson 3 with `>>`.
- 6: `> reports/listing.txt 2> reports/errors.txt`.

</details>

The answers are in [solutions/04-pipes-and-redirection.md](../solutions/04-pipes-and-redirection.md).

## Recap

- Commands have standard input, standard output and standard error.
- `>` writes output to a file (replacing it), `>>` adds to it, `2>` redirects errors, `<` reads input from a file.
- `|` pipes one command's output into the next. Build pipelines one step at a time.
- `cut`, `sort`, `uniq -c`, `head` and `wc` together can count and rank almost anything.
- `$(command)` puts a command's output inside another command.

Next: [5. Permissions](../05-permissions/)

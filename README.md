# Linux Command Line

Most of the world's servers run Linux, and nearly all of them are managed by typing commands. So are cloud machines, Docker containers, Raspberry Pis, and much of what developers do every day, on Linux and on Macs. This course teaches you to use the command line with confidence: from your first `ls`, through pipes and permissions, to writing your own scripts.

Every lesson ends with a hands-on lab in a practice folder of its own, with a script that checks your work.

## Who this is for

Complete beginners. You don't need to know any programming. If you've only ever used a computer with a mouse, this is the place to start.

## What you need

A terminal running **Bash** or **Zsh**:

- **Linux**: you already have one: open the Terminal app.
- **macOS**: open Terminal (in Applications, then Utilities). Its shell is Zsh, which works for everything here. A few commands behave slightly differently on a Mac; the lessons point them out.
- **Windows**: install **WSL** (Windows Subsystem for Linux), which gives you a real Ubuntu Linux. Open PowerShell as administrator, run `wsl --install`, restart, then open "Ubuntu" from the Start menu. Download this course inside Ubuntu, as below.

Then get a copy of this course. With Git:

```bash
git clone https://github.com/The-Future-Root/linux-command-line.git
cd linux-command-line
```

Or download the ZIP from GitHub (the green "Code" button), and unzip it.

## Lessons

| # | Lesson | You'll learn | Practice |
|---|---|---|---|
| 1 | [The terminal](./01-the-terminal/) | The shell, commands, options and getting help | Answer questions by running commands |
| 2 | [Files and directories](./02-files-and-directories/) | Paths, `cd`, `ls`, `mkdir`, `cp`, `mv`, `rm`, wildcards | Tidy up a messy downloads folder |
| 3 | [Viewing and searching](./03-viewing-and-searching/) | `cat`, `less`, `head`, `tail`, `grep`, `find` | Investigate a web server's logs |
| 4 | [Pipes and redirection](./04-pipes-and-redirection/) | `>`, `>>`, `2>`, `\|`, `sort`, `uniq`, `cut` | Build reports from a web log |
| 5 | [Permissions](./05-permissions/) | Owners, `rwx`, `chmod`, `sudo` | Fix a project's permissions |
| 6 | [Processes](./06-processes/) | `ps`, `kill`, signals, jobs, exit codes | Stop a runaway process |
| 7 | [Environment variables](./07-environment-variables/) | Variables, `export`, `PATH`, aliases, `~/.bashrc` | Set up a tool's environment |
| 8 | [Shell scripting](./08-shell-scripting/) | Scripts, arguments, `if`, loops, functions | Write a backup script |
| 9 | [Text editors](./09-text-editors/) | nano, and how to survive vim | Edit a settings file |
| 10 | [Package managers](./10-package-managers/) | `apt`, `dnf`, Homebrew, and keeping a system updated | (reading only) |
| 11 | [Project: a log report](./11-project-log-report/) | Putting it all together | A script that summarises a web log |

## How the practice works

Each lesson's `practice` folder has two scripts. Run them from the course folder:

```bash
bash 02-files-and-directories/practice/setup.sh
```

- `setup.sh` makes a practice folder under `~/practice/linux-command-line/`, with the files the lesson needs, and prints where to go and how to check.
- `check.sh` checks your work, with a PASS or FAIL line for each part and a hint for each failure.

Nothing you do in a practice folder can affect the course or the rest of your files. If you get in a muddle, run `setup.sh` again to start over. The scripts only ever delete practice folders they made themselves.

Hints are at the end of each lesson, and worked answers are in [solutions/](./solutions/).

## About the examples

The running example is a small bakery's website: its files, its settings and its server logs. Example addresses come from the ranges set aside for documentation (`192.0.2.x`, `198.51.100.x` and `203.0.113.x`). Command outputs are real, from Bash on Debian Linux, except that the username has been changed to `alex`.

## About the diagrams

The colours keep the same meaning throughout: **blue** for files, folders and commands, **amber** for the step happening now, **green** for results, and **purple** for system parts and labels.

## License

The code in this repository is released under the [MIT License](./LICENSE). The lesson text and diagrams are released under [Creative Commons Attribution 4.0](./LICENSE-CONTENT) (CC BY 4.0): you may share and adapt them, including for your own teaching, as long as you credit The Future Root.

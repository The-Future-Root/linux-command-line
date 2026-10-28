# Solution: 1. The terminal

Run these inside `~/practice/linux-command-line/01-the-terminal`.

```bash
whoami
pwd
wc -l welcome.txt
uname
ls --help | grep -i human
```

Then write what each one printed into `answers.txt`, after the question number. For example, if your username is `alex`, the practice folder is under `/home/alex`, and you're on Linux, the file ends up like this:

```
1: alex
2: /home/alex/practice/linux-command-line/01-the-terminal
3: 7
4: Linux
5: -h
```

`wc -l welcome.txt` prints `7 welcome.txt`: the number of lines, then the file name. On a Mac, `uname` prints `Darwin`, the name of the macOS kernel, and `ls --help` doesn't exist, so use `man ls` and search for "human" by typing `/human` and pressing Enter.

You can also fill in the file without an editor, which lesson 4 explains:

```bash
printf '1: %s\n2: %s\n3: 7\n4: %s\n5: -h\n' "$(whoami)" "$(pwd)" "$(uname)" > answers.txt
```

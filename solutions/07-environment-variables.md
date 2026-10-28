# Solution: 7. Environment variables

Run these inside `~/practice/linux-command-line/07-environment-variables`.

```bash
cat >> env.sh <<'END'
export BAKERY_CITY=Leeds
export PATH="$PATH:$HOME/practice/linux-command-line/07-environment-variables/bin"
alias ll='ls -l'
END

source env.sh
bakery-hours
which bakery-hours

printf '1: %s\n2: %s\n3: %s\n' "$HOME" "$SHELL" "$(which ls)" > answers.txt
cat answers.txt
```

`cat >> env.sh <<'END'` adds the lines between it and `END` to the end of `env.sh` (this is called a "here document"). You can just as well open `env.sh` in an editor and type the three lines.

After `source env.sh`, running `bakery-hours` prints `Open 7am to 3pm in Leeds`. It works by name because its folder is now on `PATH`, and it knows the city because `BAKERY_CITY` was exported.

`$HOME` in the `PATH` line is expanded when the line runs, so the folder works whoever you are. Single quotes round the alias's value stop the shell from doing anything with it until the alias is used.

To have these settings in every new terminal, you'd add the same lines (or `source` this file) at the end of `~/.bashrc`, or `~/.zshrc` on a Mac. The lab doesn't do that, so your real settings stay as they were.

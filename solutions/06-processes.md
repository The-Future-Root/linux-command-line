# Solution: 6. Processes

Run these inside `~/practice/linux-command-line/06-processes`.

```bash
ps aux | grep bakery-backup
pid=$(pgrep -f 'bash ./bakery-backup.sh')
echo "$pid"
tail -n 3 backup.log
kill "$pid"
sleep 1
ps aux | grep bakery-backup || true

grep zzz notes.txt || echo "exit code: $?"
ls /no-such-folder || echo "exit code: $?"
kill -l | head -n 2

printf '1: %s\n2: 1\n3: 2\n4: 9\n' "$pid" > answers.txt
```

(`|| true` and `|| echo` are there so this runs as one script even though those commands "fail". Typed by hand, run `grep zzz notes.txt`, then `echo $?` on its own line.)

`ps aux | grep bakery-backup` shows two lines: the backup script, and the `grep` itself, because `grep bakery-backup` is also a running command that contains those words. The PID is the number in the second column of the backup's line. `pgrep -f 'bash ./bakery-backup.sh'` prints just the PID, which is handier in scripts: `-f` matches against the whole command line.

After `kill`, the second `ps aux | grep` shows only the `grep` line, and `backup.log` stops growing.

On Linux, `ls` gives exit code `2` for a missing folder ("serious trouble"); on macOS it gives `1`. The check accepts whichever your system uses.

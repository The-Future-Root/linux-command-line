# Solution: 5. Permissions

Run these inside `~/practice/linux-command-line/05-permissions/website`.

```bash
ls -l
ls -ld secrets

chmod 755 deploy.sh
./deploy.sh

chmod 644 public/index.html public/style.css
chmod 700 secrets
chmod 600 secrets/api-key.txt
chmod 444 prices-final.csv

ls -l . public secrets
```

Before the `chmod`, running `./deploy.sh` fails with `Permission denied`, because the file isn't executable. Afterwards it prints `Deployed 2 files to live/`.

The order of `chmod 700 secrets` and `chmod 600 secrets/api-key.txt` doesn't matter, because you own the folder: even with 700 you can still get into it. If you'd made it 600 by mistake (no `x`), you wouldn't be able to reach the file inside, and you'd get `Permission denied`. Directories need `x` to be entered.

The symbolic way gives the same results: `chmod +x deploy.sh`, `chmod go-w public/*`, `chmod go-rwx secrets`, and `chmod a-w prices-final.csv` would do it too, starting from the permissions `setup.sh` created.

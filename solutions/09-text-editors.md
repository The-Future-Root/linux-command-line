# Solution: 9. Text editors

The idea of this lab is to make the changes by hand in an editor. With nano, inside `~/practice/linux-command-line/09-text-editors`:

1. `nano bakery.conf`
2. Move down to `open=08:00` with the arrow keys, and change `08` to `07`.
3. Move to the `debug=true` line and press **Ctrl+K** to cut it.
4. Move to the end of the last line (`max_order=20`), press **Enter**, and type `city=Leeds`.
5. Press **Ctrl+O** then **Enter** to save, and **Ctrl+X** to quit.
6. `nano notes.txt`, type three lines, pressing Enter after each one, then Ctrl+O, Enter, Ctrl+X.

With vim: `vim bakery.conf`, then `/08` and Enter to jump to the time, `i` to start typing, fix it, **Esc**; go to the debug line and type `dd`; type `G` to go to the last line and `o` to open a new line below it, type `city=Leeds`, **Esc**, then `:wq` and Enter.

The same changes can be made without an editor, which is how scripts change config files:

```bash
sed -i.bak -e 's/^open=08:00$/open=07:00/' -e '/^debug=/d' bakery.conf
echo "city=Leeds" >> bakery.conf
rm bakery.conf.bak
printf 'Order more flour\nFix the sign\nCall the plumber\n' > notes.txt
cat bakery.conf
```

`sed -i` edits a file in place: `s/old/new/` replaces text, and `/pattern/d` deletes matching lines. Writing `-i.bak` keeps a backup called `bakery.conf.bak`, and also makes the same command work on macOS, whose `sed` needs something after `-i`.

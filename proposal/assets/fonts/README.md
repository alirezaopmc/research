# Fonts (optional, local only)

Copy Persian font files here for portable builds without a system install:

```bash
cp ~/Library/Fonts/XB\ Niloofar.ttf assets/fonts/
cp ~/Library/Fonts/XB\ NiloofarBd.ttf assets/fonts/   # optional bold
```

When `assets/fonts/XB Niloofar.ttf` exists, `make proposal` passes `--font-path assets/fonts` so Typst loads the bundled variants (regular and bold).

Otherwise Typst falls back to the system font family `XB Niloofar`.

Font files are gitignored; do not commit unless licensing allows.

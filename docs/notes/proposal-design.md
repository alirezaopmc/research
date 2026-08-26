# Proposal design conventions

## Principles

- **Minimal** — white canvas, blue strokes only, no tinted fills
- **Cover** — matches official UT form (Behnam): double border, dual logos, structure
- **Body** — same section order; modern institutional layout (not a scanned Word form)
- **Direction** — Persian RTL; English LTR (footnotes, bibliography, Latin digits)

### Cover vs body

| Layer | Tone | Chrome |
|-------|------|--------|
| Cover | Official UT form | Double border, full grid where the template requires it |
| Body §2–§3 | Clean registry / field sheet | Horizontal rules only; no vertical grid |
| Body §4+ | Narrative blocks | Double-border frames on subsection content only |

The body should read like a contemporary university PDF (grant application, registry export)—not an Excel “all borders” table.

## Gitignore

`.agents/` holds installed skills (~70k lines). Never commit.

## Tables

Shared primitive: `lib/components/shared/data-table.typ` (`form-data-table`).

Target API:

```typst
form-data-table(..., style: "registry")  // §2 supervisors
form-data-table(..., style: "fields")    // §3 student info (2-col field pairs)
form-data-table(..., style: "grid")      // timeline month grid
```

Implemented in `lib/components/shared/data-table.typ`. Also exports `registry-header-cell`, `signature-placeholder-box`, and `form-fields-sheet`.

### Style: `registry` (§2 supervisors)

Horizontal rules only—no vertical cell borders.

```
Section title
────────────────────────────────────────
  header row                    ← bold, blue bottom rule (~1pt)
────────────────────────────────────────
  data row                      ← hairline divider (~0.35pt) or spacing
────────────────────────────────────────
```

| Rule | Value |
|------|-------|
| Row height | `auto` — never fixed |
| Header | Bold label weight; single blue underline |
| Text columns (role, name, workplace) | `right + top` |
| Short columns (rank, share, signature) | `center + horizon` |
| Signature column | Empty cell; optional dashed inner box for “fill by hand” |
| Column balance | Widen role/workplace; narrow share/signature |
| Inset | `(x: 6pt, y: 10–12pt)` when wrapped |

### Style: `fields` (§3 student info)

Replace the 4-column key-value grid with a **2×2 field sheet**—no outer cell boxing.

Each row: two label/value pairs side by side, separated by one horizontal rule between rows.

```
  نام و نام خانوادگی          تلفن ثابت/همراه
  علیرضا جعفرتاش              ۰۹۳۸…
────────────────────────────────────────
  مقطع و نوع پذیرش             آدرس ایمیل
  کارشناسی ارشد…               jtash@ut.ac.ir
```

| Rule | Value |
|------|-------|
| Labels | Bold (`text-base-label`); `right + top` |
| Persian values | Regular body; `right + top` |
| LTR values (phone, email) | `ltr-value()`; `left + top` |
| Value column width | Wider than label (`~1.6fr` vs `~1fr`) |
| Long strings | Wrap at natural width; row grows vertically |

### Style: `grid` (timeline only)

Full grid is allowed only where cells are short and uniform (month checkboxes). All cells stay `center + horizon`.

### Typography hierarchy (tables)

Hierarchy through weight and ink—not extra borders.

| Element | Treatment |
|---------|-----------|
| Section heading (`۲.`, `۳.`) | `text-base-heading` — unchanged |
| Column / field labels | Bold, 12pt; headers may use blue ink |
| Values | Regular weight, 12pt |
| Empty cells | Truly empty; no placeholder dashes |

Do not shrink body type below 11pt to avoid wraps.

### Alignment summary

| Content | Alignment |
|---------|-----------|
| Persian prose | `right + top` |
| LTR IDs (phone, email, dates) | `left + top` via `ltr-value()` |
| Short numeric / rank / share | `center + horizon` |
| Headers | `center + horizon` (registry) or `right + top` (fields) |

### Anti-patterns

| Avoid | Why |
|-------|-----|
| Full vertical + horizontal grid on §2–§3 | Reads as legacy Word form |
| Fixed row heights | Forces ugly wraps |
| Global `center + horizon` on all cells | Hard to scan wrapped RTL text |
| Ellipsis / truncation | Unacceptable on admin forms |
| Zebra stripes, gray fills, cards, shadows | Conflicts with minimal palette |
| Smaller font to fit one line | Hurts print readability |

## Section map

| § | Component | Table style |
|---|-----------|-------------|
| ۱ Summary | `body/summary.typ` | Prose — no table |
| ۲ Supervisors | `body/supervisors-table.typ` | `registry` |
| ۳ Student | `body/student-info.typ` | `fields` |
| ۴-۱–۴-۳ | `body/topic.typ`, `methodology.typ`, `background.typ` | Double-border frame on content |
| Timeline | `body/timeline.typ` | `grid` |
| References | `body/bibliography.typ` | Prose list |

## Footnotes

| Type | YAML key | Direction |
|------|----------|-----------|
| English gloss | `en:` | LTR footnote |
| Persian note | `fa:` | RTL footnote |
| Inline English word | `ltr: true` | LTR inline, no footnote |

Component: `lib/components/shared/tech-footnote.typ`

## Latin values in RTL

`ltr-value()` in `shared.typ` — auto LTR for IDs, dates, emails, phones.

## Reusable components

| Component | File |
|-----------|------|
| Double border frame | `lib/design/borders.typ` |
| Form data table | `lib/components/shared/data-table.typ` |
| Cover header (logos + invocation) | `lib/components/cover/header.typ` |
| Cover footnotes | `lib/components/cover/footnotes.typ` |
| Body subsection heading | `lib/components/body/subsection-heading.typ` |

## QA (body tables)

After layout changes, rebuild and check:

1. No vertical rules on §2 or §3
2. Wrapped Persian breaks at word boundaries, not mid-phrase if avoidable
3. LTR phone/email align left inside their cells
4. Row heights differ when content differs (auto, not uniform stamp)
5. Print at 100% — 12pt body still readable

## Build

```bash
make -C proposal proposal cover
```

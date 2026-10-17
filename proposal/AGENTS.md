# Proposal (Typst)

Persian thesis proposal PDF: cover form + body. Built with [Typst](https://typst.app/).

## Layers

```
content/fa/          YAML labels + meta
lib/content.typ      load locales, {{key}} interpolation
lib/presenters/      derive UI state from meta (e.g. radio selection)
templates/           thin adapters (pass locale to components)
lib/components/      cover, body, shared, cover-form
lib/design/          tokens, typography, layout
main/fa/             compile entry points
```

**Rule:** templates only pass `locale`. Components read `locale.labels` / `locale.meta`. Selection logic lives in `presenters/`.

## Build

From `proposal/`:

| Command | Output |
|---------|--------|
| `make proposal` | `output/fa/proposal.pdf` (cover + body) |
| `make cover` | `output/fa/proposal-cover.pdf` |
| `make watch` | watch full proposal |

Requires `typst` (`brew install typst`).

## Fonts

See [assets/fonts/README.md](assets/fonts/README.md). When `assets/fonts/XB Niloofar.ttf` exists, builds pass `--font-path assets/fonts` (regular and bold variants).

## Page chrome (body pages only)

Cover page has no running header/footer. Body pages use `letter-page-shell` (`lib/design/layout.typ`; the name is legacy from the removed letter template):

- **Header:** left-aligned title (`shared/labels/common.yaml` → `page-header-title`) + horizontal rule
- **Footer:** page number + horizontal rule
- **Footnotes:** Persian-numbered markers and a numbered listing above the footer; styled via `footnote.entry`.

Edit title in `src/content/fa/shared/labels/common.yaml`. Tune spacing in `src/lib/design/tokens.typ` (`size-page-*`, `space-*-page`).

## Edit content

### Cover field

1. Add label in `src/content/fa/cover/labels/cover.yaml`
2. Add value in `src/content/fa/cover/meta/student.yaml` or `form.yaml`
3. Render in `src/lib/components/cover/` (pick the matching section file)

Cover layout modules:

| File | Section |
|------|---------|
| `logo.typ` | UT logo |
| `organization.typ` | faculty / college / university |
| `title.typ` | form title |
| `options.typ` | degree + study-mode radios |
| `form-fields.typ` | name, IDs, supervisors, date |
| `footer-fields.typ` | campus entry, reference boxes |
| `page.typ` | stacks sections (orchestrator) |
| `spacing.typ` | `cover-section` wrapper (before/after padding) |
| `header.typ` | masthead: invocation and dual logos |
| `field.typ` | label/value row |
| `panel.typ` | right-aligned form panel |
| `footnotes.typ` | administrative footnotes |

### Cover spacing

Edit `src/lib/design/cover-spacing.typ` — each block has `before` and `after`:

| Key | Component |
|-----|-----------|
| `logo` | UT logo |
| `organization` | faculty / college / university |
| `title` | form title |
| `options` | degree + study-mode radio grid (`between-rows` = gap between the two rows) |
| `form` | main form fields panel |
| `footer` | campus entry + reference boxes |

Gap between two blocks = `block1.after` + `block2.before`. Values are em units; rebuild with `make cover`.

No template mapping needed.

### Shared organization

`src/content/fa/shared/meta/organization.yaml` — `university`, `faculty` (used by cover and body).

Cover-only: `cover/meta/organization.yaml` — `college`.

### Form options

`cover/meta/form.yaml`:

- `degree`: `masters` | `phd`
- `study-mode`: `day` | `evening` (labels: روزانه | شبانه)

### Body content

Section content: `src/content/fa/body/meta/*.yaml`; labels: `src/content/fa/body/labels/body.yaml`. Entry point: `src/main/fa/proposal.typ`.

## Design tokens

Edit `src/lib/design/tokens.typ` for sizes, spacing, form width, logo height.

Typography roles: `src/lib/design/typography.typ` (`text-cover-*`, `text-base-*`, `text-letter-*`).

## Design system

See [proposal-design.md](../../docs/notes/proposal-design.md) for layout rules, table styles, and QA.

**Body table styles:** §2 → `registry`; §3 → `fields`; timeline → `grid`. Shared API in `lib/components/shared/data-table.typ`.

**Body figures:** captions and diagram labels in `content/fa/body/meta/figures.yaml` (`meta.figures`); drawing in `lib/components/body/figures/`; primitives in `lib/components/shared/figure.typ`. Rules in the design notes.

# Dorost Bilingual Typst Package Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox syntax for tracking.

**Goal:** Extract a use-case-neutral Typst package named `dorost` for English, Persian, and mixed-direction documents, with a customizable starter and an OSS-ready repository.

**Architecture:** Keep the runtime pure Typst with one public facade and small cohesive modules for document configuration and bilingual text behavior. Use Typst's built-ins for ordinary document structures; provide only explicit configuration and helpers that address a demonstrated cross-script need. Build the standalone repository at `/Users/opmc/Dev/dorost`; leave the `research` and `aputir/course-materials` consumers unchanged during extraction.

**Tech Stack:** Typst 0.15.1 minimum baseline; shell-based compile and PDF-text checks; GitHub Actions. No Rust crate, extra package dependency, or generated PDF checked into Git.

**Spec:** `docs/superpowers/specs/2026-10-11-typst-bilingual-core-design.md`

## Global Constraints

- Package and repository slug: `dorost`; intended GitHub owner: `alirezaopmc`.
- Keep institutional identity, proposal/report/course schemas, YAML loading, and consumer policy out of the package.
- Keep language, direction, font role, and numeral formatting independently configurable.
- Persian digit conversion is opt-in; do not rewrite arbitrary prose, code, URLs, or math.
- Prefer native Typst headings, paragraphs, lists, tables, links, code, and math; only add helpers for demonstrated bilingual behavior.
- Do not redistribute XB Niloofar; its redistribution terms are not established.
- Proposed file licensing: MIT for package code, MIT-0 for copied starter files, and each bundled OFL font under its own license with source/version provenance. Use `MIT AND MIT-0 AND OFL-1.1` in the package manifest and a file-to-license map.
- Build the source fixtures with explicit licensed fonts and Typst 0.15.1; keep generated PDFs and raster output out of Git.
- Keep agent guidance to `AGENTS.md` and `CONTRIBUTING.md`; do not add a custom agent skill.
- Do not change or stage existing user modifications in `/Users/opmc/Dev/research` or modify `aputir/course-materials` as part of extraction.

## Review Focus

- Persian plus Latin punctuation/brackets in one paragraph: visual order and extracted text remain readable without callers manually inserting direction marks.
- Persian Yeh, Kaf, and ZWNJ: glyph shaping and text extraction preserve the original characters.
- URLs, identifiers, code, and math inside RTL prose: retain LTR order and are not digit-converted.
- `lang` and `direction` combinations such as English RTL or Persian LTR: remain explicit and do not silently change font selection.
- Partial font-role dictionaries: retain the documented default for an omitted role, and use no maintainer-local font.

---

## Planned repository map

```text
/Users/opmc/Dev/dorost/
  typst.toml                 # package metadata and template entry point
  lib.typ                    # explicit public exports
  src/document.typ           # configurable showable document wrapper
  src/config.typ             # default values and validation
  src/text/direction.typ     # explicit LTR/RTL helpers
  src/text/digits.typ        # opt-in Persian digit conversion
  template/main.typ          # copied, editable neutral starter
  template/thumbnail.png     # Typst Universe preview
  examples/                  # English, Persian, mixed, custom configuration
  tests/                      # fixtures and compile/text assertions
  scripts/check.sh           # reproducible local verification
  assets/fonts/              # only licensed font files and provenance
  README.md CONTRIBUTING.md AGENTS.md CHANGELOG.md LICENSE*
  .github/workflows/ci.yml
```

### Task 1: Establish the standalone OSS package shell

**Files:** Create the planned repository at `/Users/opmc/Dev/dorost`; add `typst.toml`, `lib.typ`, `template/main.typ`, `template/thumbnail.png`, `README.md`, `CONTRIBUTING.md`, `AGENTS.md`, `CHANGELOG.md`, `LICENSE`, `LICENSE-MIT-0`, `.gitignore`, `.github/pull_request_template.md`, and an initial `scripts/check.sh`.

**Interfaces:**
- Produces package identity `@local/dorost:0.1.0` for local development and `@preview/dorost:0.1.0` for published examples.
- Public `lib.typ` initially exports a smoke-test stub `document(body)`; Task 2 replaces it with the documented configuration signature.

- [ ] Write `tests/fixtures/smoke.typ` with `#import "@local/dorost:0.1.0": document`, `#show: document.with()`, and one visible paragraph.
- [ ] Install the checkout in a temporary Typst local package directory and compile the fixture with Typst 0.15.1; observe the expected missing-entrypoint failure.
- [ ] Add the minimal package manifest with the `[template]` section, public stub, file licensing map, `exclude = ["/tests/", "/scripts/", "/.github/"]`, and thumbnail path. Set `compiler = "0.15.1"` and the proposed package license expression `MIT AND MIT-0 AND OFL-1.1`; document MIT for reusable source, MIT-0 for `template/`, and OFL per bundled font directory.
- [ ] Add the minimal repository guidance, contribution steps, changelog, and ignore rules for build outputs.
- [ ] Run the smoke fixture and `git diff --check`; require a successful compile and no whitespace errors.
- [ ] Commit as `chore: initialize dorost package`.

### Task 2: Implement document configuration and style defaults

**Files:** `src/config.typ`, `src/document.typ`, `lib.typ`, `tests/fixtures/document-config.typ`, `README.md`.

**Interfaces:**
- `document(body, lang: "en", direction: ltr, fonts: default-fonts, page: default-page, text: default-text, colors: default-colors)` returns document content with configurable page, text, paragraph, and list defaults.
- `default-fonts` is `(body: ("Lora", "Vazirmatn"), code: "JetBrains Mono")`; callers can override either role independently, omitted roles use defaults, and raw code is styled LTR with the code role.
- `default-page` is `(paper: "a4", margin: (x: 2cm, y: 2cm))`; the wrapper does not set title, author, running header, or document sections.
- `default-text` is `(size: 11pt, leading: 0.65em, paragraph-spacing: 1em, list-indent: 0.6em, list-spacing: 0.6em)`; `default-colors` exposes `text`, `muted`, `accent`, and `rule` colors.
- Validate `lang` as a non-empty string, `direction` as `ltr` or `rtl`, and reject unknown keys in `fonts`, `page`, `text`, and `colors`; merge omitted config keys with documented defaults.

- [ ] Add `tests/fixtures/document-config.typ` for English LTR defaults, English RTL, Persian LTR, custom paper/margins, custom body/code fonts, custom text size/spacing/color, and omitted config roles retaining defaults. Add invalid fixtures asserting clear failures for empty `lang`, unsupported `direction`, and unknown keys in `fonts`, `page`, `text`, and `colors`.
- [ ] Compile the fixture through the local package and observe the expected unresolved `document` behavior or missing override.
- [ ] Implement explicit defaults and validation in `src/config.typ`; apply only Typst `set` rules in `src/document.typ`, keeping `lang`, `direction`, and fonts independent.
- [ ] Export only `document` and named defaults from `lib.typ`; keep internal helpers private through explicit imports.
- [ ] Recompile the fixture and assert the expected page count and extracted English text.
- [ ] Commit as `feat: add configurable document wrapper`.

### Task 3: Add explicit bilingual direction and numeral helpers

**Files:** `src/text/direction.typ`, `src/text/digits.typ`, `lib.typ`, `tests/fixtures/mixed-direction.typ`, `tests/fixtures/persian-digits.typ`, `README.md`.

**Interfaces:**
- `ltr(body)` and `rtl(body)` set direction only; they do not select language or font.
- `persian-digits(value)` converts ASCII digits `0`–`9` to Persian digits in strings and integers, preserving other string content. It does not recurse into arbitrary Typst content.
- Do not export an inference-based `ltr-value` helper.

- [ ] Add `tests/fixtures/mixed-direction.typ` and `tests/fixtures/persian-digits.typ` containing Persian Yeh/Kaf, ZWNJ, `API.get(2)`, `https://example.com/a?b=2`, paired parentheses, inline math, and `persian-digits("2026-10-11")`; assert that only the explicit helper emits `۲۰۲۶-۱۰-۱۱`.
- [ ] Compile and extract PDF text; observe missing exports or incorrect output before implementation.
- [ ] Implement direction wrappers with Typst text direction only, plus the opt-in digit mapping with explicit supported input types.
- [ ] Export the documented helpers and test strings, integers, empty strings, and unchanged non-digit characters.
- [ ] Recompile fixtures; assert that Persian text and Latin identifiers/URLs are present in extracted text and no content outside explicit digit-helper calls changes.
- [ ] Commit as `feat: add bilingual text helpers`.

### Task 4: Build the generic starter and font provenance

**Files:** `template/main.typ`, `examples/english.typ`, `examples/persian.typ`, `examples/mixed-direction.typ`, `examples/custom-theme.typ`, `assets/fonts/README.md`, `assets/fonts/{vazirmatn,lora,jetbrains-mono}/OFL.txt`, `README.md`.

**Interfaces:**
- The starter is content-only and imports the versioned `@preview/dorost:0.1.0` package; users edit their title/content and optional config without changing package internals.
- Default font roles use Lora with Vazirmatn fallback for body text and JetBrains Mono for code; all remain overridable. Math uses Typst's embedded math font.

- [ ] Add a failing smoke check that runs `typst init @local/dorost:0.1.0`, compiles the generated starter using a temporary package cache that maps `@preview/dorost:0.1.0` to this checkout, and asserts that extracted text contains the starter's editable sample heading and paragraph.
- [ ] Verify upstream versions and license text for Vazirmatn 33.003, Lora 3.021 (commit `2d53b449b60e185b39f671b44fded83e0910ad30`), and JetBrains Mono 2.304 from their pinned sources; do not copy fonts from the course repo without retaining each font's license and provenance.
- [ ] Add only the required regular/bold/italic font files, license texts, and source/version records; update the manifest to include these resources.
- [ ] Implement a neutral starter and complete examples using the public API; keep institution, proposal, course, and report material out.
- [ ] Run the starter and all example compile checks with `--ignore-system-fonts` and explicit `--font-path assets/fonts`; inspect rendered Persian and mixed-direction pages locally.
- [ ] Commit as `feat: add bilingual starter and examples`.

### Task 5: Add reproducible verification and release-ready OSS docs

**Files:** `scripts/check.sh`, `tests/`, `.github/workflows/ci.yml`, `.github/ISSUE_TEMPLATE/`, `.github/pull_request_template.md`, `README.md`, `CONTRIBUTING.md`, `AGENTS.md`, `CHANGELOG.md`, `typst.toml`.

**Interfaces:**
- `./scripts/check.sh` is the single local/CI verification entry point and returns non-zero on compile, text, manifest, or template initialization failure.
- CI compiles all examples under Typst 0.15.1 with system fonts disabled; output artifacts are retained by CI only, not committed.

- [ ] Add a failing verification case for a malformed manifest, an example that does not compile, and output missing Persian or Latin fixture text.
- [ ] Run `./scripts/check.sh` and observe each failure mode before making the checks pass.
- [ ] Implement manifest checks, local package setup, compile loop, PDF text checks, and template initialization using isolated temporary directories.
- [ ] Add GitHub Actions for the minimum supported compiler and current stable Typst; do not add unrelated dependencies or a Rust build.
- [ ] Document install/import, template init, API, font fallback and overrides, build verification, version support, contribution workflow, and release process.
- [ ] Run `./scripts/check.sh`, inspect all generated example PDFs/renders for shaping/order/clipping, and run `git diff --check`.
- [ ] Commit as `ci: verify package and bilingual fixtures`.

### Deferred follow-up: consumer migrations and publication

After the standalone package passes review, prepare a separate consumer-migration plan for `research`. `aputir/course-materials` remains a read-only reference unless Alireza separately requests a change there. Keep both migrations outside this first package implementation so consumers retain their visual identities and domain-specific content. Check GitHub and Typst Universe slug availability, then prepare the public repository and first package submission as an explicitly reviewed release step.


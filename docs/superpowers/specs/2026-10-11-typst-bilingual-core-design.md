# Bilingual Typst Core — Architecture Design

**Status:** Design for review
**Date:** 2026-10-11
**Proposed repository:** `alirezaopmc/negaresh` (name not finalized)

## Goal

Extract a reusable Typst core for English, Persian, and mixed-direction documents. It must provide coherent layout and typography defaults while allowing projects to compose their own content, metadata, and visual identity. The core must not encode University of Tehran, proposal, report, course, thesis, or other document-specific assumptions.

The repository will be a Typst package with a small generic starter. Example documents demonstrate the API; they are fixtures, not supported document types.

## Design principles

- **Compose with Typst:** expose a document function usable through `#show`; use Typst's built-in content, set, show, layout, and text features before writing custom replacements.
- **Explicit configuration:** use named, documented options and validated dictionaries. Keep defaults inspectable; avoid hidden global configuration.
- **Small public surface:** `lib.typ` is the public facade. Internal modules can change without becoming compatibility promises.
- **Pure by default:** functions transform inputs into content. Keep `context`, counters, and state local to features that truly depend on document position.
- **Separate concerns:** language is not direction; direction is not font selection; digit presentation is opt-in. Do not silently mutate identifiers, code, math, or user text.
- **Use Rust principles as engineering guidance:** clear ownership of the public API, explicit configuration and failures, cohesive modules, and composition. This is a Typst package, not a Rust crate; no Rust runtime or CLI is proposed.

Typst's template guidance uses a function to wrap the document, and its package guidance recommends keeping copied template files thin and importing the package API with a full versioned import. [Template tutorial](https://typst.app/docs/tutorial/making-a-template/), [package authoring guidance](https://github.com/typst/packages/blob/main/docs/typst.md).

## Package boundary

### Included in the reusable core

- Document setup and overridable page geometry.
- Typography roles, spacing, color, and layout tokens with sensible defaults.
- Explicit language, direction, and font configuration for English, Persian, and mixed content.
- Reusable semantic primitives for headings, paragraphs, lists, tables, links, code, and page furniture.
- Bidi helpers for inline LTR/RTL spans, URLs, identifiers, and punctuation-sensitive examples.
- Optional numeral-formatting helpers; no automatic digit conversion by default.

### Excluded from the core

- Institutional marks, forms, approval blocks, and branding.
- Proposal, weekly-report, course, thesis, or slide content schemas and workflows.
- Bibliography policy, research-specific sections, and YAML content loading.
- External assets whose license or provenance is unclear.

Consumer projects may build these concerns on top of the public API without forking the core.

## Proposed repository layout

```text
typst.toml
lib.typ                 # stable public facade
src/
  document.typ          # showable document wrapper
  config.typ            # defaults and validation
  language.typ          # language and direction primitives
  typography.typ        # font roles and text defaults
  layout.typ            # page geometry and spacing
  components/           # generic semantic components
template/
  main.typ              # small editable starter; imports a pinned package version
examples/
  english.typ
  persian.typ
  mixed-direction.typ
  custom-theme.typ
tests/                  # compile fixtures and output checks
docs/
README.md
CONTRIBUTING.md
AGENTS.md
CHANGELOG.md
LICENSE
.github/
```

Keep modules cohesive, but do not create a separate file for every token or one-off helper. Add a module when it gives a meaningful boundary or independent use.

## Public API shape

The starter should expose a minimal `#show: document.with(...)` workflow. Configuration should make language, direction, font roles, page settings, and theme overrides visible at the call site. It should not require a fixed title/author model or prescribe sections.

The locale model must allow `lang`, `direction`, fonts, and number formatting to be configured independently. Inline helpers must let mixed Persian/English text, code, URLs, punctuation, and math retain their intended direction. English and Persian examples should be complete and independently compilable.

The exact function names and dictionary schema are a design deliverable for the API phase; this document constrains behavior and ownership, not premature signatures.

## Fonts and licensing

No University or third-party logo is included. Bundle only fonts whose redistribution terms are verified and whose upstream license files and provenance are retained. Prefer a small, openly licensed Persian/Latin font set; let consumers override every font role. If a suitable font cannot be redistributed, document installation and fallback behavior instead of silently relying on a maintainer's system fonts.

Proposed licensing model: permissive license for reusable code, a no-attribution license for the copied starter if Typst Universe accepts the manifest combination, and each bundled font under its own license. Confirm the exact SPDX expression and file-to-license mapping before the first public release. Typst's registry has specific requirements for template output licensing and bundled assets. [Typst package licensing](https://github.com/typst/packages/blob/main/docs/licensing.md).

## OSS maintenance

Initial repository policy:

- Root `AGENTS.md` and `CONTRIBUTING.md`, as requested; no custom Codex skill.
- README with install/use examples, API reference, supported Typst version, font setup, and rendered previews.
- License and asset provenance, changelog, tagged semantic releases, issue forms, and pull-request template.
- GitHub Actions compiles the package and all examples with a pinned compiler and explicit fonts. Run compatibility builds against the minimum supported compiler and the current stable compiler.
- Keep generated PDFs and raster previews as CI artifacts or release assets unless a small preview is intentionally tracked. Do not commit personal or institution-specific source material.
- Add a code of conduct and security reporting policy if the project opens to outside contributions beyond occasional PRs.

Typst packages require a manifest, versioned package identity, and documented public definitions. Template packages have additional manifest, category, thumbnail, and licensing requirements. [Manifest requirements](https://github.com/typst/packages/blob/main/docs/manifest.md), [package documentation](https://github.com/typst/packages/blob/main/docs/documentation.md).

## Verification strategy

Compile the English, Persian, and mixed-direction fixtures with the minimum and current supported Typst versions. The Persian fixture must exercise Persian Yeh/Kaf, ZWNJ, mixed Latin identifiers, URLs, brackets, dates, digits, code, math, lists, tables, and running page furniture. Review rendered pages and extracted PDF text for shaping, order, clipping, and font fallback. Keep these checks separate from claims of tagged-PDF or PDF/UA conformance.

## Extraction phases

1. **Boundary audit:** classify proposal/report modules into reusable core, consumer adapters, and out-of-scope domain logic. Record current output behavior before moving shared code.
2. **Package skeleton:** create the standalone repository structure, manifest, public facade, documentation, and license policy.
3. **API design:** define configuration and locale contracts; approve public names before adopting them in examples.
4. **Core extraction:** move and simplify only shared primitives; preserve domain-specific behavior in consumer repositories.
5. **Fixtures and CI:** add bilingual examples, render checks, manifest checks, and reproducible font setup.
6. **Consumer migration:** adopt a tagged package in `research` and `aputir/course-materials`; verify both remain free to own their content and identity.
7. **First release:** publish a small, stable `0.1.0` and submit the package to Typst Universe after the local template-instantiation workflow passes.

Do not extract proposal/report content schemas or promise a complete suite of document-type templates in the first release.

## Repository name candidates

The repository owner is confirmed as `alirezaopmc`. Candidate names are use-case-neutral; final GitHub and Typst Universe slug availability must be checked before creation.

| Name | Association | Assessment |
| --- | --- | --- |
| **Negaresh** (`نگارش`) | Writing, composition | Recommended: describes document craft without naming a language or document type. |
| **Dabireh** (`دبیره`) | Script, writing system | Distinctive and culturally rooted; pronunciation may be less obvious to English speakers. |
| **Ravesh** (`روش`) | Method, approach | Clear conceptually; spelling/transliteration may be less distinctive. |
| **Dastur** (`دستور`) | Rule, form, or style | Short and memorable; can suggest command/instruction in English. |
| **Ghalam** (`قلم`) | Pen, writing | Friendly and broad; less directly signals typesetting. |
| **Hamzaban** (`هم‌زبان`) | Shared language | Strong bilingual cue; more feature-specific than the other names. |

`negaresh` is the proposed working slug, not a final selection. Avoid `typst` in the package name; Typst's registry treats it as redundant and applies additional naming rules. [Package naming rules](https://github.com/typst/packages/blob/main/docs/manifest.md).

## Decisions for review

1. Approve or revise the package boundary and extraction phases.
2. Select the repository/package name after checking slug availability; `Negaresh` is the recommendation.
3. Approve the proposed license model before any font assets or starter files are published.
4. Set the minimum Typst version based on the API and path/resource behavior selected in the API phase.

No extraction has started. The existing uncommitted changes in the research repository are outside this design and must remain untouched.

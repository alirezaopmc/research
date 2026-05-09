#!/usr/bin/env python3
"""Create docs/papers/<slug>.md from an arXiv id/URL or a generic URL."""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

_PAPER_LINK_LINE = re.compile(r"^(- \*\*Paper:\*\*)\s*$", re.MULTILINE)


def _parse_arxiv(source: str) -> str | None:
    s = source.strip()
    m = re.search(r"arxiv\.org/(?:abs|pdf)/([^/v?#]+)", s, re.I)
    if m:
        return m.group(1).rstrip(".pdf")
    m = re.match(r"^(\d{4}\.\d{4,5}(?:v\d+)?)$", s)
    if m:
        return m.group(1)
    return None


def _slugify_arxiv(aid: str) -> str:
    return "arxiv-" + re.sub(r"[^\d\w.-]+", "-", aid.lower()).strip("-")


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description="Scaffold a paper note under docs/papers/")
    p.add_argument("source", help="arXiv URL/id or generic https URL")
    p.add_argument("--slug", help="filename slug (default: derived)")
    p.add_argument("--repo-root", type=Path, default=Path.cwd(), help="repo root (default: cwd)")
    args = p.parse_args(argv)

    root: Path = args.repo_root
    papers = root / "docs" / "papers"
    papers.mkdir(parents=True, exist_ok=True)
    tpl = papers / "_template.md"
    if not tpl.is_file():
        print("missing docs/papers/_template.md", file=sys.stderr)
        return 1

    arxiv_id = _parse_arxiv(args.source)
    url: str
    if arxiv_id:
        url = f"https://arxiv.org/abs/{arxiv_id}"
        slug = args.slug or _slugify_arxiv(arxiv_id)
        front = (
            "---\n"
            f"title:\nauthors:\nyear:\nvenue:\narxiv: {arxiv_id}\n"
            f"url: {url}\ntags: []\nstatus: to-read\n---\n\n"
        )
    else:
        u = args.source.strip()
        if not u.startswith(("http://", "https://")):
            print("expected arXiv id/URL or http(s) URL", file=sys.stderr)
            return 1
        url = u
        if not args.slug:
            print("--slug required for non-arXiv URLs", file=sys.stderr)
            return 1
        slug = args.slug
        front = (
            "---\n"
            f"title:\nauthors:\nyear:\nvenue:\narxiv:\n"
            f"url: {url}\ntags: []\nstatus: to-read\n---\n\n"
        )

    dest = papers / f"{slug}.md"
    if dest.exists():
        print(f"refusing to overwrite {dest}", file=sys.stderr)
        return 1

    body = tpl.read_text(encoding="utf-8")
    if body.startswith("---"):
        _parts = body.split("---", 2)
        body = _parts[2].lstrip("\n") if len(_parts) >= 3 else body

    def repl(_m: re.Match[str]) -> str:
        return f"{_m.group(1)} [{url}]({url})"

    body, _ = _PAPER_LINK_LINE.subn(repl, body, count=1)

    dest.write_text(front + body, encoding="utf-8")
    print(dest)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

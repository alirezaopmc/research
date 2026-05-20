#!/usr/bin/env python3
"""Create docs/papers/llm-techniques/<slug>.md from an arXiv id/URL or a generic URL."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


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
    p = argparse.ArgumentParser(description="Scaffold a paper note under docs/papers/llm-techniques/")
    p.add_argument("source", help="arXiv URL/id or generic https URL")
    p.add_argument("--slug", help="filename slug (default: derived)")
    p.add_argument("--repo-root", type=Path, default=Path.cwd(), help="repo root (default: cwd)")
    args = p.parse_args(argv)

    root: Path = args.repo_root
    topic = "llm-techniques"
    papers = root / "docs" / "papers" / topic
    papers.mkdir(parents=True, exist_ok=True)

    arxiv_id = _parse_arxiv(args.source)
    url: str
    if arxiv_id:
        url = f"https://arxiv.org/abs/{arxiv_id}"
        slug = args.slug or _slugify_arxiv(arxiv_id)
        front = (
            "---\n"
            f"title:\nauthors:\nyear:\nvenue:\narxiv: {arxiv_id}\n"
            f"url: {url}\ntags: []\n"
            f"topic: {topic}\n"
            "paper_abstract: UNREAD\n"
            "paper_content: UNREAD\n"
            "paper_reproduced: 'NO'\n"
            "paper_favorite: false\n"
            "paper_to_read: true\n"
            "---\n\n"
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
            f"url: {url}\ntags: []\n"
            f"topic: {topic}\n"
            "paper_abstract: UNREAD\n"
            "paper_content: UNREAD\n"
            "paper_reproduced: 'NO'\n"
            "paper_favorite: false\n"
            "paper_to_read: true\n"
            "---\n\n"
        )

    dest = papers / f"{slug}.md"
    if dest.exists():
        print(f"refusing to overwrite {dest}", file=sys.stderr)
        return 1

    dest.write_text(front, encoding="utf-8")
    print(dest)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

from __future__ import annotations


def main() -> None:
    import uvicorn

    from research.config import Settings

    s = Settings()
    uvicorn.run(
        "research.api.main:app",
        host=s.host,
        port=s.port,
        reload=True,
        factory=False,
    )


if __name__ == "__main__":
    main()

.PHONY: install dev lint format test serve

install:
	uv sync

dev:
	uv sync --all-extras

lint:
	uv run ruff check src tests scripts
	uv run ruff format --check src tests scripts

format:
	uv run ruff format src tests scripts

test:
	uv run pytest -q

serve:
	uv run python -m research.api.cli

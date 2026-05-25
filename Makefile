.PHONY: install dev lint format test serve proposal

# Always use `./.venv` for this repo, even if another venv is active in the shell (`VIRTUAL_ENV`).
# See README / AGENTS.md / `.cursor/rules/uv-environment.mdc`.
export UV_PROJECT_ENVIRONMENT := $(CURDIR)/.venv
UV := env -u VIRTUAL_ENV uv

install:
	$(UV) sync

dev:
	$(UV) sync --all-extras

lint:
	$(UV) run ruff check src tests scripts
	$(UV) run ruff format --check src tests scripts

format:
	$(UV) run ruff format src tests scripts

test:
	$(UV) run pytest -q

serve:
	$(UV) run python -m research.api.cli

proposal:
	$(MAKE) -C proposal proposal

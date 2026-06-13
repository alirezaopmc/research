# Typst build for English weekly progress reports.
export PATH := /opt/homebrew/bin:/usr/local/bin:$(PATH)

ROOT := .
INSTANCE_DIR := src/instances
TEMPLATE := $(INSTANCE_DIR)/_template.typ
OUTPUT_DIR := output

# A report is identified by PROJECT (subfolder) + WEEK (file stem).
# PROJECT is optional; if omitted the instance lives directly under instances/.
ifeq ($(strip $(PROJECT)),)
INSTANCE := $(INSTANCE_DIR)/$(WEEK).typ
OUT := $(OUTPUT_DIR)/$(WEEK).pdf
else
INSTANCE := $(INSTANCE_DIR)/$(PROJECT)/$(WEEK).typ
OUT := $(OUTPUT_DIR)/$(PROJECT)/$(WEEK).pdf
endif

# All instances at any depth, excluding the scaffold template.
ALL_INSTANCES := $(shell find $(INSTANCE_DIR) -name '*.typ' ! -name '_template.typ' 2>/dev/null)

.PHONY: report watch new all clean list _check-typst _require-week

report: _check-typst _require-week
	@mkdir -p "$(dir $(OUT))"
	typst compile --root "$(ROOT)" "$(INSTANCE)" "$(OUT)"
	@echo "Built $(OUT)"

watch: _check-typst _require-week
	@mkdir -p "$(dir $(OUT))"
	typst watch --root "$(ROOT)" "$(INSTANCE)" "$(OUT)"

new: _require-week
	@test ! -f "$(INSTANCE)" || { \
		echo "error: $(INSTANCE) already exists" >&2; exit 1; }
	@mkdir -p "$(dir $(INSTANCE))"
	@cp "$(TEMPLATE)" "$(INSTANCE)"
	@echo "Created $(INSTANCE)"

all: _check-typst
	@for f in $(ALL_INSTANCES); do \
		out="$(OUTPUT_DIR)/$${f#$(INSTANCE_DIR)/}"; out="$${out%.typ}.pdf"; \
		mkdir -p "$$(dirname "$$out")"; \
		echo "Building $$f -> $$out"; \
		typst compile --root "$(ROOT)" "$$f" "$$out" || exit 1; \
	done

list:
	@for f in $(ALL_INSTANCES); do echo "$${f#$(INSTANCE_DIR)/}" | sed 's/\.typ$$//'; done

clean:
	rm -rf "$(OUTPUT_DIR)"

_require-week:
	@test -n "$(WEEK)" || { \
		echo "error: set WEEK=<id> (and PROJECT=<name> for subfolders)," >&2; \
		echo "       e.g. make report PROJECT=llm_hallucination WEEK=2026-W23" >&2; \
		exit 1; \
	}

_check-typst:
	@command -v typst >/dev/null 2>&1 || { \
		echo "error: typst not found. Install with: brew install typst" >&2; \
		exit 1; \
	}

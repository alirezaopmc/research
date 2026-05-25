# Typst build for Persian proposal PDF (cover + body).
export PATH := /opt/homebrew/bin:/usr/local/bin:$(PATH)

ROOT := .
FONT_DIR := assets/fonts
FONT_FILE := assets/fonts/XB Niloofar.ttf

ENTRY_FA_PROPOSAL := src/main/fa/letter.typ
ENTRY_FA_COVER := src/main/fa/cover.typ
OUTPUT_DIR := output/fa
OUTPUT_FA_PROPOSAL := $(OUTPUT_DIR)/proposal.pdf
OUTPUT_FA_COVER := $(OUTPUT_DIR)/proposal-cover.pdf

# Shell-time check: BSD make wildcard breaks on spaces in FONT_FILE.
define TYPST_COMPILE
typst compile --root "$(ROOT)" \
	$$(test -f "$(FONT_FILE)" && echo --font-path "$(FONT_DIR)") \
	"$(1)" "$(2)"
endef

define TYPST_WATCH
typst watch --root "$(ROOT)" \
	$$(test -f "$(FONT_FILE)" && echo --font-path "$(FONT_DIR)") \
	"$(1)" "$(2)"
endef

.PHONY: proposal cover watch cover-watch clean

proposal: $(OUTPUT_FA_PROPOSAL)
cover: $(OUTPUT_FA_COVER)

$(OUTPUT_FA_PROPOSAL): $(ENTRY_FA_PROPOSAL)
	@$(MAKE) --no-print-directory _check-typst
	@mkdir -p "$(OUTPUT_DIR)"
	$(call TYPST_COMPILE,$(ENTRY_FA_PROPOSAL),$(OUTPUT_FA_PROPOSAL))
	@echo "Built $(OUTPUT_FA_PROPOSAL)"

$(OUTPUT_FA_COVER): $(ENTRY_FA_COVER)
	@$(MAKE) --no-print-directory _check-typst
	@mkdir -p "$(OUTPUT_DIR)"
	$(call TYPST_COMPILE,$(ENTRY_FA_COVER),$(OUTPUT_FA_COVER))
	@echo "Built $(OUTPUT_FA_COVER)"

watch:
	@$(MAKE) --no-print-directory _check-typst
	@mkdir -p "$(OUTPUT_DIR)"
	$(call TYPST_WATCH,$(ENTRY_FA_PROPOSAL),$(OUTPUT_FA_PROPOSAL))

cover-watch:
	@$(MAKE) --no-print-directory _check-typst
	@mkdir -p "$(OUTPUT_DIR)"
	$(call TYPST_WATCH,$(ENTRY_FA_COVER),$(OUTPUT_FA_COVER))

_check-typst:
	@command -v typst >/dev/null 2>&1 || { \
		echo "error: typst not found. Install with: brew install typst" >&2; \
		exit 1; \
	}

clean:
	rm -rf output

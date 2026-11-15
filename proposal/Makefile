# Typst build for Persian proposal PDF (cover + body).
export PATH := $(HOME)/.cargo/bin:/opt/homebrew/bin:/usr/local/bin:$(PATH)

ROOT := .
FONT_DIR := assets/fonts
FONT_FILE := assets/fonts/XB Niloofar.ttf

ENTRY_FA_PROPOSAL := src/main/fa/proposal.typ
ENTRY_FA_PROPOSAL_SIGNED := src/main/fa/proposal-signed.typ
SIGNED_SUPERVISORS := src/content/fa/body/meta/supervisors.signed.yaml
SIGNED_SUPERVISORS_EXAMPLE := src/content/fa/body/meta/supervisors.signed.yaml.example
SIGNATURE_ASSETS := $(wildcard assets/signatures/*)
# Optional: only depend on signed YAML/scans when they exist (file is gitignored).
SIGNED_EXTRA_DEPS := $(wildcard $(SIGNED_SUPERVISORS)) $(SIGNATURE_ASSETS)
ENTRY_FA_COVER := src/main/fa/cover.typ
OUTPUT_DIR := output/fa
OUTPUT_FA_PROPOSAL := $(OUTPUT_DIR)/proposal.pdf
OUTPUT_FA_PROPOSAL_SIGNED := $(OUTPUT_DIR)/proposal-signed.pdf
OUTPUT_FA_COVER := $(OUTPUT_DIR)/proposal-cover.pdf
ENTRY_FA_CHEATSHEET := src/main/fa/cheatsheet.typ
OUTPUT_FA_CHEATSHEET := $(OUTPUT_DIR)/cheatsheet.pdf
DIST_DIR := dist
OUTPUT_FA_PROPOSAL_SINGLE := $(DIST_DIR)/proposal-single.typ
BUNDLE_SINGLE := scripts/bundle-single.py
# Rebuild when any template, component, or YAML content changes.
SOURCES := $(shell find src -type f \( -name '*.typ' -o -name '*.yaml' \))

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

.PHONY: proposal proposal-signed proposal-single setup-proposal-signed cover cheatsheet watch cover-watch clean

proposal: $(OUTPUT_FA_PROPOSAL)

proposal-single: $(OUTPUT_FA_PROPOSAL_SINGLE)

proposal-signed:
	@$(MAKE) --no-print-directory $(OUTPUT_FA_PROPOSAL_SIGNED)
	@echo "Ready: $(OUTPUT_FA_PROPOSAL_SIGNED)"

setup-proposal-signed:
	@mkdir -p assets/signatures
	@if [ ! -f "$(SIGNED_SUPERVISORS)" ]; then \
		cp "$(SIGNED_SUPERVISORS_EXAMPLE)" "$(SIGNED_SUPERVISORS)"; \
		echo "Created $(SIGNED_SUPERVISORS) from example."; \
	else \
		echo "Exists: $(SIGNED_SUPERVISORS)"; \
	fi
	@echo "Add supervisor scans to assets/signatures/ (see example YAML), then: make proposal-signed"

cover: $(OUTPUT_FA_COVER)
cheatsheet: $(OUTPUT_FA_CHEATSHEET)

$(OUTPUT_FA_PROPOSAL): $(ENTRY_FA_PROPOSAL) $(SOURCES)
	@$(MAKE) --no-print-directory _check-typst
	@mkdir -p "$(OUTPUT_DIR)"
	$(call TYPST_COMPILE,$(ENTRY_FA_PROPOSAL),$(OUTPUT_FA_PROPOSAL))
	@echo "Built $(OUTPUT_FA_PROPOSAL)"

$(OUTPUT_FA_PROPOSAL_SIGNED): $(ENTRY_FA_PROPOSAL_SIGNED) $(SOURCES) $(SIGNED_EXTRA_DEPS)
	@$(MAKE) --no-print-directory _check-typst
	@test -f "$(SIGNED_SUPERVISORS)" || { \
		echo "error: missing $(SIGNED_SUPERVISORS)." >&2; \
		echo "  Run: make -C proposal setup-proposal-signed" >&2; \
		echo "  Then place ali-fahim.jpg and rohollah-abedian.jpg under assets/signatures/" >&2; \
		exit 1; \
	}
	@test -f assets/signatures/ali-fahim.jpg -a -f assets/signatures/rohollah-abedian.jpg || { \
		echo "error: missing signature images under assets/signatures/" >&2; \
		echo "  Expected: ali-fahim.jpg, rohollah-abedian.jpg" >&2; \
		exit 1; \
	}
	@mkdir -p "$(OUTPUT_DIR)"
	$(call TYPST_COMPILE,$(ENTRY_FA_PROPOSAL_SIGNED),$(OUTPUT_FA_PROPOSAL_SIGNED))
	@echo "Built $(OUTPUT_FA_PROPOSAL_SIGNED) (local; not for git)"

$(OUTPUT_FA_COVER): $(ENTRY_FA_COVER) $(SOURCES)
	@$(MAKE) --no-print-directory _check-typst
	@mkdir -p "$(OUTPUT_DIR)"
	$(call TYPST_COMPILE,$(ENTRY_FA_COVER),$(OUTPUT_FA_COVER))
	@echo "Built $(OUTPUT_FA_COVER)"

$(OUTPUT_FA_CHEATSHEET): $(ENTRY_FA_CHEATSHEET) $(SOURCES)
	@$(MAKE) --no-print-directory _check-typst
	@mkdir -p "$(OUTPUT_DIR)"
	$(call TYPST_COMPILE,$(ENTRY_FA_CHEATSHEET),$(OUTPUT_FA_CHEATSHEET))
	@echo "Built $(OUTPUT_FA_CHEATSHEET)"

$(OUTPUT_FA_PROPOSAL_SINGLE): $(ENTRY_FA_PROPOSAL) $(BUNDLE_SINGLE) $(SOURCES)
	@mkdir -p "$(DIST_DIR)"
	python3 $(BUNDLE_SINGLE) --entry $(ENTRY_FA_PROPOSAL) --out $@

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

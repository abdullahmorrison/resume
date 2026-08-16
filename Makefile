TEX := resume.tex
BIN := $(CURDIR)/bin
TEX_FMT_VERSION := v0.5.7

# Suppressed chktex warnings, and why:
#    1  command terminated with space  -- "\faEnvelope \hspace{...}" is deliberate
#    8  wrong length of dash           -- "2018 -- 2023" date ranges are intentional
#   13  intersentence spacing (\@)     -- noisy on resume sentence fragments
#   27  could not execute LaTeX command -- standalone chktex has no TeX Live
#                                        search path, so it cannot resolve
#                                        \input{glyphtounicode}; pdflatex can
#   36  space in front of parenthesis
#   46  use \( \) instead of $ $       -- \labelitemi uses $\vcenter{...}$
CHKTEX_FLAGS := -n1 -n8 -n13 -n27 -n36 -n46

export PATH := $(BIN):$(PATH)

.PHONY: lint fmt fmt-check pdf tools clean

## lint: static analysis with chktex; fails on any finding
lint:
	@command -v chktex >/dev/null || { \
	  echo "chktex not found -- install it with: sudo apt install chktex"; exit 1; }
	@out=$$(chktex $(CHKTEX_FLAGS) $(TEX) 2>&1); \
	if [ -n "$$out" ]; then printf '%s\n' "$$out"; echo "==> chktex found issues"; exit 1; fi; \
	echo "==> chktex: clean"

## fmt: rewrite the source in place
fmt: tools
	tex-fmt $(TEX)

## fmt-check: fail if the source is not already formatted
fmt-check: tools
	tex-fmt --check $(TEX)

## pdf: build locally; needs a TeX toolchain (CI builds this for you)
pdf:
	@command -v pdflatex >/dev/null || { \
	  echo "pdflatex not found -- CI builds the PDF; see README to install TeX Live"; exit 1; }
	pdflatex -interaction=nonstopmode -halt-on-error $(TEX)

# Fetches tex-fmt into ./bin. No sudo and no cargo required.
tools:
	@command -v tex-fmt >/dev/null && exit 0; \
	echo "==> installing tex-fmt $(TEX_FMT_VERSION) into $(BIN)"; \
	mkdir -p $(BIN); \
	tmp=$$(mktemp -d); \
	curl -fsSL "https://github.com/WGUNDERWOOD/tex-fmt/releases/download/$(TEX_FMT_VERSION)/tex-fmt-x86_64-linux.tar.gz" \
	  | tar -xz -C $$tmp; \
	find $$tmp -name tex-fmt -type f -exec mv {} $(BIN)/ \; ; \
	chmod +x $(BIN)/tex-fmt; \
	rm -rf $$tmp

clean:
	rm -f *.aux *.log *.out *.pdf *.fls *.fdb_latexmk *.synctex.gz

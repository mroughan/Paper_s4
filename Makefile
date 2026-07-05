TEXDIR = Tex
BIB = references/s5_references.bib
DOCS = s5_annotated_bibliography s5_package_paper
PDFS = $(addsuffix .pdf,$(DOCS))
PACKAGE_DIR = ../SymbolicLongMemorySequences.jl
PLOTDIR = Plots
VALIDATION_PROD_SRC = $(PACKAGE_DIR)/validation/results/lrd_diagnostics/production
MARGINAL_SRC = $(PACKAGE_DIR)/validation/results/marginal_control
BENCHMARK_SRC = $(PACKAGE_DIR)/benchmark/results
VALIDATION_PROD_DST = $(PLOTDIR)/validation/lrd_diagnostics/production
MARGINAL_DST = $(PLOTDIR)/validation/marginal_control
BENCHMARK_DST = $(PLOTDIR)/benchmark/results

LATEX = pdflatex -interaction=nonstopmode -halt-on-error -synctex=1 -output-directory=$(TEXDIR)
BIBTEX = bibtex
INKSCAPE = inkscape
RSYNC = rsync -a --delete

.PHONY: all clean distclean plots figures sync-plots sync-figures $(DOCS)

all: sync-plots $(PDFS)

plots: sync-plots

figures: sync-plots

sync-figures: sync-plots

sync-plots:
	mkdir -p $(VALIDATION_PROD_DST) $(MARGINAL_DST) $(BENCHMARK_DST)
	$(RSYNC) $(VALIDATION_PROD_SRC)/ $(VALIDATION_PROD_DST)/
	$(RSYNC) $(MARGINAL_SRC)/ $(MARGINAL_DST)/
	$(RSYNC) $(BENCHMARK_SRC)/ $(BENCHMARK_DST)/

%.pdf: %.tex $(BIB) sync-plots | $(TEXDIR)
	$(LATEX) $<
	$(BIBTEX) $(TEXDIR)/$*
	$(LATEX) $<
	$(LATEX) $<
	cp $(TEXDIR)/$@ $@

%.pdf: %.svg
	$(INKSCAPE) "$<" --export-type=pdf --export-filename="$@"

$(DOCS): %: %.pdf

$(TEXDIR):
	mkdir -p $(TEXDIR)

clean:
	rm -f $(TEXDIR)/*.aux $(TEXDIR)/*.bbl $(TEXDIR)/*.blg $(TEXDIR)/*.log
	rm -f $(TEXDIR)/*.out $(TEXDIR)/*.synctex.gz
	rm -f $(TEXDIR)/*.fdb_latexmk $(TEXDIR)/*.fls $(TEXDIR)/*.toc

distclean: clean
	rm -f $(PDFS)
	rm -rf $(TEXDIR)

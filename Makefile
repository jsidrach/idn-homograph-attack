# Targets:
#    all     : pdf & clean (defalt option)
#    pdf     : compiles the proposal, paper and presentation to PDF files
#    clean   : removes the out/ directory holding temporary files

### Clean always
.PHONY: clean

### Name of the text files used
PROPOSAL = proposal
PAPER = paper
PRESENTATION = presentation

all: pdf clean

pdf: out/$(PROPOSAL).pdf out/$(PAPER).pdf out/$(PRESENTATION).pdf

clean:
	rm -rf out/

### Compilation Flags
PDFLATEX_FLAGS = -interaction=nonstopmode -halt-on-error -output-directory out/

### File Types (for dependancies)
TEX_FILES = $(shell find . -name '*.tex' -or -name '*.sty' -or -name '*.cls')
BIB_FILES = $(shell find . -name '*.bib')
IMG_FILES = $(shell find . -path '*.jpg' -or -path '*.png' -or \( \! -path './out/*.pdf' -path '*.pdf' \) )

### Clean

### Core Latex Generation
out/:
	mkdir -p out/

out/$(PROPOSAL).aux: $(TEX_FILES) $(IMG_FILES) | out/
	xelatex $(PDFLATEX_FLAGS) $(PROPOSAL)

out/$(PROPOSAL).pdf: out/$(PROPOSAL).aux
	xelatex $(PDFLATEX_FLAGS) $(PROPOSAL)
	mv out/$(PROPOSAL).pdf $(PROPOSAL).pdf

out/$(PAPER).aux: $(TEX_FILES) $(IMG_FILES) | out/
	xelatex $(PDFLATEX_FLAGS) $(PAPER)

out/$(PAPER).bbl: $(BIB_FILES) | out/$(PAPER).aux
	bibtex out/$(PAPER)
	xelatex $(PDFLATEX_FLAGS) $(PAPER)

out/$(PAPER).pdf: out/$(PAPER).aux $(if $(BIB_FILES), out/$(PAPER).bbl)
	xelatex $(PDFLATEX_FLAGS) $(PAPER)
	mv out/$(PAPER).pdf $(PAPER).pdf

out/$(PRESENTATION).aux: $(TEX_FILES) $(IMG_FILES) | out/
	xelatex $(PDFLATEX_FLAGS) $(PRESENTATION)

out/$(PRESENTATION).pdf: out/$(PRESENTATION).aux
	xelatex $(PDFLATEX_FLAGS) $(PRESENTATION)
	mv out/$(PRESENTATION).pdf $(PRESENTATION).pdf

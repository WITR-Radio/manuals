# What PDFs should be made here?
PDFS = amm.pdf

# Alias to make all PDFs when you just run "make"
all: ${PDFS}

# How to make a PDF
%.pdf : %.tex
	latexmk -pdf -xelatex -use-make $<

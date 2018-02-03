# What PDFs should be made here?
PDFS = djtrainer.pdf

# Alias to make all PDFs when you just run "make"
all: ${PDFS}

# How to make a PDF
%.pdf : %.tex
	xelatex $<

FILE = search1-utf8

all:
	uplatex $(FILE).tex
	uplatex $(FILE).tex
	dvipdfmx $(FILE).dvi
tex:
	uplatex $(FILE).tex
	uplatex $(FILE).tex
pdf: $(FILE).dvi
	dvipdfmx $(FILE).dvi
clean:
	@rm -f	*~ \
		$(FILE).aux $(FILE).dvi $(FILE).log \
		$(FILE).lof $(FILE).lot $(FILE).toc \
		$(FILE).ps  $(FILE).pdf

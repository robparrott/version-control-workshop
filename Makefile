THEME = small-white
THEME_ARG = --theme $(THEME)

HTMLDOCS = version-control.html version-control.s5.html
SVGDOCS = $(shell ls *.svg)
PNGDOCS = $(SVGDOCS:.svg=.png)

%.html: %.rst
	rst2html $< $@
%.s5.html: %.rst
	rst2s5 $(THEME_ARG) $< $@

%.png: %.svg
	inkscape -f $< -e $@

all: $(HTMLDOCS) $(PNGDOCS)

clean:
	rm -f presentation.html


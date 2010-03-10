THEME = seas
THEME_ARG = --theme-url ui/$(THEME)

RSTDOCS = $(shell ls *.rst)
HTMLDOCS = version-control.html version-control.s5.html
SVGDOCS = $(shell ls *.svg)
PNGDOCS = $(SVGDOCS:.svg=.png)

GENERATED = $(HTMLDOCS) $(PNGDOCS)

%.html: %.rst
	rst2html $< $@
%.s5.html: %.rst
	rst2s5 $(THEME_ARG) $< $@

%.png: %.svg
	inkscape -D -f $< -e $@

all: $(HTMLDOCS) $(PNGDOCS)

clean:
	rm -f $(GENERATED)

$(HTMLDOCS): $(RSTDOCS)


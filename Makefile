THEME = seas
THEME_ARG = --theme-url ui/$(THEME)

RSTDOCS = $(shell ls *.rst)
HTMLDOCS = version-control.html version-control.s5.html \
	   subversion-example.html \
	   README.html

SVGDOCS = $(shell ls images/*.svg)
PNGDOCS = $(SVGDOCS:.svg=.png)
STATIC = \
	images/git-transport.png \
	ui/seas/star.png \
	ui/seas/seas-logo.png \
	ui/seas/framing.css \
	ui/seas/pretty.css \
	ui/seas/print.css \
	ui/seas/iepngfix.htc \
	ui/seas/blank.gif \
	ui/seas/slides.js \
	ui/seas/opera.css \
	ui/seas/outline.css \
	ui/seas/s5-core.css \
	ui/seas/slides.css

DESTDIR = $(HOME)/public_html/version-control-workshop

GENERATED = $(HTMLDOCS) $(PNGDOCS)

%.html: %.rst
	rst2html $< $@
%.s5.html: %.rst
	rst2s5 $(THEME_ARG) $< $@

%.png: %.svg
	inkscape -D -f $< -e $@

all: $(HTMLDOCS) $(PNGDOCS) $(STATIC)

clean:
	rm -f $(GENERATED)

view: all
	firefox version-control.html

install: all
	find $(HTMLDOCS) $(PNGDOCS) $(STATIC) -print | cpio -pd $(DESTDIR)

version-control.html version-control.s5.html : $(RSTDOCS)

subversion-example.rst: examples/subversion/run.sh
	( cd examples/subversion && sh ./run.sh -nf ) > $@


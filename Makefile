RST2HTML	= rst2html
RST2S5		= rst2s5
INKSCAPE	= inkscape

THEME = seas
THEME_ARG = --theme-url ui/$(THEME)

RSTDOCS = \
	git.rst \
	history_of_vc.rst \
	intro.rst \
	seealso.rst \
	subversion.rst \
	vc_models.rst \
	version-control.rst \
	why_use_vc.rst

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
	$(RST2HTML) $< $@
%.s5.html: %.rst
	$(RST2S5) $(THEME_ARG) $< $@

%.png: %.svg
	env LANG=C DISPLAY= $(INKSCAPE) -D -f $< -e $@

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


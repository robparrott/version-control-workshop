# This Makefile renders the RestructuredText (.rst) content to HTML,
# renders the .svg files to .png images, and otherwise prepares the 
# presentation for viewing.

# COMMAND PATHS
# 
# There are here so that we can override them on the commandline if 
# necessary (e.g., on OS X, where Inkscape might be 
# /Applications/Inkscape.app/MacOS/Resources/bin/inkscape or something).
RST2HTML	= rst2html.py 
RST2S5		= rst2slides
INKSCAPE	= inkscape

# S5 CONFIGURATION
THEME = seas
#THEME_ARG = --theme-url ui/$(THEME)
#THEME_ARG = --stylesheet-dirs=ui/$(THEME)

# SOURCE FILES
#
# These are the "sources" for our presentation.

RSTDOCS = \
	git.rst \
	history_of_vc.rst \
	intro.rst \
	seealso.rst \
	subversion.rst \
	vc_models.rst \
	version-control.rst \
	why_use_vc.rst \
	vocabulary.rst

SVGDOCS = $(shell ls images/*.svg)

# GENERATED CONTENT
# 
# These are things we generate.

HTMLDOCS = index.html slides.html README.html

PNGDOCS = $(SVGDOCS:.svg=.png)

# STATIC CONTENT
#
# These are files that we use as-is.

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

# Where to install the rendered presentation.
DESTDIR = $(HOME)/public_html/version-control-workshop

# A list of all generated documents (so we can remove them).
#GENERATED = $(HTMLDOCS) $(PNGDOCS)
GENERATED = $(HTMLDOCS) 

# PATTERN RULES
#
# These rules are applied based on file extensions.

%.html: %.rst
	$(RST2HTML) $< $@

%.s5.html: %.rst
	$(RST2S5) $(THEME_ARG) $< $@

%.png: %.svg
	env LANG=C DISPLAY= $(INKSCAPE) -D -f $< -e $@

# TARGETS

all: $(HTMLDOCS) $(PNGDOCS) $(STATIC)

clean:
	rm -f $(GENERATED)

view: all
	firefox index.html

# The ``install`` target copies the final content to $(DESTDIR).  If
# a script named ``deploy`` exists in the current directory, it will be
# called with $(DESTDIR) as its only argument.
install: all
	find $(HTMLDOCS) $(PNGDOCS) $(STATIC) -print | cpio -pud $(DESTDIR)
	test -x deploy && ./deploy $(DESTDIR) || exit 0

# Tell Make about the depdencies of the presentation.
index.html slides.html : $(RSTDOCS)


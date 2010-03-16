=======================================
Version control with Subversion and Git
=======================================

:Author: Lars Kellogg-Stedman <lars@seas.harvard.edu>

This is a basic introduction to version control with Subversion and Git.

Viewing the presentation
========================

- View the presentation as slideshow_.

- View the presentation as a `simple HTML document`_.

.. _slideshow: version-control.s5.html
.. _simple html document: version-control.html

Building the presentation from source
=====================================

Required tools
--------------

If you want to build this presentation from source you will need:

- Python Docutils_

  Docutils_ provides the ``rst2html`` and ``rst2s5`` commands used to
  generate the HTML version of the presentation.


- Inkscape_

  Inkscape is an open-source vector illustration program that was used to
  create the illustrations in this presentation.  While in theory any
  application that will convert from SVG to PNG will work, the Makefile
  assumes Inkscape (and other applications may generate images with
  slightly different bounding boxes or other aspects that could affect the
  appearance of the presentation).

Getting the source
------------------

The source for this presentation is available online.

- via Subversion::
  
    svn co \
    https://source.seas.harvard.edu/svn/version-control-workshop/trunk \
    version-control-workshop

- via Git::

    git svn clone -s \
    https://source.seas.harvard.edu/svn/version-control-workshop

.. _docutils: http://docutils.sourceforge.net/
.. _inkscape: http://www.inkscape.org/


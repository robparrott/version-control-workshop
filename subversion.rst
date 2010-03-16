svn: Introduction
=================

Subversion is a centralized version control system developed to address the
shortcomings of CVS.

svn: Getting help
=================

- Most commands have built-in documentatino you can access with the
  ``--help`` option::

    svn checkout --help

svn: Creating a repository
==========================

Use ``svnadmin create`` to create a new repository::

  svnadmin create REPOS_PATH

Where *REPOS_PATH* is a local filesystem path.

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svnadmin.html

   If you will be accessing the repository remotely (or offering remote
   access to collaborators), you will need to decide what sort of remote
   access to provide.  Your options are:

   - file:// (local only)
   - svn:// (subversion's native protocol)
   - svn+ssh:// (subversion over ssh)
   - http:// (subversion over webdav)

   The Subversion page on `choosing a server configuration`_ provides more
   information about the pros and cons of each of these methods.

   .. _choosing a server configuration: http://svnbook.red-bean.com/en/1.5/svn.serverconfig.choosing.html

   E.g::
   
     $ svnadmin create ~/repos/hello
   
   You could then access this using the URL file://$HOME/repos/hello.

svn: Checking out a remote repository
=====================================

Use the ``svn checkout`` command to get a working copy of a Subversion
repository::

  svn checkout URL[@REV]... [PATH]

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.checkout.html

   *URL* is often an ``http://`` URL, but may also be ``svn+ssh://`` for
   access over ssh, or ``file://`` for access to a repository on the local
   filesystem.

   For a local repository::
   
     $ svn checkout file://$HOME/repos/hello
   
   For a repository hosted on the CIT Subversion server::
   
     $ svn checkout \
     https://source.seas.harvard.edu/svn/version-control-workshop

svn: Adding files: import
=========================

``svn import`` imports an entire tree into an existing Subversion
repository::

  svn import [PATH] URL

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.import.html

   For example, if I wanted to start using Subversion to track changes to
   the hello project, I might do something like this::

     $ svn import hello-2.5 https://source.seas.harvard.edu/svn/hello/trunk

   And the output would look something like this::

     Adding         gnulib
     Adding         gnulib/m4
     Adding         gnulib/m4/lib-link.m4
     Adding         gnulib/m4/fcntl-o.m4
     Adding         gnulib/m4/getopt.m4
     Adding         gnulib/m4/localcharset.m4
     Adding         gnulib/m4/string_h.m4
     Adding         gnulib/m4/mbrtowc.m4
     Adding         gnulib/m4/iconv.m4
     Adding         gnulib/m4/longlong.m4
     [...]

   Note that ``svn import`` does not modify your current directory!  You
   would still need to issue an ``svn checkout`` to get a working copy of
   the repository.

svn: Commiting changes
======================

Use ``svn commit`` to send changes back to the repository::

  svn commit [PATH ...]

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.commit.html

svn: Adding files: add
======================

`svn add` schedules individual files or directories in your working copy to
be added to the repository next time you commit your working copy::

  svn add PATH [PATH ...]

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.add.html

   For example, let's say I wanted to package up the hello project for the
   Fedora project.  I'd need to create a package specification, or spec,
   file and then add it to the repository::

     $ svn add hello.spec
     A         hello.spec
     $ svn ci -m 'added spec file' hello.spec
     Adding         hello.spec
     Transmitting file data .
     Committed revision 2.

svn: What's changed: status
===========================

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.commit.html

svn: What's changed: diffs
==========================

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.diff.html

svn: Updating your working copy
===============================

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.update.html

svn: Removing files
===================

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.delete.html


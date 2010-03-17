svn: Introduction
=================

Subversion is a centralized version control system developed to address the
shortcomings of CVS.

svn: Getting help
=================

- Most commands have built-in documentation you can access with the
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

  You can elect to checkout only a particular subtree of a repository.  For
  example, if you really like the images in this presentation::

     $ svn checkout \
     https://source.seas.harvard.edu/svn/version-control-workshop/images

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

   Subversion will start an editor allowing you to provide a commit message
   (you can also provide one with the ``-m`` option).

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

Use ``svn status`` lists the state of files in your working copy::

  svn status

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.commit.html

   The ``svn status`` command shows you what files in your working copy
   have been changed (added, deleted, renamed, modified).  It will also
   show you which files are not part of your repository.  For example::

     $ svn status
     ?       subversion-example.rst
     M       why_use_vc.rst
     M       history_of_vc.rst
     M       subversion.rst
     A       vocabulary.rst

   This shows that three files have been modified, one has been added, and
   one is unknown to the version control system.

svn: What's changed: diffs
==========================

Use ``svn diff`` to display the changes made to your repository::

  svn diff [-r N[:M]] [TARGET]

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.diff.html

   - Without any arguments, display all of the uncomitted changes in your
     working copy.

   - Specify *TARGET* to see just the changes in a particular file or
     directory.

   - Use the ``-r`` option to look at the changes between specific
     revisions.

   For example::

     $ svn diff -r 44:46 README.rst 
     Index: README.rst
     ===================================================================
     --- README.rst	(revision 44)
     +++ README.rst	(revision 46)
     @@ -3,6 +3,8 @@
      =======================================
      
      :Author: Lars Kellogg-Stedman <lars@seas.harvard.edu>
     +:Organization: Instructional and Research Computing Services, Harvard
     +               School of Engineering and Applied Sciences
      
      This is a basic introduction to version control with Subversion and Git.

svn: Updating your working copy
===============================

Use ``svn update`` to update your working copy with changes from the
repository::

  svn update

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.update.html

   - You can elect to update only a particular subtree of your repository
     by passing an optional path argument, e.g::

       $ svn update images/

svn: Removing files
===================

Use ``svn delete`` to remove files from the repository::

  svn delete PATH [PATH ...]

.. container:: handout

   [documentation__]

   .. __: http://svnbook.red-bean.com/en/1.5/svn.ref.svn.c.delete.html

   - Removes the file from your working copy and schedules a remove from
     the repository (next time you commit).

   - If you remove the file manually, you will still need to issue ``svn
     delete`` after the fact to mark the item deleted in the repository.

svn: Tagging and branching
==========================

- Tags and branches are naming conventions.
- Use ``svn copy`` to create tags or branches.
- Space efficient via copy-on-write

.. container:: handout

   The conventional layout of a Subversion repository looks like this::

     /trunk/
     /tags/
     /branches/

   You normally work in the ``trunk`` directory.  To create a tag::

     $ svn copy trunk tags/version_1
     $ svn ci -m 'tagged version 1'

   Or to create a branch::

     $ svn copy trunk branches/version_1_fixes
     $ svn ci -m 'created branch for version 1 fixes'

   While functionally the same, the convention is that you do not edit
   things in the ``tags/`` tree, while you *may* change things in the
   ``branches/`` tree.

   See `choosing a repository layout`_ from the Subversion documentation
   for more information.

   .. _choosing a repository layout: http://svnbook.red-bean.com/en/1.0/ch05s04.html#svn-ch-5-sect-6.1


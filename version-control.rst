==================================
An introduction to version control
==================================

:Author: Lars Kellogg-Stedman <lars@seas.harvard.edu>
:IRCS: http://ircs.seas.harvard.edu/
:Support: | ircshelp@seas.harvard.edu
          | http://ircs.seas.harvard.edu/userdocs/

.. class:: handout

This document may be viewed as a slideshow_.

.. class:: handout
.. contents::

Who are you?
============

| Lars Kellogg-Stedman <lars@seas.harvard.edu>
| Senior Technologist, Instructional and Research Computing Services (IRCS_)

.. admonition:: **Please ask me lots of questions.**

   Interactive presentations are much more fun.

Why version control?
====================

- Protection.
- Isolation.
- Collaboration.
- Accountability.

Protection
==========

Version control is like having infinite undo.

.. container:: handout

   If you accidentally delete a chunk of code or find a bug introduced a
   year ago it's easy to go back in time and make things better.

Isolation
=========

Version control makes it easy to test out changes to your code.

.. container:: handout

   You can test out extensive changes in dedicated branches of your code,
   merging them back in or discarding them at the end of the process.

Collaboration
=============

A VCS manages the tasks of propogating changes and handling conflicts.

.. container:: handout
 
   This makes it easier for multiple developers to work on the same project.

Accountability
==============

A VCS makes it easier to identify the provenance of a specific change.

.. container:: handout

   You can identify when the change was introduced, who made, and you may
   even find information about why the change was made.

History of version control
==========================

In the beginning, there was RCS_.

- managed files, not projects.
- uses locking to manage conflicts.
- everyone worked in the same place.

History of version control
==========================

RCS begat CVS_.

- Developed by a professor who was working on a project with two
  students.
- Uses merging and conflict detection to manage conflicts.
- Supports distributed operation.

History of version control
==========================

CVS begat Subversion_.

- Subversion designed primarily to address the failings of CVS.
- Command line familiar to CVS users.
- Atomic operations, handles directories and renames.

History of version control
==========================

The DVCS explosion (c. 2005).

.. image:: kaboom.png
   :class: centered
   :align: center
   :width: 600

History of version control
==========================

- Aegis_
- Bazaar_
- darcs_
- git_
- Mercurial_
- monotone_

- ...and a variety of commercial solutions.

Centralized version control
===========================

- CVS, Subversion
- One main repository
- Lots of working copies

Centralized version control
===========================

Developers check out working copies.

.. image:: central-1.png
   :align: center
   :width: 300

Centralized version control
===========================

Someone commits bad code to repository.

.. image:: central-2.png
   :align: center
   :width: 300

Centralized version control
===========================

Changes are visible to everyone.

.. image:: central-3.png
   :align: center
   :width: 300

Distributed version control
===========================

Most modern version control systems use a distributed model.

Distributed version control
===========================

Developers check out working copies.

.. image:: central-1.png
   :align: center
   :width: 300

Distributed version control
===========================

Commits bad code to her local repository.

.. image:: dvcs-2.png
   :align: center
   :width: 300

Distributed version control
===========================

Fixes locally and pushes to remote repository.

.. image:: dvcs-3.png
   :align: center
   :width: 300

Distributed version control
===========================

Everyone is happy.

.. image:: dvcs-4.png
   :align: center
   :width: 300

Distributed version control
===========================

There is no spoon.

.. image:: nospoon.png
   :align: center
   :width: 600

.. container:: handout

   In the world of distributed version control, the idea of a central
   repository is a social construct rather than a technical one.  While
   some projects may find it convenient to identify a central repository,
   git (and other DVC systems) do not enforce a hub and spoke
   configuration.

   For some of my own projects I have something of an "inverted tree": my
   working copies push to two remote repositories.  One is a "personal"
   repository, which I use to coordinate my work between my office, my
   laptop, and so forth.  The other is a "public" repository, where I push
   my code when I want others to see it.

Why git?
========

These are the reasons I started using Git.

- Good Subversion support
- Works locally
- Easy ("cheap") branching
- Fast

Using git: basics
=================

- Most commit commands have built-in documentation you can access with the
  ``--help`` option::

    git init --help

- If you pretend that git is sort of like Subversion you will mostly be
  okay.

Using git: Creating a repository
================================

Use ``git init`` to create a git repository in your current directory::

  git init

.. container:: handout

   This creates a ``.git`` subdirectory in the current directory.

Using git: Adding files
=======================

Use ``git add`` to select files to add to the repository, and use ``git
commit`` to commit them to the (local) repository::

  git add .
  git commit -m "initial import"

Using git: What's changed?
==========================

Use ``git status`` to see a list of modified files::

  git status

.. container:: handout

   The output will look something like this::

     # On branch master
     # Changed but not updated:
     #   (use "git add <file>..." to update what will be committed)
     #   (use "git checkout -- <file>..." to discard changes in working directory)
     #
     #	modified:   version-control.rst
     #
     # Untracked files:
     #   (use "git add <file>..." to include in what will be committed)
     #
     #	examples/
     no changes added to commit (use "git add" and/or "git commit -a")

   The files listed as "changed but not updated" are files that you have
   modified but not yet added to the repository.  "Untracked files" are
   files about which git knows nothing.

Using git: What's changed?
==========================

Use ``git diff`` to see pending changes in your working copy::

  git diff

.. container:: handout

   The output of ``git diff`` is standard diff output, e.g.::

     diff --git a/version-control.rst b/version-control.rst
     index e518192..b1c519a 100644
     --- a/version-control.rst
     +++ b/version-control.rst
     @@ -243,6 +243,34 @@ commit`` to commit them to the (local) repository::
      Using git: What's changed?
      ==========================
      
     +Use ``git status`` to see a list of modified files::
     +
     +  git status
     +
     +.. container:: handout
     +
     +   The output will look something like this::
     +

Using git: What's changed?
==========================

You can also use ``git diff`` to see the changes between arbitrary
revisions of your project::

  - Changes in working copy vs. previous commit::

      git diff <commit>

  - Changes between two previous commits::

      git diff <commit1> <commit2>

Using git: the index
====================

- Git is not really just like Subversion.
- The *index* is a staging area between your working copy and your local
  repository.
- ``git add`` adds files to the index; ``git commit`` moves files from the
  index to the repository.

Using git: the index
====================

- ``git diff`` is the difference between your working copy and the index.
- ``git diff HEAD`` is the difference between your working copy and the
  local repository.
- ``git diff --cached`` is the difference between the index and the local
  repository.

Using git: the index
====================

Refer back to this illustration if you get confused:

.. image:: git-transport.png

.. container:: handout

   (This image used with permission.)

Plays well with others
======================

Git can integrate with other version control systems.  In this section
we'll look briefly at:

- Using git as a Subversion client
- Import a CVS repository into git

git as a Subversion client
==========================

You can use git as your Subversion client.  This gives you many of the
benefits of a DVCS while still interacting with someone else's Subversion
repository.

.. container:: handout

   For advanced users:

   If you need to edit the layout of a Subversion repository, git may be a
   better tool for the job than the standard suggestion of ``svnadmin
   dump``, ``svndumpfilter``, and ``svnadmin load``.

git as a Subversion client
==========================

Cloning a remote repository::

  git svn clone [ -s ] http://...

git as a Subversion client
==========================

Committing your changes back to the Subversion repository::

  git svn dcommit

Importing a CVS respository
===========================

You can import a CVS repository into git (this is a one-time, one-way
operation).

Requires:

- cvsps_

Importing a CVS repository
==========================

This may take a while::

  export CVSHOME=:pserver:anonymous@example.com
  cvs login
  git cvsimport -o cvs_head -C my-project

More information
================

We have compiled a list of helpful or interesting links related to
Git and to version control in general:

- http://delicious.com/seas_ircs/versioncontrol

If you are looking explicitly for additional tutorials:

- http://delicious.com/seas_ircs/versioncontrol+tutorial

Metadata
========

This presentation is available online:

- via Git::

    git clone git://git.seas.harvard.edu/lars/version-control-tutorial

- via Subversion::
  
    svn co http://source.seas.harvard.edu/svn/version-control-tutorial

.. _rcs: http://www.gnu.org/software/rcs/
.. _cvs: http://www.nongnu.org/cvs/
.. _subversion: http://subversion.tigris.org/
.. _git: http://git-scm.org/
.. _aegis: http://aegis.sourceforge.net/
.. _bazaar: http://bazaar.canonical.com/en/
.. _mercurial: http://mercurial.selenic.com/
.. _darcs: http://www.darcs.net/
.. _monotone: http://www.monotone.ca/
.. _cvsps: http://www.cobite.com/cvsps/
.. _slideshow: version-control.s5.html
.. _ircs: http://ircs.seas.harvard.edu/


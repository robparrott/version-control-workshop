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
     #  modified:   version-control.rst
     #
     # Untracked files:
     #   (use "git add <file>..." to include in what will be committed)
     #
     #  examples/
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

.. _cvsps: http://www.cobite.com/cvsps/

Importing a CVS repository
==========================

This may take a while::

  export CVSHOME=:pserver:anonymous@example.com
  cvs login
  git cvsimport -o cvs_head -C my-project


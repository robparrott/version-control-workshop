git: Introduction
=================

Git is a distributed version control system originally developed by Linus
Torvals as a replacement for BitKeeper.

git: Basics
===========

- Most commands have built-in documentation you can access with the
  ``--help`` option::

    git init --help

- If you pretend that git is sort of like Subversion you will mostly be
  okay.

git: Creating a repository
==========================

Use ``git init`` to create a git repository in your current directory::

  git init

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-init.html

   ``git init`` creates a git repository (named ``.git``) in your current
   working directory.  You will add files to this repository using ``git
   add``.

git: Adding files
=================

``git add`` schedules files to be committed to the repository (you will
need to issue a ``git commit``).

  git add PATH [PATH ...]

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-add.html

   Note that unlike Subversion, you will need to explicitly add any changes
   to the repository.  In other words, if you modify a file you (generally)
   need to ``git add`` that file in order to make it part of the next
   commit.

git: Committing changes
=======================

Use ``git commit`` to commit files to your local repository::

  git commit [-a] [PATH ...]

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-commit.html

   ``git commit`` by itself will commit any changes scheduled using ``git
   add``.  If you would like to commit all locally modified files, use the
   ``-a`` option::

     git commit -a

   You may also commit a subset of modified files by specifying paths on
   the command line::

     git commit path/to/modified/file

   A common usage of the above commands is to initialize a git repository
   and then add all of the files in your current directory::

     $ git init
     Initialized empty Git repository in .../.git/
     $ git add .
     $ git commit -m 'initial import'

git: What's changed: status
===========================

Use ``git status`` to see a list of modified files::

  git status

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-status.html

   The output of ``git status`` will look something like this::

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
   files that have not previously been added to the repository.

git: What's changed: diffs
==========================

Use ``git diff`` to see pending changes in your working copy::

  git diff

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-diff.html

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

   You can also use ``git diff`` to see the changes between arbitrary
   revisions of your project:

   - Changes in working copy vs. previous commit::

       git diff <commit>

   - Changes between two previous commits::

       git diff <commit1> <commit2>

git: Pushing changes
====================

Use ``git push`` to send your committed changes to a remote repository::

  git push [REPOSITORY [REFSPEC] ]

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-push.html

   ``git push`` by itself will push your changes to the remote repository
   defined by the ``branch.master.remote`` config option (which will
   typically be the repository from which you originally cloned your
   working copy).  If there are multiple remote repositories associated
   with your working copy, you can specify a repository (and branch) on the
   command line.

git: the index
==============

- Git is not really just like Subversion.
- The *index* is a staging area between your working copy and your local
  repository.
- ``git add`` adds files to the index; ``git commit`` commits files from the
  index to the repository.

git: the index
==============

- ``git diff`` is the difference between your working copy and the index.
- ``git diff HEAD`` is the difference between your working copy and the
  local repository.
- ``git diff --cached`` is the difference between the index and the local
  repository.

git: the index
==============

Refer back to this illustration if you get confused:

.. image:: images/git-transport.png

.. container:: handout

   (This image used with permission.)

git: Plays well with others
===========================

Git can integrate with other version control systems.

- Can act as a Subversion client (may be the only Subversion client you
  ever need).

- Can import a CVS repository.

git: Integrating w/ Subversion
==============================

You can use git as your Subversion client.  This gives you many of the
benefits of a DVCS while still interacting with a Subversion
repository.

git: Integrating w/ Subversion
==============================

Cloning a remote repository::

  git svn clone [ -s ] REPO_URL

.. container:: handout

   The ``-s`` flag informs git that your Subversion repository uses the
   recommended repository layout (i.e., that the top level of your
   repository contains ``trunk/``, ``tags/``, and ``branches/``
   directories).  The ``HEAD`` of your working copy will track the trunk.

git: Integrating w/ Subversion
==============================

Committing your changes back to the Subversion repository::

  git svn dcommit

git: Integrating w/ CVS
=======================

You can import a CVS repository into git (this is a one-time, one-way
operation).

.. container:: handout

   The CVS import feature requires cvsps_, a tool for collating CVS changes
   into changesets.
 
   .. _cvsps: http://www.cobite.com/cvsps/

git: Integrating w/ CVS
=======================

This may take a while::

  export CVSHOME=:pserver:anonymous@example.com
  cvs login
  git cvsimport -o cvs_head -C my-project


git: Introduction
=================

Git is a distributed version control system originally developed by Linus
Torvals as a replacement for BitKeeper.

git: Getting help
=================

- Most commands have built-in documentation you can access with the
  ``--help`` option::

    git init --help

- Also available via ``man``, e.g::

    man git-init

git: Creating a repository
==========================

Use ``git init`` to create a git repository in your current directory::

  git init

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-init.html

   ``git init`` creates a git repository (named ``.git``) in your current
   working directory.  You will add files to this repository using ``git
   add``.  This gives you a repository (the ``.git`` directory) and a
   working copy (everything else).

   If you are going to start tracking an existing project with git, you
   will generally start like this::

     $ git init
     Initialized empty Git repository in .../.git/
     $ git add .
     $ git commit -m 'initial import'

   If you are creating a repository that people will be accessing remotely,
   you will normally want to create a "bare" repository, which consists of
   just the contents of the ``.git`` directory and no working copy.  You do
   this with the ``-b`` flag::

     $ git init -b

git: Adding files
=================

``git add`` schedules files to be committed to the repository.

  git add PATH [PATH ...]

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-add.html

   Unlike Subversion, if you modify a file you (generally) need to ``git
   add`` that file in order to make the changes part of the next commit.

   Use the ``git reset`` command to "undo" an add operation::

     git reset HEAD

   This resets the index but leaves your working directory untouched. You
   can also use ``git reset`` to revert to a previous commit; read the
   documentation for more information.

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

git: What's changed: status
===========================

Use ``git status`` to see a list of modified files::

  git status

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-status.html

   The output of ``git status`` will look something like this::

     $ git status
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

     $ git diff
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

git: Cloning a remote repository
================================

Use the ``git clone`` command to check out a working copy of a remote
repository::

  git clone REPOSITORY [DIRECTORY]

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-clone.html

   ``git clone`` will clone the remote repository to a new directory in
   your current directory named after the repository, unless you explicitly
   provide a name with the *DIRECTORY* argument.

   This is analagous to Subversions ``checkout`` operation.

   You can only clone the top-level repository; unlike Subversion, git does
   not allow you to clone individual subtrees.

git: Updating your working copy
===============================

Use ``git pull`` to update your local repository from the remote repository
and merge changes into your working copy::

  git pull [REPOSITORY [REFSPEC]]

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-pull.html

   ``git pull`` by itself will pull changes from the remote repository
   defined by the ``branch.master.remote`` config option (which will
   typically be the repository from which you originally cloned your
   working copy).  If there are multiple remote repositories associated
   with your working copy, you can specify a repository (and branch) on the
   command line, e.g, to pull changes from the branch *master* at a remote
   named *origin*::

     $ git pull origin master

git: Pushing changes
====================

Use ``git push`` to send your committed changes to a remote repository::

  git push [REPOSITORY [REFSPEC]]

.. container:: handout

   [documentation__]

   .. __: http://www.kernel.org/pub/software/scm/git/docs/v1.6.6.2/git-push.html

   ``git push`` by itself will push your changes to the remote repository
   defined by the ``branch.master.remote`` config option (which will
   typically be the repository from which you originally cloned your
   working copy).  If there are multiple remote repositories associated
   with your working copy, you can specify a repository (and branch) on the
   command line, e.g, to push your changes to branch *master* at a remote
   named *origin*::

     $ git push origin master

git: the index
==============

Git is not really just like Subversion (or most other version control
solutions).

- The *index* is a staging area between your working copy and your local
  repository.
- ``git add`` adds files to the index
- ``git commit`` commits files from the
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
   :height: 300

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

   This instructs git to clone the *entire* repository, including the
   complete revision history. This may take a while for repositories with a
   long history.  You can use the ``-r`` option to request a partial
   history.  From the man page::

      -r <ARG>, --revision <ARG>
          Used with the fetch command.

          This allows revision ranges for partial/cauterized history to be
          supported. $NUMBER, $NUMBER1:$NUMBER2 (numeric ranges),
          $NUMBER:HEAD, and BASE:$NUMBER are all supported.

          This can allow you to make partial mirrors when running fetch; but
          is generally not recommended because history will be skipped and
          lost.

git: Integrating w/ Subversion
==============================

Committing your changes back to the Subversion repository::

  git svn dcommit

.. container:: handout

   Before you push your changes to the Subversion repository you need to
   first commit any pending modifications to your local repository.
   Otherwise, git will complain::

     $ git svn dcommit
     Cannot dcommit with a dirty index.  Commit your changes first, or stash them with `git stash'.
       at /usr/libexec/git-core/git-svn line 491

   To fix this, commit your changes::

     $ git commit -m 'a meaningful commit message' -a

   And then send your changes to the Subversion repository::
 
     $ git svn dcommit
     Committing to https://source.seas.harvard.edu/svn/version-control-workshop/trunk ...
       M	seealso.rst
     Committed r38
       M	seealso.rst
     r38 = 03254f2c0b3d5e068a87566caef84454558b85b0 (refs/remotes/trunk)
     No changes between current HEAD and refs/remotes/trunk
     Resetting to the latest refs/remotes/trunk
     Unstaged changes after reset:
     M	git.rst
       M	git.rst
     Committed r39
       M	git.rst
     r39 = d1f884a3f945f6083541e28ab7a09ca8efc6343b (refs/remotes/trunk)
     No changes between current HEAD and refs/remotes/trunk
     Resetting to the latest refs/remotes/trunk

git: Integrating w/ Subversion
==============================

Updating your working copy from the Subversion repository::

  git svn rebase

.. container:: handout

   As with ``git svn dcommit``, you must have a clean working copy before
   running the ``rebase`` command.

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

git: Frontends
==============

The `git wiki`_ has a `list of frontends`_ for git.

.. _git wiki: http://git.wiki.kernel.org/index.php/Main_Page
.. _list of frontends: http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Graphical_Interfaces


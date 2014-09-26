History of version control
==========================

In the beginning (c. 1985), there was `RCS`.

- uses locking to manage conflicts.

But...

- managed files, not projects.
- everyone worked in the same place.
- locks were inconvenient.

----

RCS begat `CVS`.

- uses merging and conflict detection to manage conflicts.
- supports distributed operation.

But...

- operations were not atomic
- no support for renaming files/directories

----

`CVS` begat `Subversion`.

- designed to address problems in CVS
- command line familiar to CVS users.
- atomic operations, handles directories and renames.


   The Subversion documentation describes the development of Subversion
   thusly:

     In early 2000, CollabNet, Inc. (http://www.collab.net) began seeking
     developers to write a replacement for CVS...
     CVS's limitations were obvious from the beginning, and
     CollabNet knew it would eventually have to find something better...
     So CollabNet determined to write a new version control
     system from scratch, retaining the basic ideas of CVS, but without the
     bugs and misfeatures.

----

The version control explosion.

![kaboom.png](../images/kaboom.png)

- `git`
- `Bazaar`
- `darcs`
- `Mercurial`
- `monotone`

.. class:: handout

git and mercurial
-----------------

Git_ and Mercurial_ both stem directly from the brouhaha surrounding the
adoption -- `and subsequent rejection`_ in 2005 -- of the commercial
BitKeeper_ version control system for the Linux kernel.

.. class:: handout

Bazaar
------

Bazaar_ was developed in 2005 by Canonical as a replacement for baz_, which
was itself a fork of `GNU arch`_.

.. class:: handout

Darcs
-----

Darcs_ was developed in 2002 as a result of the author's experience with
`Gnu arch`_.

.. class:: handout

Monotone
--------

Monotone was initially released in 2003.  In 2005 it was briefly a
candidate for replacing BitKeeper_ for use in Linux kernel development.

.. _rcs: http://www.gnu.org/software/rcs/
.. _cvs: http://www.nongnu.org/cvs/
.. _subversion: http://subversion.tigris.org/
.. _git: http://git-scm.org/
.. _aegis: http://aegis.sourceforge.net/
.. _bazaar: http://bazaar.canonical.com/en/
.. _mercurial: http://mercurial.selenic.com/
.. _darcs: http://www.darcs.net/
.. _monotone: http://www.monotone.ca/
.. _and subsequent rejection: http://kerneltrap.org/node/4966
.. _bitkeeper: http://www.bitkeeper.com/
.. _baz: http://en.wikipedia.org/wiki/Bazaar_(software)#Baz:_an_earlier_Canonical_Ltd_version_control_system
.. _gnu arch: http://en.wikipedia.org/wiki/GNU_arch


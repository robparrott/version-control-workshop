History of version control
==========================

In the beginning (c. 1985), there was `RCS`.

- uses locking to manage conflicts.

But...

- managed files, not projects.
- everyone worked in the same place.
- locks were inconvenient.

----

## RCS begat `CVS`.

- uses merging and conflict detection to manage conflicts.
- supports distributed operation.

But...

- operations were not atomic
- no support for renaming files/directories

----

## `CVS` begat `Subversion`.

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

# The version control explosion.

![kaboom.png](../images/kaboom.png)

- `git`
- `Bazaar`
- `darcs`
- `Mercurial`
- `monotone`


git and mercurial
-----------------

`Git` and `Mercurial` both stem directly from the brouhaha surrounding the
adoption -- _and subsequent rejection_ in 2005 -- of the commercial
`BitKeeper` version control system for the Linux kernel.


Bazaar
------

`Bazaar` was developed in 2005 by Canonical as a replacement for `baz`, which
was itself a fork of `GNU arch`.


Darcs
-----

`Darcs` was developed in 2002 as a result of the author's experience with
`Gnu arch`.

.. class:: handout

Monotone
--------

`Monotone` was initially released in 2003.  In 2005 it was briefly a
candidate for replacing BitKeeper_ for use in Linux kernel development.

Links
-----

* [rcs](http://www.gnu.org/software/rcs/)
* [cvs](http://www.nongnu.org/cvs/)
* [subversion](http://subversion.tigris.org/)
* [git](http://git-scm.org/)
* [aegis](http://aegis.sourceforge.net/)
* [bazaar](http://bazaar.canonical.com/en/)
* [mercurial](http://mercurial.selenic.com/)
* [darcs](http://www.darcs.net/)
* [monotone](http://www.monotone.ca/) and subsequent [rejection](http://kerneltrap.org/node/4966)
* [bitkeeper](http://www.bitkeeper.com/)
* [baz](http://en.wikipedia.org/wiki/Bazaar_(software)#Baz:_an_earlier_Canonical_Ltd_version_control_system)
* [gnu arch](http://en.wikipedia.org/wiki/GNU_arch)


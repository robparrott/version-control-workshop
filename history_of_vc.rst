History of version control
==========================

In the beginning, there was RCS_.

- uses locking to manage conflicts.

But...

- managed files, not projects.
- everyone worked in the same place.
- locks were inconvenient.

History of version control
==========================

RCS begat CVS_.

- uses merging and conflict detection to manage conflicts.
- supports distributed operation.

But...

- operations were not atomic
- no support for renaming files/directories

History of version control
==========================

CVS begat Subversion_.

- designed to address problems in CVS
- command line familiar to CVS users.
- atomic operations, handles directories and renames.

But...

- still a centralized model

History of version control
==========================

The DVCS explosion (c. 2005).

.. image:: kaboom.png
   :class: center
   :align: center
   :width: 600

History of version control
==========================

- git_
- Aegis_
- Bazaar_
- darcs_
- Mercurial_
- monotone_
- ...and a variety of commercial solutions.

.. container:: handout

   git and mercurial both stem directly from the brouhaha surrounding the
   adoption -- `and subsequent rejection`_ -- of the commercial BitKeeper_
   version control system for the Linux kernel.

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

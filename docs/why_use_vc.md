Why version control?
====================

Protection.
-----------

Version control is like having infinite undo.

   - Imagine that you are working on some code.  You get it working, but
     then make a few additional changes.  You return to the code later that
     day to find that you broke it.  Version control makes it easy to see
     what has changed, and possibly revert your code back to a known state.

   - You release some code, and a month later someone finds a critical bug.
     In the intervening month your code has diverged substantially from your
     previous release, making it difficult to fix what may be a simple
     problem.  Version control makes it easy to return to a previous state of
     your code in order to fix a problem without losing all of your
     intervening work.


Isolation.
----------

Version control makes it easy to experiment with your code.

   - You can test out experimental features in a dedicated branch of your
     project without affecting the production code (or the work of your
     collaborators).

     You can merge your changes into another branch or discard them when
     you have finished experimenting.


Collaboration.
--------------

Version control makes it easier for multiple developers to work on the same
project.


   - It makes it easier to share code.

     A VCS handles the task of generating patches and merging changes, and
     makes it easier for a group of people to keep local working trees in
     sync.

   - It promotes accountability.

     In a large project with many contributors, a version control system
     keeps track of who has made which changes.  If a problem crops up,
     it's easy to identify the person responsible for the change.


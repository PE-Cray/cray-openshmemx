shmem_team_destroy
==================

::

   Destroy an existing team.

C/C++ Synopsis
--------------

.. code:: bash

       void shmem_team_destroy(shmem_team_t team);

Arguments
=========

::

   IN  team     An OpenSHMEM team handle

Description
===========

::

   The shmem_team_destroy routine is a collective operation that destroys the
   team referenced by the team handle argument team. Upon return, the
   referenced team is invalid.

   This routine destroys all shareable contexts created from the referenced
   team. The user is responsible for destroying all contexts created from this
   team with the SHMEM_CTX_PRIVATE option enabled prior to calling this routine;
   otherwise, the behavior is undefined.

   If team compares equal to SHMEM_TEAM_WORLD or any other predefined team, the
   behavior is undefined.

   If team compares equal to SHMEM_TEAM_INVALID, then no operation is performed.
   If team is otherwise invalid, the behavior is undefined.

Return Values
=============

::

   None.

Notes
=====

::

   None.

Examples
========

::

   None.

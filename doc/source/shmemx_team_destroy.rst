shmemx_team_destroy
===================

   shmemx_team_destroy - function destroys existing team

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_team_destroy(shmem_team_t *newteam);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER(KIND=8) newteam
   CALL SHMEMX_TEAM_DESTROY(newteam)

Arguments
=========

   newteam A valid SHMEM team handle.

Description
===========

   The shmemx_team_destroy function destroys an existing team. This is a
   collective call, in which every member of the team being destroyed needs
   to participate. This will free all internal memory structures associated
   with the team and invalidate the team handle. Upon return, the team
   handle is set to SHMEM_TEAM_NULL, after which it can no longer be
   used for team collective calls.

   It is considered erroneous to free SHMEM_TEAM_WORLD or
   SHMEM_TEAM_NODE. Error checking will be done to ensure a valid
   team handle is provided. All errors are considered fatal, and will
   result in the job aborting with an informative error message.

Notes
=====

   Note that SHMEM team handles have local semantics only. That is, team
   handles should not be stored in shared variables and used across other
   processes. Doing so will result in unpredictable behavior.

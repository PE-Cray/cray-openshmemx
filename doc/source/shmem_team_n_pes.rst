shmem_team_n_pes
================

   Returns the number of PEs in a specified team.

C/C++ Synopsis
--------------

.. code:: bash

       int shmem_team_n_pes(shmem_team_t team);

Arguments
=========

   IN team An OpenSHMEM team handle.

Description
===========

   When team specifies a valid team, the shmem_team_n_pes routine returns the
   number of PEs in the team.

   This will always be a value between 1 and N, where N is the total number of
   PEs running in the OpenSHMEM program.

   If team compares equal to SHMEM_TEAM_INVALID, then the value -1 is returned.
   If team is otherwise invalid, the behavior is undefined.

Return Values
=============

   The number of PEs in the specified team, or the value -1 if the team handle
   compares equal to SHMEM_TEAM_INVALID.

Notes
=====

   For the world team, this routine will return the same value as shmem_n_pes

Examples
========

   None.

shmemx_team_n_pes
=================

   shmemx_team_n_pes - returns the total number of PEs in
   the provided team

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   int shmemx_team_n_pes(shmem_team_t newteam);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER(KIND=8) newteam
   CALL SHMEMX_TEAM_N_PES(newteam)

Arguments
=========

   newteam A valid SHMEM team handle.

Description
===========

    The shmemx_team_n_pes function returns the number of processes in the
    team. This will always be a value between 1 and the total number of
    PEs. For the team SHMEM_TEAM_WORLD, this will return shmem_n_pes.
    Every team must have a least one member. All processes in the team
    will get back the same value for the team size.

    Error checking will be done to ensure a valid team handle is provided.
    All errors are considered fatal and will result in the job aborting
    with an informative error message.

Notes
=====

    By default, SHMEM creates two predefined teams that will be available
    for use once the routine start_pes has been called. These teams can be
    referenced in the application by the constants SHMEM_TEAM_WORLD and
    SHMEM_TEAM_NODE. Every PE process is a member of the SHMEM_TEAM_WORLD
    team, and its rank in SHMEM_TEAM_WORLD corresponds to the value of its
    global PE rank. The SHMEM_TEAM_NODE team only contains the set of PEs
    that reside on the same node as the current PE.

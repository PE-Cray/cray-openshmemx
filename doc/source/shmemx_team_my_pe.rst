shmemx_team_my_pe
=======

::

   shmemx_team_my_pe - returns the calling process's virtual rank in
   the provided team

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   int shmemx_team_my_pe(shmem_team_t newteam);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER(KIND-8) newteam
   CALL SHMEMX_TEAM_MY_PE(newteam)

Arguments
---------

::

   newteam A valid SHMEM team handle.

Description
-----------

::

    The shmemx_team_my_pe function returns the calling process's virtual
    rank in the provided team. The rank will be a value between 0 and N-1,
    for a team of size N. Different members of a team cannot have the same
    rank. For the team SHMEM_TEAM_WORLD, this will return shmem_my_pe.

    Error checking will be done to ensure a valid team handle is provided.
    All errors are considered fatal, and will result in the job aborting
    with an informative error message.

Notes
-----

::

    By default, SHMEM creates two predefined teams that will be available
    for use once the routine start_pes has been called. These teams can be
    referenced in the application by the constants SHMEM_TEAM_WORLD and
    SHMEM_TEAM_NODE. Every PE process is a member of the SHMEM_TEAM_WORLD
    team, and its rank in SHMEM_TEAM_WORLD corresponds to the value of its
    global PE rank. The SHMEM_TEAM_NODE team only contains the set of PEs
    that reside on the same node as the current PE.

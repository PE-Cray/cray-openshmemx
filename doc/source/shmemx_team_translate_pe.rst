shmemx_team_translate_pe
=======

::

    shmemx_team_translate_pe -- Translate a given virtual rank of one team
    to its corresponding virtual rank in another team

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   int shmemx_team_translate_pe(shmem_team_t team1, int team1_pe,
                                shmem_team_t team2);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER         team1_pe, team2_pe
   INTEGER(KIND-8) team1, team2

   team2_pe - SHMEMX_TEAM_TRANSLATE_PE(team1, team1_pe, team2)

Arguments
---------

::

    team1     A valid SHMEM team handle.

    team1_pe  A virtual team rank in team1.

    team2     A valid SHMEM team handle.

Description
-----------

::

    The shmemx_team_translate_pe function will translate a virtual rank of
    one team to its corresponding virtual rank in another team.
    Specifically, given the team1_pe in team1, this function returns that
    PE's virtual rank in team2.

    If SHMEM_TEAM_WORLD is provided as the team2 parameter, this function
    acts as a global PE rank translator and will return the corresponding
    SHMEM_TEAM_WORLD rank. This may be useful when performing point-to-
    point operations between PEs in a subset, as point-to-point operations
    require the global (SHMEM_TEAM_WORLD) rank. This function requires
    team1_pe to be a member of team1. If team1_pe is not a member of
    team2, a value of -1 is returned.

    Error checking will be done to ensure valid team handles are provided.
    All team handle errors are considered fatal and will result in the job
    aborting with an informative error message.

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

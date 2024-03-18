shmemx_team_split_color
=======================

::

   shmemx_team_split_color - collective routine to partition the existing
   parent team into a new SHMEM teams, one for each value of color, similar to
   the MPI communicator concept

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_team_split(shmem_team_t parent_team, int color, int key,
                          shmem_team_t *newteam);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER color, key INTEGER(KIND-8) parent_team, newteam
   CALL SHMEMX_TEAM_SPLIT(parent_team, color, key, newteam)

Arguments
---------

::

   parent_team
           A valid SHMEM team. The predefined teams SHMEM_TEAM_WORLD or
           SHMEM_TEAM_NODE may be used, or any team created by the
           shmemx_team_split_color() or shmem_team_create_strided()
           routines.

   color   A nonnegative integer representing the subgroup. Processes with the
           same color are in the same new team. A value of SHMEM_COLOR_UNDEFINED
           may be used to avoid team membership.

   key     An integer controlling the PE order within the subgroup.

   newteam A new SHMEM team handle representing a PE subset of all the
           PEs that supplied the same color as the calling PE.

Description
-----------

::

   The shmemx_team_split routine is a collective routine. It
   partitions an existing parent team into disjoint subgroups, one for each
   value of color, similar to the MPI communicator concept. Each subgroup
   contains all processes of the same color. Within each subgroup, the
   processes are ranked in the order defined by the value of the argument
   key, with ties broken according to their rank in the parent team. A
   new team is created for each subgroup and returned in the handle
   newteam. Each resulting newteam consists of a set of disjoint
   processes.

   A process may supply the color value SHMEM_COLOR_UNDEFINED, in
   which case a value of SHMEM_TEAM_NULL is returned for newteam,
   as this PE will not be a member of any new team. This is a collective
   call over all members of the parent team, but each process is permitted
   to provide different values for color and key. This function
   involves gathering the color and key data from all processes in the
   parent team to determine the participants in the new team.

   By default, SHMEM creates two predefined teams that will be available
   for use once the routine start_pes has been called. These teams can
   be referenced in the application by the constants SHMEM_TEAM_WORLD
   and SHMEM_TEAM_NODE. Every PE process is a member of the
   SHMEM_TEAM_WORLD team, and its rank in SHMEM_TEAM_WORLD
   corresponds to the value of its global PE rank, shmem_my_pe. The
   SHMEM_TEAM_NODE team only contains the set of PEs that reside on
   the same node as the current PE. These predefined constants can be used
   as the parent team when creating new SHMEM team subsets.

   Any valid SHMEM team can be used as the parent team. This function must
   be called by all processes in the parent team. The value of color must
   be nonnegative or SHMEM_COLOR_UNDEFINED. None of the parameters
   need to reside in symmetric memory.

   Error checking will be done to ensure a valid team handle is provided.
   All errors are considered fatal and will result in the job aborting with
   an informative error message.

Notes
-----

::

   Note that SHMEM team handles have local semantics only. That is, team
   handles should not be stored in shared variables and used across other
   processes. Doing so will result in unpredictable behavior.

   SHMEM teams may be used in any of the supported team collectives, such
   as shmem_team_barrier, shmem_team_alltoall,
   shmem_team_alltoallv and shmem_team_alltoallv_packed.

Examples
--------

C/C++ Example
-------------

::

   This example shows the shmemx_team_split_color function being used to
   create two disjoint PE subsets, one with all the even numbered PEs and
   one with the odd numbered PEs.

.. code:: bash

   #include <shmem.h>
   #include <stdio.h>

   int main()
   {
       int me, numpes, color,key, t_pe, t_size;
       shmem_team_t new_team;

       shmem_init();

       me      - shmem_my_pe();
       numpes  - shmem_n_pes();

       /* split TEAM_WORLD into odd/even subsets */
       color   - me % 2;
       key     - me;

       shmemx_team_split_color(SHMEM_TEAM_WORLD, color, key, &new_team);

       if (new_team !- SHMEM_TEAM_NULL) {
           /* query my new team\'s size and team PE value */
           t_size  - shmemx_team_n_pes(new_team);
           t_pe    - shmemx_team_my_pe(new_team);

           printf(\"Global PE %d: has a team_pe of %d out of %dn\",me,t_pe,t_size);

           shmem_team_free(&new_team);
       }

       shmem_barrier_all();
       shmem_finalize();
       return 0;
   }

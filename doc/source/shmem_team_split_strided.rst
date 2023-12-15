shmem_team_split_strided
========================

::

   Create a new OpenSHMEM team from a subset of the existing parent team PEs,
   where the subset is defined by the PE triplet (start, stride, and size)
   supplied to the routine.

C/C++ Synopsis
--------------

.. code:: bash

       int shmem_team_split_strided(shmem_team_t parent_team, int start, int stride,
                                    int size, const shmem_team_config_t *config,
                                    long config_mask, shmem_team_t *new_team);

Arguments
=========

::

   IN      parent_team     An OpenSHMEM team.
   IN      start           The lowest PE number of the subset of PEs from the
                           parent team that will form the new team.
   IN      stride          The stride between team PE numbers in the parent
                           team that comprise the subset of PEs that will form
                           the new team.
   IN      size            The number of PEs from the parent team in the subset
                           of PEs that will form the new team. size must be a
                           positive integer.
   IN      config          A pointer to the configuration parameters for the
                           new team.
   IN      config_mask     The bitwise mask representing the set of configuration
                           parameters to use from config.
   OUT     new_team        An OpenSHMEM team handle. Upon successful creation,
                           it references an OpenSHMEM team that contains the
                           subset of all PEs in the parent team specified by
                           the PE triplet provided.

Description
===========

::

   The shmem_team_split_strided routine is a collective routine. It creates a
   new OpenSHMEM team from an existing parent team, where the PE subset of the
   resulting team is defined by the triplet of arguments (start, stride, size).
   A valid triplet is one such that: start +stride ·i ∈ ZN−1 ∀ i ∈ Zsize−1

   where Z is the set of natural numbers (0,1,...), N is the number of PEs in
   the parent team and size is a positive number indicating the number of PEs
   in the new team. The index i specifies the number of the given PE in the new
   team. Thus, PEs in the new team remain in the same relative order as in the
   parent team.

   This routine must be called by all PEs in the parent team. All PEs must
   provide the same values for the PE triplet. On successful creation of the
   new team:
       • The new_team handle will reference a valid team for the subset of PEs
       in the parent team that are members of the new team.
       • Those PEs in the parent team that are not members of the new team will
       have new_team assigned to SHMEM_TEAM_INVALID.
       • shmem_team_split_strided will return zero to all PEs in the parent
       team.

   If the new team cannot be created or an invalid PE triplet is provided, then
   new_team will be assigned the value SHMEM_TEAM_INVALID and
   shmem_team_split_strided will return a nonzero value on all PEs in
   the parent team.

   The config argument specifies team configuration parameters, which are
   described in shmem_team_config(3).

   The config_mask argument is a bitwise mask representing the set of
   configuration parameters to use from config. A config_mask value of 0
   indicates that the team should be created with the default values for all
   configuration parameters. See shmem_team_config(3) for field mask names and
   default configuration parameters.

   If parent_team compares equal to SHMEM_TEAM_INVALID, then no new team will
   be created and new_team will be assigned the value SHMEM_TEAM_INVALID. If
   parent_team is otherwise invalid, the behavior is undefined.

Return Values
=============

::

   Zero on successful creation of new_team; otherwise, nonzero.

Notes
=====

::

   The shmem_team_split_strided operation uses an arbitrary stride argument,
   whereas the logPE_stride argument to the active set collective operations
   only permits strides that are a power of two. Arbitrary strides allow a
   greater number of PE subsets to be expressed and can support a broader range
   of usage models.

   See the description of team handles and predefined teams in Section 9.4 for
   more information about team handle semantics and usage.

Examples
========

::

   Example 11. The following example demonstrates the use of strided split in a
   C11 program. The program creates a new team of all even number PEs from the
   world team, then retrieves the PE number and team size on all PEs that are
   members of the new team.

.. code:: bash

   #include <shmem.h>
   #include <stdio.h>
   int main(void) {
       shmem_team_t new_team;
       shmem_team_config_t *config;

       shmem_init();
       config = NULL;
       int mype = shmem_my_pe();
       int npes = shmem_n_pes();

       shmem_team_split_strided(SHMEM_TEAM_WORLD, 0, 2, npes / 2, config, 0, &new_team);

       if (new_team != SHMEM_TEAM_INVALID) {
           int team_npes = shmem_team_n_pes(new_team);
           int team_mype = shmem_team_my_pe(new_team);
           if ((mype % 2 != 0) || (mype / 2 != team_mype) || (npes / 2 != team_npes)) {
               shmem_global_exit(1);
           }
       }

       shmem_finalize();
       return 0;
   }

shmem_team_translate_pe
=======================

   Translate a given PE number from one team to the corresponding PE number in
   another team.

C/C++ Synopsis
--------------

.. code:: bash

       int shmem_team_translate_pe(shmem_team_t src_team, int src_pe, shmem_team_t dest_team);

Arguments
=========

   IN      src_team        An OpenSHMEM team handle.
   IN      src_pe          A PE number in src_team.
   IN      dest_team       An OpenSHMEM team handle.

Description
===========

   The shmem_team_translate_pe routine will translate a given PE number in one
   team into the corresponding PE number in another team. Specifically, given
   the src_pe in src_team, this routine returns that PE’s number in dest_team.
   If src_pe is not a member of both src_team and dest_team, a value of -1 is
   returned. If at least one of src_team and dest_team compares equal to
   SHMEM_TEAM_INVALID, then -1 is returned. If either of the src_team or
   dest_team handles are otherwise invalid, the behavior is undefined.

Return Values
=============

   The specified PE’s number in the dest_team, or a value of -1 if any team
   handle arguments are invalid or the src_pe is not in both the source and
   destination teams.

Notes
=====

   If SHMEM_TEAM_WORLD is provided as the dest_team parameter, this routine
   acts as a global PE number translator and will return the corresponding
   SHMEM_TEAM_WORLD number.

Examples
========

The following example demonstrates the use of the team PE number
translation routine. The program makes a new team of all of the even
number PEs in the world team. Then, all PEs in the new team acquire
their PE number in the new team and translate it to the PE number in the
world team.

.. code:: bash

   #include <shmem.h>
   #include <stddef.h>
   int main(void) {
       shmem_init();
       shmem_team_config_t *config = NULL;
       int mype = shmem_my_pe();
       int npes = shmem_n_pes();

       shmem_team_t new_team;
       shmem_team_split_strided(SHMEM_TEAM_WORLD, 0, 2, (npes + 1) / 2, config, 0, &new_team);

       if (new_team != SHMEM_TEAM_INVALID) {
           int team_mype = shmem_team_my_pe(new_team);
           int global_mype = shmem_team_translate_pe(new_team, team_mype, SHMEM_TEAM_WORLD);
           if (global_mype != mype) {
               shmem_global_exit(1);
           }
       }
       shmem_finalize();
       return 0;
   }

shmem_sync
==========

   Registers the arrival of a PE at a synchronization point. This routine does
   not return until all other PEs in a given OpenSHMEM team or active set
   arrive at this synchronization point.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_sync(shmem_team_t team);

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_team_sync(shmem_team_t team);

Deprecated Synopsis
===================

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_sync(int PE_start, int logPE_stride, int PE_size, long *pSync);

Arguments
=========

   team    The team over which to perform the operation

   ---Deprecated---------------------------------------------------

   PE_start    The lowest PE number of the active set of PEs
   logPE_stride    The log (base 2) of the stride between consecutive PE
               numbers in the active set.
   PE_size     The number of PEs in the active set.
   pSync       Symmetric address of a work array of size at least
               SHMEM_SYNC_SIZE.

Description
===========

   shmem_sync is a collective synchronization routine over an existing
   OpenSHMEM team or active set. The routine registers the arrival of a PE at
   a synchronization point in the program. This is a fast mechanism for
   synchronizing all PEs that participate in this collective call. The routine
   blocks the calling PE until all PEs in the specified team or active set
   have called shmem_sync. In a multithreaded OpenSHMEM program, only the
   calling thread is blocked.

   Team-based sync routines operate over all PEs in the provided team argument.
   All PEs in the provided team must participate in the sync operation. If team
   compares equal to SHMEM_TEAM_INVALID or is otherwise invalid, the behavior
   is undefined.

   Active-set-based sync routines operate over all PEs in the active set
   defined by the PE_start, logPE_stride, PE_size triplet.

   As with all active set-based collective routines, each of these routines
   assumes that only PEs in the active set call the routine. If a PE not in the
   active set calls an active set-based collective routine, the behavior is
   undefined.

   The values of arguments PE_start, logPE_stride, and PE_size must be equal on
   all PEs in the active set. The same work array must be passed in pSync to
   all PEs in the active set.

   In contrast with the shmem_barrier routine, shmem_sync only ensures
   completion and visibility of previously issued memory stores and does not
   ensure completion of remote memory updates issued via OpenSHMEM routines.

   The same pSync array may be reused on consecutive calls to shmem_sync if
   the same active set is used.

Return Values
=============

   Zero on successful local completion. Nonzero otherwise.

Notes
=====

   The shmem_sync routine can be used to portably ensure that memory access
   operations observe remote updates in the order enforced by the initiator
   PEs, provided that the initiator PE ensures completion of remote updates
   with a call to shmem_quiet prior to the call to the shmem_sync routine.

Examples
========

C/C++ Example
-------------

   The following shmem_sync example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static int x = 10101;

      shmem_team_t twos_team = SHMEM_TEAM_INVALID;
       shmem_team_t threes_team = SHMEM_TEAM_INVALID;
       shmem_team_config_t *config = NULL;

       shmem_init();
       int mype = shmem_my_pe();
       int npes = shmem_n_pes();

       if (npes > 2)
           shmem_team_split_strided(SHMEM_TEAM_WORLD, 2, 2, (npes - 1) / 2, config,
               0, &twos_team);

       if (npes > 3)
           shmem_team_split_strided(SHMEM_TEAM_WORLD, 3, 3, (npes - 1) / 3, config,
           0, &threes_team);

       int mype_twos = shmem_team_my_pe(twos_team);
       int mype_threes = shmem_team_my_pe(threes_team);
       int npes_twos = shmem_team_n_pes(twos_team);
       int npes_threes = shmem_team_n_pes(threes_team);

       if (twos_team != SHMEM_TEAM_INVALID) {
           /* put the value 2 to the next team member in a circular fashion */
           shmem_p(&x, 2, shmem_team_translate_pe(twos_team,
               (mype_twos + 1) % npes_twos, SHMEM_TEAM_WORLD));
           shmem_quiet();
           shmem_sync(twos_team);
       }

       shmem_sync(SHMEM_TEAM_WORLD);

       if (threes_team != SHMEM_TEAM_INVALID) {
       /* put the value 3 to the next team member in a circular fashion */
           shmem_p(&x, 3, shmem_team_translate_pe(threes_team,
               (mype_threes + 1) % npes_threes, SHMEM_TEAM_WORLD));
           shmem_quiet();
           shmem_sync(threes_team);
       }

       if (mype && mype % 3 == 0) {
           if (x != 3)
           shmem_global_exit(3);
       }
       else if (mype && mype % 2 == 0) {
           if (x != 2)
           shmem_global_exit(2);
       }
       else if (x != 10101) {
           shmem_global_exit(1);
       }

       shmem_finalize();
       return 0;
   }

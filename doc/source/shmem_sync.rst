shmem_sync
=======

::

   Performs all operations described in the shmem_sync_all interface but with
   respect to a subset of PEs defined by the active set.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_sync(int PE_start, int logPE_stride, int PE_size, long *pSync);

Arguments
---------

::

   PE_start    The lowest PE number of the active set of PEs.  PE_start must be
               of type integer.
   logPE_stride    The log (base 2) of the stride between consecutive PE numbers
               in the active set.  logPE_stride must be of type integer.
   PE_size     The number of PEs in the active set. PE_size must be of type integer.
   pSync       A symmetric work array. In  C/C++, pSync must be of type `long`
               and size SHMEM_BARRIER_SYNC_SIZE.  Every element of this array
               must be initialized to SHMEM_SYNC_VALUE before any of the
               PEs in the active set enter shmem_sync the first time.

Description
-----------

::

   shmem_sync is a collective synchronization routine over an active set.
   Control returns from shmem_sync after all PEs in the active set (specified
   by PE_start, logPE_stride, and PE_size) have called shmem_sync.

   As with all OpenSHMEM collective routines, each of these routines assumes
   that only PEs in the active set call the routine.  If a PE not in the active
   set calls an OpenSHMEM collective routine, the behavior is undefined.

   The values of arguments PE_start, logPE_stride, and PE_size must be equal on
   all PEs in the active set.  The same work array must be passed in pSync to
   all PEs in the active set.

   In contrast with the shmem_barrier routine, shmem_sync only ensures completion
   and visibility of previously issued memory stores and does not ensure
   completion of remote memory updates issued via OpenSHMEM routines.

   The same pSync array may be reused on consecutive calls to shmem_sync if the
   same active set is used.

Return Values
-------------

::

   None.

Notes
-----

::

   If the pSync array is initialized at run time, another method of
   synchronization (e.g., shmem_sync_all) must be used before the initial use
   of that pSync array by shmem_sync.

   If the active set does not change, shmem_sync can be called repeatedly with
   the same pSync array.  No additional synchronization beyond that implied by
   shmem_sync itself is necessary in this case.

   The shmem_sync routine can be used to portably ensure that memory access
   operations observe remote updates in the order enforced by the initiator PEs,
   provided that the initiator PE ensures completion of remote updates with a
   call to shmem_quiet prior to the call to the shmem_sync routine.

Examples
--------

C/C++ Example
-------------

::

   The following shmem_sync_all and shmem_sync example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static int x - 10101;
      static long pSync[SHMEM_BARRIER_SYNC_SIZE];

      shmem_init();
      int me - shmem_my_pe();
      int npes - shmem_n_pes();

      for (int i - 0; i < SHMEM_BARRIER_SYNC_SIZE; i++)
         pSync[i] - SHMEM_SYNC_VALUE;

      shmem_sync_all();

      if (me % 2 -- 0) {
         /* put to next even PE in a circular fashion */
         shmem_p(&x, 4, (me + 2) % npes);
         /* synchronize all even pes */
         shmem_quiet();
         shmem_sync(0, 1, (npes / 2 + npes % 2), pSync);
      }
      printf("%d: x - %d\n", me, x);
      shmem_finalize();
      return 0;
   }

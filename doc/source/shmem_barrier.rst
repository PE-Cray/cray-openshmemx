shmem_barrier
=============

::

   Performs all operations described in the shmem_barrier_all interface
   but with respect to a subset of PEs defined by the active set.

Deprecated Synopsis
===================

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_barrier(int PE_start, int logPE_stride, int PE_size, long *pSync);

Arguments
=========

::

   PE_start    The lowest PE number of the active set of PEs. PE_start must be
               of type integer.  When using Fortran, it must be a default
               integer value.
   logPE_stride    The log (base 2) of the stride between consecutive
               PE numbers in the active set.  logPE_stride must be of type
               integer. When using Fortran, it must be a default integer value.
   PE_size     The number of  PEs in the active set.  PE_size must be of type
               integer.  When using  Fortran, it must be a default integer value.
   pSync       A symmetric work array of size SHMEM_BARRIER_SYNC_SIZE.
               In C/C++, pSync must be an array of elements of type `long`.
               In Fortran, pSync must be an array of elements of default integer
               type. Every element of this array must be initialized to
               SHMEM_SYNC_VALUE before any of the PEs in the active set enter
               shmem_barrier the first time.

Description
===========

::

   shmem_barrier is a collective synchronization routine over an active set.
   Control returns from shmem_barrier after all PEs in the active set
   (specified by PE_start, logPE_stride, and PE_size) have called shmem_barrier.

   As with all OpenSHMEM collective routines, each of these routines assumes that
   only PEs in the active set call the routine.  If a PE not  in  the
   active set calls an OpenSHMEM collective routine, the behavior is undefined.

   The values of arguments PE_start, logPE_stride, and PE_size must be the same
   value on all PEs in the active set.  The same work array must be passed in
   pSync to all PEs in the active set.

   shmem_barrier ensures that all previously issued stores and remote memory
   updates, including AMOs and RMA operations, done by any of the PEs in the
   active set on the default context are complete before returning.

   The  same  pSync array may be reused on consecutive calls to shmem_barrier
   if the same active set is used.

Return Values
=============

::

   None.

Notes
=====

::

   As of OpenSHMEM 1.5, shmem_barrier has been deprecated. No team-based
   barrier is provided by OpenSHMEM, as a team may have any number of
   communication contexts associated with the team. Applications seeking such
   an idiom should call shmem_ctx_quiet on the desired communication context,
   followed by a call to shmem_team_sync on the desired team.

   The shmem_barrier routine can be used to portably ensure that memory access
   operations observe remote updates in the order enforced by initiator PEs.

   Calls to shmem_ctx_quiet can be performed prior to calling the barrier
   routine to ensure completion of operations issued on additional contexts.

Examples
========

C/C++ Example
-------------

::

   The following barrier example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static int x = 10101;
      static long pSync[SHMEM_BARRIER_SYNC_SIZE];
      for (int i = 0; i < SHMEM_BARRIER_SYNC_SIZE; i++)
         pSync[i] = SHMEM_SYNC_VALUE;

      shmem_init();
      int me = shmem_my_pe();
      int npes = shmem_n_pes();

      if (me % 2 == 0) {
         /* put to next even PE in a circular fashion */
         shmem_p(&x, 4, (me + 2) % npes);
         /* synchronize all even pes */
         shmem_barrier(0, 1, (npes / 2 + npes % 2), pSync);
      }
      printf("%d: x = %d\n", me, x);
      shmem_finalize();
      return 0;
   }

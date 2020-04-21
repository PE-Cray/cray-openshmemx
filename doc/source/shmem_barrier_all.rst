shmem_barrier_all
=======

::

   Registers the arrival of a PE at a barrier and blocks the PE until all other
   PEs arrive at the barrier and all local updates and remote memory updates on
   the default context are completed.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_barrier_all(void);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_BARRIER_ALL

Arguments
---------

::

   None

Description
-----------

::

   The shmem_barrier_all routine registers the arrival of a PE at a barrier.
   Barriers are a mechanism for synchronizing all PEs at once. This routine
   blocks the PE until all PEs have called shmem_barrier_all. In a multithreaded
   OpenSHMEM program, only the calling thread is blocked.

   Prior to synchronizing with other PEs, shmem_barrier_all ensures completion
   of all previously issued memory stores and remote memory updates issued on
   the default context via OpenSHMEM AMOs and RMA routine calls such
   as shmem_int_add, shmem_put32, shmem_put_nbi, and shmem_get_nbi.

Return Values
-------------

::

   None.

Notes
-----

::

   The shmem_barrier_all routine can be used to portably ensure that memory
   access operations observe remote updates in the order enforced by initiator PEs.

   Calls to shmem_ctx_quiet can be performed prior to calling the barrier
   routine to ensure completion of operations issued on additional contexts.

Examples
--------

C/C++ Example
-------------

::

   The following shmem_barrier_all example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static int x - 1010;

      shmem_init();
      int me - shmem_my_pe();
      int npes - shmem_n_pes();

      /* put to next  PE in a circular fashion */
      shmem_p(&x, 4, (me + 1) % npes);

      /* synchronize all PEs */
      shmem_barrier_all();
      printf("%d: x - %d\n", me, x);
      shmem_finalize();
      return 0;
   }

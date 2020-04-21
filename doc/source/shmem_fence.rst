shmem_fence
=======

::

   Assures ordering of delivery of PUT, AMO, memory store, and nonblocking PUT
   routines to symmetric data objects.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_fence(void);
   void shmem_ctx_fence(shmem_ctx_t ctx);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_FENCE

Arguments
---------

::

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.

Description
-----------

::

   This routine assures ordering of delivery of PUT, AMO, memory store, and
   nonblocking PUT routines to symmetric data objects.  All PUT, AMO, memory
   store, and nonblocking PUT routines to symmetric data objects issued to a
   particular remote PE on the given context prior to the call to shmem_fence
   are guaranteed to be delivered before any subsequent PUT, AMO, memory store,
   and nonblocking PUT routines to symmetric data objects to the same PE.
   shmem_fence guarantees order of delivery, not completion. It does not
   guarantee order of delivery of nonblocking GET routines.

Return Values
-------------

::

   None.

Notes
-----

::

   shmem_fence only provides per-PE ordering guarantees and does not guarantee
   completion of delivery. shmem_fence also does not have an effect on the
   ordering between memory accesses issued by the target PE. shmem_wait_until,
   shmem_test, shmem_barrier, shmem_barrier_all routines can be called by the
   target PE to guarantee ordering of its memory accesses. There is a subtle
   difference between shmem_fence and shmem_quiet, in that, shmem_quiet
   guarantees completion of PUT, AMO, memory store, and nonblocking PUT routines
   to symmetric data objects which makes the updates visible to all other PEs.

   The shmem_quiet routine should be called if completion of PUT, AMO, memory
   store, and nonblocking PUT routines to symmetric data objects is desired
   when multiple remote PEs are involved.

   In an OpenSHMEM program with multithreaded PEs, it is the user's responsibility
   to ensure ordering between operations issued by the threads in a PE that
   target symmetric memory (e.g. PUT, AMO, memory stores, and nonblocking
   routines) and calls by threads in that PE to shmem_fence. The shmem_fence
   routine can enforce memory store ordering only for the calling thread. Thus,
   to ensure ordering for memory stores performed by a thread that is not the
   thread calling shmem_fence, the update must be made visible to the calling
   thread according to the rules of the memory model associated with the
   threading environment.

Examples
--------

C/C++ Example
-------------

::

   The following example uses shmem_fence in a C11 program:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      int src - 99;
      long source[10] - { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
      static long dest[10];
      static int targ;
      shmem_init();
      int me - shmem_my_pe();
      if (me -- 0) {
         shmem_put(dest, source, 10, 1); /* put1 */
         shmem_put(dest, source, 10, 2); /* put2 */
         shmem_fence();
         shmem_put(&targ, &src, 1, 1); /* put3 */
         shmem_put(&targ, &src, 1, 2); /* put4 */
      }
      shmem_barrier_all();  /* sync sender and receiver */
      printf("dest[0] on PE %d is %ld\n", me, dest[0]);
      shmem_finalize();
      return 0;
   }

::

   Put1 will be ordered to be delivered before put3 and put2 will be ordered to
   be delivered before put4.

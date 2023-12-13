shmem_quiet
===========

   Waits for completion of all outstanding PUT, AMO, memory store,
   and nonblocking PUT and GET routines to symmetric data
   objects issued by a PE.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_quiet(void);
   void shmem_ctx_quiet(shmem_ctx_t ctx);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_QUIET

Arguments
=========

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.

Description
===========

   The shmem_quiet routine ensures completion of PUT, AMO, memory store, and
   nonblocking PUT and GET routines on symmetric data objects issued by the
   calling PE on the given context. All PUT, AMO, memory store, and nonblocking
   PUT and GET routines to symmetric data objects are guaranteed to be completed
   and visible to all PEs when shmem_quiet returns.

Return Values
=============

   None.

Notes
=====

   shmem_quiet is most useful as a way of ensuring completion of several PUT,
   AMO, memory store, and nonblocking PUT and GET routines to symmetric data
   objects initiated by the calling PE.  For example, one might use shmem_quiet
   to await delivery of a block of data before issuing another PUT or nonblocking
   PUT routine, which sets a completion flag on another PE. shmem_quiet is not
   usually needed if shmem_barrier_all or shmem_barrier are called.  The barrier
   routines wait for the completion of outstanding writes (PUT, AMO,
   memory stores, and nonblocking PUT and GET routines) to
   symmetric data objects on all PEs.

   In an OpenSHMEM program with multithreaded PEs, it is the user's responsibility
   to ensure ordering between operations issued by the threads in a PE that target
   symmetric memory (e.g. PUT, AMO, memory stores, and nonblocking routines) and
   calls by threads in that PE to shmem_quiet. The shmem_quiet routine can enforce
   memory store ordering only for the calling thread. Thus, to ensure ordering for
   memory stores performed by a thread that is not the thread calling shmem_quiet,
   the update must be made visible to the calling thread according to the rules
   of the memory model associated with the threading environment.

   A call to shmem_quiet by a thread completes the operations posted prior
   to calling shmem_quiet. If the user intends to also complete operations
   issued by a thread that is not the thread calling shmem_quiet, the
   user must ensure that the operations are performed prior to the call to
   shmem_quiet. This may require the use of a synchronization
   operation provided by the threading package. For example, when using POSIX
   Threads, the user may call the pthread_barrier_wait routine to
   ensure that all threads have issued operations before a thread calls
   shmem_quiet.

   shmem_quiet does not have an effect on the ordering between memory
   accesses issued by the target PE. shmem_wait_until, shmem_test, shmem_barrier,
   shmem_barrier_all routines can be called by the target PE to guarantee
   ordering of its memory accesses.

Examples
========

C/C++ Example
-------------

   The following example uses shmem_quiet in a C11 program:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static long dest[3];
      static long source[3] = { 1, 2, 3 };
      static int targ;
      static int src = 90;
      long x[3] = { 0 };
      int y = 0;
      shmem_init();
      int me = shmem_my_pe();
      if (me == 0) {
         shmem_put(dest, source, 3, 1); /* put1 */
         shmem_put(&targ, &src, 1, 2);  /* put2 */
         shmem_quiet();
         shmem_get(x, dest, 3, 1);   /* gets updated value from dest on PE 1 to local array x */
         shmem_get(&y, &targ, 1, 2); /* gets updated value from targ on PE 2 to local variable y */
         printf("x: { %ld, %ld, %ld }\n", x[0], x[1], x[2]); /* x: { 1, 2, 3 } */
         printf("y: %d\n", y); /* y: 90 */
         shmem_put(&targ, &src, 1, 1); /* put3 */
         shmem_put(&targ, &src, 1, 2); /* put4 */
      }
      shmem_finalize();
      return 0;
   }

   put1 and put2 will be completed and visible before put3 and put4.

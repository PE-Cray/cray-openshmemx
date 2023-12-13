shmem_init
==========

   A collective operation that allocates and initializes the resources used by
   the OpenSHMEM library.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_init(void);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_INIT()

Arguments
=========

   None.

Description
===========

   shmem_init allocates and initializes resources used by the OpenSHMEM
   library. It is a collective operation that all PEs must call before any
   other OpenSHMEM routine may be called. At the end of the OpenSHMEM program
   which it initialized, the call to shmem_init must be matched with a call to
   shmem_finalize. After the first call to shmem_init, a subsequent call to
   shmem_init or shmem_init_thread in the same program results in undefined
   behavior.

Return Values
=============

   None.

Notes
=====

   As of OpenSHMEM[1.2], the use of start_pes has been deprecated and calls to
   it should be replaced with calls to shmem_init. While support for start_pes
   is still required in OpenSHMEM libraries, users are encouraged to use
   shmem_init. An important difference between shmem_init and start_pes is that
   multiple calls to shmem_init within a program results in undefined behavior,
   while in the case of start_pes, any subsequent calls to start_pes after the
   first one results in a no-op.

Examples
========

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void) {
       static int targ = 0;

       shmem_init();
       int me = shmem_my_pe();
       int receiver = 1 % shmem_n_pes();

       if (me == 0) {
           int src = 33;
           shmem_put(&targ, &src, 1, receiver);
       }

       shmem_barrier_all(); /* Synchronizes sender and receiver */

       if (me == receiver)
           printf("PE %d targ=%d (expect 33)\n", me, targ);

       shmem_finalize();
       return 0;
   }

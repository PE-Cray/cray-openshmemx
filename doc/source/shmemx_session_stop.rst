shmemx_session_stop
===================

::

   Stop a communication session.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_session_stop(shmem_ctx_t ctx);

Arguments
=========

::

   ctx         A context handle specifying the context associated with this
               session.

Description
===========

::

   The shmemx_session_stop routine ends a session on context ctx. If a session
   is already stopped on a given communication context, another call to
   shmemx_session_stop on that context has no effect.

Return Values
=============

::

   None.

Notes
=====

::

   Users are discouraged from including non-OpenSHMEM code, such as a long
   computation loop, within a sessioin without first calling shmemx_session_stop.

Examples
========

C/C++ Example
-------------

The following example demonstrates the usage of shmemx_session_start and
shmemx_session_stop with a loop of random atomic non-fetching XOR
updates to a distributed table, similar to the Giga-updates per second
(GUPS) microbenchmark.

.. code:: bash

   #include <stdio.h>
   #include <stdint.h> 
   #include <stdlib.h>
   #include <shmem.h>
   #include <shmemx.h>

   #define N_UPDATES (1lu << 22)
   #define N_INDICES (1lu << 10) 
   #define N_VALUES (1lu << 31)

   int main(void) {
       shmem_init();
       uint64_t *table = shmem_calloc(N_INDICES, sizeof(uint64_t));
       
       int mype = shmem_my_pe();
       int npes = shmem_n_pes();
       srand(mype);

       shmemx_session_start(SHMEM_CTX_DEFAULT, SHMEM_SESSION_UNIFORM_AMO);

       for (size_t i = 0; i < N_UPDATES; i++) { 
           int random_pe = rand() % npes;
           size_t random_idx = rand() % N_INDICES;
           uint64_t random_val = rand() % N_VALUES;
           shmem_uint64_atomic_xor(&table[random_idx], random_val, random_pe);
       }

       shmemx_session_stop(SHMEM_CTX_DEFAULT);

       shmem_free(table);
       shmem_finalize();
       return 0;
   }

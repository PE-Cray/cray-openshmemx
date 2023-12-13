shmem_ctx_create
================

   Create a communication context.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_ctx_create(long options, shmem_ctx_t *ctx);

Arguments
=========

   options     The set of options requested for the given context.
               Multiple options may be requested by combining them with a bitwise
               OR operation; otherwise, 0 can be given if no options are
               requested.
   ctx         A handle to the newly created context.

Description
===========

   The shmem_ctx_create routine creates a new communication context
   and returns its handle through the ctx argument.  If the context was
   created successfully, a value of zero is returned; otherwise, a nonzero
   value is returned.  An unsuccessful context
   creation call is not treated as an error and the OpenSHMEM library remains
   in a correct state.  The creation call can be reattempted with different
   options or after additional resources become available.

   By default, contexts are shareable and, when it is allowed by the threading
   model provided by the OpenSHMEM library, they can be used concurrently by
   multiple threads within the PE where they were created.

   The following options can be supplied during context creation to restrict
   this usage model and enable performance optimizations.  When using a given
   context, the application must comply with the requirements of all options
   set on that context; otherwise, the behavior is undefined.
   No options are enabled on the default context.

       SHMEM_CTX_SERIALIZED:
           The given context is shareable; however, it will not be used by
           multiple threads concurrently. When the SHMEM_CTX_SERIALIZED option
           is set, the user must ensure that operations involving the given
           context are serialized by the application.

       SHMEM_CTX_PRIVATE:
           The given context will be used only by the thread that created it.

       SHMEM_CTX_NOSTORE:
           Quiet and fence operations performed on the given context are not
           required to enforce completion and ordering of memory store
           operations.
           When ordering of store operations is needed, the application must
           perform a synchronization operation on a context without the
           SHMEM_CTX_NOSTORE option enabled.

Return Values
=============

   Zero on success and nonzero otherwise.

Notes
=====

   None.

Examples
========

C/C++ Example
-------------

   The following example demonstrates the use of contexts in a multithreaded
   C11 program that uses OpenMP for threading.  This example shows the
   shared counter load balancing method and illustrates the use of contexts
   for thread isolation.

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   long pwrk[SHMEM_REDUCE_MIN_WRKDATA_SIZE];
   long psync[SHMEM_REDUCE_SYNC_SIZE];

   long task_cntr  = 0; /* Next task counter */
   long tasks_done = 0; /* Tasks done by this PE */
   long total_done = 0; /* Total tasks done by all PEs */

   int main(void) {
       int tl, i;
       long ntasks = 1024;  /* Total tasks per PE */

       for (i = 0; i < SHMEM_REDUCE_SYNC_SIZE; i++)
           psync[i] = SHMEM_SYNC_VALUE;

       shmem_init_thread(SHMEM_THREAD_MULTIPLE, &tl);
       if (tl != SHMEM_THREAD_MULTIPLE) shmem_global_exit(1);

       int me = shmem_my_pe();
       int npes = shmem_n_pes();

   #pragma omp parallel reduction (+:tasks_done)
       {
           shmem_ctx_t ctx;
           int task_pe = me, pes_done = 0;
           int ret = shmem_ctx_create(SHMEM_CTX_PRIVATE, &ctx);

           if (ret != 0) {
               printf("%d: Error creating context (%d)\n", me, ret);
               shmem_global_exit(2);
           }

           /* Process tasks on all PEs, starting with the local PE.  After
            * all tasks on a PE are completed, help the next PE. */
           while (pes_done < npes) {
               long task = shmem_atomic_fetch_inc(ctx, &task_cntr, task_pe);
               while (task < ntasks) {
                   /* Perform task (task_pe, task) */
                   tasks_done++;
                   task = shmem_atomic_fetch_inc(ctx, &task_cntr, task_pe);
               }
               pes_done++;
               task_pe = (task_pe + 1) % npes;
           }

           shmem_ctx_destroy(ctx);
       }

       shmem_long_sum_to_all(&total_done, &tasks_done, 1, 0, 0, npes, pwrk, psync);

       int result = (total_done != ntasks * npes);
       shmem_finalize();
       return result;
   }

.. _cc-example-1:

C/C++ Example
-------------

   The following example demonstrates the use of contexts in a
   single-threaded C11 program that performs a summation reduction where
   the data contained in the in_buf arrays on all PEs is reduced into
   the out_buf arrays on all PEs.  The buffers are divided into
   segments and processing of the segments is pipelined.  Contexts are used
   to overlap an all-to-all exchange of data for segment p with the
   local reduction of segment p-1

.. code:: bash

   #include <stdio.h>
   #include <stdlib.h>
   #include <shmem.h>

   #define LEN  8192 /* Full buffer length */
   #define PLEN 512  /* Length of each pipeline stage */

   int in_buf[LEN], out_buf[LEN];

   int main(void) {
       int i, j, *pbuf[2];
       shmem_ctx_t ctx[2];

       shmem_init();
       int me = shmem_my_pe();
       int npes = shmem_n_pes();

       pbuf[0] = shmem_malloc(PLEN * npes * sizeof(int));
       pbuf[1] = shmem_malloc(PLEN * npes * sizeof(int));

       int ret_0 = shmem_ctx_create(0, &ctx[0]);
       int ret_1 = shmem_ctx_create(0, &ctx[1]);
       if (ret_0 || ret_1) shmem_global_exit(1);

       for (i = 0; i < LEN; i++) {
           in_buf[i] = me; out_buf[i] = 0;
       }

       int p_idx = 0, p = 0; /* Index of ctx and pbuf (p_idx) for current pipeline stage (p) */
       for (i = 1; i <= npes; i++)
           shmem_put_nbi(ctx[p_idx], &pbuf[p_idx][PLEN*me], &in_buf[PLEN*p],
                         PLEN, (me+i) % npes);

       /* Issue communication for pipeline stage p, then accumulate results for stage p-1 */
       for (p = 1; p < LEN/PLEN; p++) {
           p_idx ^= 1;
           for (i = 1; i <= npes; i++)
               shmem_put_nbi(ctx[p_idx], &pbuf[p_idx][PLEN*me], &in_buf[PLEN*p],
                             PLEN, (me+i) % npes);

           shmem_ctx_quiet(ctx[p_idx^1]);
           shmem_sync_all();
           for (i = 0; i < npes; i++)
               for (j = 0; j < PLEN; j++)
                   out_buf[PLEN*(p-1)+j] += pbuf[p_idx^1][PLEN*i+j];
       }

       shmem_ctx_quiet(ctx[p_idx]);
       shmem_sync_all();
       for (i = 0; i < npes; i++)
           for (j = 0; j < PLEN; j++)
               out_buf[PLEN*(p-1)+j] += pbuf[p_idx][PLEN*i+j];

       shmem_finalize();
       return 0;
   }

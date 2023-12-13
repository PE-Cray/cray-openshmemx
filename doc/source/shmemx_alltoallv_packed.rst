shmemx_alltoallv_packed
=======================

   shmemx_alltoallv_packed - Each PE exchanges distinct data with all other PEs
   in the defined set. Each PE may send a different amount of data and provide
   offsets for the source data. The incoming data is deposited in the target
   array in a contiguous manner, but the specific order of the data in the
   target array is indeterminate. The total number of bytes deposited in the
   target array is returned in the t_size parameter.

Definitions
===========

C or C++ SYNOPSIS
-----------------

.. code:: bash

   void shmemx_alltoallv_packed(void *target, size_t target_len, size_t *t_size,
                                const void *source, size_t *s_offsets,
                                size_t *s_sizes, int PE_start, int logPE_stride,
                                int PE_size, long *pSync)

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pSync(SHMEM_ALLTOALL_SYNC_SIZE)
   INTEGER PE_start, logPE_stride, PE_size
   INTEGER (KIND=8) s_offsets(*), s_sizes(*)
   INTEGER (KIND=8) target_len, t_size
   <TYPE> target(*), source(*)

   CALL SHMEM_ALLTOALLV_PACKED(target, target_len, t_size, source, s_offsets,
                               s_sizes, PE_start, logPE_stride, PE_size, pSync)

Arguments
=========

      target    A symmetric array large enough to receive the data being sent
                from each PE in the active set.

      target_len
                The total number of bytes allocated for the target array.

      t_size    An output variable that upon function return will contain the
                total number of bytes deposited in the target array.

      source    A symmetric array that contains the data to be sent to each PE
                in the active set.

      s_offsets A symmetric array with PE_size entries. Entry i specifies the
                offset (relative to source) of the starting address of the data
                to be sent to PE i.

      s_sizes   A symmetric array with PE_size entries. Entry i specifies the
                amount of data (in bytes) that will be sent to PE i.

      PE_start  The lowest virtual PE number of the active set of PEs.

      logPE_stride
                The log (base 2) of the stride between consecutive virtual PE
                numbers in the active set.

      PE_size   The number of PEs in the active set.

      pSync     A symmetric work array. Every element of this array must be
                initialized with the value SHMEM_SYNC_VALUE before any of the
                PEs in the active set enter shmemx_alltoallv_packed.

      The values of arguments PE_start, logPE_stride, and PE_size must be equal
      on all PEs in the active set. The same target and source arrays, and
      the same s_offset and s_sizes arrays, and the same pSync work array must
      be passed to all PEs in the active set.

      Before any PE calls shmemx_alltoallv_packed, the following conditions must
      exist (synchronization via a barrier or some other method is often needed
      to ensure this).

      The pSync array on all PEs in the active set is not still in use from a
      prior call to a shmemx_alltoallv_packed routine.

      The target array on all PEs in the active set is ready to accept the
      shmemx_alltoallv_packed data.

Description
===========

      The shmemx_alltoallv_packed routine is a collective routine; each PE in
      the defined set exchanges distinct data with all other PEs in the set.
      Each PE specifies an array of source offsets and source sizes (in
      bytes) that describe what data to send to each of the other PEs in the
      set. The caller also specifies a target buffer and a target length. The
      target_len parameter specifies the maximum number of bytes allocated
      for the target buffer. On return from this collective, the t_size
      parameter contains the actual amount of data (in bytes) deposited in the
      local target buffer.

      The shmem_alltoallv_packed routine requires each PE to allocate its target
      array large enough to hold the incoming data. If the target array is not
      allocated large enough to hold all the incoming data, overwriting of the
      target array may occur. To aid in debugging this scenario an optional
      target size check may be requested by setting the SHMEM_ALLTOALLV_TSIZE_CHK
      environment variable to abort or trunc. See the intro_shmem(3) man page
      for more information on SHMEM_ALLTOALLV_TSIZE_CHK.

      As with all Cray SHMEM collectives, this routine assumes that only PEs in
      the active set call the routine. If a PE that is not in the active set
      calls a Cray SHMEM collective routine, undefined behavior results.

Notes
=====

      The shmem_alltoallv_packed routine sets the values in pSync based on
      PE_start, logPE_stride, and PE_size values; therefore, a particular pSync
      buffer need only be initialized the first time it is used.

      Ensure that the pSync array is not being updated by any PE in the active
      set while any of the PEs participate in the processing of a
      shmem_alltoallv_packed routine. Be careful to avoid these situations:

       - If the pSync array is initialized at run time, some type of
       synchronization is needed to ensure that all PEs in the working set have
       initialized pSync before any of them enter a Cray SHMEM routine.

       - A pSync array may be reused in a subsequent call to
       shmem_alltoallv_packed only if none of the PEs in the active set are
       still processing a prior call to shmem_alltoallv_packed that used the
       same pSync array. In general, this can be ensured only by doing some
       type of synchronization. However, in the special case of Cray SHMEM
       outines being called with the same active set, it is permissible to
       allocate two pSync arrays and alternate between them on successive calls.

       There are several Cray SHMEM environment variables that can alter the
       specific algorithm used and, therefore, the performance of the
       shmem_alltoallv_packed collective. Please see the intro_shmem(3) man page
       for more information on these environment variables.

Examples
========

C/C++ Example
-------------

    This C example shows shmem_alltoallv_packed exchanging 64 integer values
    among all PEs.

.. code:: bash

   #include <shmem.h>
   #include <shmemx.h>
   #include <stdio.h>
   #include <stdlib.h>
   #include <strings.h>

   int main(void)
   {
       static long pSync[SHMEM_ALLTOALL_SYNC_SIZE];
       int *source, *target, *counts;
       size_t *s_offsets, *s_sizes;
       size_t target_len, t_size, expected_tsize;
       int  i, maxcount, pe, idx;

       shmem_init();

       maxcount  = 64;
       target    = (int *) shmem_malloc(maxcount * shmem_n_pes() * sizeof(int));
       source    = (int *) shmem_malloc(maxcount * shmem_n_pes() * sizeof(int));
       s_offsets = (size_t *) shmem_malloc(shmem_n_pes() * sizeof(size_t));
       s_sizes   = (size_t *) shmem_malloc(shmem_n_pes() * sizeof(size_t));

       target_len     = maxcount * shmem_n_pes() * sizeof(int);
       t_size         = 0;
       expected_tsize = target_len;

       for (pe=0; pe <shmem_n_pes(); pe++) {
           /* set source sizes */
           s_sizes[pe] = maxcount * sizeof(int);

           /* calculate source offsets */
           s_offsets[pe] = pe * maxcount * sizeof(int);
       }

       /* assign source values */
       for (idx=0,pe=0; pe<shmem_n_pes(); pe++) {
           for (i=0; i<s_sizes[pe]/sizeof(int); i++) {
               source[idx++] = shmem_my_pe();
           }
       }

       for (i=0; i < _SHMEM_ALLTOALL_SYNC_SIZE; i++) {
           pSync[i] = _SHMEM_SYNC_VALUE;
       }

       /* wait for all PEs to initialize pSync */
       shmem_barrier_all();

       /* alltoallv on all PES */
       shmemx_alltoallv_packed(target, target_len, &t_size, source,
                               s_offsets, s_sizes, 0, 0, shmem_n_pes(), pSync);

       /* verify t_size result */
       if (t_size != expected_tsize) {
          printf("[%d] ERROR: t_size=%ld, should be %ld\n",
                 shmem_my_pe(), t_size, expected_tsize);
       }

       /* verify results - note order is indeterminate */
       counts = (int *) malloc(maxcount * shmem_n_pes() * sizeof(int));
       bzero(counts,maxcount * shmem_n_pes() * sizeof(int));

       for (i=0; i<t_size/sizeof(int); i++) {
           counts[target[i]] ++;
       }

       for (pe=0; pe<shmem_n_pes(); pe++) {
           if (counts[pe] != maxcount) {
               printf("[%d] ERROR: received %d elements of value %d, "
                      "should be %d\n", shmem_my_pe(), counts[pe], pe, maxcount);
           }
       }

       shmem_barrier_all();
       shmem_free(s_sizes);
       shmem_free(s_offsets);
       shmem_free(target);
       shmem_free(source);
       free(counts);

       shmem_finalize();
       return 0;
   }

shmemx_alltoallv
=======

::

   shmemx_alltoallv is a cray-specific collective routine, where each PE in the
   defined set exchanges distinct data with all other PEs in the active set.

Definitions
-----------

C or C++ SYNOPSIS
-----------------

.. code:: bash

   void shmemx_alltoallv(void *target, size_t t_offsets, size_t t_sizes,
                         const void *source, size_t s_offsets, size_t s_sizes,
                         int PE_start, int logPE_stride, int PE_size, long *pSync)

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pSync(SHMEM_ALLTOALL_SYNC_SIZE)
   INTEGER PE_start, logPE_stride, PE_size, nelems
   INTEGER (KIND-8) t_offsets(*), t_sizes(*), s_offsets(*), s_sizes(*)
   <TYPE>  target(*), source(*)

   CALL SHMEMX_ALLTOALLV(target, t_offsets, t_sizes, source, s_offsets,
                         s_sizes, PE_start, logPE_stride, PE_size, pSync)

Arguments
---------

::

      target    A symmetric array large enough to receive the data being sent
                from each PE in the active set.

      t_offsets A symmetric array with PE_size entries. Entry i specifies the
                offset (relative to target) at which to place the incoming data
                from PE i.

      t_sizes   A symmetric array with PE_size entries. On function return,
                entry i will contain the number of bytes received from PE i.

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
                PEs in the active set enter shmemx_alltoallv.

      The values of arguments PE_start, logPE_stride, and PE_size must be equal
      on all PEs in the active set. The same target and source arrays, and the
      same pSync work array must be passed to all PEs in the active set.

      Before any PE calls shmemx_alltoallv, the following conditions must exist
      (synchronization via a barrier or some other method is often needed to
       ensure this).

      The pSync array on all PEs in the active set is not still in use from a
      prior call to a shmemx_alltoallv routine.

      The target array on all PEs in the active set is ready to accept the
      shmemx_alltoallv data.

Description
-----------

::

   The shmemx_alltoallv routine is a collective routine, each PE in the
   defined set exchanges distinct data with all other PEs in the set. Each
   PE specifies an array of source offsets and source sizes (in bytes) that
   describe what data to send to each of the other PEs in the set. The
   caller also specifies a target buffer and a target offset array that
   specifies where data received from each of the other PEs is deposited.
   The t_sizes array is an output parameter. On return from the collective,
   the t_sizes array contains the actual amount of data in bytes the local PE
   received from each PE.

   The shmemx_alltoallv routine requires each PE to allocate its target
   array large enough to hold the incoming data. If the caller calculates
   the t_offsets using a smaller maximum size than is being used by one
   or more of the senders, data may be overwritten. To aid in debugging
   this scenario an optional target size check may be requested by setting
   the SHMEM_ALLTOALLV_TSIZE_CHK environment variable to abort
   or trunc. If set, the user must supply the maximum number of bytes
   allowed from each PE in the t_sizes array upon function entry. See
   the intro_shmem(3) man page for more information on SHMEM_ALLTOALLV_TSIZE_CHK.

   As with all Cray OpenSHMEMX collectives, this routine assumes that only PEs
   in the active set call the routine. If a PE that is not in the active
   set calls a Cray OpenSHMEMX collective routine, undefined behavior results.

Notes
-----

::

   The shmemx_alltoallv routine sets the values in pSync based on
   PE_start, logPE_stride, and PE_size values; therefore, a
   particular pSync buffer need only be initialized the first time it is
   used.

   Ensure that the pSync array is not being updated by any PE in the
   active set while any of the PEs participate in the processing of a
   shmem_alltoallv routine. Be careful to avoid these situations:

   -   If the pSync array is initialized at run time, some type of
       synchronization is needed to ensure that all PEs in the working set
       have initialized pSync before any of them enter a Cray OpenSHMEMX
       routine.
   -   A pSync array may be reused in a subsequent call to
       shmemx_alltoallv only if none of the PEs in the active set are
       still processing a prior call to shmemx_alltoallv that used the
       same pSync array. In general, this can be ensured only by doing
       some type of synchronization. However, in the special case of Cray
       SHMEM routines being called with the same active set, it is
       permissible to allocate two pSync arrays and alternate between
       them on successive calls.

   There are several Cray OpenSHMEMX environment variables that can alter the
   specific algorithm used and, therefore, the performance of the
   shmemx_alltoallv collective. Please see the intro_shmem(3) man page for more
   information on these environment variables.

Examples
--------

C/C++ Example
-------------

::

   This C example shows shmemx_alltoallv exchanging variable sized data
   amounts among all PEs.

.. code:: bash

   #include <shmem.h>
   #include <shmemx.h>
   #include <stdio.h>

   int main(void)
   {
       static long pSync[SHMEM_ALLTOALL_SYNC_SIZE];
       long *source, *target;
       size_t *s_offsets, *s_sizes, *t_offsets, *t_sizes, offset;
       int  i, maxcount, pe, idx;

       shmem_init();

       maxcount  - shmem_n_pes();
       target    - (long *) shmem_malloc(maxcount * shmem_n_pes() * sizeof(long));
       source    - (long *) shmem_malloc(maxcount * shmem_n_pes() * sizeof(long));
       s_offsets - (size_t *) shmem_malloc(shmem_n_pes() * sizeof(size_t));
       s_sizes   - (size_t *) shmem_malloc(shmem_n_pes() * sizeof(size_t));
       t_offsets - (size_t *) shmem_malloc(shmem_n_pes() * sizeof(size_t));
       t_sizes   - (size_t *) shmem_malloc(shmem_n_pes() * sizeof(size_t));

       s_offsets[0] - 0;
       for (pe-0; pe <shmem_n_pes(); pe++) {

           /* set source sizes, no need to set target sizes */
           s_sizes[pe] - pe * sizeof(long);
           t_sizes[pe] - 0;

           /* calculate source offsets */
           if (pe > 0) {
              s_offsets[pe] - s_offsets[pe-1] + s_sizes[pe-1];
           }

           /* calculate target offsets */
           t_offsets[pe] - (shmem_my_pe() * sizeof(long)) * pe;
       }

       /* assign source values */
       for (idx-0,pe-0; pe<shmem_n_pes(); pe++) {
           for (i-0; i<s_sizes[pe]/sizeof(long); i++) {
               source[idx++] - shmem_my_pe();
           }
       }

       for (i-0; i < _SHMEM_ALLTOALL_SYNC_SIZE; i++) {
           pSync[i] - _SHMEM_SYNC_VALUE;
       }

       /* wait for all PEs to initialize pSync */
       shmem_barrier_all();

       /* alltoallv on all PES */
       shmemx_alltoallv(target, t_offsets, t_sizes, source,
                        s_offsets, s_sizes, 0, 0, shmem_n_pes(), pSync);

       /* verify results */
       for (pe-0; pe<shmem_n_pes(); pe++) {
           offset - t_offsets[pe] / sizeof(long);
           for (i-0; i<t_sizes[pe]/sizeof(long); i++) {
               if (target[offset] !- pe) {
                   printf("[%d] ERROR: target[%d]-%ld, should be %d\n",
                          shmem_my_pe(), offset, target[offset], pe);
               }
               offset++;
           }
       }

       shmem_barrier_all();
       shmem_free(s_offsets);
       shmem_free(s_sizes);
       shmem_free(t_offsets);
       shmem_free(t_sizes);
       shmem_free(target);
       shmem_free(source);

       shmem_finalize();
       return 0;
   }

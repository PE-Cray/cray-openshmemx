shmem_alltoalls
=======

::

   shmem_alltoalls is a collective routine where each PE exchanges a fixed
   amount of strided data with all other PEs in the active set.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_alltoalls32(void *dest, const void *source, ptrdiff_t dst,
                          ptrdiff_t sst, size_t nelems, int PE_start,
                          int logPE_stride, int PE_size, long *pSync);
   void shmem_alltoalls64(void *dest, const void *source, ptrdiff_t dst,
                          ptrdiff_t sst, size_t nelems, int PE_start,
                          int logPE_stride, int PE_size, long *pSync);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pSync(SHMEM_ALLTOALLS_SYNC_SIZE)
   INTEGER dst, sst, PE_start, logPE_stride, PE_size
   INTEGER nelems
   CALL SHMEM_ALLTOALLS32(dest, source, dst, sst, nelems, PE_start,
                          logPE_stride, PE_size, pSync)
   CALL SHMEM_ALLTOALLS64(dest, source, dst, sst, nelems, PE_start,
                          logPE_stride, PE_size, pSync)

Arguments
---------

::

   dest    A symmetric data object large enough to receive the combined total
           of nelems elements from each PE in the active set.
   source  A symmetric data object that contains nelems elements of data for
           each PE in the active set, ordered according to destination PE.
   dst     The stride between consecutive elements of the dest data object. The
           stride is scaled by the element size.  A value of 1 indicates
           contiguous data.  dst must be of type ptrdiff_t. When using Fortran,
           it must be a default integer value.
   sst     The stride between consecutive elements of the source data object.
           The stride is scaled by the element size. A value of 1 indicates
           contiguous data.  sst must be of type ptrdiff_t.  When using Fortran,
           it must be a default integer value.
   nelems  The number of elements to exchange for each PE. nelems must be of
           type size_t for  C/C++.  When using Fortran, it must be a default
           integer value.
   PE_start    The lowest PE number of the active set of PEs.  PE_start must be
           of type integer.  When using Fortran, it must be a default integer
           value.
   logPE_stride    The log (base 2) of the stride between consecutive PE
           numbers in the active set.  logPE_stride must be of type integer.
           When using Fortran, it must be a default integer value.
   PE_size     The number of PEs in the active set. PE_size must be of type
           integer.  When using Fortran, it must be a default integer value.
   pSync       A symmetric work array of size SHMEM_ALLTOALLS_SYNC_SIZE.
           In  C/C++, pSync must be an array of elements of type long.
           In Fortran, pSync must be an array of elements of default integer
           type. Every element of this array must be initialized with the value
           SHMEM_SYNC_VALUE before any of the PEs in the active set enter the
           routine.

Description
-----------

::

   The shmem_alltoalls routines are collective routines. Each PE in the active
   set exchanges nelems strided data elements of size 32 bits
   (for shmem_alltoalls32) or 64 bits (for shmem_alltoalls64) with all other
   PEs in the set. Both strides, dst and sst, must be greater than or equal to 1.

   Given a PE i that is the kth PE in the active set and a PE j that is the lth
   PE in the active set, PE i sends the sst*lth block of the source data object
   to the dst*kth block of the dest data object on PE j.

   As with all OpenSHMEM collective routines, these routines assume that only
   PEs in the active set call the routine.  If a PE not in the active set calls
   an OpenSHMEM collective routine, undefined behavior results.

   The values of arguments dst, sst, nelems, PE_start, logPE_stride, and PE_size
   must be equal on all PEs in the active set. The same dest and source data
   objects, and the same pSync work array must be passed to all PEs in the
   active set.

   Before any PE calls a shmem_alltoall routine, the following conditions must
   be ensured:
   1. The pSync array on all PEs in the active set is not still in use from a
   prior call to a shmem_alltoall routine.
   2. The dest data object on all PEs in the active set is ready to accept the
   shmem_alltoall data.
   Otherwise, the behavior is undefined.

   Upon return from a shmem_alltoalls routine, the following is true for
   the local PE: Its dest symmetric data object is completely updated and
   the data has been copied out of the source data object.
   The values in the pSync array are restored to the original values.

   The dest and source data objects must conform to certain typing constraints,
   which are as follows:
   |     Routine    |Data type of dest and source|
   |----------------|----------------------------|
   |shmem_alltoall64|      64 bits aligned.      |
   |shmem_alltoall32|      32 bits aligned.      |

Return Values
-------------

::

   None.

Notes
-----

::

   This routine restores pSync to its original contents.  Multiple calls to
   OpenSHMEM routines that use the same pSync array do not require that pSync
   be reinitialized after the first call.

   The user must ensure that the pSync array is not being updated by any PE in
   the active set while any of the PEs participates in processing of an
   OpenSHMEM shmem_alltoalls routine. Be careful to avoid these situations: If
   the pSync array is initialized at run time, some type of synchronization is
   needed to ensure that all PEs in the active set have initialized pSync
   before any of them enter an OpenSHMEM routine called with the pSync
   synchronization array.  A pSync array may be reused on a subsequent OpenSHMEM
   shmem_alltoalls routine only if none of the PEs in the active set are still
   processing a prior OpenSHMEM shmem_alltoalls routine call that used the same
   pSync array.  In general, this can be ensured only by doing some type of
   synchronization.

Examples
--------

C/C++ Example
-------------

::

   This example shows a shmem_alltoalls64 on two long elements among all PEs.

.. code:: bash

   #include <stdio.h>
   #include <inttypes.h>
   #include <shmem.h>

   int main(void)
   {
      static long pSync[SHMEM_ALLTOALLS_SYNC_SIZE];
      for (int i - 0; i < SHMEM_ALLTOALLS_SYNC_SIZE; i++)
         pSync[i] - SHMEM_SYNC_VALUE;

      shmem_init();
      int me - shmem_my_pe();
      int npes - shmem_n_pes();

      const int count - 2;
      const ptrdiff_t dst - 2;
      const ptrdiff_t sst - 3;
      int64_t* dest - (int64_t*) shmem_malloc(count * dst * npes * sizeof(int64_t));
      int64_t* source - (int64_t*) shmem_malloc(count * sst * npes * sizeof(int64_t));

      /* assign source values */
      for (int pe - 0; pe < npes; pe++) {
         for (int i - 0; i < count; i++) {
            source[sst * ((pe * count) + i)] - me + pe;
            dest[dst * ((pe * count) + i)] - 9999;
         }
      }
      /* wait for all PEs to update source/dest */
      shmem_barrier_all();

      /* alltoalls on all PES */
      shmem_alltoalls64(dest, source, dst, sst, count, 0, 0, npes, pSync);

      /* verify results */
      for (int pe - 0; pe < npes; pe++) {
         for (int i - 0; i < count; i++) {
            int j - dst * ((pe * count) + i);
            if (dest[j] !- pe + me) {
               printf("[%d] ERROR: dest[%d]-%" PRId64 ", should be %d\n",
                  me, j, dest[j], pe + me);
             }
          }
      }

      shmem_free(dest);
      shmem_free(source);
      shmem_finalize();
      return 0;
   }

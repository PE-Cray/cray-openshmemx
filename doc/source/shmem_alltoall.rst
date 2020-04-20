shmem_alltoall
=======

::

   shmem_alltoall is a collective routine where each PE exchanges a fixed
   amount of data with all other PEs in the active set.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_alltoall32(void *dest, const void *source, size_t nelems,
                         int PE_start, int logPE_stride, int PE_size, long *pSync);
   void shmem_alltoall64(void *dest, const void *source, size_t nelems,
                         int PE_start, int logPE_stride, int PE_size, long *pSync);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pSync(SHMEM_ALLTOALL_SYNC_SIZE)
   INTEGER PE_start, logPE_stride, PE_size, nelems
   CALL SHMEM_ALLTOALL32(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_ALLTOALL64(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)

Arguments
---------

::

   dest    A symmetric data object large enough to receive the combined total
           of nelems elements from each PE in the active set.
   source  A symmetric data object that contains nelems elements of data for
           each PE in the active set, ordered according to destination PE.
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
   pSync       A symmetric work array of size SHMEM_ALLTOALL_SYNC_SIZE.
           In  C/C++, pSync must be an array of elements of type long.
           In Fortran, pSync must be an array of elements of default integer
           type. Every element of this array must be initialized with the value
           SHMEM_SYNC_VALUE before any of the PEs in the active set enter the
           routine.

Description
-----------

::

   The shmem_alltoall routines are collective routines. Each PE in the active
   set exchanges nelems data elements of size 32 bits (for shmem_alltoall32) or
   64 bits (for shmem_alltoall64) with all other PEs in the set. The data being
   sent and received are stored in a contiguous symmetric data object. The
   total size of each PEs source object and dest object is nelems times the
   size of an element (32 bits or 64 bits) times PE_size. The source object
   contains PE_size blocks of data (the size of each block defined by nelems)
   and each block of data is sent to a different PE. Given a PE i that is the
   kth PE in the active set and a PE j that is the lth PE in the active set, PE
   i sends the lth block of its source object to the kth block of the dest
   object of PE j.

   As with all OpenSHMEM collective routines, this routine assumes that only
   PEs in the active set call the routine.  If a PE not in the active set calls
   an OpenSHMEM collective routine, the behavior is undefined.

   The values of arguments nelems, PE_start, logPE_stride, and PE_size must be
   equal on all PEs in the active set. The same dest and source data objects,
   and the same pSync work array must be passed to all PEs in the active set.

   Before any PE calls a shmem_alltoall routine, the following conditions must
   be ensured:
   1. The pSync array on all PEs in the active set is not still in use from a
   prior call to a shmem_alltoall routine.
   2. The dest data object on all PEs in the active set is ready to accept the
   shmem_alltoall data.
   Otherwise, the behavior is undefined.

   Upon return from a shmem_alltoall routine, the following is true for the
   local PE: Its dest symmetric data object is completely updated and the data
   has been copied out of the source data object. The values in the pSync array
   are restored to the original values.

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
   be reinitialized after the first call. The user must ensure that the pSync
   array is not being updated by any PE in the active set while any of the PEs
   participates in processing of an OpenSHMEM shmem_alltoall routine. Be
   careful to avoid these situations: If the pSync array is initialized at run
   time, some type of synchronization is needed to ensure that all PEs in the
   active set have initialized pSync before any of them enter an OpenSHMEM
   routine called with the pSync synchronization array.  A pSync array may be
   reused on a subsequent OpenSHMEM shmem_alltoall routine only if none of the
   PEs in the active set are still processing a prior OpenSHMEM shmem_alltoall
   routine call that used the same pSync array. In general, this can be ensured
   only by doing some type of synchronization.

Examples
--------

C/C++ Example
-------------

::

   This example shows a shmem_alltoall64 on two long elements among all PEs.

.. code:: bash

   #include <stdio.h>
   #include <inttypes.h>
   #include <shmem.h>

   int main(void)
   {
      static long pSync[SHMEM_ALLTOALL_SYNC_SIZE];
      for (int i - 0; i < SHMEM_ALLTOALL_SYNC_SIZE; i++)
         pSync[i] - SHMEM_SYNC_VALUE;

      shmem_init();
      int me - shmem_my_pe();
      int npes - shmem_n_pes();

      const int count - 2;
      int64_t* dest - (int64_t*) shmem_malloc(count * npes * sizeof(int64_t));
      int64_t* source - (int64_t*) shmem_malloc(count * npes * sizeof(int64_t));

      /* assign source values */
      for (int pe - 0; pe < npes; pe++) {
         for (int i - 0; i < count; i++) {
            source[(pe * count) + i] - me + pe;
            dest[(pe * count) + i] - 9999;
         }
      }
      /* wait for all PEs to update source/dest */
      shmem_barrier_all();

      /* alltoall on all PES */
      shmem_alltoall64(dest, source, count, 0, 0, npes, pSync);

      /* verify results */
      for (int pe - 0; pe < npes; pe++) {
         for (int i - 0; i < count; i++) {
            if (dest[(pe * count) + i] !- pe + me) {
               printf("[%d] ERROR: dest[%d]-%" PRId64 ", should be %d\n",
                  me, (pe * count) + i, dest[(pe * count) + i], pe + me);
              }
          }
      }

      shmem_free(dest);
      shmem_free(source);
      shmem_finalize();
      return 0;
   }

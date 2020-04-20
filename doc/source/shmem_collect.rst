shmem_collect
=======

::

   Concatenates blocks of data from multiple PEs to an array in every PE.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_collect32(void *dest, const void *source, size_t nelems,
                        int PE_start, int logPE_stride, int PE_size,
                        long *pSync);
   void shmem_collect64(void *dest, const void *source, size_t nelems,
                        int PE_start, int logPE_stride, int PE_size,
                        long *pSync);
   void shmem_fcollect32(void *dest, const void *source, size_t nelems,
                        int PE_start, int logPE_stride, int PE_size,
                        long *pSync);
   void shmem_fcollect64(void *dest, const void *source, size_t nelems,
                        int PE_start, int logPE_stride, int PE_size,
                        long *pSync);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER nelems
   INTEGER PE_start, logPE_stride, PE_size
   INTEGER pSync(SHMEM_COLLECT_SYNC_SIZE)
   CALL SHMEM_COLLECT4(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_COLLECT8(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_COLLECT32(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_COLLECT64(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_FCOLLECT4(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_FCOLLECT8(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_FCOLLECT32(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_FCOLLECT64(dest, source, nelems, PE_start, logPE_stride, PE_size, pSync)

Arguments
---------

::

   dest        A symmetric data object. The dest array argument must be large
               enough to accept the concatenation of the source arrays on all
               participating PEs.  The data types are as follows:
               For shmem_collect8, shmem_collect64, shmem_fcollect8, and
               shmem_fcollect64, any data type with an element size of 64 bits.
               Fortran derived types, Fortran character type, and  C/C++
               structures  are not permitted.  For shmem_collect4,
               shmem_collect32, shmem_fcollect4, and shmem_fcollect32,
               any data type with an element size of 32 bits.  Fortran
               derived types, Fortran character type, and  C/C++ structures are
               not permitted.
   source      A symmetric data object that can be of any type permissible
               for the dest argument.
   nelems      The number of elements in the source array. nelems
               must be of type size_t for C. When using Fortran, it must be
               a default integer value.
   PE_start    The lowest PE number of the active set of PEs.  PE_start must be
               of type integer.  When using Fortran, it must be a default integer
               value.
   logPE_stride    The log (base 2) of the stride between consecutive PE numbers
               in the active set. log_PE_stride must be of type integer.  When
               using Fortran, it must be a default integer value.
   PE_size     The number of PEs in the active set. PE_size must be of type
               integer.  When using Fortran, it must be a default integer value.
   pSync       A symmetric work array of size SHMEM_COLLECT_SYNC_SIZE.
               In  C/C++, pSync must be an array of elements of type `long`.
               In Fortran, pSync must be an array of elements of default integer type.
               Every element of this array must be initialized with the value
               SHMEM_SYNC_VALUE before any of the PEs in the active set
               enters shmem_broadcast.

Description
-----------

::

   OpenSHMEM collect and fcollect routines concatenate nelems 64-bit or 32-bit
   data items from the source array into the dest array, over the set of PEs
   defined by PE_start, log2PE_stride, and PE_size, in processor number order.
   The resultant dest array contains the contribution from PE PE_start
   first, then the contribution from PE PE_start + PE_stride second, and so on.
   The collected result is written to the dest array for all PEs in the active
   set.

   The fcollect routines require that nelems be the same value in all
   participating PEs, while the collect routines allow nelems to vary from PE to PE.

   As with all OpenSHMEM collective routines, each of these routines assumes that
   only PEs in the active set call the routine. If a PE not in the
   active set and calls this collective routine, the behavior is undefined.

   The values of arguments PE_start, logPE_stride, and PE_size
   must be the same value on all PEs in the active set. The same dest and source
   arrays and the same pSync work array must be passed by all PEs in the
   active set.

   Upon return from a collective routine, the following are true for the local
   PE: The dest array is updated and the source array may be safely reused.
   The values in the pSync array are restored to the original values.

Return Values
-------------

::

   None.

Notes
-----

::

   All OpenSHMEM collective routines reset the values in pSync before they
   return, so a particular pSync buffer need only be initialized the first
   time it is used.

   The user must ensure that the pSync array is not being updated on any PE
   in the active set while any of the PEs participate in processing of an
   OpenSHMEM collective routine.  Be careful to avoid these situations: If the
   pSync array is initialized at run time, some type of synchronization is
   needed to ensure that all PEs in the working set have initialized
   pSync before any of them  enter an OpenSHMEM routine called with the
   pSync synchronization array.  A pSync array can be reused on a
   subsequent OpenSHMEM collective routine only if none of the PEs in the
   active set  are still processing a  prior OpenSHMEM collective routine call
   that used the same pSync array.  In general, this may be ensured only by
   doing some type of synchronization.

   The collective routines operate on active PE sets that have a
   non-power-of-two PE_size with some performance degradation.  They operate
   with no performance degradation when nelems is a non-power-of-two value.

Examples
--------

C/C++ Example
-------------

::

   The following shmem_collect example is for  C/C++ programs:

.. code:: bash

   #include <stdio.h>
   #include <stdlib.h>
   #include <shmem.h>

   int main(void)
   {
      static long lock - 0;
      static long pSync[SHMEM_COLLECT_SYNC_SIZE];
      for (int i - 0; i < SHMEM_COLLECT_SYNC_SIZE; i++)
         pSync[i] - SHMEM_SYNC_VALUE;

      shmem_init();
      int me - shmem_my_pe();
      int npes - shmem_n_pes();
      int my_nelem - me + 1; /* linearly increasing number of elements with PE */
      int total_nelem - (npes * (npes + 1)) / 2;

      int* source - (int*) shmem_malloc(npes*sizeof(int)); /* symmetric alloc */
      int* dest - (int*) shmem_malloc(total_nelem*sizeof(int));

      for (int i - 0; i < my_nelem; i++)
         source[i] - (me * (me + 1)) / 2 + i;
      for (int i - 0; i < total_nelem; i++)
         dest[i] - -9999;

      shmem_barrier_all(); /* Wait for all PEs to update source/dest */

      shmem_collect32(dest, source, my_nelem, 0, 0, npes, pSync);

      shmem_set_lock(&lock); /* Lock prevents interleaving printfs */
      printf("%d: %d", me, dest[0]);
      for (int i - 1; i < total_nelem; i++)
         printf(", %d", dest[i]);
      printf("\n");
      shmem_clear_lock(&lock);
      shmem_finalize();
      return 0;
   }

Fortran Example
---------------

::

   The following SHMEM_COLLECT example is for Fortran programs:

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_COLLECT_SYNC_SIZE)
   DATA PSYNC /SHMEM_COLLECT_SYNC_SIZE*SHMEM_SYNC_VALUE/

   CALL SHMEM_COLLECT4(DEST, SOURCE, 64, PE_START, LOGPE_STRIDE,
   &  PE_SIZE, PSYNC)

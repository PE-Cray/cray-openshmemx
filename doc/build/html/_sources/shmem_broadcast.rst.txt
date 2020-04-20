shmem_broadcast
=======

::

   Broadcasts a block of data from one PE to one or more destination PEs.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_broadcast32(void *dest, const void *source, size_t nelems,
                          int PE_root, int PE_start, int logPE_stride,
                          int PE_size, long *pSync);
   void shmem_broadcast64(void *dest, const void *source, size_t nelems,
                          int PE_root, int PE_start, int logPE_stride,
                          int PE_size, long *pSync);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER nelems, PE_root, PE_start, logPE_stride, PE_size
   INTEGER pSync(SHMEM_BCAST_SYNC_SIZE)
   CALL SHMEM_BROADCAST4(dest, source, nelems, PE_root, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_BROADCAST8(dest, source, nelems, PE_root, PE_start, logPE_stride, PE_size, pSync)
   CALL SHMEM_BROADCAST32(dest, source, nelems, PE_root, PE_start, logPE_stride, PE_size,pSync)
   CALL SHMEM_BROADCAST64(dest, source, nelems, PE_root, PE_start, logPE_stride, PE_size,pSync)

Arguments
---------

::

   dest        A symmetric data object.
   source      A symmetric data object that can be of any data type that is
               permissible for the dest argument.
   nelems      The number of elements in source. For shmem_broadcast32 and
               shmem_broadcast4, this is the number of 32-bit halfwords. nelems
               must be of type size_t in C.  When using Fortran, it must be a
               default integer value.
   PE_root     Zero-based ordinal of the PE, with respect to the active set,
               from which the data is copied. Must be greater than or equal to
               0 and less than PE_size. PE_root must be of type integer.  When
               using Fortran, it must be a default integer value.
   PE_start    The lowest PE number of the active set of PEs.  PE_start must be
               of type integer.  When using Fortran, it must be a default
               integer value.
   logPE_stride    The log (base 2) of the stride between consecutive PE numbers
               in the active set. log_PE_stride must be of type integer.  When
               using Fortran, it must be a default integer value.
   PE_size     The number of PEs in the active set. PE_size must be of type
               integer.  When using Fortran, it must be a default integer value.
   pSync       A symmetric work array of size SHMEM_BCAST_SYNC_SIZE.
               In  C/C++, pSync must be an array of elements of type `long`.
               In Fortran, pSync must be an array of elements of default integer type.
               Every element of this array must be initialized with the value
               SHMEM_SYNC_VALUE before any of the PEs in the active set
               enters shmem_broadcast.

Description
-----------

::

   OpenSHMEM broadcast routines are collective routines.  They copy data object
   source on the processor specified by PE_root and store the values at
   dest on the other PEs specified by the triplet PE_start, logPE_stride,
   PE_size.  The data is not copied to the dest area on the root PE.

   As with all OpenSHMEM collective routines, each of these routines assumes that
   only PEs in the active set call the routine.  If a PE not in the
   active set calls an OpenSHMEM collective routine, the behavior is undefined.

   The values of arguments PE_root, PE_start, logPE_stride,
   and PE_size must be the same value on all PEs in the active set.  The same
   dest and source data objects and the same pSync work array must be
   passed by all PEs in the active set.

   Before any PE calls a broadcast routine, the following conditions must be
   ensured:
   1. The pSync array on all PEs in the active set is not still in use from a
   prior call to a broadcast routine.
   2. The dest array on all PEs in the active set is ready to accept the broadcast
   data.
   Otherwise, the behavior is undefined.

   Upon return from a broadcast routine, the following are true for the local
   PE:
   1. If the current PE is not the root PE, the dest data object is updated.
   2. The source data object may be safely reused.
   3. The values in the pSync array are restored to the original values.


   When using Fortran, dest and source must conform to certain typing
   constraints, which are as follows:
   |     Routine      |    Data type of dest and source    |
   |------------------|------------------------------------|
   |shmem_broadcast8  |Any noncharacter type that has an   |
   |shmem_broadcast64 |element size of 64 bits. No Fortran |
   |                  |derived types or C/C++ structures   |
   |                  |are allowed.                        |
   |shmem_broadcast4  |Any noncharacter type that has an   |
   |shmem_broadcast32 |element size of 32 bits. No Fortran |
   |                  |derived types or  C/C++ structures  |
   |                  |are allowed.                        |

Return Values
-------------

::

   None.

Notes
-----

::

   All OpenSHMEM broadcast routines restore pSync to its original contents.
   Multiple calls to OpenSHMEM routines that use the same pSync array do not
   require that pSync be reinitialized after the first call.

   The user must ensure that the pSync array is not being updated by any
   PE in the active set while any of the PEs participates in processing
   of an OpenSHMEM broadcast routine. Be careful to avoid these situations: If
   the pSync array is initialized at run time, before its first use, some type
   of synchronization is needed to ensure that all PEs in the active set have
   initialized pSync before any of them enter an OpenSHMEM routine called with
   the pSync synchronization array.  A pSync array may be reused on a
   subsequent OpenSHMEM broadcast routine only if none of the PEs in the
   active set are still processing a prior OpenSHMEM broadcast routine call that
   used the same pSync array. In general, this can be ensured only by doing
   some type of synchronization.

}

Examples
--------

C/C++ Example
-------------

::

   In the following examples, the call to shmem_broadcast64 copies source
   on PE 4 to dest on PEs 5, 6, and 7.

.. code:: bash

   #include <stdio.h>
   #include <stdlib.h>
   #include <shmem.h>

   int main(void)
   {
      static long pSync[SHMEM_BCAST_SYNC_SIZE];
      for (int i - 0; i < SHMEM_BCAST_SYNC_SIZE; i++)
         pSync[i] - SHMEM_SYNC_VALUE;
      static long source[4], dest[4];

      shmem_init();
      int me - shmem_my_pe();
      int npes - shmem_n_pes();

      if (me -- 0)
         for (int i - 0; i < 4; i++)
            source[i] - i;

      shmem_broadcast64(dest, source, 4, 0, 0, 0, npes, pSync);
      printf("%d: %ld, %ld, %ld, %ld\n", me, dest[0], dest[1], dest[2], dest[3]);
      shmem_finalize();
      return 0;
   }

Fortran Example
---------------

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_BCAST_SYNC_SIZE)
   INTEGER DEST, SOURCE, NLONG, PE_ROOT, PE_START,
   &   LOGPE_STRIDE, PE_SIZE, PSYNC
   COMMON /COM/ DEST, SOURCE

   DATA PSYNC /SHMEM_BCAST_SYNC_SIZE*SHMEM_SYNC_VALUE/

   CALL SHMEM_BROADCAST64(DEST, SOURCE, NLONG, 0, 4, 0, 4, PSYNC)

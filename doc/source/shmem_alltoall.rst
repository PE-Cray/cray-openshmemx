shmem_alltoall
==============

::

   Exchanges a fixed amount of contiguous data blocks between all pairs of PEs
   participating in the collective routine.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   int shmem_alltoall(shmem_team_t team, TYPE *dest, const TYPE *source,
                       size_t nelems);

::

   Where TYPE is one of the standard RMA types specified by table:5.

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_alltoall(shmem_team_t team, TYPE *dest, const TYPE *source,
                               size_t nelems);

::

   where TYPE is one of the standard RMA types corresponding to TYPENAME
   specified by table:5.

.. code:: bash

   int shmem_alltoallmem(shmem_team_t team, TYPE *dest, const TYPE *source,
                           size_t nelems);

Deprecated Synopsis
===================

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_alltoall32(void *dest, const void *source, size_t nelems,
                         int PE_start, int logPE_stride, int PE_size, long *pSync);
   void shmem_alltoall64(void *dest, const void *source, size_t nelems,
                         int PE_start, int logPE_stride, int PE_size, long *pSync);

Datatype Reference Table
========================

Table:5
-------

::

     |           TYPE          |      TYPENAME       |
     |-------------------------|---------------------|
     |   float                 |     float           |
     |   double                |     double          |
     |   long double           |     longdouble      |
     |   char                  |     char            |
     |   signed char           |     schar           |
     |   short                 |     short           |
     |   int                   |     int             |
     |   long                  |     long            |
     |   long long             |     longlong        |
     |   unsigned char         |     uchar           |
     |   unsigned short        |     ushort          |
     |   unsigned int          |     uint            |
     |   unsigned long         |     ulong           |
     |   unsigned long long    |     ulonglong       |
     |   int8_t                |     int8            |
     |   int16_t               |     int16           |
     |   int32_t               |     int32           |
     |   int64_t               |     int64           |
     |   uint8_t               |     uint8           |
     |   uint16_t              |     uint16          |
     |   uint32_t              |     uint32          |
     |   uint64_t              |     uint64          |
     |   size_t                |     size            |
     |   ptrdiff_t             |     ptrdiff         |

Arguments
=========

::

   team    A valid OpenSHMEM team handle to a team.
   dest    Symmetric address of a data object large enough to receive the
           combined total of nelems elements from each PE in the active set.
           The type of dest should match that implied in the SYNOPSIS section.
   source  Symmetric address of a data object that contains nelems elements of
           data for each PE in the active set, ordered according to
           destination PE. The type of source should match that implied in the
           SYNOPSIS section.
   nelems  The number of elements to exchange for each PE. For
           shmem_alltoallmem, elements are bytes; for shmem_alltoall{32,64},
           elements are 4 or 8 bytes, respectively.

   ---Deprecated---------------------------------------------------

   PE_start    The lowest PE number of the active set of PEs.
   logPE_stride    The log (base 2) of the stride between consecutive PE
               numbers in the active set.
   PE_size     The number of PEs in the active set.
   pSync       Symmetric address of a work array of size at least
               SHMEM_ALLTOALL_SYNC_SIZE.

Description
===========

::

   The shmem_alltoall routines are collective routines. Each PE participating
   in the operation exchanges nelems data elements with all other PEs
   participating in the operation. The size of a data element is:
       • 32 bits for shmem_alltoall32
       • 64 bits for shmem_alltoall64
       • 8 bits for shmem_alltoallmem
       • sizeof(TYPE) for alltoall routines taking typed source and dest

   The data being sent and received are stored in a contiguous symmetric
   data object. The total size of each PE’s source object and dest object is
   nelems times the size of an element times N, where N equals the number of
   PEs participating in the operation. The source object contains N blocks of
   data (where the size of each block is defined by nelems) and each block of
   data is sent to a different PE.

   The same dest and source arrays, and same value for nelems must be passed
   by all PEs that participate in the collective.

   Given a PE i that is the kth PE participating in the operation and a PE j
   that is the lth PE participating in the operation, PE i sends the lth block
   of its source object to the kth block of the dest object of PE j.

   Team-based collect routines operate over all PEs in the provided team
   argument. All PEs in the provided team must participate in the collective.
   If team compares equal to SHMEM_TEAM_INVALID or is otherwise invalid,
   the behavior is undefined.

   Active-set-based collective routines operate over all PEs in the active set
   defined by the PE_start, logPE_stride, PE_size triplet.

   As with all active-set-based collective routines, this routine assumes that
   only PEs in the active set call the routine. If a PE not in the active set
   calls an active-set-based collective routine, the behavior is undefined.
   The values of arguments PE_start, logPE_stride, and PE_size must be equal
   on all PEs in the active set.

   The same pSync work array must be passed to all PEs in the active set.

   Before any PE calls a shmem_alltoall routine, the following conditions
   must be ensured:
       • The dest data object on all PEs in the active set is ready to accept
           the shmem_alltoall data.
       • For active-set-based routines, the pSync array on all PEs in the
           active set is not still in use from a prior call to a
           shmem_alltoall routine.
   Otherwise, the behavior is undefined.

   Upon return from a shmem_alltoall routine, the following is true for the
   local PE:
       • Its dest symmetric data object is completely updated and the data has
           been copied out of the source data object.
       • For active-set-based routines, the values in the pSync array are
           restored to the original values.

Return Values
=============

::

   Zero on successful local completion. Nonzero otherwise.

Examples
========

C/C++ Example
-------------

::

   This example shows a shmem_int64_alltoall on two 64-bit integers among
   all PEs.

.. code:: bash

   #include <inttypes.h>
   #include <shmem.h>
   #include <stdio.h>

   int main(void)
   {
      shmem_init();
      int mype = shmem_my_pe();
      int npes = shmem_n_pes();

      const int count = 2;
      int64_t* dest = (int64_t*) shmem_malloc(count * npes * sizeof(int64_t));
      int64_t* source = (int64_t*) shmem_malloc(count * npes * sizeof(int64_t));

      /* assign source values */
      for (int pe = 0; pe < npes; pe++) {
         for (int i = 0; i < count; i++) {
            source[(pe * count) + i] = mype + pe;
            dest[(pe * count) + i] = 9999;
         }
      }

      /* wait for all PEs to update source/dest */
      shmem_team_sync(SHMEM_TEAM_WORLD);

      /* alltoall on all PES */
      shmem_int64_alltoall(SHMEM_TEAM_WORLD, dest, source, count);

      /* verify results */
      for (int pe = 0; pe < npes; pe++) {
         for (int i = 0; i < count; i++) {
            if (dest[(pe * count) + i] != pe + mype) {
               printf("[%d] ERROR: dest[%d]=%" PRId64 ", should be %d\n",
                  mype, (pe * count) + i, dest[(pe * count) + i], pe + mype);
              }
          }
      }

      shmem_free(dest);
      shmem_free(source);
      shmem_finalize();
      return 0;
   }

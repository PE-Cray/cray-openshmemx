shmem_alltoalls
===============

::

   Exchanges a fixed amount of strided data blocks between all pairs of PEs
   participating in the collective routine.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   int shmem_alltoalls(shmem_team_t team, TYPE *dest, const TYPE *source,
                       ptrdiff_t dst, ptrdiff_t sst, size_t nelems);

::

       where TYPE is one of the standard RMA types specified by Table:5.

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_alltoalls(shmem_team_t team, TYPE *dest, const TYPE *source, ptrdiff_t
                               dst, ptrdiff_t sst, size_t nelems);

::

   where TYPE is one of the standard RMA types and has a corresponding TYPENAME
   specified by Table:5.

.. code:: bash

   int shmem_alltoallsmem(shmem_team_t team, void *dest, const void *source, ptrdiff_t dst,
                           ptrdiff_t sst, size_t nelems);

Deprecated Synopsis
===================

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_alltoalls32(void *dest, const void *source, ptrdiff_t dst,
                          ptrdiff_t sst, size_t nelems, int PE_start,
                          int logPE_stride, int PE_size, long *pSync);
   void shmem_alltoalls64(void *dest, const void *source, ptrdiff_t dst,
                          ptrdiff_t sst, size_t nelems, int PE_start,
                          int logPE_stride, int PE_size, long *pSync);

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

   team    A valid OpenSHMEM team handle
   dest    Symmetric address of a data object large enough to receive the
           combined total of nelems elements from each PE in the active set.
           The type of dest should match that implied in the SYNOPSIS section.
   source  Symmetric address of a data object that contains nelems elements of
           data for each PE in the active set, ordered according to
           destination PE. The type of source should match that implied in the
           SYNOPSIS section.
   dst     The stride between consecutive elements of the dest data object. The
           stride is scaled by the element size. A value of 1 indicates
           contiguous data.
   sst     The stride between consecutive elements of the source data object.
           The stride is scaled by the element size. A value of 1 indicates
           contiguous data.
   nelems  The number of elements to exchange for each PE. For
           shmem_alltoallsmem, elements are bytes; for shmem_alltoalls{32,64},
           elements are 4 or 8 bytes, respectively.

   ---Deprecated---------------------------------------------------

   PE_start    The lowest PE number of the active set of PEs.
   logPE_stride    The log (base 2) of the stride between consecutive PE
           numbers in the active set.
   PE_size     The number of PEs in the active set.
   pSync       Symmetric address of a work array of size at least
               SHMEM_ALLTOALLS_SYNC_SIZE.

Description
===========

::

   The shmem_alltoalls routines are collective routines. These routines are
   equivalent in functionality to the corresponding shmem_alltoall routines
   except that they add explicit stride values for accessing the source and
   destination data arrays, whereas the array access in shmem_alltoall is
   always with a stride of 1.

   Each PE participating in the operation exchanges nelems strided data
   elements with all other PEs participating in the operation. Both strides,
   dst and sst, must be greater than or equal to 1.

   The same dest and source arrays and same values for values of arguments dst,
   sst, nelems must be passed by all PEs that participate in the collective.

   Given a PE i that is the kth PE participating in the operation and a PE j
   that is the lth PE participating in the operation PE i sends the sst*lth
   block of the source data object to the dst*kth block of the dest data
   object on PE j.

   See the description of shmem_alltoall for:
       • Data element sizes for the different sized and typed shmem_alltoalls
           variants.
       • Rules for PE participation in the collective routine.
       • The pre- and post-conditions for symmetric objects.
       • Typing constraints for dest and source data objects.

Return Values
=============

::

   Zero on successful local completion. Nonzero otherwise.

Examples
========

C/C++ Example
-------------

::

   This example shows a shmem_int64_alltoalls on two 64-bit integers among
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
      const ptrdiff_t dst = 2;
      const ptrdiff_t sst = 3;
      int64_t *dest = (int64_t *)shmem_malloc(count * dst * npes * sizeof(int64_t));
      int64_t *source = (int64_t *)shmem_malloc(count * sst * npes * sizeof(int64_t));

      /* assign source values */
      for (int pe = 0; pe < npes; pe++) {
         for (int i = 0; i < count; i++) {
            source[sst * ((pe * count) + i)] = mype + pe;
            dest[dst * ((pe * count) + i)] = 9999;
         }
      }
      /* wait for all PEs to update source/dest */
       shmem_team_sync(SHMEM_TEAM_WORLD);

      /* alltoalls on all PES */
       shmem_int64_alltoalls(SHMEM_TEAM_WORLD, dest, source, dst, sst, count);

      /* verify results */
      for (int pe = 0; pe < npes; pe++) {
         for (int i = 0; i < count; i++) {
            int j = dst * ((pe * count) + i);
            if (dest[j] != pe + mype) {
               printf("[%d] ERROR: dest[%d]=%" PRId64 ", should be %d\n",
                  mype, j, dest[j], pe + mype);
             }
          }
      }

      shmem_free(dest);
      shmem_free(source);
      shmem_finalize();
      return 0;
   }

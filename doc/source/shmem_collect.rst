shmem_collect
=============

::

   Concatenates blocks of data from multiple PEs to an array in every PE
   participating in the collective routine.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   int shmem_collect(shmem_team_t team, TYPE *dest, const TYPE *source,
                       size_t nelems);
   int shmem_fcollect(shmem_team_t team, TYPE *dest, const TYPE *source,
                       size_t nelems);

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_collect(shmem_team_t team, TYPE *dest, const TYPE *source,
                               size_t nelems);
   int shmem_TYPENAME_fcollect(shmem_team_t team, TYPE *dest, const TYPE *source,
                               size_t nelems);

::

   where TYPE is one of the standard RMA types and has a corresponding TYPENAME
   specified by Table:5.

.. code:: bash

   int shmem_collectmem(shmem_team_t team, void *dest, const void *source,
                           size_t nelems);
   int shmem_fcollectmem(shmem_team_t team, void *dest, const void *source,
                           size_t nelems);

Deprecated Synopsis
===================

Deprecated C/C++ Synopsis
-------------------------

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

   team        A valid OpenSHMEM team handle
   dest        Symmetric address of an array large enough to accept the
               concatenation of the source arrays on all participating PEs.
               The type of dest should match that implied in the
               SYNOPSIS section.
   source      Symmetric address of the source data object. The type of source
               should match that implied in the SYNOPSIS section.
   nelems      The number of elements in source array. For shmem_[f]collectmem,
               elements are bytes; for shmem_[f]collect{32,64},
               elements are 4 or 8 bytes, respectively.

   ---Deprecated---------------------------------------------------

   PE_start    The lowest PE number of the active set of PEs.
   logPE_stride    The log (base 2) of the stride between consecutive PE
               numbers in the active set.
   PE_size     The number of PEs in the active set.
   pSync       Symmetric address of a work array of size at least
               SHMEM_COLLECT_SYNC_SIZE.

Description
===========

::

   OpenSHMEM collect and fcollect routines perform a collective operation to
   concatenate nelems data items from the source array into the dest array,
   over an OpenSHMEM team or active set in processor number order.
   The resultant dest array contains the contribution from PEs as follows:
       • For an active set, the data from PE PE_start is first, then the
           contribution from PE PE_start + PE_stride second, and so on.
       • For a team, the data from PE number 0 in the team is first, then the
           contribution from PE 1 in the team, and so on.

   The collected result is written to the dest array for all PEs that
   participate in the operation. The same dest and source arrays must be passed
   by all PEs that participate in the operation.

   The fcollect routines require that nelems be the same value in all
   participating PEs, while the collect routines allow nelems to vary from PE
   to PE.

   Team-based collect routines operate over all PEs in the provided team
   argument. All PEs in the provided team must participate in the operation.
   If team compares equal to SHMEM_TEAM_INVALID or is otherwise invalid, the
   behavior is undefined.

   Active-set-based collective routines operate over all PEs in the active set
   defined by the PE_start, logPE_stride, PE_size triplet. As with all
   active-set-based collective routines, each of these routines assumes that
   only PEs in the active set call the routine. If a PE not in the active set
   and calls this collective routine, the behavior is undefined.

   The values of arguments PE_start, logPE_stride, and PE_size must be the same
   value on all PEs in the active set. The same pSync work array must be passed
   by all PEs in the active set.

   Upon return from a collective routine, the following are true for the
   local PE:
       • The dest array is updated and the source array may be safely reused.
       • For active-set-based collective routines, the values in the pSync
           array are restored to the original values

Return Values
=============

::

   Zero on successful local completion. Nonzero otherwise.

Notes
=====

::

   The collective routines operate on active PE sets that have a
   non-power-of-two PE_size with some performance degradation. They operate
   with no performance degradation when nelems is a non-power-of-two value.

Examples
========

C/C++ Example
-------------

::

   The following shmem_collect example is for  C/C++ programs:

.. code:: bash

   #include <shmem.h>
   #include <stdio.h>
   #include <stdlib.h>

   int main(void)
   {
       static long lock = 0;

       shmem_init();
       int mype = shmem_my_pe();
       int npes = shmem_n_pes();
       int my_nelem = mype + 1; /* linearly increasing number of elements with PE */
       int total_nelem = (npes * (npes + 1)) / 2;

       int *source = (int *) shmem_malloc(npes * sizeof(int)); /* symmetric alloc */
       int *dest = (int *) shmem_malloc(total_nelem * sizeof(int));

       for (int i = 0; i < my_nelem; i++)
           source[i] = (mype * (mype + 1)) / 2 + i;
       for (int i = 0; i < total_nelem; i++)
           dest[i] = -9999;

       /* Wait for all PEs to initialize source/dest: */
       shmem_team_sync(SHMEM_TEAM_WORLD);

       shmem_int_collect(SHMEM_TEAM_WORLD, dest, source, my_nelem);

       shmem_set_lock(&lock); /* Lock prevents interleaving printfs */
       printf("%d: %d", mype, dest[0]);
       for (int i = 1; i < total_nelem; i++)
           printf(", %d", dest[i]);
       printf("\n");
       shmem_clear_lock(&lock);
       shmem_finalize();
       return 0;
   }

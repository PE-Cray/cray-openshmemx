shmem_broadcast
===============

   Broadcasts a block of data from one PE to one or more destination PEs.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   int shmem_broadcast(shmem_team_t team, TYPE *dest, const TYPE *source,
                       size_t nelems, int PE_root);

   where TYPE is one of the standard RMA types specified by Table:5.

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_broadcast(shmem_team_t team, TYPE *dest, const TYPE *source,
                                   size_t nelems, int PE_root);

   where TYPE is one of the standard RMA types and has a corresponding TYPENAME
   specified by Table:5.

.. code:: bash

   int shmem_broadcastmem(shmem_team_t team, void *dest, const void *source,
                           size_t nelems, int PE_root);

Deprecated Synopsis
===================

Depricated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_broadcast32(void *dest, const void *source, size_t nelems,
                          int PE_root, int PE_start, int logPE_stride,
                          int PE_size, long *pSync);
   void shmem_broadcast64(void *dest, const void *source, size_t nelems,
                          int PE_root, int PE_start, int logPE_stride,
                          int PE_size, long *pSync);

Datatype Reference Table
========================

Table:5
-------

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

   team    A valid OpenSHMEM team handle to a team.
   dest    Symmetric address of destination data object. The type of dest
           should match that implied in the SYNOPSIS section.
   source  Symmetric address of the source data object. The type of source
           should match that implied in the SYNOPSIS section
   nelems  The number of elements in source and dest arrays.
           For shmem_broadcastmem, elements are bytes; for
           shmem_broadcast{32,64}, elements are 4 or 8 bytes, respectively.
   PE_root Zero-based ordinal of the PE, with respect to the team or
           active set, from which the data is copied.

   ---Deprecated---------------------------------------------------

   PE_start    The lowest PE number of the active set of PEs.
   logPE_stride    The log (base 2) of the stride between consecutive PE
               numbers in the active set.
   PE_size     The number of PEs in the active set.
   pSync       Symmetric address of a work array of size at least
               SHMEM_ALLTOALL_SYNC_SIZE.

Description
===========

   OpenSHMEM broadcast routines are collective routines over an active set or
   valid OpenSHMEM team. They copy the source data object on the PE specified
   by PE_root to the dest data object on the PEs participating in the
   collective operation. The same dest and source data objects and the same
   value of PE_root must be passed by all PEs participating in the collective
   operation.

   For team-based broadcasts:
       • The dest object is updated on all PEs.
       • All PEs in the team argument must participate in the operation.
       • If team compares equal to SHMEM_TEAM_INVALID or is otherwise invalid,
           the behavior is undefined.
       • PE numbering is relative to the team. The specified root PE must be a
           valid PE number for the team, between 0 and N−1, where N is the size
           of the team.

   For active-set-based broadcasts:
       • The dest object is updated on all PEs other than the root PE.
       • All PEs in the active set defined by the PE_start, logPE_stride,
           PE_size triplet must participate in the operation.
       • Only PEs in the active set may call the routine. If a PE not in the
           active set calls an active-set-based collective routine, the
           behavior is undefined.
       • The values of arguments PE_root, PE_start, logPE_stride, and PE_size
           must be the same value on all PEs in the active set.
       • The value of PE_root must be between 0 and PE_size − 1.
       • The same pSync work array must be passed by all PEs in the active set.

   Before any PE calls a broadcast routine, the following conditions must
   be ensured:
       • The dest array on all PEs participating in the broadcast is ready to
           accept the broadcast data.
       • For active-set-based broadcasts, the pSync array on all PEs in the
           active set is not still in use from a prior call to an OpenSHMEM
           collective routine.
   Otherwise, the behavior is undefined.

   Upon return from a broadcast routine, the following are true for the
   local PE:
       • For team-based broadcasts, the dest data object is updated.
       • For active-set-based broadcasts:
           – If the current PE is not the root PE, the dest data object is
               updated.
           – The values in the pSync array are restored to the original values.
       • The source data object may be safely reused.

Return Values
=============

   For team-based broadcasts, zero on successful local completion;
   otherwise, nonzero.

   For active-set-based broadcasts, none.

Notes
=====

   Team handle error checking and integer return codes are currently undefined.
   Implementations may define these behaviors as needed, but programs should
   ensure portability by doing their own checks for invalid team handles and
   for SHMEM_TEAM_INVALID.

Examples
========

C11 Example
-----------

   In the following examples, the call to shmem_broadcast copies source on
   PE 0 to dest on PEs 0...npes−1.

.. code:: bash

   #include <shmem.h>
   #include <stdio.h>
   #include <stdlib.h>

   int main(void)
   {
      static long source[4], dest[4];

      shmem_init();
      int mype = shmem_my_pe();
      int npes = shmem_n_pes();

      if (mype == 0)
         for (int i = 0; i < 4; i++)
            source[i] = i;

       shmem_broadcast(SHMEM_TEAM_WORLD, dest, source, 4, 0);
       printf("%d: %ld, %ld, %ld, %ld\n", mype, dest[0], dest[1], dest[2], dest[3]);
       shmem_finalize();
       return 0;
   }

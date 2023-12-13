shmem_wait_until_all
====================

   Wait on an array of variables on the local PE until all variables meet the
   specified wait condition.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_wait_until_all(TYPE *ivars, size_t nelems, const int *status,
                   int cmp, TYPE cmp_value);

where TYPE is one of the point-to-point synchronization types specified
by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_wait_until_all(TYPE *ivars, size_t nelems, const int *status,
                   int cmp, TYPE cmp_value);

where TYPE is one of the point-to-point synchronization types and has a
corresponding TYPENAME specified by Table:1

Datatype Reference Table
========================

Table:1
-------

     |           TYPE          |      TYPENAME       |
     |-------------------------|---------------------|
     |   short                 |     short           |
     |   int                   |     int             |
     |   long                  |     long            |
     |   long long             |     longlong        |
     |   unsigned short        |     ushort          |
     |   unsigned int          |     uint            |
     |   unsigned long         |     ulong           |
     |   unsigned long long    |     ulonglong       |
     |   int32_t               |     int32           |
     |   int64_t               |     int64           |
     |   uint32_t              |     uint32          |
     |   uint64_t              |     uint64          |
     |   size_t                |     size            |
     |   ptrdiff_t             |     ptrdiff         |

Arguments
=========

   ivars       Local address of an array of remotely accessible data objects.
               The type of ivars should match that implied in the SYNOPSIS
               section.
   nelems      The number of elements in the ivars array.
   status      Local address of an optional mask array of length nelems that
               indicates which elements in ivars are excluded from the wait set.
   cmp         A comparison operator from Table 12 that compares elements of
               ivars with cmp_value.
   cmp_value   The value to be compared with the objects pointed to by ivars.
               The type of cmp_value should match that implied in the SYNOPSIS
               section.

Description
===========

   The shmem_wait_until_all routine waits until all entries in the wait set
   specified by ivars and status have satisfied the wait condition at the
   calling PE. The ivars objects at the calling PE may be updated by an AMO
   performed by a thread located within the calling PE or within another PE.
   If nelems is 0, the wait set is empty and this routine returns immediately.
   This routine compares each element of the ivars array in the wait set with
   the value cmp_value according to the comparison operator cmp at the calling
   PE. This routine is semantically similar to shmem_wait_until in Section
   9.10.1, but adds support for point-to-point synchronization involving an
   array of symmetric data objects.

   The optional status is a mask array of length nelems where each element
   corresponds to the respective element in ivars and indicates whether the
   element is excluded from the wait set. Elements of status set to 0 will be
   included in the wait set, and elements set to 1 will be ignored. If all
   elements in status are set to 1 or nelems is 0, the wait set is empty and
   this routine returns immediately. If status is a null pointer, it is
   ignored and all elements in ivars are included in the wait set. The ivars
   and status arrays must not overlap in memory.

   Implementations must ensure that shmem_wait_until_all does not return before
   the update of the memory indicated by ivars is fully complete.

Return Values
=============

   None.

Notes
=====

   None.

Examples
========

C/C++ Example
-------------

The following C11 example demonstrates the use of shmem_wait_until_all
to implement a simple linear barrier synchronization.

.. code:: bash

   #include <shmem.h>

   int main(void) {
     shmem_init();
     int mype = shmem_my_pe();
     int npes = shmem_n_pes();

     int *flags = shmem_calloc(npes, sizeof(int));
     int *status = NULL;

     for (int i = 0; i < npes; i++)
       shmem_atomic_set(&flags[mype], 1, i);

     shmem_wait_until_all(flags, npes, status, SHMEM_CMP_EQ, 1);

     shmem_free(flags);
     shmem_finalize();
     return 0;
   }

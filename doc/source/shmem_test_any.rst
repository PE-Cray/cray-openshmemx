shmem_test_any
==============

::

   Indicate whether any one variable within an array of variables on the local
   PE meets a specified test condition.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   size_t shmem_test_any(TYPE *ivars, size_t nelems, const int *status, int cmp,
                         TYPE cmp_value);

where TYPE is one of the point-to-point synchronization types specified
by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   size_t shmem_TYPENAME_test_any(TYPE *ivars, size_t nelems, const int *status,
                         int cmp, TYPE cmp_value);

where TYPE is one of the point-to-point synchronization types and has a
corresponding TYPENAME specified by Table:1

Datatype Reference Table
========================

Table:1
-------

::

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

::

   ivars       Local address of an array of remotely accessible data objects.
               The type of ivars should match that implied in the SYNOPSIS
               section.
   nelems      The number of elements in the ivars array.
   status      Local address of an optional mask array of length nelems that
               indicates which elements in ivars are excluded from the test set.
   cmp         A comparison operator from Table 12 that compares elements of
               ivars with cmp_value.
   cmp_value   The value to be compared with the objects pointed to by ivars.
               The type of cmp_value should match that implied in the SYNOPSIS
               section.

Description
===========

::

   The shmem_test_any routine indicates whether any entry in the test set
   specified by ivars and status has satisfied the test condition at the
   calling PE. The ivars objects at the calling PE may be updated by an AMO
   performed by a thread located within the calling PE or within another PE.
   This routine does not block and returns SIZE_MAX if no entries in ivars
   satisfied the test condition. This routine compares each element of the
   ivars array in the test set with the value cmp_value according to the
   comparison operator cmp at the calling PE. The order in which these
   elements are tested is unspecified. If an entry i in ivars within the test
   set satisfies the test condition, a series of calls to shmem_test_any must
   eventually return i. The optional status is a mask array of length nelems
   where each element corresponds to the respective element in ivars and
   indicates whether the element is excluded from the test set. Elements of
   status set to 0 will be included in the test set, and elements set to 1
   will be ignored. If all elements in status are set to 1 or nelems is 0, the
   test set is empty and this routine returns SIZE_MAX. If status is a null
   pointer, it is ignored and all elements in ivars are included in the test
   set. The ivars and status arrays must not overlap in memory.

   Implementations must ensure that shmem_test_any does not return an index
   before the update of the memory indicated by the corresponding ivars
   element is fully complete.

Return Values
=============

::

   shmem_test_any returns the index of an element in the ivars array that
   satisfies the test condition. If the test set is empty or no conditions in
   the test set are satisfied, this routine returns SIZE_MAX.

Notes
=====

::

   None.

Examples
========

C/C++ Example
-------------

The following C11 example demonstrates the use of shmem_test_any to
implement a simple linear barrier synchronization while potentially
overlapping communication with computation.

.. code:: bash

   #include <shmem.h>
   #include <stdlib.h>

   int main(void) {
     shmem_init();
     int mype = shmem_my_pe();
     int npes = shmem_n_pes();

     int *flags = shmem_calloc(npes, sizeof(int));
     int *status = calloc(npes, sizeof(int));

     for (int i = 0; i < npes; i++)
       shmem_atomic_set(&flags[mype], 1, i);

     int ncompleted = 0;
     size_t completed_idx;

     while (ncompleted < npes) {
       completed_idx = shmem_test_any(flags, npes, status, SHMEM_CMP_EQ, 1);
       if (completed_idx != SIZE_MAX) {
         ncompleted++;
         status[completed_idx] = 1;
       }
       else {
         /* Overlap some computation here */
       }
     }

     free(status);
     shmem_free(flags);
     shmem_finalize();
     return 0;
   }

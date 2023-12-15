shmem_test_all
==============

::

   Indicate whether all variables within an array of variables on the local PE
   meet a specified test condition.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   int shmem_test_all(TYPE *ivars, size_t nelems, const int *status, int cmp,
                   TYPE cmp_value);

where TYPE is one of the point-to-point synchronization types specified
by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_test_all(TYPE *ivars, size_t nelems, const int *status,
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

   The shmem_test_all routine indicates whether all entries in the test set
   specified by ivars and status have satisfied the test condition at the
   calling PE. The ivars objects at the calling PE may be updated by an AMO
   performed by a thread located within the calling PE or within another PE.
   This routine does not block and returns zero if not all entries in ivars
   satisfied the test condition. This routine compares each element of the
   ivars array in the test set with the value cmp_value according to the
   comparison operator cmp at the calling PE.

   If nelems is 0, the test set is empty and this routine returns 1.

   The optional status is a mask array of length nelems where each element
   corresponds to the respective element in ivars and indicates whether the
   element is excluded from the test set. Elements of status set to 0 will be
   included in the test set, and elements set to 1 will be ignored. If all
   elements in status are set to 1 or nelems is 0, the test set is empty and
   this routine returns 0. If status is a null pointer, it is ignored and all
   elements in ivars are included in the test set. The ivars, indices, and
   status arrays must not overlap in memory.

   Implementations must ensure that shmem_test_all does not return 1 before
   the update of the memory indicated by ivars is fully complete.

Return Values
=============

::

   shmem_test_all returns 1 if all variables in ivars satisfy the test
   condition or if nelems is 0, otherwise this routine returns 0.

Notes
=====

::

   None.

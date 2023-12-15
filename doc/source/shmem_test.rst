shmem_test
==========

Test whether a variable on the local PE has changed.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   int shmem_test(TYPE *ivar, int cmp, TYPE cmp_value);

where TYPE is one of the point-to-point synchronization types specified
by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_test(TYPE *ivar, int cmp, TYPE cmp_value);

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

   ivar        A pointer to a remotely accessible data object.
   cmp         The comparison operator that compares ivar with cmp_value.
   cmp_value   The value against which the object pointed to by ivar will be
               compared.

Description
===========

::

   shmem_test tests the numeric comparison of the symmetric object pointed to
   by ivar with the value cmp_value according to the comparison operator cmp.

Return Values
=============

::

   shmem_test returns 1 if the comparison of the symmetric object pointed to by
   ivar with the value cmp_value according to the comparison operator cmp
   evalutes to true; otherwise, it returns 0.

Notes
=====

::

   None.

Examples
========

C/C++ Example
-------------

::

   The following example demonstrates the use of shmem_test to wait on an array
   of symmetric objects and return the index of an element that satisfies the
   specified condition.

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int user_wait_any(long *ivar, int count, int cmp, long value)
   {
     int idx = 0;
     while (!shmem_test(&ivar[idx], cmp, value))
       idx = (idx + 1) % count;
     return idx;
   }

   int main(void)
   {
     shmem_init();
     const int mype = shmem_my_pe();
     const int npes = shmem_n_pes();

     long *wait_vars = shmem_calloc(npes, sizeof(long));
     if (mype == 0)
     {
       int who = user_wait_any(wait_vars, npes, SHMEM_CMP_NE, 0);
       printf("PE %d observed first update from PE %d\n", mype, who);
     }
     else
       shmem_p(&wait_vars[mype], mype, 0);

     shmem_free(wait_vars);
     shmem_finalize();
     return 0;
   }

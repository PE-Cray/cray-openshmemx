shmem_g
=======

::

   Copies one data item from a remote PE

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   TYPE shmem_g(const TYPE *source, int pe);
   TYPE shmem_g(shmem_ctx_t ctx, const TYPE *source, int pe);

where TYPE is one of the standard RMA types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   TYPE shmem_TYPENAME_g(const TYPE *source, int pe);
   TYPE shmem_ctx_TYPENAME_g(shmem_ctx_t ctx, const TYPE *source, int pe);

where TYPE is one of the standard RMA types and has a corresponding
TYPENAME specified by Table:1

Datatype Reference Table
========================

Table:1
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

   ctx   The context on which to perform the operation. When this argument is
         not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   source  The remotely accessible array element or scalar data object.
   pe    The number of the remote PE on which source resides.

Description
===========

These routines provide a very low latency get capability for single
elements of most basic types.

Return Values
=============

::

   Returns a single element of type specified in the synopsis.

Notes
=====

::

   None.

Examples
========

C/C++ Example
-------------

::

   The following shmem_g example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      long y = -1;
      static long x = 10101;
      shmem_init();
      int me = shmem_my_pe();
      int npes = shmem_n_pes();
      if (me == 0)
         y = shmem_g(&x, npes-1);
      printf("%d: y = %ld\n", me, y);
      shmem_finalize();
      return 0;
   }

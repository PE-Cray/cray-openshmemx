shmem_p
=======

::

   Copies one data item to a remote PE.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_p(TYPE *dest, TYPE value, int pe);
   void shmem_p(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the standard RMA types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_p(TYPE *dest, TYPE value, int pe);
   void shmem_ctx_TYPENAME_p(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

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
   dest  The remotely accessible array element or scalar data object
         which will receive the data on the remote PE.
   value The value to be transferred to dest on the remote PE.
   pe    The number of the remote PE.

Description
===========

::

   These routines provide a very low latency put capability for single elements
   of most basic types.

   As with shmem_put, these routines start the remote transfer and may return
   before the data is delivered to the remote PE.  Use shmem_quiet to force
   completion of all remote PUT transfers.

Return Values
=============

::

   None.

Notes
=====

::

   None.

Examples
========

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <math.h>
   #include <shmem.h>

   int main(void)
   {
      const double e = 2.71828182;
      const double epsilon = 0.00000001;
      static double f = 3.1415927;
      shmem_init();
      int me = shmem_my_pe();
      if (me == 0)
         shmem_p(&f, e, 1);
      shmem_barrier_all();
      if (me == 1)
         printf("%s\n", (fabs(f - e) < epsilon) ? "OK" : "FAIL");
      shmem_finalize();
      return 0;
   }

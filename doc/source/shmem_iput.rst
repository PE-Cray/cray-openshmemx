shmem_iput
==========

::

   Copies strided data to a specified PE.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_iput(TYPE *dest, const TYPE *source, ptrdiff_t dst, ptrdiff_t sst,
                   size_t nelems, int pe);
   void shmem_iput(shmem_ctx_t ctx, TYPE *dest, const TYPE *source, ptrdiff_t dst,
                   ptrdiff_t sst, size_t nelems, int pe);

where TYPE is one of the standard RMA types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_iput(TYPE *dest, const TYPE *source, ptrdiff_t dst,
                            ptrdiff_t sst, size_t nelems, int pe);
   void shmem_ctx_TYPENAME_iput(shmem_ctx_t ctx, TYPE *dest, const TYPE *source,
                                ptrdiff_t dst, ptrdiff_t sst, size_t nelems, int pe);

where TYPE is one of the standard RMA types and has a corresponding
TYPENAME specified by Table:1

.. code:: bash

   void shmem_iputSIZE(void *dest, const void *source, ptrdiff_t dst,
                       ptrdiff_t sst, size_t nelems, int pe);
   void shmem_ctx_iputSIZE(shmem_ctx_t ctx, void *dest, const void *source,
                           ptrdiff_t dst, ptrdiff_t sst, size_t nelems, int pe);

where SIZE is one of 8, 16, 32, 64, 128.

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER dst, sst, nelems, pe
   CALL SHMEM_COMPLEX_IPUT(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_DOUBLE_IPUT(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_INTEGER_IPUT(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IPUT4(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IPUT8(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IPUT32(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IPUT64(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IPUT128(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_LOGICAL_IPUT(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_REAL_IPUT(dest, source, dst, sst, nelems, pe)

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

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   dest    Array to be updated on the remote PE. This data object  must be
           remotely accessible.
   source  Array containing the data to be copied.
   dst     The stride between consecutive elements of the dest array. The stride
           is scaled by the element size of the dest array. A value of 1
           indicates contiguous data. dst must be of type ptrdiff_t. When using
           Fortran,  it  must be a default integer value.
   sst     The stride between consecutive elements of the source array. The
           stride is scaled by the element size of the source array.  A  value
           of 1 indicates contiguous data.  sst must be of type ptrdiff_t. When
           using  Fortran,  it  must be a default integer value.
   nelems  Number of elements in the dest and source arrays.  nelems must be of
           type size_t for C. When using Fortran, it must be  a constant, variable,
           or array element of default integer type.
   pe      PE number of the remote PE.  pe must be of type integer. When using
           Fortran, it must be a constant, variable, or array element of default
           integer type.

Description
===========

::

   The iput routines provide a method  for  copying strided data elements
   (specified by sst) of an array from a source array on the local PE to
   locations specified by stride dst on a dest array on specified remote PE.
   Both strides, dst and sst, must be greater than or equal to 1. The routines
   return when the data has been copied out of the source array on the local PE
   but not necessarily before the data has been delivered to the remote data object.

   When using Fortran, dest and source must conform to certain typing
   constraints, which are as follows:
   |     Routine       |    Data type of dest and source           |
   |-------------------|-------------------------------------------|
   |shmem_iput4,       |Any noncharacter type that has a           |
   |shmem_iput32       |storage size equal to 32 bits.             |
   |shmem_iput8        |C: Any noncharacter type that has a        |
   |                   |storage size equal to 8 bits.              |
   |                   |Fortran: Any noncharacter type that        |
   |                   |has a storage size equal to 64 bits.       |
   |shmem_iput64       |Any noncharacter type that has a           |
   |                   |storage size equal to 64 bits.             |
   |shmem_iput128      |Any noncharacter type that has a           |
   |                   |storage size equal to 128 bits.            |
   |SHMEM_COMPLEX_IPUT |Elements of type complex of default size.  |
   |SHMEM_DOUBLE_IPUT  |Fortran: Elements of type double precision.|
   |SHMEM_INTEGER_IPUT |Elements of type integer.                  |
   |SHMEM_LOGICAL_IPUT |Elements of type logical.                  |
   |SHMEM_REAL_IPUT    |Elements of type real.                     |

Return Values
=============

::

   None.

Notes
=====

::

   When using Fortran, data types must be of default size.  For example, a
   real variable must be declared as  REAL, REAL*4 or
   REAL(KIND=KIND(1.0)).

Examples
========

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      short source[10] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
      static short dest[10];
      shmem_init();
      int me = shmem_my_pe();
      if (me == 0) /* put 5 elements into dest on PE 1 */
         shmem_iput(dest, source, 1, 2, 5, 1);
      shmem_barrier_all(); /* sync sender and receiver */
      if (me == 1) {
         printf("dest on PE %d is %hd %hd %hd %hd %hd\n", me,
            dest[0], dest[1], dest[2], dest[3], dest[4]);
      }
      shmem_finalize();
      return 0;
   }

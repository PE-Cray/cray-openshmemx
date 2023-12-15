shmem_iget
==========

::

   Copies strided data from a specified PE.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_iget(TYPE *dest, const TYPE *source, ptrdiff_t dst, ptrdiff_t sst,
                   size_t nelems, int pe);
   void shmem_iget(shmem_ctx_t ctx, TYPE *dest, const TYPE *source, ptrdiff_t dst,
                   ptrdiff_t sst, size_t nelems, int pe);

where TYPE is one of the standard RMA types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_iget(TYPE *dest, const TYPE *source, ptrdiff_t dst,
                            ptrdiff_t sst, size_t nelems, int pe);
   void shmem_ctx_TYPENAME_iget(shmem_ctx_t ctx, TYPE *dest, const TYPE *source,
                                ptrdiff_t dst, ptrdiff_t sst, size_t nelems, int pe);

where TYPE is one of the standard RMA types and has a corresponding
TYPENAME specified by Table:1

.. code:: bash

   void shmem_igetSIZE(void *dest, const void *source, ptrdiff_t dst, ptrdiff_t sst,
                       size_t  nelems, int pe);
   void shmem_ctx_igetSIZE(shmem_ctx_t ctx, void *dest, const void *source,
                           ptrdiff_t dst, ptrdiff_t sst, size_t nelems, int pe);

where SIZE is one of 8, 16, 32, 64, 128.

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER dst, sst, nelems, pe
   CALL SHMEM_COMPLEX_IGET(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_DOUBLE_IGET(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IGET4(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IGET8(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IGET32(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IGET64(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_IGET128(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_INTEGER_IGET(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_LOGICAL_IGET(dest, source, dst, sst, nelems, pe)
   CALL SHMEM_REAL_IGET(dest, source, dst, sst, nelems, pe)

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
   dest    Local data object to be updated.
   source  Array containing the data to be copied on the remote PE.
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

   The iget routines provide a method for copying strided data elements from
   a symmetric array from a specified remote PE to strided locations on a
   local array. The routines return when the data has been copied into the local
   dest array.

   When using Fortran, dest and source must conform to certain typing
   constraints, which are as follows:
   |     Routine       |    Data type of dest and source           |
   |-------------------|-------------------------------------------|
   |shmem_iget4,       |Any noncharacter type that has a           |
   |shmem_iget32       |storage size equal to 32 bits.             |
   |shmem_iget8        |C: Any noncharacter type that has a        |
   |                   |storage size equal to 8 bits.              |
   |                   |Fortran: Any noncharacter type that        |
   |                   |has a storage size equal to 64 bits.       |
   |shmem_iget64       |Any noncharacter type that has a           |
   |                   |storage size equal to 64 bits.             |
   |shmem_iget128      |Any noncharacter type that has a           |
   |                   |storage size equal to 128 bits.            |
   |SHMEM_COMPLEX_IGET |Elements of type complex of default size.  |
   |SHMEM_DOUBLE_IGET  |Fortran: Elements of type double precision.|
   |SHMEM_INTEGER_IGET |Elements of type integer.                  |
   |SHMEM_LOGICAL_IGET |Elements of type logical.                  |
   |SHMEM_REAL_IGET    |Elements of type real.                     |

Return Values
=============

::

   None.

Notes
=====

::

   When using Fortran, data types must be of default size. For example, a
   real variable must be declared as REAL, REAL*4, or
   REAL(KIND=KIND(1.0)).

Examples
========

Fortran Example
---------------

::

   The following example uses shmem_logical_iget in a Fortran program.

.. code:: bash

   PROGRAM STRIDELOGICAL
   INCLUDE "shmem.fh"

   LOGICAL SOURCE(10), DEST(5)
   SAVE SOURCE   ! SAVE MAKES IT REMOTELY ACCESSIBLE
   DATA SOURCE /.T.,.F.,.T.,.F.,.T.,.F.,.T.,.F.,.T.,.F./
   DATA DEST / 5*.F. /
   CALL SHMEM_INIT()
   IF (SHMEM_MY_PE() .EQ. 0) THEN
      CALL SHMEM_LOGICAL_IGET(DEST, SOURCE, 1, 2, 5, 1)
      PRINT*,'DEST AFTER SHMEM_LOGICAL_IGET:',DEST
   ENDIF
   CALL SHMEM_BARRIER_ALL

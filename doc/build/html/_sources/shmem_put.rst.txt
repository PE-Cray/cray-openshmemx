shmem_put
=======

::

   The  put routines  provide  a method for copying data from a contiguous local
   data object to a data object on a specified PE.

Definitions
-----------

C11 Synopsis
------------

.. code:: bash

   void shmem_put(TYPE *dest, const TYPE *source, size_t nelems, int pe);
   void shmem_put(shmem_ctx_t ctx, TYPE *dest, const TYPE *source, size_t nelems, int pe);

where TYPE is one of the standard RMA types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_put(TYPE *dest, const TYPE *source, size_t nelems, int pe);
   void shmem_ctx_TYPENAME_put(shmem_ctx_t ctx, TYPE *dest, const TYPE *source,
                               size_t nelems, int pe);

where TYPE is one of the standard RMA types and has a corresponding
TYPENAME specified by Table:1

.. code:: bash

   void shmem_putSIZE(void *dest, const void *source, size_t nelems, int pe);
   void shmem_ctx_putSIZE(shmem_ctx_t ctx, void *dest, const void *source,
                          size_t nelems, int pe);

where SIZE is one of 8, 16, 32, 64, 128.

.. code:: bash

   void shmem_putmem(void *dest, const void *source, size_t nelems, int pe);
   void shmem_ctx_putmem(shmem_ctx_t ctx, void *dest, const void *source,
                         size_t nelems, int pe);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_CHARACTER_PUT(dest, source, nelems, pe)
   CALL SHMEM_COMPLEX_PUT(dest, source, nelems, pe)
   CALL SHMEM_DOUBLE_PUT(dest, source, nelems, pe)
   CALL SHMEM_INTEGER_PUT(dest, source, nelems, pe)
   CALL SHMEM_LOGICAL_PUT(dest, source, nelems, pe)
   CALL SHMEM_PUT4(dest, source, nelems, pe)
   CALL SHMEM_PUT8(dest, source, nelems, pe)
   CALL SHMEM_PUT32(dest, source, nelems, pe)
   CALL SHMEM_PUT64(dest, source, nelems, pe)
   CALL SHMEM_PUT128(dest, source, nelems, pe)
   CALL SHMEM_PUTMEM(dest, source, nelems, pe)
   CALL SHMEM_REAL_PUT(dest, source, nelems, pe)

Datatype Reference Table
------------------------

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
---------

::

   ctx   The context on which to perform the operation. When this argument is
         not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   dest  Data object to be updated on the remote PE. This data object must be
         remotely accessible.
   source  Data object containing the data to be copied.
   nelems  Number of elements in the dest and source arrays. nelems must be of
         type size_t for C. When using Fortran, it must be a constant, variable,
         or array element of default integer type.
   pe    PE number of the remote PE. pe must be of type integer. When using
         Fortran, it must be a constant, variable, or array element of default
         integer type.

Description
-----------

::

   The routines return after the data has been copied out of the source array
   on the local PE.  The delivery of data words into the data object on the
   destination PE may occur in any order.  Furthermore, two successive put
   routines may deliver data out of order unless a call to shmem_fence is
   introduced between the two calls.


   When using Fortran, dest and source must conform to certain typing
   constraints, which are as follows:
   |     Routine       |    Data type of dest and source    |
   |-------------------|------------------------------------|
   |shmem_putmem       |Fortran: Any noncharacter type.     |
   |                   |C: Any data type. nelems is scaled  |
   |                   |in bytes.                           |
   |shmem_put4,        |Any noncharacter type that has a    |
   |shmem_put32        |storage size equal to 32 bits.      |
   |shmem_put8         |C: Any noncharacter type that has a |
   |                   |storage size equal to 8 bits.       |
   |                   |Fortran: Any noncharacter type that |
   |                   |has a storage size equal to 64 bits.|
   |shmem_put64        |Any noncharacter type that has a    |
   |                   |storage size equal to 64 bits.      |
   |shmem_put128       |Any  noncharacter type that has a   |
   |                   |storage size equal to 128 bits.     |
   |SHMEM_CHARACTER_PUT|Elements of type character. nelems  |
   |                   |is the number  of characters to     |
   |                   |transfer. The actual character      |
   |                   |lengths of the source and dest      |
   |                   |variables are ignored.              |
   |SHMEM_COMPLEX_PUT  |Elements of type complex of default |
   |                   |size.                               |
   |SHMEM_DOUBLE_PUT   |Fortran: Elements of type double    |
   |                   |precision.                          |
   |SHMEM_INTEGER_PUT  |Elements of type integer.           |
   |SHMEM_LOGICAL_PUT  |Elements of type logical.           |
   |SHMEM_REAL_PUT     |Elements of type real.              |

Return Values
-------------

::

   None.

Notes
-----

::

   When using Fortran, data types must be of default size.  For example,
   a real variable must be declared as REAL,  REAL*4,  or REAL(KIND-KIND(1.0)).
   As of OpenSHMEM[1.2], the Fortran API routine SHMEM_PUT has been deprecated,
   and either SHMEM_PUT8 or SHMEM_PUT64 should be used in its place

Examples
--------

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      long source[10] - { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
      static long dest[10];
      shmem_init();
      int me - shmem_my_pe();
      if (me -- 0) /* put 10 words into dest on PE 1 */
         shmem_put(dest, source, 10, 1);
      shmem_barrier_all(); /* sync sender and receiver */
      printf("dest[0] on PE %d is %ld\n", me, dest[0]);
      shmem_finalize();
      return 0;
   }

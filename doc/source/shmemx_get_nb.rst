shmemx_get_nb
=============

::

   The nonblocking get routines provide a method for copying data from a
   contiguous remote data object on the specified PE to the local data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmemx_get_nb(TYPE *dest, const TYPE *source, size_t nelems, int pe);
   void shmemx_get_nb(shmem_ctx_t ctx, TYPE *dest, const TYPE *source, size_t nelems, int pe);

where TYPE is one of the standard RMA types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_TYPENAME_get_nb(TYPE *dest, const TYPE *source, size_t nelems, int pe);
   void shmemx_ctx_TYPENAME_get_nb(shmem_ctx_t ctx, TYPE *dest, const TYPE *source,
                                   size_t nelems, int pe);

where TYPE is one of the standard RMA types and has a corresponding
TYPENAME specified by Table:1

.. code:: bash

   void shmemx_getSIZE_nb(void *dest, const void *source, size_t  nelems, int pe);
   void shmemx_ctx_getSIZE_nb(shmem_ctx_t ctx, void *dest, const void *source, size_t  nelems, int pe);

where SIZE is one of 8, 16, 32, 64, 128.

.. code:: bash

   void shmemx_getmem_nb(void *dest, const void *source, size_t nelems, int pe);
   void shmemx_ctx_getmem_nb(shmem_ctx_t ctx, void *dest, const void *source,
                             size_t nelems, int pe);

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
   source  Data object on the PE identified by pe that contains the data to be
           copied. This data object must be remotely accessible.
   nelems  Number of elements in the dest and source arrays. nelems must be of
           type size_t for C. When using Fortran, it must be a constant, variable,
           or array element of default integer type.
   pe      PE number of the remote PE.  pe must be of type integer. When using
           Fortran, it must be a constant, variable, or array element of default
           integer type.

Description
===========

::

   The get routines provide a method for copying a contiguous symmetric data
   object from a different PE to a contiguous data object on the local PE. The
   routines return after posting the operation.  The operation is considered
   complete after a subsequent call to shmem_quiet. At the completion of
   shmem_quiet, the data has been delivered to the dest array on the local PE.

Return Values
=============

::

   None.

Notes
=====

::

   See Section 3 for a definition of the term remotely accessible

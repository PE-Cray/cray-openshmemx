shmem_atomic_fetch_inc_nbi
==========================

   This nonblocking atomic routine performs an atomic fetch-and-increment
   operation on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_fetch_inc_nbi(TYPE *fetch, TYPE *dest, int pe);
   void shmem_atomic_fetch_inc_nbi(shmem_ctx_t ctx, TYPE *fetch, TYPE *dest, int pe);

where TYPE is one of the standard AMO types specified by Table:6

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_atomic_fetch_inc_nbi(TYPE *fetch, TYPE *dest, int pe);
   void shmem_ctx_TYPENAME_atomic_fetch_inc_nbi(shmem_ctx_t ctx, TYPE *fetch,
                                   TYPE *dest, int pe);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:6

Datatype Reference Table
========================

Table:6
-------

     |           TYPE          |      TYPENAME       |
     |-------------------------|---------------------|
     |   int                   |     int             |
     |   long                  |     long            |
     |   long long             |     longlong        |
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

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   fetch   Local address of data object to be updated. The type of fetch should
           match that implied in the SYNOPSIS section.
   dest    Symmetric address of the destination data object. The type of dest
           should match that implied in the SYNOPSIS section.
   pe      An integer that indicates the PE number on which dest is to be
           updated.  When using Fortran, it must be a default integer value.

Description
===========

   The nonblocking shmem_atomic_fetch_inc_nbi routines perform an atomic
   fetch-and-increment operation. This routine returns after initiating the
   operation. The operation is considered complete after a subsequent call to
   shmem_quiet. At the completion of shmem_quiet, dest on PE pe has been increased
   by one and the previous contents of dest fetched into the fetch local data
   object.

Return Values
=============

   None.

Notes
=====

   None.

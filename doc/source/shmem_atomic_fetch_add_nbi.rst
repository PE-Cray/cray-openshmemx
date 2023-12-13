shmem_atomic_fetch_add_nbi
==========================

   The nonblocking atomic routine performs an atomic fetch-and-add operation on
   a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_fetch_add_nbi(TYPE *fetch, TYPE *dest, TYPE value, int pe);
   void shmem_atomic_fetch_add_nbi(shmem_ctx_t ctx, TYPE *fetch, TYPE *dest,
                                   TYPE value, int pe);

where TYPE is one of the standard AMO types specified by Table:6

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_atomic_fetch_add_nbi(TYPE *fetch, TYPE *dest, TYPE value,
                                   int pe);
   void shmem_ctx_TYPENAME_atomic_fetch_add_nbi(shmem_ctx_t ctx, TYPE *fetch,
                                   TYPE *dest, TYPE value, int pe);

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
   value   The operand to the atomic fetch-and-add operation. The type of value
           should match that implied in the SYNOPSIS section.
   pe      An integer that indicates the PE number on which dest is to be
           updated.  When using Fortran, it must be a default integer value.

Description
===========

   The nonblocking shmem_atomic_fetch_add_nbi routines perform an atomic
   fetch-and-add operation. This routine returns after initiating the operation.
   An atomic fetch-and-add operation fetches the old dest and adds value to
   dest without the possibility of another atomic operation on the dest between
   the time of the fetch and the update. This routine returns after initiating
   the operation. The operation is considered complete after a subsequent call
   to shmem_quiet. At the completion of shmem_quiet, value has been added to
   dest on pe and the prior contents of dest fetched into the fetch local data
   object.

Return Values
=============

   None.

Notes
=====

   None.

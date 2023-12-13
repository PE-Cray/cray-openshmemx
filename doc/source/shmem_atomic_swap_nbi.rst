shmem_atomic_swap_nbi
=====================

   The nonblocking atomic operation performs an atomic swap to a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_swap_nbi(TYPE *fetch, TYPE *dest, TYPE value, int pe);
   void shmem_atomic_swap_nbi(shmem_ctx_t ctx, TYPE *fetch, TYPE *dest, TYPE value,
                           int pe);

where TYPE is one of the extended AMO types specified by Table:7

C/C++ Synopsis
--------------

.. code:: bash

       void shmem_TYPENAME_atomic_swap_nbi(TYPE *fetch, TYPE *dest, TYPE value,
                           int pe);
       void shmem_ctx_TYPENAME_atomic_swap_nbi(shmem_ctx_t ctx, TYPE *fetch,
                           TYPE *dest, TYPE value, int pe);

where TYPE is one of the extended AMO types and has a corresponding
TYPENAME specified by Table:7

Datatype Reference Table
========================

Table:7
-------

     |           TYPE          |      TYPENAME       |
     |-------------------------|---------------------|
     |   float                 |     float           |
     |   double                |     double          |
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

   ctx   A context handle specifying the context on which to perform the
         operation. When this argument is not provided, the operation is
         performed on the default context.
   fetch Local address of data object to be updated. The type of fetch
         should match that implied in the SYNOPSIS section.
   dest  Symmetric address of the destination data object. The type of dest
         should match that implied in the SYNOPSIS section.
   value The value to be atomically written to the remote PE. The type of
         value should match that implied in the SYNOPSIS section.
   pe    An integer that indicates the PE number on which dest is to be updated.

Description
===========

   The nonblocking shmem_atomic_swap_nbi routines perform an atomic swap
   operation. This routine returns after initiating the operation. The
   operation is considered complete after a subsequent call to shmem_quiet. At
   the completion of shmem_quiet, it has written value into dest on PE and
   fetched the prior contents of dest into fetch local data object.

Return Values
=============

   None

Notes
=====

   None.

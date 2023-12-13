shmem_atomic_fetch_nbi
======================

   The nonblocking atomic fetch routine provides a method for atomically
   fetching the value of a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_fetch_nbi(TYPE *fetch, const TYPE *source, int pe);
   void shmem_atomic_fetch_nbi(shmem_ctx_t ctx, TYPE *fetch, const TYPE *source,
                               int pe);

where TYPE is one of the extended AMO types specified by Table:7

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_atomic_fetch_nbi(TYPE *fetch, const TYPE *source, int pe);
   void shmem_ctx_TYPENAME_atomic_fetch_nbi(shmem_ctx_t ctx, TYPE *fetch,
                               const TYPE *source, int pe);

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

   ctx    The context on which to perform the operation. When this argument is
          not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   fetch  Local address of data object to be updated. The type of fetch should
          match that implied in the SYNOPSIS section.
   source Symmetric address of the source data object. The type of source should
          match that implied in the SYNOPSIS section.
   pe     An integer that indicates the PE number from which source is to be
          fetched.

Description
===========

   The nonblocking atomic fetch routines perform a nonblocking fetch of a value
   atomically from a remote data object. This routine returns after initiating
   the operation. The operation is considered complete after a subsequent call
   to shmem_quiet. At the completion of shmem_quiet, contents of the source
   data object from PE has been fetched into fetch local data object.

Return Values
=============

   None.

Notes
=====

   None.

shmem_atomic_fetch_or_nbi
=========================

   This nonblocking atomic operation performs an atomic fetching bitwise OR
   operation on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_fetch_or_nbi(TYPE *fetch, TYPE *dest, TYPE value, int pe);
   void shmem_atomic_fetch_or_nbi(shmem_ctx_t ctx, TYPE *fetch, TYPE *dest,
                                  TYPE value, int pe);

where TYPE is one of the bitwise AMO types specified by Table:8

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_atomic_fetch_or_nbi(TYPE *fetch, TYPE *dest, TYPE value,
                                   int pe);
   void shmem_ctx_TYPENAME_atomic_fetch_or_nbi(shmem_ctx_t ctx, TYPE *fetch,
                                   TYPE *dest, TYPE value, int pe);

where TYPE is one of the bitwise AMO types and has a corresponding
TYPENAME specified by Table:8

Datatype Reference Table
========================

Table:1
-------

     |           TYPE          |      TYPENAME       |
     |-------------------------|---------------------|
     |   unsigned int          |     uint            |
     |   unsigned long         |     ulong           |
     |   unsigned long long    |     ulonglong       |
     |   int32_t               |     int32           |
     |   int64_t               |     int64           |
     |   uint32_t              |     uint32          |
     |   uint64_t              |     uint64          |

Arguments
=========

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   fetch   Local address of data object to be updated. The type of fetch should
           match that implied in the SYNOPSIS section.
   dest    Symmetric address of the destination data object. The type of dest
           should match that implied in the SYNOPSIS section.
   value   The operand operand to the bitwise OR operation. The type of value
           should match that implied in the SYNOPSIS section.
   pe      An integer that indicates the PE number upon which is to be updated.

Description
===========

   The nonblocking shmem_atomic_fetch_or_nbi routines perform an atomic
   fetching bitwise OR on the remotely accessible data object pointed by dest
   at PE pe with the operand value. This routine returns after initiating the
   operation. The operation is considered complete after a subsequent call to
   shmem_quiet. At the completion of shmem_quiet, these routines have performed
   a fetching bitwise OR on dest at PE pe with the operand value and fetched
   the prior contents of dest into the fetch local data object.

Return Values
=============

   None.

Notes
=====

None.

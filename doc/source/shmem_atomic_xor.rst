shmem_atomic_xor
================

Atomically perform a non-fetching bitwise exclusive OR (XOR) operation
on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_xor(TYPE *dest, TYPE value, int pe);
   void shmem_atomic_xor(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the bitwise AMO types specified by Table:1

C/C++ Synopsis
==============

.. code:: bash

   void shmem_TYPENAME_atomic_xor(TYPE *dest, TYPE value, int pe);
   void shmem_ctx_TYPENAME_atomic_xor(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the bitwise AMO types and has a corresponding
TYPENAME specified by Table:1

Datatype Reference Table
========================

Table:1
-------

::

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

::

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   dest    A pointer to the remotely accessible data object to be updated.
   value   The operand to the bitwise XOR operation.
   pe      An integer that indicates the PE number upon which is to be updated.

Description
===========

shmem_atomic_xor atomically performs a non-fetching bitwise XOR on the
remotely accessible data object pointed to by dest at PE pe with the
operand value.

Return Values
=============

None. }

Notes
=====

None. }

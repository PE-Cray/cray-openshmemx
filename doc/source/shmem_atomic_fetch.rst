shmem_atomic_fetch
==================

::

   Atomically fetches the value of a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   TYPE shmem_atomic_fetch(const TYPE *source, int pe);
   TYPE shmem_atomic_fetch(shmem_ctx_t ctx, const TYPE *source, int pe);

where TYPE is one of the extended AMO types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   TYPE shmem_TYPENAME_atomic_fetch(const TYPE *source, int pe);
   TYPE shmem_ctx_TYPENAME_atomic_fetch(shmem_ctx_t ctx, const TYPE *source, int pe);

where TYPE is one of the extended AMO types and has a corresponding
TYPENAME specified by Table:1

Deprecated Synopsis
===================

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   TYPE shmem_fetch(const TYPE *source, int pe);

where TYPE is one of ``float``, ``double``, ``int``, ``long``,
``long long``.

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   TYPE shmem_TYPENAME_fetch(const TYPE *source, int pe);

where TYPE is one of ``float``, ``double``, ``int``, ``long``,
``long long`` and has a corresponding TYPENAME specified by Table:1

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pe
   INTEGER*4 SHMEM_INT4_FETCH, ires_i4
   ires_i4 = SHMEM_INT4_FETCH(source, pe)
   INTEGER*8 SHMEM_INT8_FETCH, ires_i8
   ires_i8 = SHMEM_INT8_FETCH(source, pe)
   REAL*4 SHMEM_REAL4_FETCH, res_r4
   res_r4 = SHMEM_REAL4_FETCH(source, pe)
   REAL*8 SHMEM_REAL8_FETCH, res_r8
   res_r8 = SHMEM_REAL8_FETCH(source, pe)

Datatype Reference Table
========================

Table:1
-------

::

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

::

   ctx   The context on which to perform the operation. When this argument is
         not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   source  The remotely accessible data object to be fetched from the remote PE.
   pe    An integer that indicates the PE number from which source is to be
         fetched.

Description
===========

::

   shmem_atomic_fetch performs an atomic fetch operation. It returns the
   contents of the source as an atomic operation.

Return Values
=============

::

   The contents at the source address on the remote PE. The data type of the
   return value is the same as the type of the remote data object.

Notes
=====

::

   None.

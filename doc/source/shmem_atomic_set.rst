shmem_atomic_set
=======

::

   Atomically sets the value of a remote data object.

Definitions
-----------

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_set(TYPE *dest, TYPE value, int pe);
   void shmem_atomic_set(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the extended AMO types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_atomic_set(TYPE *dest, TYPE value, int pe);
   void shmem_ctx_TYPENAME_atomic_set(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the extended AMO types and has a corresponding
TYPENAME specified by Table:1

Deprecated Synopsis
-------------------

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   void shmem_set(TYPE *dest, TYPE value, int pe);

where TYPE is one of ``float``, ``double``, ``int``, ``long``,
``long long``.

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_TYPENAME_set(TYPE *dest, TYPE value, int pe);

where TYPE is one of ``float``, ``double``, ``int``, ``long``,
``long long`` and has a corresponding TYPENAME specified by Table:1

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pe
   INTEGER*4 SHMEM_INT4_SET, value_i4
   CALL SHMEM_INT4_SET(dest, value_i4, pe)
   INTEGER*8 SHMEM_INT8_SET, value_i8
   CALL SHMEM_INT8_SET(dest, value_i8, pe)
   REAL*4 SHMEM_REAL4_SET, value_r4
   CALL SHMEM_REAL4_SET(dest, value_r4, pe)
   REAL*8 SHMEM_REAL8_SET, value_r8
   CALL SHMEM_REAL8_SET(dest, value_r8, pe)

Datatype Reference Table
------------------------

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
---------

::

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   dest    The remotely accessible integer data object to be updated on the
           remote PE.
   value   The value to be atomically written to the remote PE.
   pe      An integer that indicates the PE number on which dest is to be updated.

Description
-----------

::

   shmem_atomic_set performs an atomic set operation. It writes the value into
   dest on pe as an atomic operation.

Return Values
-------------

::

   None.

Notes
-----

::

   None.

shmem_atomic_add
================

::

   Performs an atomic add operation on a remote symmetric data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_add(TYPE *dest, TYPE value, int pe);
   void shmem_atomic_add(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the standard AMO types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_atomic_add(TYPE *dest, TYPE value, int pe);
   void shmem_ctx_TYPENAME_atomic_add(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:1

Deprecated Synopsis
===================

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   void shmem_add(TYPE *dest, TYPE value, int pe);

where TYPE is one of ``int``, ``long``, ``long long``.

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_TYPENAME_add(TYPE *dest, TYPE value, int pe);

where TYPE is one of ``int``, ``long``, ``long long`` and has a
corresponding TYPENAME specified by Table:1

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pe
   INTEGER*4  value_i4
   CALL SHMEM_INT4_ADD(dest, value_i4, pe)
   INTEGER*8 value_i8
   CALL SHMEM_INT8_ADD(dest, value_i8, pe)

Datatype Reference Table
========================

Table:1
-------

::

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

::

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   dest    The remotely accessible integer data object to be updated  on the
           remote PE. When using  C/C++, the type of dest should match that
           implied in the SYNOPSIS section.
   value   The value to be atomically added to dest. When using C/C++, the type
           of value should match that  implied in the SYNOPSIS section. When
           using Fortran, it must be of type integer with an element size of
           integer with an element size of dest.
   pe      An integer that indicates the PE number upon which is to be updated.
           When using Fortran, it must be a default integer value.

Description
===========

::

   The shmem_atomic_add routine performs an atomic add operation. It adds
   value to dest on PE pe and atomically updates the dest without returning the
   value.

   When using Fortran, dest and value must be of the following type:
   |     Routine    |Data type of dest and source|
   |----------------|----------------------------|
   | SHMEM_INT4_ADD |      4-byte integer        |
   | SHMEM_INT8_ADD |      8-byte integer        |

Return Values
=============

::

   None.

Notes
=====

::

   None.

Examples
========

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>
   int main(void)
   {
      static int dst = 22;
      shmem_init();
      int me = shmem_my_pe();
      if (me == 1)
         shmem_atomic_add(&dst, 44, 0);
      shmem_barrier_all();
      printf("%d: dst = %d\n", me, dst);
      shmem_finalize();
      return 0;
   }

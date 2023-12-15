shmem_atomic_fetch_add
======================

::

   Performs an atomic fetch-and-add operation on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   TYPE shmem_atomic_fetch_add(TYPE *dest, TYPE value, int pe);
   TYPE shmem_atomic_fetch_add(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the standard AMO types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   TYPE shmem_TYPENAME_atomic_fetch_add(TYPE *dest, TYPE value, int pe);
   TYPE shmem_ctx_TYPENAME_atomic_fetch_add(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:1

Deprecated Synopsis
===================

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   TYPE shmem_fadd(TYPE *dest, TYPE value, int pe);

where TYPE is one of ``int``, ``long``, ``long long``.

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   TYPE shmem_TYPENAME_fadd(TYPE *dest, TYPE value, int pe);

where TYPE is one of ``int``, ``long``, ``long long`` and has a
corresponding TYPENAME specified by Table:1

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pe
   INTEGER*4 SHMEM_INT4_FADD, ires_i4, value_i4
   ires_i4 = SHMEM_INT4_FADD(dest, value_i4, pe)
   INTEGER*8 SHMEM_INT8_FADD, ires_i8, value_i8
   ires_i8 = SHMEM_INT8_FADD(dest, value_i8, pe)

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
   dest    The remotely accessible integer data object to be updated on the
           remote PE. The type of dest should match that implied in the
           SYNOPSIS section.
   value   The value to be atomically added to dest. The type of value
           should match that implied in the SYNOPSIS section.
   pe      An integer that indicates the PE number on which dest is to be
           updated.  When using Fortran, it must be a default integer value.

Description
===========

::

   shmem_atomic_fetch_add routines perform an atomic fetch-and-add operation. An
   atomic fetch-and-add operation fetches the old dest and adds value to dest
   without the possibility of another atomic operation on the dest between the
   time of the fetch and the update.  These routines add value to dest on pe and
   return the previous contents of dest as an atomic operation.

   When using Fortran, dest and value must be of the following type:
   |     Routine      |Data type of dest and source|
   |------------------|----------------------------|
   | SHMEM_INT4_FADD  |      4-byte integer        |
   | SHMEM_INT8_FADD  |      8-byte integer        |

Return Values
=============

::

   The contents that had been at the dest address on the remote PE prior to the
   atomic addition operation.  The data type of the return value is the same as
   the dest.

Notes
=====

::

   None.

Examples
========

C/C++ Example
-------------

::

       The following shmem_atomic_fetch_add example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      int old = -1;
      static int dst = 22;
      shmem_init();
      int me = shmem_my_pe();
      if (me == 1)
         old = shmem_atomic_fetch_add(&dst, 44, 0);
      shmem_barrier_all();
      printf("%d: old = %d, dst = %d\n", me, old, dst);
      shmem_finalize();
      return 0;
   }

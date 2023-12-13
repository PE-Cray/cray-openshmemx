shmem_atomic_inc
================

   Performs an atomic increment operation on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_atomic_inc(TYPE *dest, int pe);
   void shmem_atomic_inc(shmem_ctx_t ctx, TYPE *dest, int pe);

where TYPE is one of the standard AMO types specified by Table:1

C/C++ Synopsis
==============

.. code:: bash

   void shmem_TYPENAME_atomic_inc(TYPE *dest, int pe);
   void shmem_ctx_TYPENAME_atomic_inc(shmem_ctx_t ctx, TYPE *dest, int pe);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:1

Deprecated Synopsis
===================

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   void shmem_inc(TYPE *dest, int pe);

where TYPE is one of ``int``, ``long``, ``long long``.

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_TYPENAME_inc(TYPE *dest, int pe);

where TYPE is one of ``int``, ``long``, ``long long`` and has a
corresponding TYPENAME specified by Table:1

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pe
   CALL SHMEM_INT4_INC(dest, pe)
   CALL SHMEM_INT8_INC(dest, pe)

Datatype Reference Table
========================

Table:1
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
   dest    The remotely accessible integer data object to be updated on the
           remote PE. The type of dest should match that implied in the
           SYNOPSIS section.
   pe      An integer that indicates the PE number on which dest is to be
           updated. When using Fortran, it must be a default integer value.

Description
===========

   These  routines perform  an atomic increment operation on the dest data
   object on PE.

   When using Fortran, dest and value must be of the following type:
   |     Routine    |Data type of dest and source|
   |----------------|----------------------------|
   | SHMEM_INT4_INC |      4-byte integer        |
   | SHMEM_INT8_INC |      8-byte integer        |

Return Values
=============

   None.

Notes
=====

   None.

Examples
========

C/C++ Example
-------------

   The following shmem_atomic_inc example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static int dst = 74;
      shmem_init();
      int me = shmem_my_pe();
      if (me == 0)
         shmem_atomic_inc(&dst, 1);
      shmem_barrier_all();
      printf("%d: dst = %d\n", me, dst);
      shmem_finalize();
      return 0;
   }

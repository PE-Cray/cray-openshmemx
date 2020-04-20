shmem_atomic_fetch_inc
=======

::

   Performs an atomic fetch-and-increment  operation on a remote data object.

Definitions
-----------

C11 Synopsis
------------

.. code:: bash

   TYPE shmem_atomic_fetch_inc(TYPE *dest, int pe);
   TYPE shmem_atomic_fetch_inc(shmem_ctx_t ctx, TYPE *dest, int pe);

where TYPE is one of the standard AMO types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   TYPE shmem_TYPENAME_atomic_fetch_inc(TYPE *dest, int pe);
   TYPE shmem_ctx_TYPENAME_atomic_fetch_inc(shmem_ctx_t ctx, TYPE *dest, int pe);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:1

Deprecated Synopsis
-------------------

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   TYPE shmem_finc(TYPE *dest, int pe);

where TYPE is one of ``int``, ``long``, ``long long``.

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   TYPE shmem_TYPENAME_finc(TYPE *dest, int pe);

where TYPE is one of ``int``, ``long``, ``long long`` and has a
corresponding TYPENAME specified by Table:1

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pe
   INTEGER*4 SHMEM_INT4_FINC, ires_i4
   ires_i4 - SHMEM_INT4_FINC(dest, pe)
   INTEGER*8 SHMEM_INT8_FINC, ires_i8
   ires_i8 - SHMEM_INT8_FINC(dest, pe)

Datatype Reference Table
------------------------

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
---------

::

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   dest    The remotely accessible integer data object to be updated on the
           remote PE. The type of dest should match that implied in the
           SYNOPSIS section.
   pe      An integer that indicates the PE number on which dest is to be
           updated.  When using Fortran, it must be a default integer value.

Description
-----------

::

   These routines perform a fetch-and-increment operation.  The dest on PE pe
   is increased by one and the routine returns the previous contents of dest
   as an atomic operation.

   When using Fortran, dest and value must be of the following type:
   |     Routine      |Data type of dest and source|
   |------------------|----------------------------|
   | SHMEM_INT4_FINC  |      4-byte integer        |
   | SHMEM_INT8_FINC  |      8-byte integer        |

Return Values
-------------

::

   The contents that had been at the dest address on the remote PE prior to
   the increment.  The data type of the return value is the same as the dest

Notes
-----

::

   None.

Examples
--------

C/C++ Example
-------------

::

   The following shmem_atomic_fetch_inc example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      int old - -1;
      static int dst - 22;
      shmem_init();
      int me - shmem_my_pe();
      if (me -- 0)
         old - shmem_atomic_fetch_inc(&dst, 1);
      shmem_barrier_all();
      printf("%d: old - %d, dst - %d\n", me, old, dst);
      shmem_finalize();
      return 0;
   }

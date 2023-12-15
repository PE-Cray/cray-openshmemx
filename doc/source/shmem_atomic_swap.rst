shmem_atomic_swap
=================

::

   Performs an atomic swap to a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   TYPE shmem_atomic_swap(TYPE *dest, TYPE value, int pe);
   TYPE shmem_atomic_swap(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the extended AMO types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   TYPE shmem_TYPENAME_atomic_swap(TYPE *dest, TYPE value, int pe);
   TYPE shmem_ctx_TYPENAME_atomic_swap(shmem_ctx_t ctx, TYPE *dest, TYPE value, int pe);

where TYPE is one of the extended AMO types and has a corresponding
TYPENAME specified by Table:1

Deprecated Synopsis
===================

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   TYPE shmem_swap(TYPE *dest, TYPE value, int pe);

where TYPE is one of ``float``, ``double``, ``int``, ``long``,
``long long``.

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   TYPE shmem_TYPENAME_swap(TYPE *dest, TYPE value, int pe);

where TYPE is one of ``float``, ``double``, ``int``, ``long``,
``long long`` and has a corresponding TYPENAME specified by Table:1

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER SHMEM_SWAP, value, pe
   ires = SHMEM_SWAP(dest, value, pe)
   INTEGER*4 SHMEM_INT4_SWAP, value_i4, ires_i4
   ires_i4 = SHMEM_INT4_SWAP(dest, value_i4, pe)
   INTEGER*8 SHMEM_INT8_SWAP, value_i8, ires_i8
   ires_i8 = SHMEM_INT8_SWAP(dest, value_i8, pe)
   REAL*4 SHMEM_REAL4_SWAP, value_r4, res_r4
   res_r4 = SHMEM_REAL4_SWAP(dest, value_r4, pe)
   REAL*8 SHMEM_REAL8_SWAP, value_r8, res_r8
   res_r8 = SHMEM_REAL8_SWAP(dest, value_r8, pe)

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

   ctx     The context on which to perform the operation. When this argument is
           not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   dest    The remotely accessible integer data object to be updated on the
           remote PE. When using  C/C++, the type of dest should match that
           implied in the SYNOPSIS section.
   value   The value to be atomically written to the remote PE. value is the
           same type as dest.
   pe      An integer that indicates the PE number on which dest is to be updated.

Description
===========

::

   shmem_atomic_swap performs an atomic swap operation. It writes value into
   dest on PE and returns the previous contents of dest as an atomic operation.

   When using Fortran, dest and value must be of the following type:
   |     Routine      |Data type of dest and source|
   |------------------|----------------------------|
   | SHMEM_SWAP       | integer of default kind    |
   | SHMEM_INT4_SWAP  |      4-byte integer        |
   | SHMEM_INT8_SWAP  |      8-byte integer        |
   | SHMEM_REAL4_SWAP |      4-byte integer        |
   | SHMEM_REAL8_SWAP |      8-byte integer        |

Return Values
=============

::

   The content that had been at the dest address on the remote PE prior to the
   swap is returned.

Notes
=====

::

   None.

Examples
========

C/C++ Example
-------------

::

   The example below swaps values between odd numbered PEs and their right
   (modulo) neighbor and outputs the result of swap.

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static long dest;
      shmem_init();
      int me = shmem_my_pe();
      int npes = shmem_n_pes();
      dest = me;
      shmem_barrier_all();
      long new_val = me;
      if (me & 1) {
         long swapped_val = shmem_atomic_swap(&dest, new_val, (me + 1) % npes);
         printf("%d: dest = %ld, swapped = %ld\n", me, dest, swapped_val);
      }
      shmem_finalize();
      return 0;
   }

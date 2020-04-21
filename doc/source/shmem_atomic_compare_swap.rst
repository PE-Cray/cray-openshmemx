shmem_atomic_compare_swap
=======

::

   Performs an atomic conditional swap on a remote data object.

Definitions
-----------

C11 Synopsis
------------

.. code:: bash

   TYPE shmem_atomic_compare_swap(TYPE *dest, TYPE cond, TYPE value, int pe);
   TYPE shmem_atomic_compare_swap(shmem_ctx_t ctx, TYPE *dest, TYPE cond, TYPE value, int pe);

where TYPE is one of the standard AMO types specified by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   TYPE shmem_TYPENAME_atomic_compare_swap(TYPE *dest, TYPE cond, TYPE value, int pe);
   TYPE shmem_ctx_TYPENAME_atomic_compare_swap(shmem_ctx_t ctx, TYPE *dest,
                                               TYPE cond, TYPE value, int pe);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:1

Deprecated Synopsis
-------------------

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   TYPE shmem_cswap(TYPE *dest, TYPE cond, TYPE value, int pe);

where TYPE is one of ``int``, ``long``, ``long long``.

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   TYPE shmem_TYPENAME_cswap(TYPE *dest, TYPE cond, TYPE value, int pe);

where TYPE is one of ``int``, ``long``, ``long long`` and has a
corresponding TYPENAME specified by Table:1 \\end{DeprecateBlock}

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER pe
   INTEGER*4 SHMEM_INT4_CSWAP,  cond_i4, value_i4, ires_i4
   ires_i4 - SHMEM_INT4_CSWAP(dest, cond_i4, value_i4, pe)
   INTEGER*8 SHMEM_INT8_CSWAP,  cond_i8, value_i8, ires_i8
   ires_i8 - SHMEM_INT8_CSWAP(dest, cond_i8, value_i8, pe)

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
   dest    The remotely accessible integer data object to be updated  on the
           remote PE.
   cond    cond is compared to the remote dest value. If cond and the remote
           dest are equal, then value is swapped into the remote dest; otherwise,
           the remote dest is unchanged.  In either case, the old value of the
           remote dest is returned as the routine return value. cond must be of
           the same data type as dest.
   value   The value to be atomically written to the remote PE. value must be
           the same data type as dest.
   pe      An integer that indicates the PE number upon which dest is to be
           updated. When using Fortran, it must be a default integer value.

Description
-----------

::

   The conditional swap routines conditionally update a dest data object on
   the specified PE and return the prior contents of the data object in one
   atomic operation.

   When using Fortran, dest and value must be of the following type:
   |     Routine      |Data type of dest and source|
   |------------------|----------------------------|
   | SHMEM_INT4_CSWAP |      4-byte integer        |
   | SHMEM_INT8_CSWAP |      8-byte integer        |

Return Values
-------------

::

   The contents that had been in the dest data object on the remote
   PE prior to the conditional swap. Data type is the same as the
   dest data type.

Notes
-----

::

   None.

Examples
--------

C/C++ Example
-------------

::

   The following call ensures that the first PE to execute the
   conditional swap will successfully write its PE number to
   race_winner on PE 0.

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static int race_winner - -1;
      shmem_init();
      int me - shmem_my_pe();
      int oldval - shmem_atomic_compare_swap(&race_winner, -1, me, 0);
      if (oldval -- -1) printf("PE %d was first\n", me);
      shmem_finalize();
      return 0;
   }

shmem_atomic_compare_swap_nbi
=============================

::

   The nonblocking atomic routine provides a method for performing an atomic
   conditional swap on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

       void shmem_atomic_compare_swap_nbi(TYPE *fetch, TYPE *dest, TYPE cond,
                                          TYPE value, int pe);
       void shmem_atomic_compare_swap_nbi(shmem_ctx_t ctx, TYPE *fetch, TYPE *dest,
                                          TYPE cond, TYPE value, int pe);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:6

C/C++ Synopsis
--------------

.. code:: bash

       void shmem_TYPENAME_atomic_compare_swap_nbi(TYPE *fetch, TYPE *dest,
                                           TYPE cond, TYPE value, int pe);
       void shmem_ctx_TYPENAME_atomic_compare_swap_nbi(shmem_ctx_t ctx, TYPE *fetch,
                                           TYPE *dest, TYPE cond, TYPE value, int pe);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:6

Datatype Reference Table
========================

Table:6
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

   ctx    The context on which to perform the operation. When this argument is
          not provided, the operation is performed on SHMEM_CTX_DEFAULT.
   fetch  Local address of data object to be updated. The type of fetch should
          match that implied in the SYNOPSIS section.
   dest   Symmetric address of the destination data object. The type of dest
          should match that implied in the SYNOPSIS section.
   cond   cond is compared to the remote dest value. If cond and the remote dest
          are equal, then value is swapped into the remote dest; otherwise, the
          remote dest is unchanged. The type of cond should match that implied
          in the SYNOPSIS section.
   value  The value to be atomically written to the remote PE. The type of value
          should match that implied in the SYNOPSIS section.
   pe     An integer that indicates the PE number from which source is to be
          fetched.

Description
===========

::

   The nonblocking conditional swap routines conditionally update a dest data
   object on the specified PE as an atomic operation and fetches the prior
   contents of the dest data object into the fetch local data object. This
   routine returns after initiating the operation. The operation is considered
   complete after a subsequent call to shmem_quiet. At the completion of
   shmem_quiet, prior contents of the dest data object have been fetched into
   fetch local data object and the contents of value have been conditionally
   updated into dest on the remote PE

Return Values
=============

::

   None.

Notes
=====

::

   None.

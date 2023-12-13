shmemx_cswap_nb
===============

   The nonblocking atomic routine provides a method for performing an atomic
   conditional swap on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmemx_cswap_nb(TYPE *fetch, TYPE *target, TYPE cond, TYPE value,
       int pe, void **transfer_handle);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:6

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_TYPENAME_cswap_nb(TYPE *fetch, TYPE *target, TYPE cond,
       TYPE value, int pe, void **transfer_handle);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:6

Datatype Reference Table
========================

Table:6
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

   fetch  Local address of data object to be updated. The type of fetch should
          match that implied in the SYNOPSIS section.
   target Symmetric address of the destination data object. The type of target
          should match that implied in the SYNOPSIS section.
   cond   cond is compared to the remote target value. If cond and the remote
          target are equal, then value is swapped into the remote target;
          otherwise, the remote target is unchanged. The type of cond should
          match that implied in the SYNOPSIS section.
   value   The value to be atomically written to the remote PE. The type of
           value should match that implied in the SYNOPSIS section.
   pe     An integer that indicates the PE number from which source is to be
          fetched.
   transfer_handle Not utilizated. Supply NULL.

Description
===========

   The nonblocking conditional swap routines conditionally update a dest data
   object on the specified PE as an atomic operation and fetches the prior
   contents of the dest data object into the fetch local data object.
   This routine returns after initiating the operation. The operation is
   considered complete after a subsequent call to shmem_quiet. At the
   completion of shmem_quiet, prior contents of the dest data object have
   been fetched into fetch local data object and the contents of value have
   been conditionally updated into dest on the remote PE.

Return Values
=============

   None.

Notes
=====

   None.

shmemx_swap_nb
==============

   The nonblocking atomic routine performs an atomic fetch-and-swap operation
   on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmemx_swap_nb(TYPE *fetch, TYPE *target, TYPE value, int pe,
       void **transfer_handle);

where TYPE is one of the standard AMO types specified by Table:6

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_##TYPENAME##_swap_nb(TYPE *fetch, TYPE *target, TYPE value, int pe,
       void **transfer_handle);

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
   value   The value to be atomically written to the remote PE. value is of
           type in the SYNOPSIS section.
   pe      An integer that indicates the PE number on which target is to be
           updated.
   transfer_handle Not utilizated. Supply NULL.

Description
===========

   The nonblocking shmemx_short_swap_nb routines perform an atomic
   fetch-and-swap operation. This routine returns after initiating the
   operation. An atomic fetch-and-swap operation fetches the old target and
   swaps the value to target without the possibility of another atomic
   operation on the target between the time of the fetch and the update.
   This routine returns after initiating the operation. The operation is
   considered complete after a subsequent call to shmem_quiet. At the
   completion of shmem_quiet, value has been swaped to target on pe and
   the prior contents of target fetched into the fetch local data object.

Return Values
=============

   None.

Notes
=====

   None.

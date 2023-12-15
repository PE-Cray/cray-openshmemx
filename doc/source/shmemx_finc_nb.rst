shmemx_finc_nb
==============

::

   This nonblocking atomic routine performs an atomic fetch-and-increment
   operation on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmemx_finc_nb(TYPE *fetch, TYPE *target, int pe,
       void **transfer_handle);

where TYPE is one of the standard AMO types specified by Table:6

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_TYPENAME_finc_nb(TYPE *fetch, TYPE *target, int pe,
       void **transfer_handle);

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

   fetch  Local address of data object to be updated. The type of fetch should
          match that implied in the SYNOPSIS section.
   target Symmetric address of the destination data object. The type of target
          should match that implied in the SYNOPSIS section.
   pe     An integer that indicates the PE number from which source is to be
          fetched.
   transfer_handle Not utilizated. Supply NULL.

Description
===========

::

   The nonblocking shmemx_finc_nb routines perform an atomic
   fetch-and-increment operation. This routine returns after initiating the
   operation. The operation is considered complete after a subsequent call to
   shmem_quiet. At the completion of shmem_quiet, dest on PE pe has been
   increased by one and the previous contents of dest fetched into the fetch
   local data object.

Return Values
=============

::

   None.

Notes
=====

::

   None.

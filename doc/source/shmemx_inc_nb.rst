shmemx_inc_nb
=============

   Performs an atomic increment operation on a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmemx_inc_nb(TYPE *target, int pe, void **transfer_handle);

where TYPE is one of the standard AMO types specified by Table:1

C/C++ Synopsis
==============

.. code:: bash

   void shmem_TYPENAME_inc_nb(TYPE *target, int pe, void **transfer_handle);

where TYPE is one of the standard AMO types and has a corresponding
TYPENAME specified by Table:1

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

   target  The remotely accessible integer data object to be updated on the
           remote PE. The type of target should match that implied in the
           SYNOPSIS section.
   pe      An integer that indicates the PE number on which dest is to be
           updated. When using Fortran, it must be a default integer value.
   transfer_handle Not utilizated. Supply NULL.

Description
===========

   These  routines perform  a non-blocking atomic increment operation on the
   target data object on PE.

Return Values
=============

   None.

Notes
=====

   None.

shmemx_add_nb
=============

   Performs a non-blocking atomic add operation on a remote symmetric
   data object.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_add_nb(short *target, short value, int pe,
       void **transfer_handle);

where TYPE is one of the standard AMO types specified by Table:1

.. code:: bash

   void shmemx_##TYPENAME##_add_nb(TYPE *target, TYPE value, int pe,
       void **transfer_handle)

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

   target  The remotely accessible integer data object to be updated  on the
           remote PE. When using  C/C++, the type of target should match that
           implied in the SYNOPSIS section.
   value   The value to be atomically added to target. When using C/C++, the
           type of value should match that  implied in the SYNOPSIS section.
   pe      An integer that indicates the PE number upon which is to be updated.
           When using Fortran, it must be a default integer value.
   transfer_handle Not utilizated. Supply NULL.

Description
===========

   The shmemx_add_nb routine performs a non-blocking atomic add operation. It
   adds value to target on PE pe and atomically updates the target without
   returning the value.

Return Values
=============

   None.

Notes
=====

   None.

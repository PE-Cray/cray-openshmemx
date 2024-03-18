shmem_ptr
=========

::

   Returns a local pointer to a symmetric data object on the specified PE.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void *shmem_ptr(const void *dest, int pe);

Deprecated Synopsos
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   POINTER (PTR, POINTEE)
   INTEGER pe
   PTR = SHMEM_PTR(dest, pe)

Arguments
=========

::

   dest    The symmetric data object to be referenced.
   pe      An integer that indicates the PE number on which dest is to
           be accessed.  When using Fortran, it must be a  default integer
           value.

Description
===========

::

   shmem_ptr returns an address that may be used to directly reference dest
   on the specified PE.  This address can be assigned to a pointer. After that,
   ordinary loads and stores to this remote address may be performed.

   The shmem_ptr routine can provide an efficient means to accomplish
   communication, for example when a sequence of reads and writes to a data
   object on a remote PE does not match the access pattern provided in an
   OpenSHMEM data transfer routine like shmem_put or shmem_iget.

Return Values
=============

::

   The address of the dest data object is returned when it is accessible
   using memory loads and stores.  Otherwise, a null pointer is returned.

Notes
=====

::

   When calling shmem_ptr, dest is the address of the referenced symmetric data
   object on the calling PE.


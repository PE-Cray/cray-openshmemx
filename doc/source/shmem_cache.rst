shmem_cache
===========

::

   Controls data cache utilities.

Deprecated Synopsis
===================

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void shmem_clear_cache_inv(void);
   void shmem_set_cache_inv(void);
   void shmem_clear_cache_line_inv(void *dest);
   void shmem_set_cache_line_inv(void *dest);
   void shmem_udcflush(void);
   void shmem_udcflush_line(void *dest);

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_CLEAR_CACHE_INV
   CALL SHMEM_SET_CACHE_INV
   CALL SHMEM_SET_CACHE_LINE_INV(dest)
   CALL SHMEM_UDCFLUSH
   CALL SHMEM_UDCFLUSH_LINE(dest)

Arguments
=========

::

   dest        A data object that is local to the PE.  dest can be of any
               noncharacter type. When using Fortran, it can be of any kind.

Description
===========

::

   shmem_set_cache_inv enables automatic cache coherency mode.

   shmem_set_cache_line_inv enables automatic cache coherency mode for
   the cache line associated with the address of dest only.

   shmem_clear_cache_inv disables automatic cache coherency mode
   previously enabled by shmem_set_cache_inv or
   shmem_set_cache_line_inv.

   shmem_udcflush makes the entire user data cache coherent.

   shmem_udcflush_line makes coherent the cache line that corresponds with
   the address specified by dest.

Return Values
=============

::

   None.

Notes
=====

::

   These routines have been retained for improved backward compatibility with
   legacy architectures.  They are not required to be supported by implementing
   them as no-ops and where used, they may have no effect on cache line
   states.

Examples
========

None.

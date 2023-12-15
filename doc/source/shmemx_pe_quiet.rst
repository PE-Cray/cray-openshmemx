shmemx_pe_quiet
===============

::

   Waits for the completion of all Put, AMO, and memory store routines to
   symmetric data objects to a particular target.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_pe_quiet(int target_pe);

Arguments
=========

::

   target_pe     The pe on which to perform the operation.

Description
===========

::

   The shmem_pe_quiet routine ensure the completion of all operations
   to a particular process rather than all processes as in the existing
   shmem_quiet operation. shmem_pe_quiet waits for the local completion of all
   Put, AMO, and memory store routines to symmetric data objects to a
   particular target.

Return Values
=============

::

   None.

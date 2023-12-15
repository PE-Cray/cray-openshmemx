shmem_pe_accessible
===================

::

   Determines whether a PE is accessible via OpenSHMEM's data transfer
   routines.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_pe_accessible(int pe);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   LOGICAL LOG, SHMEM_PE_ACCESSIBLE
   INTEGER pe
   LOG = SHMEM_PE_ACCESSIBLE(pe)

Arguments
=========

::

   pe  Specific PE to be checked for accessibility from the local PE.

Description
===========

::

   shmem_pe_accessible is a query routine that indicates whether a specified PE
   is accessible via OpenSHMEM from the local PE. The shmem_pe_accessible routine
   returns a value indicating whether the remote PE is a process running from the
   same executable file as the local PE, thereby indicating whether full support
   for symmetric data objects, which may reside in either static memory or the
   symmetric heap, is available.

Return Values
=============

::

   C/C++: The return value is 1 if the specified PE is a valid remote PE for
   OpenSHMEM routines; otherwise, it is 0.

   Fortran: The return value is .TRUE. if the specified PE is a valid
   remote PE for OpenSHMEM routines; otherwise, it is .FALSE..

Notes
=====

::

   This routine may be particularly useful for hybrid programming with other
   communication libraries (such as MPI) or parallel languages.  For
   example, when an MPI job uses Multiple Program Multiple Data (MPMD) mode,
   multiple executable MPI programs are executed as part of the same MPI job.
   In such cases, OpenSHMEM support may only be available between processes
   running from the same executable file.  In addition, some environments may
   allow a hybrid job to span multiple network partitions.  In such scenarios,
   OpenSHMEM support may only be available between PEs within the same partition.

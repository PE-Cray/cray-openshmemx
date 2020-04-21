shmem_addr_accessible
=====================

::

   Determines whether an address is accessible via OpenSHMEM data transfer
   routines from the specified remote PE.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_addr_accessible(const void *addr, int pe);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   LOGICAL LOG, SHMEM_ADDR_ACCESSIBLE
   INTEGER pe
   LOG - SHMEM_ADDR_ACCESSIBLE(addr, pe)

Arguments
---------

::

   addr    Data object on the local PE.
   pe      Integer id of a remote PE.

Description
-----------

::

   shmem_addr_accessible is a query routine that indicates whether a local
   address is accessible via OpenSHMEM routines from the specified remote PE.

   This routine verifies that the data object is symmetric and accessible with
   respect to a remote PE via OpenSHMEM data transfer routines.  The
   specified address addr is a data object on the local PE.

Return Values
-------------

::

   C/C++: The return value is 1 if addr is a symmetric data object
   and accessible via OpenSHMEM routines from the specified remote PE;
   otherwise, it is 0.

   Fortran: The return value is .TRUE. if addr is a symmetric data
   object and accessible via OpenSHMEM routines from the specified remote PE;
   otherwise, it is .FALSE..

Notes
-----

::

   This routine may be particularly useful for hybrid programming with other
   communication libraries (such as MPI) or parallel languages.  For
   example, when an MPI job uses MPMD mode, multiple executable MPI programs
   may use OpenSHMEM routines.  In such cases, static memory, such as a Fortran
   common block or C global variable, is symmetric between processes running
   from the same executable file, but is not symmetric between processes
   running from different executable files. Data allocated from the symmetric
   heap (shmem_malloc or shpalloc) is symmetric across the same or different
   executable files.

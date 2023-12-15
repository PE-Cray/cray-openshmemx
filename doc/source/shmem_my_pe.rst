shmem_my_pe
===========

::

   Returns the number of the calling PE.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_my_pe(void);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER SHMEM_MY_PE, ME
   ME = SHMEM_MY_PE()

Arguments
=========

::

   None.

Description
===========

::

   This routine returns the PE number of the calling PE.  It accepts no
   arguments.  The result is an integer between 0 and npes - 1, where npes is
   the total number of PEs executing the current program.

Return Values
=============

::

   Integer - Between 0 and npes - 1

Notes
=====

::

   Each PE has a unique number or identifier. As of OpenSHMEM[1.2]
   the use of _my_pe has been deprecated. Although OpenSHMEM libraries are
   required to support the call, users are encouraged to use shmem_my_pe
   instead.  The behavior and signature  of the routine shmem_my_pe remains
   unchanged from the deprecated _my_pe version.

Examples
========

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      shmem_init();
      int me = shmem_my_pe();
      int npes = shmem_n_pes();
      printf("I am #%d of %d PEs executing this program\n", me, npes);
      shmem_finalize();
      return 0;
   }

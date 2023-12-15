shmem_n_pes
===========

::

   Returns the number of PEs running in a program.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_n_pes(void);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER SHMEM_N_PES, N_PES
   N_PES = SHMEM_N_PES()

Arguments
=========

::

   None.

Description
===========

::

   The routine returns the number of PEs running in the program.

Return Values
=============

::

   Integer -  Number of PEs running in the OpenSHMEM program.

Notes
=====

::

   As of OpenSHMEM[1.2] the use of _num_pes has been deprecated. Although
   OpenSHMEM libraries are required to support the call, users are encouraged
   to use shmem_n_pes instead.  The behavior and signature  of the routine
   shmem_n_pes remains unchanged from the deprecated _num_pes version.

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

shmem_global_exit
=================

::

   A routine that allows any PE to force termination of an entire program.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   _Noreturn void shmem_global_exit(int status);

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_global_exit(int status);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER STATUS
   CALL SHMEM_GLOBAL_EXIT(status)

Arguments
=========

::

   status  The exit status from the main program.

Description
===========

::

   shmem_global_exit is a non-collective routine that allows any one PE to force
   termination of an OpenSHMEM program for all PEs, passing an exit status to
   the execution environment. This routine terminates the entire program, not
   just the OpenSHMEM portion.  When any PE calls shmem_global_exit, it results
   in the immediate notification to all PEs to terminate.  shmem_global_exit
   flushes I/O and releases resources in accordance with  C/C++/Fortran language
   requirements for normal program termination. If more than one PE calls
   shmem_global_exit, then the exit status returned to the environment shall be
   one of the values passed to shmem_global_exit as the status argument.  There
   is no return to the caller of shmem_global_exit; control is returned from the
   OpenSHMEM program to the execution environment for all PEs.

Return Values
=============

::

   None.

Notes
=====

::

   shmem_global_exit may be used in situations where one or more PEs have
   determined that the program has completed and/or should terminate early.
   Accordingly, the integer status argument can be used to pass any information
   about the nature of the exit; e.g., that the program encountered an error or
   found a solution. Since shmem_global_exit is a non-collective routine, there
   is no implied synchronization, and all PEs must terminate regardless of their
   current execution state. While I/O must be flushed for standard language I/O
   calls from  C/C++/Fortran, it is implementation dependent as to how I/O done
   by other means (e.g., third party I/O libraries) is handled. Similarly,
   resources are released according to C/C++/Fortran standard language
   requirements, but this may not include all resources allocated for the
   OpenSHMEM program. However, a quality implementation will make a best effort
   to flush all I/O and clean up all resources.

Examples
========

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <stdlib.h>
   #include <shmem.h>

   int main(void)
   {
      shmem_init();
      int me = shmem_my_pe();
      if (me == 0) {
         FILE *fp = fopen("input.txt", "r");
         if (fp == NULL) {  /* Input file required by program is not available */
            shmem_global_exit(EXIT_FAILURE);
         }
         /* do something with the file */
         fclose(fp);
     }
     shmem_finalize();
     return 0;
   }

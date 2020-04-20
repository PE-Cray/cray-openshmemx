shmem_finalize
=======

::

   A collective operation that releases all resources used by the OpenSHMEM
   library.  This only terminates the OpenSHMEM portion of a program, not the
   entire program.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_finalize(void);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_FINALIZE()

Arguments
---------

::

   None.

Description
-----------

::

   shmem_finalize is a collective operation that ends the OpenSHMEM portion of
   a program previously initialized by shmem_init or shmem_init_thread and
   releases all resources used by the OpenSHMEM library. This collective
   operation requires all PEs to participate in the call. There is an implicit
   global barrier in shmem_finalize to ensure that pending communications are
   completed and that no resources are released until all PEs have entered
   shmem_finalize. This routine destroys all shareable contexts.  The user is
   responsible for destroying all contexts with the SHMEM_CTX_PRIVATE option
   enabled prior to calling this routine; otherwise, the behavior is undefined.
   shmem_finalize must be the last OpenSHMEM library call encountered in the
   OpenSHMEM portion of a program. A call to shmem_finalize will release all
   resources initialized by a corresponding call to shmem_init or shmem_init_thread.
   All processes that represent the PEs will still exist after the call to
   shmem_finalize returns, but they will no longer have access to resources
   that have been released.

Return Values
-------------

::

   None.

Notes
-----

::

   shmem_finalize releases all resources used by the OpenSHMEM library including
   the symmetric memory heap and pointers initiated by shmem_ptr. This collective
   operation requires all PEs to participate in the call, not just a subset of
   the PEs. The non-OpenSHMEM portion of a program may continue after a call to
   shmem_finalize by all PEs.

Examples
--------

C/C++ Example
-------------

::

   The following finalize example is for C11 programs:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static long x - 10101;
      long y - -1;

      shmem_init();
      int me - shmem_my_pe();
      int npes - shmem_n_pes();

      if (me -- 0)
         y - shmem_g(&x, npes-1);

      printf("%d: y - %ld\n", me, y);

      shmem_finalize();
      return 0;
   }

shmemx_thread_unregister
=======

::

   shmem_thread_register - cray specific routine to unregister threads on a
   previously registered thread using shmemx_thread_register routine

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_thread_unregister(void);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEMX_THREAD_UNREGISTER

Description
-----------

::

   If the currently provided thread safety level is SHMEM_THREAD_MULTIPLE, any
   thread that calls shmemx_thread_register() must call shmemx_thread_unregister()
   to unregister the thread before the thread exits. Failure to do this is
   undefined behavior that may cause the program to fail. If the calling thread
   is registered, this routine unregisters the thread, otherwise this routine
   has no effect. If this routine encounters an error, it prints an error message
   and aborts.

Notes
-----

::

   Most thread-safe SHMEM calls must occur while the calling thread is
   registered; that is, between a shmemx_thread_register() call and a
   shmemx_thread_unregister() call. The following routines are exempt
   from this restriction.

   -   shmemx_init_thread()
   -   shmem_finalize()
   -   shmem_query_thread()
   -   shmem_my_pes()
   -   shmem_n_pes()

   All other thread-safe SHMEM calls should occur while the calling thread
   is registered.

shmemx_thread_register
======================

::

   shmem_thread_register - cray specific routine to register threads to
   obtain thread specific resource for optimized performance on a multithreaded
   OpenSHMEM application

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_thread_register(void);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEMX_THREAD_REGISTER

Description
===========

::

   If the currently provided thread safety level is SHMEM_THREAD_MULTIPLE, any
   thread can perform Cray OpenSHMEMX operation. If the calling thread is
   registered using shmemx_thread_register call, Cray OpenSHMEMX will try to
   allocate separate resource for optimized performance.

   Any thread that has called shmemx_thread_register must call
   shmemx_thread_unregister to unregister itself properly. See the
   shmemx_thread_unregister(3) man page.

   If this routine encounters an error, it will print an error message and
   abort. If the number of threads currently registered exceeds the user's
   specified maximum number of threads making Cray OpenSHMEMX calls (the value
   of the SHMEM_MAX_NUM_THREADS environment variable) this routine
   will print an error message and abort.

Notes
=====

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

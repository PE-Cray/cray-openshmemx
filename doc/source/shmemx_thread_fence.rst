shmemx_thread_fence
=======

::

   shmemx_thread_fence - cray specific routine to perform thread-specific
   version of the shmem_fence routine

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_thread_fence(void);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEMX_THREAD_FENCE

Description
-----------

::

   This function is the thread-specific version of the shmem_fence
   routine. The function ensures ordering of put (remote write) and
   non-blocking get operations. All such operations, which are issued by
   the calling thread to a particular remote processing element (PE) prior
   to the call to shmemx_thread_fence, are guaranteed to be delivered
   before any subsequent such operations to the same PE that follow the
   call to shmemx_thread_fence and are issued by the calling thread.

   If this routine encounters an error, it will print an error message and
   abort.

Notes
-----

::

   Use the shmemx_thread_quiet function to allow an individual thread
   to wait for completion of the puts and non-blocking gets it previously
   issued.

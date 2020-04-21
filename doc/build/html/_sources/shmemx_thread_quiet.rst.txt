shmemx_thread_quiet
=======

::

   shmemx_thread_quiet - cray specific routine to perform thread-specific
   version of the shmem_quiet routine

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_thread_quiet(void);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEMX_THREAD_QUIET

Description
-----------

::

   The shmemx_thread_quiet function is the thread-specific version of
   the shmem_quiet routine. It allows an individual thread to wait for
   completion of puts and non-blocking gets it previously issued. All put
   or non-blocking get operations issued prior to the call to
   shmemx_thread_quiet are guaranteed to be visible to all other
   processes no later than any subsequent memory load or store, remote put
   or get, AMO, or synchronization operations that follow the call to
   shmemx_thread_quiet.

   If this routine encounters an error, it will print an error message and
   abort.

Notes
-----

::

   Use the shmemx_thread_quiet function to allow an individual thread
   to wait for completion of the puts and non-blocking gets it previously
   issued.

   The shmemx_thread_quiet function is most useful as a way of
   ensuring ordering of delivery of several put operations. For example,
   you might use shmemx_thread_quiet to await delivery of a block of
   data before issuing another put that sets a completion flag on another
   thread.

   The shmemx_thread_quiet function is not needed if shmem_barrier(3),
   shmem_barrier_all(3), or shmem_quiet(3) are called. The barrier
   routines all wait for the completion of outstanding remote writes
   (puts) of all threads. It is the programmer's responsibility to ensure
   overall thread safety when using the above APIs.

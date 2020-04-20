shmem_init_thread
=======

::

   Initializes the OpenSHMEM library, similar to shmem_init, and performs any
   initialization required for supporting the provided thread level.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_init_thread(int requested, int *provided);

Arguments
---------

::

   requested   The thread level support requested by the user.
   provided    The thread level support provided by the OpenSHMEM implementation.

Description
-----------

::

   shmem_init_thread initializes the OpenSHMEM library in the same way as
   shmem_init. In addition, shmem_init_thread also performs the initialization
   required for supporting the provided thread level. The argument requested is
   used to specify the desired level of thread support. The argument provided
   returns the support level provided by the library. The allowed values for
   provided and requested are SHMEM_THREAD_SINGLE, SHMEM_THREAD_FUNNELED,
   SHMEM_THREAD_SERIALIZED, and SHMEM_THREAD_MULTIPLE.

   An OpenSHMEM program is initialized either by shmem_init or shmem_init_thread.
   Once an OpenSHMEM library initialization call has been performed, a
   subsequent initialization call in the same program results in undefined
   behavior. If the call to shmem_init_thread is unsuccessful in allocating and
   initializing resources for the OpenSHMEM library, then the behavior of any
   subsequent call to the OpenSHMEM library is undefined.

Return Values
-------------

::

   shmem_init_thread returns 0 upon success; otherwise, it returns a non-zero value.

Notes
-----

::

   The OpenSHMEM library can be initialized either by shmem_init or
   shmem_init_thread. If the OpenSHMEM library is initialized by shmem_init, the
   library implementation can choose to support any one of the defined thread
   levels.

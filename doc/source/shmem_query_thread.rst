shmem_query_thread
=======

::

   Returns the level of thread support provided by the library.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_query_thread(int *provided);

Arguments
---------

::

   provided    The thread level support provided by the OpenSHMEM implementation.

Description
-----------

::

   The shmem_query_thread call returns the level of thread support currently
   being provided. The value returned will be same as was returned in provided
   by a call to shmem_init_thread, if the OpenSHMEM library was initialized by
   shmem_init_thread. If the library was initialized by shmem_init, the
   implementation can choose to provide any one of the defined thread levels,
   and shmem_query_thread returns this thread level.

Return Values
-------------

::

   None.

Notes
-----

::

   None.

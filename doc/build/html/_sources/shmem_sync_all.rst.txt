shmem_sync_all
=======

::

   Registers the arrival of a PE at a barrier and suspends PE execution until
   all other PEs arrive at the barrier.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_sync_all(void);

Arguments
---------

::

   None.

Description
-----------

::

   The shmem_sync_all routine registers the arrival of a PE at a barrier.
   Barriers are a fast mechanism for synchronizing all PEs at once. This routine
   blocks the PE until all PEs have called shmem_sync_all. In a multithreaded
   OpenSHMEM program, only the calling thread is blocked.

   In contrast with the shmem_barrier_all routine, shmem_sync_all only ensures
   completion and visibility of previously issued memory stores and does not
   ensure completion of remote memory updates issued via OpenSHMEM routines.

Return Values
-------------

::

   None.

Notes
-----

::

   The shmem_sync_all routine can be used to portably ensure that memory access
   operations observe remote updates in the order enforced by the initiator PEs,
   provided that the initiator PE ensures completion of remote updates with a
   call to shmem_quiet prior to the call to the shmem_sync_all routine.

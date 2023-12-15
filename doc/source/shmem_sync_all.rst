shmem_sync_all
==============

::

   Registers the arrival of a PE at a synchronization point and suspends
   execution until all other PEs in the world team arrive at the
   synchronization point. For multithreaded programs, execution is suspended
   as specified by the threading model.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_sync_all(void);

Arguments
=========

::

   None.

Description
===========

::

   This routine blocks the calling PE until all PEs in the world team have
   called shmem_sync_all. In a multithreaded OpenSHMEM program, only the
   calling thread is blocked. In contrast with the shmem_barrier_all routine,
   shmem_sync_all only ensures completion and visibility of previously issued
   memory stores and does not ensure completion of remote memory updates
   issued via OpenSHMEM routines.

Return Values
=============

::

   None.

Notes
=====

::

   The shmem_sync_all routine is equivalent to calling shmem_team_sync on
   the world team.

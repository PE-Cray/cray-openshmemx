shmem_signal_fetch
==================

::

   Fetches the signal update on a local data object.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   uint64_t shmem_signal_fetch(const uint64_t *sig_addr);

Arguments
=========

::

   sig_addr    Local address of the remotely accessible signal variable.

Description
===========

::

   shmem_signal_fetch performs a fetch operation and returns the contents of
   the sig_addr signal data object. Access to sig_addr signal object at the
   calling PE is expected to satisfy the atomicity guarantees as described
   in Atomicity Guarantees for Signaling Operations.

Return Values
=============

::

   Returns the contents of the signal data object, sig_addr, at the calling PE.

Notes
=====

::

   None.

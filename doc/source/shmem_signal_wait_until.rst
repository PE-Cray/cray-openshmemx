shmem_signal_wait_until
=======================

::

   Wait for a variable on the local PE to change from a signaling operation.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   uint64_t shmem_signal_wait_until(uint64_t *sig_addr, int cmp, uint64_t cmp_value);

Arguments
=========

::

   sig_addr    Local address of the source signal variable.
   cmp         The comparison operator that compares sig_addr with cmp_value.
   cmp_value   The value against which the object pointed to by sig_addr will
               be compared.

Description
===========

::

   shmem_signal_wait_until operation blocks until the value contained in the
   signal data object, sig_addr, at the calling PE satisfies the wait
   condition. In an OpenSHMEM program with single-threaded or multithreaded
   PEs, the sig_addr object at the calling PE is expected only to be updated
   as a signal, through the signaling operations available in Section 9.8.3
   and Section 9.8.4. This routine can be used to implement point-to-point
   synchronization between PEs or between threads within the same PE. A call
   to this routine blocks until the value of sig_addr at the calling PE
   satisfies the wait condition specified by the comparison operator, cmp, and
   comparison value, cmp_value

Return Values
=============

::

   Return the contents of the signal data object, sig_addr, at the calling PE
   that satisfies the wait condition

Notes
=====

::

   Implementations must ensure that shmem_signal_wait_until do not return
   before the update of the memory indicated by sig_addr is fully complete.
   Partial updates to the memory must not cause shmem_signal_wait_until to
   return.

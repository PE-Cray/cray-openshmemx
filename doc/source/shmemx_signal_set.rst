shmemx_signal_set
=================

   Sets the signal value of a remote data object.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_signal_set(shmem_ctx_t ctx, const uint64_t *sig_addr, uint64_t signal,
                        int pe);

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_signal_set(const uint64_t *sig_addr, uint64_t signal, int pe);
   void shmem_ctx_signal_set(shmem_ctx_t ctx, const uint64_t *sig_addr,
                        uint64_t signal, int pe);

Arguments
=========

   ctx         A context handle specifying the context associated with this
               session. When this argument is not provided, the operation is
               performed on the default context.
   sig_addr    Symmetric address of the signal data object to be updated on the
               remote PE
   signal      Unsigned 64-bit value that is used for updating the remote
               sig_addr signal data object.
   pe          PE number of remote target process.

Description
===========

   shmem_signal_set writes value into the signal data object pointed to by
   sig_addr on target PE. The update to the sig_addr signal object at the
   calling PE is expected to satisfy the atomicity guarantees as provided
   by the SHMEM signaling operations. Refer shmem_put_signal operations for
   more details on the signaling atomicity guarantees.

Return Values
=============

   None.

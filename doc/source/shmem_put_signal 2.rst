shmem_put_signal
================

   The put-with-signal routines provide a method for copying data from a
   contiguous local data object to a data object on a specified PE and
   subsequently updating a remote flag to signal completion.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_put_signal(TYPE *dest, const TYPE *source, size_t nelems,
       uint64_t *sig_addr, uint64_t signal, int sig_op, int pe);
   void shmem_put_signal(shmem_ctx_t ctx, TYPE *dest, const TYPE *source,
       size_t nelems, uint64_t *sig_addr, uint64_t signal, int sig_op, int pe);

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_put_signal(TYPE *dest, const TYPE *source, size_t nelems,
       uint64_t *sig_addr, uint64_t signal, int sig_op, int pe);
   void shmem_ctx_TYPENAME_put_signal(shmem_ctx_t ctx, TYPE *dest,
       const TYPE *source, size_t nelems, uint64_t *sig_addr, uint64_t signal,
       int sig_op, int pe);

where TYPE is one of the standard RMA types and has a corresponding
TYPENAME specified by Table:1

.. code:: bash

   void shmem_putSIZE_signal(void *dest, const void *source, size_t nelems,
       uint64_t *sig_addr, uint64_t signal, int sig_op, int pe);
   void shmem_ctx_putSIZE_signal(shmem_ctx_t ctx, void *dest, const void *source,
       size_t nelems, uint64_t *sig_addr, uint64_t signal, int sig_op, int pe);

where SIZE is one of 8, 16, 32, 64, 128.

.. code:: bash

   void shmem_putmem_signal(void *dest, const void *source, size_t nelems,
       uint64_t *sig_addr, uint64_t signal, int sig_op, int pe);
   void shmem_ctx_putmem_signal(shmem_ctx_t ctx, void *dest, const void *source,
       size_t nelems, uint64_t *sig_addr, uint64_t signal, int sig_op, int pe);

Datatype Reference Table
========================

Table:1
-------

     |           TYPE          |      TYPENAME       |
     |-------------------------|---------------------|
     |   short                 |     short           |
     |   int                   |     int             |
     |   long                  |     long            |
     |   long long             |     longlong        |
     |   unsigned short        |     ushort          |
     |   unsigned int          |     uint            |
     |   unsigned long         |     ulong           |
     |   unsigned long long    |     ulonglong       |
     |   int32_t               |     int32           |
     |   int64_t               |     int64           |
     |   uint32_t              |     uint32          |
     |   uint64_t              |     uint64          |
     |   size_t                |     size            |
     |   ptrdiff_t             |     ptrdiff         |

Arguments
=========

   ctx     A context handle specifying the context on which to perform the
           operation. When this argument is not provided, the operation is
           performed on the default context.
   dest    Symmetric address of the data object to be updated on the remote PE.
           The type of dest should match that implied in the SYNOPSIS section.
   source  Local address of data object containing the data to be copied.
           The type of source should match that implied in the
           SYNOPSIS section.
   nelems  Number of elements in the dest and source arrays. For
           shmem_putmem_signal and shmem_ctx_putmem_signal, elements are bytes.
   sig_addr    Symmetric address of the signal data object to be updated on the
           remote PE as a signal.
   signal  Unsigned 64-bit value that is used for updating the remote sig_addr
           signal data object.
   sig_op  Signal operator that represents the type of update to be performed
           on the remote sig_addr signal data object.
   pe      PE number of the remote PE.

Description
===========

   The put-with-signal routines provide a method for copying data from a
   contiguous local data object to a data object on a specified PE and
   subsequently updating a remote flag to signal completion. The routines
   return after the data has been copied out of the source array on the
   local PE.

   The sig_op signal operator determines the type of update to be performed on
   the remote sig_addr signal data object. The completion of signal update
   based on the sig_op signal operator using the signal flag on the remote PE
   indicates the delivery of its corresponding dest data words into the data
   object on the remote PE.

   An update to the sig_addr signal data object through a put-with-signal
   routine completes as if performed atomically as described by Atomicity
   Guarantees for Signaling Operations. The various options, as defined in
   Available Signal Operators, can be used as the sig_op signal operator.

Return Values
=============

   None.

Notes
=====

   The dest and sig_addr data objects must both be remotely accessible. The
   sig_addr and dest could be of different kinds, for example, one could be a
   global/static C variable and the other could be allocated on the
   symmetric heap.

   sig_addr and dest may not be overlapping in memory.

   The completion of signal update using the signal flag on the remote PE
   indicates only the delivery of its corresponding dest data words into the
   data object on the remote PE. Without a memory-ordering operation, there is
   no implied ordering between the signal update of a put-with-signal routine
   and another data transfer. For example, the completion of the signal update
   in a sequence consisting of a put routine followed by a put-with-signal
   routine does not imply delivery of the put routine’s data.

Examples
========

C/C++ Example
-------------

   The following example demonstrates the usage of shmem_put_signal. It shows
   the implementation of a broadcast operation from PE 0 to itself and all
   other PEs in the job as a simple ring-based algorithm using
   shmem_put_signal:

.. code:: c

   #include <shmem.h>
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>

   int main(void) {
       int i, err_count = 0;

       shmem_init();

       size_t size = 2048;
       int mype = shmem_my_pe();
       int npes = shmem_n_pes();
       int pe = (mype + 1) % npes;
       uint64_t *message = malloc(size * sizeof(uint64_t));
       static uint64_t sig_addr = 0;

       for (i = 0; i < size; i++) {
           message[i] = mype;
       }

       uint64_t *data = shmem_calloc(size, sizeof(uint64_t));

       if (mype == 0) {
           shmem_put_signal(data, message, size, &sig_addr, 1,
               SHMEM_SIGNAL_SET, pe);
       }
       else {
           shmem_wait_until(&sig_addr, SHMEM_CMP_EQ, 1);
           shmem_put_signal(data, data, size, &sig_addr, 1, SHMEM_SIGNAL_SET, pe);
       }

       free(message);
       shmem_free(data);

       shmem_finalize();
       return 0;
   }

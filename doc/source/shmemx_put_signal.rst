shmemx_put_signal
=================

::

   The put-with-signal routine provide a method for copying data from a
   contiguous local data obeject to a data object on a specified PE and then
   setting a remote signal flag indicating the data transfer is complete.

Definitions
===========

C/C++ SYNOPSIS
--------------

.. code:: bash

   void shmemx_TYPENAME_put_signal(TYPE *target, const TYPE *source, size_t len,
                                   uint64_t *sig_addr, uint64_t signal, int pe)

where TYPE is one of the standard RMA types and has a corresponding
TYPENAME specified by Table:1

.. code:: bash

   void shmem_putSIZE(void *target, const void *source, size_t len,
                      uint64_t *sig_addr, uint64_t signal, int pe)

where SIZE is one of 8, 16, 32, 64, 128.

.. code:: bash

   void shmem_putmem(void *target, const void *source, size_t len,
                     uint64_t *sig_addr, uint64_t signal, int pe)

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER len, pe
   UNSIGNED(KIND=8) sig_addr(*)
   UNSIGNED(KIND=8) signal

   <TYPE> target(*), source(*)
   CALL SHMEMX_PUT_SIGNAL(target, source, len, sig_addr, signal, pe)

   <TYPE> target(*), source(*)
   CALL SHMEMX_PUTMEM_SIGNAL(target, source, len, sig_addr, signal, pe)

   <TYPE>(KIND=4) target(*), source(*)
   CALL SHMEMX_PUT4_SIGNAL(target, source, len, sig_addr, signal, pe)

   <TYPE>(KIND=8) target(*), source(*)
   CALL SHMEMX_PUT8_SIGNAL(target, source, len, sig_addr, signal, pe)

   <TYPE>(KIND=2) target(*), source(*)
   CALL SHMEMX_PUT16_SIGNAL(target, source, len, sig_addr, signal, pe)

   <TYPE>(KIND=4) target(*), source(*)
   CALL SHMEMX_PUT32_SIGNAL(target, source, len, sig_addr, signal, pe)

   <TYPE>(KIND=8) target(*), source(*)
   CALL SHMEMX_PUT64_SIGNAL(target, source, len, sig_addr, signal, pe)

   <TYPE>(KIND=16) target(*), source(*)
   CALL SHMEMX_PUT128_SIGNAL(target, source, len, sig_addr, signal, pe)

   CHARACTER*(*) target(*), source(*)
   CALL SHMEMX_CHARACTER_PUT_SIGNAL(target, source, len, sig_addr, signal, pe)

   COMPLEX target(*), source(*)
   CALL SHMEMX_COMPLEX_PUT_SIGNAL(target, source, len, sig_addr, signal, pe)

   DOUBLE PRECISION target(*), source(*)
   CALL SHMEMX_DOUBLE_PUT_SIGNAL(target, source, len, sig_addr, signal, pe)

   INTEGER target(*), source(*)
   CALL SHMEMX_INTEGER_PUT_SIGNAL(target, source, len, sig_addr, signal, pe)

   LOGICAL target(*), source(*)
   CALL SHMEMX_LOGICAL_PUT_SIGNAL(target, source, len, sig_addr, signal, pe)

   REAL target(*), source(*)
   CALL SHMEMX_REAL_PUT_SIGNAL(target, source, len, sig_addr, signal, pe)

Datatype Reference Table
========================

Table:1
-------

::

     |           TYPE          |      TYPENAME       |
     |-------------------------|---------------------|
     |   float                 |     float           |
     |   double                |     double          |
     |   long double           |     longdouble      |
     |   char                  |     char            |
     |   int                   |     int             |
     |   long                  |     long            |
     |   long long             |     longlong        |

Arguments
=========

::

      target    Data object on the remote PE to be updated. This data object
                must be remotely accessible.

      source    Data object containing the data to be copied.

      len       Number of elements to transfer. len must be of type integer.
                If using Fortran, it must be a constant, variable, or array
                element of default integer type.

      sig_addr  Data object on the remote PE to be updated with the signal. For
                optimal performance, this object should be in the same memory
                segment (data segment or symmetric heap) as the data object
                specified in target.

      signal    The unsigned 64-bit value used to set the remote flag. If using
                Fortran, it must be a constant, variable, or array element of
                unsigned type (kind=8).

      pe        PE number of the remote PE. pe must be of type integer. If you
                are using Fortran, it must be a constant, variable, or array
                element of default integer type.

Description
===========

::

   The block data put+signal routines provide a high-performance method for
   copying contiguous data from a data object on the local PE to a
   contiguous data object on a remote PE and then setting a remote signal
   flag indicating the data transfer is complete. These routines are
   blocking; that is, the routines return only after the data has been
   copied from the source data object on the local PE, but not necessarily
   before the data has been copied to the target data object on the remote
   PE. Calling shmem_quiet (or routines that call it) guarantees that
   all puts previously issued by this PE are complete, indicating the data
   has been copied to the target on the remote PE and the remote signal
   flag has been set.

Notes
=====

::

   Per OpenSHMEM specification 1.2 Annex C, support for zero-length
   transfers is provided for zero-length get, put, and put with signals.
   Remote memory transfers for zero number of elements are accepted, and
   this support is provided for both block and non-blocking transfers. For
   put with signals, if the number of elements is zero, only the signal is
   passed. The usage of NULL pointers for data transfer usually leads to
   program abort, but for zero-length transfers, the usage of NULL pointers
   is accepted.

Example
=======

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <stdlib.h>
   #include <shmem.h>
   #include <shmemx.h>

   #define MAX_SIZE (2<<10)
   #define VAL_USED 10

   int
   main(int argc, char* argv[])
   {
       int i, err_count  = 0;

       shmem_init();

       size_t    size    = MAX_SIZE;
       int       me      = shmem_my_pe();
       int       n       = shmem_n_pes();
       int       pe      = (me + 1)%n;

       uint64_t* message = malloc(size * sizeof(uint64_t));
       uint64_t* data    = shmem_malloc(size * sizeof(uint64_t));
       uint64_t* signals = shmem_malloc(sizeof(uint64_t));

       signals[0] = 0;
       for (i = 0; i < size; i++) {
           message[i] = VAL_USED;
           data[i]    = 0;
       }
       shmem_barrier_all();

       if (me != 0) {
           shmem_long_wait_until((long *)&signals[0], SHMEM_CMP_EQ, 1);
       }

       shmemx_putmem_signal(data, message, size*sizeof(uint64_t),
               &signals[0], 1, pe);

       if (me == 0) {
           shmem_long_wait_until((long *)&signals[0], SHMEM_CMP_EQ, 1);
           printf("BCAST with put with signal is complete\n");
       }

       free(message);
       shmem_free(data);
       shmem_free(signals);

       shmem_finalize();
       return 0;
   }

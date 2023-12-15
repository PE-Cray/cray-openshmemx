shmem_malloc_with_hints
=======================

::

   Collective memory allocation routine with support for providing hints.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void *shmem_malloc_with_hints(size_t size, long hints);

Arguments
=========

::

   IN      size     The size, in bytes, of a block to be allocated from the
                    symmetric heap. This argument is of type size_t
   IN      hints    A bit array of hints provided by the user to the
                    implementation

Description
===========

::

   The shmem_malloc_with_hints routine, like shmem_malloc, returns a pointer to
   a block of at least size bytes, which shall be suitably aligned so that it
   may be assigned to a pointer to any type of object. This space is allocated
   from the symmetric heap (similar to shmem_malloc). When the size is zero,
   the shmem_malloc_with_hints routine performs no action and returns a null
   pointer.

   In addition to the size argument, the hints argument is provided by the user.
   The hints describes the expected manner in which the OpenSHMEM program may
   use the allocated memory. The valid usage hints are described in Table 1.
   Multiple hints may be requested by combining them with a bitwise OR operation.
   A zero option can be given if no options are requested.

   The information provided by the hints is used to optimize for performance by
   the implementation. If the implementation cannot optimize, the behavior is
   same as shmem_malloc. If more than one hint is provided, the implementation
   will make the best effort to use one or more hints to optimize performance.

   The shmem_malloc_with_hints routine is provided so that multiple PEs in a
   program can allocate symmetric, remotely accessible memory blocks. When no
   action is performed, these routines return without performing a barrier.
   Otherwise, the routine will call a procedure that is semantically equivalent
   to shmem_barrier_all on exit. This ensures that all PEs participate in the
   memory allocation, and that the memory on other PEs can be used as soon as
   the local PE returns. The implicit barrier performed by this routine will
   quiet the default context. It is the user’s responsibility to ensure that no
   communication operations involving the given memory block are pending on
   other contexts prior to calling the shmem_free and shmem_realloc routines.
   The user is also responsible for calling these routines with identical
   argument(s) on all PEs; if differing size, or hints arguments are used, the
   behavior of the call and any subsequent OpenSHMEM calls is undefined.

Return Values
=============

::

   The shmem_malloc_with_hints routine returns a pointer to the allocated space;
   otherwise, it returns a null pointer.

Table:1
=======

::

   | Hints                         |  Usage hint                         |
   |-------------------------------|-------------------------------------|
   | 0                             |  Behavior same as shmem_malloc      |
   | SHMEM_MALLOC_ATOMICS_REMOTE   |  Memory used for atomic operations  |
   | SHMEM_MALLOC_SIGNAL_REMOTE    |  Memory used for signal operations  |

Notes
=====

::

   OpenSHMEM programs should allocate memory with SHMEM_MALLOC_ATOMICS_REMOTE
   when the majority of operations performed on this memory are atomic
   operations, and origin and target PEs of the atomic operations do not share
   a memory domain. That is, symmetric objects on the target PE are not
   accessible using load/store operations from the origin PE or vice versa

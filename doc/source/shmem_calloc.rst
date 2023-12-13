shmem_calloc
============

Allocate a zeroed block of symmetric memory.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void *shmem_calloc(size_t count, size_t size);

Arguments
=========

   count   The number of elements to allocate.
   size    The size in bytes of each element to allocate.

Description
===========

   The shmem_calloc routine is a collective operation that allocates a
   region of remotely-accessible memory for an array of count objects of size
   bytes each and returns a pointer to the lowest byte address of the allocated
   symmetric memory. The space is initialized to all bits zero.

   If the allocation succeeds, the pointer returned shall be suitably aligned so
   that it may be assigned to a pointer to any type of object. If the allocation
   does not succeed, or either count or size is 0, the return value is a null
   pointer.

   The values for count and size shall each be equal across all PEs calling
   shmem_calloc; otherwise, the behavior is undefined.

   The shmem_calloc routine calls a procedure that is semantically equivalent to
   shmem_barrier_all on exit.

Return Values
=============

   The shmem_calloc routine returns a pointer to the lowest byte address of the
   allocated space; otherwise, it returns a null pointer.

Notes
=====

None.

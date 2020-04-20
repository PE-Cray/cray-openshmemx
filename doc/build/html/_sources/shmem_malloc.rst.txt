shmem_malloc
=======

::

   Collective symmetric heap memory management routines.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void *shmem_malloc(size_t size);
   void shmem_free(void *ptr);
   void *shmem_realloc(void *ptr, size_t size);
   void *shmem_align(size_t alignment, size_t size);

Arguments
---------

::

   size    The size, in bytes, of a block to be allocated from the symmetric
           heap. This argument is of type size_t
   ptr     Points to a block within the symmetric heap.
   alignment   Byte alignment of the block allocated from the symmetric heap.

Description
-----------

::

   The shmem_malloc, shmem_free, shmem_realloc, and shmem_align routines are
   collective operations that require participation by all PEs.

   The shmem_malloc routine returns a pointer to a block of at least
   size bytes suitably aligned for any use.  This space is allocated from the
   symmetric heap (in contrast to malloc, which allocates from the private
   heap).

   The shmem_align routine allocates a block in the symmetric heap that has
   a byte alignment specified by the alignment argument.

   The shmem_free routine causes the block to which ptr points to be
   deallocated, that is, made available for further allocation.  If ptr is a
   null pointer, no action occurs.

   The shmem_realloc routine changes the size of the block to which
   ptr points to the size (in bytes) specified by size.  The contents
   of the block are unchanged up to the lesser of the new and old sizes. If the
   new size is larger, the newly allocated portion of the block is
   uninitialized.  If ptr is a null pointer, the shmem_realloc routine behaves
   like the shmem_malloc routine for the specified size.  If size is 0 and ptr
   is not a null pointer, the block to which it points is freed. If the space
   cannot be allocated, the block to which ptr points is unchanged.

   The shmem_malloc, shmem_align, shmem_free, and shmem_realloc routines
   are provided  so that multiple PEs in a program can allocate symmetric,
   remotely accessible memory blocks.  These memory blocks can then be used with
   OpenSHMEM communication routines.  Each of these routines includes at least one
   call to a procedure that is semantically equivalent to shmem_barrier_all:
   shmem_malloc and shmem_align call a barrier on exit; shmem_free calls a
   barrier on entry; and shmem_realloc may call barriers on both entry and exit,
   depending on whether an existing allocation is modified and whether new
   memory is allocated. This ensures that all PEs participate in the memory
   allocation, and that the memory on other PEs can be used as soon as the local
   PE returns. The implicit barriers performed by these routines quiet the
   default context.  It is the user's responsibility to ensure that no
   communication operations involving the given memory block are pending on
   other contexts prior to calling the shmem_free and shmem_realloc routines.
   The user is also responsible for calling these routines with identical
   argument(s) on all PEs; if differing ptr, size, or alignment arguments are
   used, the behavior of the call and any subsequent OpenSHMEM calls is undefined.

Return Values
-------------

::

   The shmem_malloc routine returns a pointer to the allocated space;
   otherwise, it returns a null pointer.

   The shmem_free routine returns no value.

   The shmem_realloc routine returns a pointer to the allocated space
   (which may have moved); otherwise, it returns a null pointer.

   The shmem_align routine returns an aligned pointer to the allocated
   space; otherwise, it returns a null pointer.

Notes
-----

::

   As of OpenSHMEM[1.2] the use of shmalloc, shmemalign, shfree, and shrealloc
   has been deprecated. Although OpenSHMEM libraries are required to support the
   calls, users are encouraged to use shmem_malloc, shmem_align, shmem_free, and
   shmem_realloc instead.  The behavior and signature  of the routines
   remains unchanged from the deprecated versions.

   The total size of the symmetric heap is determined at job startup.  One can
   specify the size of the heap using the SHMEM_SYMMETRIC_SIZE environment
   variable (where available).

   The shmem_malloc, shmem_free, and shmem_realloc routines
   differ from the private heap allocation routines in that all PEs in a
   program must call them (a barrier is used to ensure this).

   The symmetric heap allocation routines always return a pointer to corresponding
   symmetric objects across all PEs. The OpenSHMEM specification does not
   require that the virtual addresses are equal across all PEs. Nevertheless,
   the implementation must avoid costly address translation operations in the
   communication path, including O(N) memory translation tables,
   where N is the number of PEs.  In order to avoid address translations, the
   implementation may re-map the allocated block of memory based on agreed virtual
   address.  Additionally, some operating systems provide an option to disable
   virtual address randomization, which enables predictable allocation of virtual
   memory addresses.

shmem_ptr
=======

::

   Returns a local pointer to a symmetric data object on the specified PE.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void *shmem_ptr(const void *dest, int pe);

Deprecated Synopsos
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   POINTER (PTR, POINTEE)
   INTEGER pe
   PTR - SHMEM_PTR(dest, pe)

Arguments
---------

::

   dest    The symmetric data object to be referenced.
   pe      An integer that indicates the PE number on which dest is to
           be accessed.  When using Fortran, it must be a  default integer
           value.

Description
-----------

::

   shmem_ptr returns an address that may be used to directly reference dest
   on the specified PE.  This address can be assigned to a pointer. After that,
   ordinary loads and stores to this remote address may be performed.

   The shmem_ptr routine can provide an efficient means to accomplish
   communication, for example when a sequence of reads and writes to a data
   object on a remote PE does not match the access pattern provided in an
   OpenSHMEM data transfer routine like shmem_put or shmem_iget.

Return Values
-------------

::

   The address of the dest data object is returned when it is accessible
   using memory loads and stores.  Otherwise, a null pointer is returned.

Notes
-----

::

   When calling shmem_ptr, dest is the address of the referenced symmetric data
   object on the calling PE.

Examples
--------

Fortran Example
---------------

::

   This  Fortran  program calls shmem_ptr and then PE 0 writes to the BIGD
   array on PE 1:

.. code:: bash

   PROGRAM REMOTEWRITE
   INCLUDE "shmem.fh"

   INTEGER BIGD(100)
   SAVE BIGD

   INTEGER POINTEE(*)
   POINTER (PTR,POINTEE)

   CALL SHMEM_INIT()


   IF (SHMEM_MY_PE() .EQ. 0) THEN
      ! initialize PE 1's BIGD array
      PTR - SHMEM_PTR(BIGD, 1)     ! get address of PE 1's BIGD
                                   !   array
      DO I-1,100
           POINTEE(I) - I
      ENDDO
   ENDIF

   CALL SHMEM_BARRIER_ALL

   IF (SHMEM_MY_PE() .EQ. 1) THEN
      PRINT*,'BIGD on PE 1 is: '
      PRINT*,BIGD
   ENDIF
   END

C/C++ Example
-------------

::

   This is the equivalent program written in C11:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static int dest[4];
      shmem_init();
      int me - shmem_my_pe();
      if (me -- 0) { /* initialize PE 1's dest array */
         int* ptr - shmem_ptr(dest, 1);
         if (ptr -- NULL)
            printf("can't use pointer to directly access PE 1's dest array\n");
         else
            for (int i - 0; i < 4; i++)
               *ptr++ - i + 1;
      }
      shmem_barrier_all();
      if (me -- 1)
         printf("PE 1 dest: %d, %d, %d, %d\n",
            dest[0], dest[1], dest[2], dest[3]);
      shmem_finalize();
      return 0;
   }

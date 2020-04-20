shmem_lock
=======

::

   Releases, locks, and tests a mutual exclusion memory lock.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_clear_lock(long *lock);
   void shmem_set_lock(long *lock);
   int shmem_test_lock(long *lock);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER lock, SHMEM_TEST_LOCK
   CALL SHMEM_CLEAR_LOCK(lock)
   CALL SHMEM_SET_LOCK(lock)
   I - SHMEM_TEST_LOCK(lock)

Arguments
---------

::

   lock    A symmetric data object that is a scalar variable or an array
           of  length 1.  This data  object  must  be set to 0 on all
           PEs prior to the first use.  lock  must  be  of type long.
           When using Fortran, it must be of default kind.

Description
-----------

::

   The shmem_set_lock routine sets a mutual exclusion lock after  waiting
   for  the lock  to be freed by any other PE currently holding the lock.
   Waiting PEs are assured of getting the lock in a first-come, first-served
   manner.  The shmem_clear_lock routine releases a lock  previously set
   by shmem_set_lock after ensuring that all local and remote   stores
   initiated in the critical region are complete.  The shmem_test_lock
   routine sets a mutual exclusion lock only if it is currently cleared. By
   using this routine, a PE can avoid blocking on a set lock.  If the lock is
   currently set, the routine returns without waiting.  These routines are
   appropriate for protecting a critical region from simultaneous update by
   multiple PEs.

Return Values
-------------

::

   The shmem_test_lock routine returns 0 if  the lock  was originally cleared
   and  this  call was  able  to set the lock.  A value of 1 is returned if the
   lock had been set and the call returned without waiting to set the lock.

Notes
-----

::

   The lock variable should always be initialized to zero and accessed only by
   the OpenSHMEM locking API.  Changing the value of the lock variable by other
   means without using the OpenSHMEM API, can lead to undefined behavior.

Examples
--------

C/C++ Example
-------------

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
      static long lock - 0;
      static int count - 0;
      shmem_init();
      int me - shmem_my_pe();
      shmem_set_lock(&lock);
      int val - shmem_g(&count, 0); /* get count value on PE 0 */
      printf("%d: count is %d\n", me, val);
      val++; /* incrementing and updating count on PE 0 */
      shmem_p(&count, val, 0);
      shmem_quiet();
      shmem_clear_lock(&lock);
      shmem_finalize();
      return 0;
   }

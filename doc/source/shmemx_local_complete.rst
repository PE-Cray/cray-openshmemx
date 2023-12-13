shmemx_local_complete
=====================

   Waits for local completion of all outstanding non-blocking PUT and
   PUT-WITH-SIGNAL routines to symmetric data objects issued by a PE.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_local_complete(void);

Arguments
=========

   None.

Description
===========

   The shmemx_local_complete routine ensures local completion of all
   outstanding non-blocking PUT and PUT-WITH-SIGNAL operations. By local
   completion, the operation refers to the reusability of all the source buffer
   involved in all outstanding non-blocking PUT and PUT-WITH-SIGNAL operations.

   Return from shmemx_local_complete guarantees the reusability of the source
   buffer involved in all prevoiusly posted non-blocking PUT and PUT-WITH-SIGNAL
   operations.

   Return from shmemx_local_complete does not guarantee the global visibility
   of any previously posted operation. It is user responsibility to initiate
   some memory ordering operation like shmem_quiet to observe global visiblity
   of the previously locally completed operations.

Return Values
=============

   None.

Notes
=====

   None.

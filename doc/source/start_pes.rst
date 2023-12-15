start_pes
=========

::

   Called at the beginning of an OpenSHMEM program to initialize the execution
   environment. This routine is deprecated and is provided for backwards 
   compatibility. Implementations must include it, and the routine should 
   function properly and may notify the user about deprecation of its use.

Definitions
===========

Deprecated Synopsis
===================

Deprecated C/C++ Synopsis
-------------------------

.. code:: bash

   void start_pes(int npes);

Arguments
=========

::

   npes    Unused  Should be set to 0.

Description
===========

::

   The start_pes routine initializes the OpenSHMEM execution environment. An
   OpenSHMEM program must call start_pes, shmem_init, or shmem_init_thread 
   before calling any other OpenSHMEM routine. Unlike shmem_init and 
   shmem_init_thread, start_pes does not require a call to shmem_finalize. 
   Instead, the OpenSHMEM library is implicitly finalized when the program 
   exits. Implicit finalization is collective and includes a global 
   synchronization to ensure that all pending communication is completed 
   before resources are released.

Return Values
=============

::

   None.

Notes
=====

::

   If any other OpenSHMEM call occurs before start_pes, the behavior is
   undefined. Although it is recommended to set npes to 0 for start_pes, 
   this is not mandated. The value is ignored. Calling start_pes more
   than once has no subsequent effect.
   As of OpenSHMEM 1.2 the use of start_pes has been deprecated. Although
   OpenSHMEM libraries are required to support the call, users are 
   encouraged to use shmem_init or shmem_init_thread instead.

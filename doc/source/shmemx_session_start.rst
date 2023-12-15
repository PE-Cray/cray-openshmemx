shmemx_session_start
====================

::

   Start a communication session.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_session_start(shmem_ctx_t ctx, long options);

Arguments
=========

::

   ctx         A context handle specifying the context associated with this
               session.

   options     The set of requested options from Table 9 for this session.
               Multiple options may be requested by combining them with a
               bitwise OR operation; otherwise, 0 can be given if no options
               are requested

Description
===========

::

   The shmemx_session_start routine begins a session on communication context
   ctx with hints requested via options. If a session is already started on a
   given context, another call to shmemx_session_start on that context
   combines any new options via a bitwise OR operation. Sessions on a
   communication context must be stopped with a call to shmem_session_stop on
   the same context. Passing false or ambiguous options to a session should
   not result in undefined behavior, but may result in the library aborting
   the program.

Return Values
=============

::

   None.

Session Hint Options
====================

+--------------------------+-------------------------------------------+
| Option                   | Usage hint                                |
+==========================+===========================================+
| SHMEM_SESSION_BUNDLE     | Bundle ops where the implemenation has an |
|                          | expectation of                            |
|                          | further operations of the same type       |
+--------------------------+-------------------------------------------+
| SHMEM_SESSION_HRP        | High rate put optimizationion             |
+--------------------------+-------------------------------------------+
| SHMEM_SESSION_STAMO      | This session will contain single transfer |
|                          | AMOs                                      |
+--------------------------+-------------------------------------------+
| SHMEM                    | This session will contain single access   |
| _SESSION_NO_CNCR_TACCESS | AMOs                                      |
+--------------------------+-------------------------------------------+
| SHMEM_SESSION_OP_PUT     | This session will contain non-blocking    |
|                          | put and/or                                |
|                          | scalar put operations                     |
+--------------------------+-------------------------------------------+
| SHMEM_SESSION_OP_AMO     | This session will contain non-fetching    |
|                          | AMOs                                      |
+--------------------------+-------------------------------------------+
| SHMEM_SESSION_OP_FAMO    | This session will contain fetching AMOs   |
+--------------------------+-------------------------------------------+
| SHMEM_SESSION_OP_PWS     | This session will contain non-blocking    |
|                          | put-with-signal                           |
|                          | operations                                |
+--------------------------+-------------------------------------------+
| SHMEM_SESSION_DC         | All operations within this session will   |
|                          | be using                                  |
|                          | delivery complete semantics instead of    |
|                          | the transmit                              |
|                          | complete default                          |
+--------------------------+-------------------------------------------+

Notes
=====

::

   The shmemx_session_start routine is a hint for improving performance, and
   OpenSHMEM implementations are not required to apply any optimization.
   Implementations are encouraged to supply users with information about the
   session options being applied or ignored; for instance, when SHMEM_DEBUG is
   set.

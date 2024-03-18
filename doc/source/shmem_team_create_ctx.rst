shmem_team_create_ctx
=====================

::

   Create a communication context from a team.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_team_create_ctx(shmem_team_t team, long options, shmem_ctx_t *ctx);

Arguments
=========

::

   team    A handle to the specified PE team.
   options     The set of options requested for the given context. Multiple
               options may be requested by combining them with a bitwise OR
               operation; otherwise, 0 can be given if no options are
               requested.
   ctx     A handle to the newly created context.

Description
===========

::

   The shmem_team_create_ctx routine creates a new communication context and
   returns its handle through the ctx argument. This context is created from
   the team specified by the team argument; however, the context creation
   operation is not collective.
   In addition to the team, the shmem_team_create_ctx routine accepts the same
   arguments and provides all the same return conditions as the
   shmem_ctx_create routine.
   The shmem_team_create_ctx routine may be called any number of times to
   create multiple simultaneously existing contexts for the team. Programs
   should request the total number of simultaneous contexts to be created from
   the team during team creation. See SHMEM_TEAM_CONFIG_T for more information
   on how to request contexts during team creation.
   A call to shmem_team_create_ctx on a team may fail, regardless of the
   configuration request for contexts, if the implementation is unable to
   create a context at the time when shmem_team_create_ctx is called.
   All explicitly created resources associated with a team must be destroyed
   before the shmem_team_destroy routine is called. If a context returned from
   shmem_team_create_ctx is not explicitly destroyed before the team is
   destroyed, behavior is undefined.
   All OpenSHMEM routines that operate on this context will do so with respect
   to the associated PE team.
   That is, all point-to-point routines operating on this context will use
   team-relative PE numbering.
   If team compares equal to SHMEM_TEAM_INVALID, then a nonzero value is
   returned and ctx is set to SHMEM_CTX_INVALID. If team is otherwise invalid,
   the behavior is undefined.

Return Values
=============

::

   Zero on success and nonzero otherwise.

Notes
=====

::

   None.


shmem_ctx_get_team
==================

   Retrieve the team associated with the communication context.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_ctx_get_team(shmem_ctx_t ctx, shmem_team_t *team);

Arguments
=========

   ctx     A handle to a communication context.
   team    A pointer to a handle to the associated PE team.

Description
===========

   The shmem_ctx_get_team routine returns a handle to the team associated
   with the specified communication context ctx. The team handle is returned
   through the pointer argument team.

   If ctx is the default context or one created by a call to shmem_ctx_create,
   team is assigned the handle value SHMEM_TEAM_WORLD.

   If ctx compares equal to SHMEM_CTX_INVALID, then team is assigned the value
   SHMEM_TEAM_INVALID and a nonzero value is returned. If ctx is otherwise
   invalid, the behavior is undefined.

   If team is a null pointer, the behavior is undefined.

Return Values
=============

   Zero on success; otherwise, nonzero.

Notes
=====

   None.

shmem_team_get_config
=====================

::

   Return the configuration parameters of a given team

C/C++ Synopsis
--------------

.. code:: bash

       int shmem_team_get_config(shmem_team_t team, long config_mask, shmem_team_config_t *config);

Arguments
=========

::

   IN      team            An OpenSHMEM team handle
   IN      config_mask     The bitwise mask representing the set of
                           configuration parameters to fetch from the given team.
   OUT     config          A pointer to the configuration parameters for the
                           given team.

Description
===========

::

   shmem_team_get_config returns through the config argument the configuration
   parameters as described by the mask, which were assigned according to input
   configuration parameters when the team was created.

   If team compares equal to SHMEM_TEAM_INVALID, then no operation is performed.
   If team is otherwise invalid, the behavior is undefined.

Return Values
=============

::

   If team does not compare equal to SHMEM_TEAM_INVALID, then
   shmem_team_get_config returns 0; otherwise, it returns nonzero.

Notes
=====

::

   None.

Examples
========

::

   None.

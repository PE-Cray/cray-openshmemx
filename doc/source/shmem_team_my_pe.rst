shmem_team_my_pe
================

::

   Returns the number of the calling PE within a specified team.

C/C++ Synopsis
--------------

.. code:: bash

       int shmem_team_my_pe(shmem_team_t team);

Arguments
=========

::

   IN team An OpenSHMEM team handle.

Description
===========

::

   When team specifies a valid team, the shmem_team_my_pe routine returns the
   number of the calling PE within the specified team. The number is an integer
   between 0 and N − 1 for a team containing N PEs.

   Each member of the team has a unique number.

   If team compares equal to SHMEM_TEAM_INVALID, then the value -1 is returned.
   If team is otherwise invalid, the behavior is undefined.

Return Values
=============

::

   The number of the calling PE within the specified team, or the value -1 if
   the team handle compares equal to SHMEM_TEAM_INVALID.

Notes
=====

::

   For the world team, this routine will return the same value as shmem_my_pe.

Examples
========

::

   None.

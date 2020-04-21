shmemx_team_split_strided
=======

::

   shmemx_team_split_strided - collective routine to partition the existing
   parent team into a new SHMEM team based on the PE triplet (PE_start,
   PE_stride, and PE_size) supplied to the function.

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_team_split_strided(shmem_team_t parent_team, int PE_start,
                                  int PE_stride, int PE_size,
                                  shmem_team_t *newteam);

Deprecated Synopsis
-------------------

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER PE_start, PE_stride, PE_size
   INTEGER(KIND-8) parent_team, newteam
   CALL SHMEMX_TEAM_SPLIT_STRIDED(parent_team, PE_start, PE_stride, PE_size, newteam)

Arguments
---------

::

   parent_team
       A valid SHMEM team. The predefined teams SHMEM_TEAM_WORLD or
       SHMEM_TEAM_NODE may be used, or any team created by the users.

   PE_start
       The lowest virtual PE number of the parent_team of PEs.

   PE_stride
       The stride between consecutive virtual PE numbers in the
       parent_team.

   PE_size
       The number of PEs in the defined set.

   newteam
       A new SHMEM team handle, representing a PE subset of all the
       PEs, that is created from the PE triplet provided.

Description
-----------

::

   The shmemx_team_split_strided function is a collective routine.
   It partitions the existing parent team into a new SHMEM team based on
   the PE triplet (PE_start, PE_stride, and PE_size) supplied to
   the function. It is important to note the use of the less restrictive
   PE_stride argument instead of logPE_stride. This method of
   creating a team with an arbitrary set of PEs is inherently restricted by
   its parameters, but allows for many additional use-cases over using a
   logPE_stride parameter, and may provide an easier transition for
   existing SHMEM programs to create and use SHMEM teams. This function
   must be called by all processes contained in the SHMEM triplet
   specification. It may be called by additional PEs not included in the
   triplet specification, but for those processes a newteam value of
   SHMEM_TEAM_NULL is returned. All calling processes must provide the
   same values for the PE triplet. This function will return a newteam
   containing the PE subset specified by the triplet, and ordered by the
   existing global PE rank value. None of the parameters need to reside in
   symmetric memory.

   Error checking will be done to ensure a valid PE triplet is provided,
   and also to determine whether a valid team handle is provided for the
   parent_team.

   All errors are considered fatal and will result in the job aborting with
   an informative error message.

Notes
-----

::

   Note that SHMEM team handles have local semantics only. That is, team
   handles should not be stored in shared variables and used across other
   processes. Doing so will result in unpredictable behavior.

shmemx_team_split_3d
=======

::

   shmemx_team_split_3d - partitions an existing parent team into three subgroups,
   based on the three-dimensional Cartesian space defined by the triplet (xrange,
   yrange, and zrange) describing the size of the Cartesian space in X, Y, and Z
   dimensions

Definitions
-----------

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_team_split_3d(shmem_team_t parent_team, int xrange, int yrange,
                             int zrange, shmem_team_t *xaxis_team,
                             shmem_team_t *yaxis_team, shmem_team_t *zaxis_team)

Arguments
---------

::

   parent_team
           A valid PE team. A predefined team constant or any team created by a
           split team routine may be used.

   xrange  A non-negative integer representing the number of elements in
           the first dimension.

   yrange  A non-negative integer representing the number of elements in
           the second dimension.

   zrange  A non-negative integer representing the number of elements in
           the third dimension.

   xaxis_team
           A new PE team handle representing a PE subset consisting of all the
           PEs that are in the same row in the X-axis.

   yaxis_team
           A new PE team handle representing a PE subset consisting of all the
           PEs that are in the same column in the Y-axis.

   zaxis_team
           A new PE team handle representing a PE subset consisting of all the
           PEs that are in the same position in in the Z-axis.

Description
-----------

::

   The shmemx_team_split_3d routine is a collective routine. It
   partitions an existing parent team into three subgroups, based on the
   three-dimensional Cartesian space defined by the triplet (xrange,
   yrange, and zrange) describing the size of the Cartesian space in X,
   Y, and Z dimensions. Each subgroup contains all PEs that are in the same
   dimension, along the X-axis, Y-axis and Z-axis. Within each subgroup,
   the PEs are ranked based on the position of the PE with respect to its
   dimension in three-dimensional Cartesian space.

   Any valid PE team can be used as the parent team. This routine must be
   called by all PEs in the parent team. The value of the triplets must be
   non-negative, and the size of the parent team should be greater than or
   equal to the size of the three-dimensional Cartesian space. None of the
   parameters need to reside in symmetric memory.

   Error checking will be done to ensure a valid team handle is provided.
   All errors are considered fatal and will result in the job aborting with
   an informative error message.

Examples
--------

C/C++ Example
-------------

::

   The example program shows the shmemx_team_split_3d routine being
   used to create three teams, consisting of PEs which share the same row
   on the X-axis as xaxis_team, PEs which share the same column on the
   Y-axis as yaxis_team, and PEs which share the same orientation on the
   Z-axis as zaxis_team. The size of the xaxis_team, yaxis_team,
   and zaxis_team are determined based on the xrange, yrange, and
   zrange values.

.. code:: bash

   #include <math.h>
   #include <stdio.h>
   #include <shmem.h>
   #include <shmemx.h>

   int main(int argc, char *argv[]) {
       int rank, npes;
       int t_pe, t_size;
       int xrange, yrange, zrange;
       shmem_team_t xaxis_team;
       shmem_team_t yaxis_team;
       shmem_team_t zaxis_team;

       shmem_init();
       rank - shmem_my_pe();
       npes - shmem_n_pes();

       xrange - (npes > 4) ? floor(log(npes)/log(2))-1 : 1;
       yrange - (npes > 4) ? floor(log(npes)/log(2))-1 : 1;
       zrange - (npes / (xrange*yrange));
       shmemx_team_split_3d(SHMEM_TEAM_WORLD, xrange, yrange,
                            zrange, &xaxis_team, &yaxis_team,
                            &zaxis_team);

       if (xaxis_team !- SHMEM_TEAM_NULL) {
           t_size - shmemx_team_npes(xaxis_team);
           t_pe   - shmemx_team_mype(xaxis_team);

           printf("Global PE %d has team_pe of %d out of %d in xaxis_team\n",
                  rank, t_pe, t_size);
       }

       if (yaxis_team !- SHMEM_TEAM_NULL) {
           t_size - shmemx_team_npes(yaxis_team);
           t_pe   - shmemx_team_mype(yaxis_team);

           printf("Global PE %d has team_pe of %d out of %d in yaxis_team\n",
                   rank, t_pe, t_size);
       }

       if (zaxis_team !- SHMEM_TEAM_NULL) {
           t_size - shmemx_team_npes(zaxis_team);
           t_pe   - shmemx_team_mype(zaxis_team);

           printf("Global PE %d has team_pe of %d out of %d in zaxis_team\n",
                   rank, t_pe, t_size);
       }

       shmem_barrier_all();
       shmem_finalize();
       return 0;
   }

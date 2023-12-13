shmem_team_split_2d
===================

   Create two new teams by splitting an existing parent team into two subsets
   based on a 2D Cartesian space defined by the xrange argument and a y
   dimension that is derived from xrange and the parent team size.

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_team_split_2d(shmem_team_t parent_team, int xrange,
                           const shmem_team_config_t *xaxis_config,
                           long xaxis_mask, shmem_team_t *xaxis_team,
                           const shmem_team_config_t *yaxis_config,
                           long yaxis_mask, shmem_team_t *yaxis_team);

Arguments
=========

   IN      parent_team     A valid OpenSHMEM team. Any predefined teams, such
                           as SHMEM_TEAM_WORLD, may be used, or any team
                           created by the user.
   IN      xrange          A positive integer representing the number of
                           elements in the first dimension.
   IN      xaxis_config    A pointer to the configuration parameters for the
                           new x-axis team.
   IN      xaxis_mask      The bitwise mask representing the set of
                           configuration parameters to use from xaxis_config.
   OUT     xaxis_team      A new PE team handle representing a PE subset
                           consisting of all the PEs that have the same
                           coordinate along the y-axis as the calling PE.
   IN      yaxis_config    A pointer to the configuration parameters for the
                           new y-axis team.
   IN      yaxis_mask      The bitwise mask representing the set of
                           configuration parameters to use from yaxis_config.
   OUT     yaxis_team      A new PE team handle representing a PE subset
                           consisting of all the PEs that have the same
                           coordinate along the x-axis as the calling PE.

Description
===========

   The shmem_team_split_2d routine is a collective operation. It returns two
   new teams to the calling PE by splitting an existing parent team into
   subsets based on a 2D Cartesian space. The user provides the size of the x
   dimension, which is then used to derive the size of the y dimension based on
   the size of the parent team. The size of the y dimension will be equal to
   [N ÷ xrange], where N is the size of the parent team. In other words,
   xrange * yrange ≥ N, so that every PE in the parent team has a unique (x,y)
   location in the 2D Cartesian space. The resulting xaxis_team and yaxis_team
   correspond to the calling PE’s row and column, respectively, in the 2D
   Cartesian space.

   The mapping of PE number to coordinates is (x, y) = (pe mod xrange, [pe÷xrange]),
   where pe is the PE number in the parent team. For example, if xrange = 3,
   then the first 3 PEs in the parent team will form the first xteam, the
   second three PEs in the parent team form the second xteam, and so on.

   Thus, after the split operation, each of the new xteams will contain all PEs
   that have the same coordinate along the y-axis as the calling PE. Each of
   the new yteams will contain all PEs with the same coordinate along the
   x-axis as the calling PE.

   The PEs are numbered in the new teams based on the coordinate of the PE along
   the given axis. As a result, the value returned by shmem_team_my_pe(xteam)
   is the x-coordinate and the value returned by shmem_team_my_pe(yteam) is the
   y-coordinate of the calling PE.

   Any valid OpenSHMEM team can be used as the parent team. This routine must
   be called by all PEs in the parent team. The value of xrange must be
   positive and all PEs in the parent team must pass the same value for xrange.
   When xrange is greater than the size of the parent team, shmem_team_split_2d
   behaves as though xrange were equal to the size of the parent team.

   The xaxis_config and yaxis_config arguments specify team configuration
   parameters for the x- and y-axis teams, respectively. These parameters are
   described in Section shmem_team_config(3). All PEs that will be in the same
   resultant team must specify the same configuration parameters. The PEs in
   the parent team do not have to all provide the same parameters for new teams.

   The xaxis_mask and yaxis_mask arguments are a bitwise masks representing the
   set of configuration parameters to use from xaxis_config and yaxis_config,
   respectively. A mask value of 0 indicates that the team should be created
   with the default values for all configuration parameters. See Section
   shmem_team_config(3) for field mask names and default configuration parameters.

   If parent_team compares equal to SHMEM_TEAM_INVALID, then no new teams will
   be created and both xaxis_team and yaxis_team will be assigned the value
   SHMEM_TEAM_INVALID. If parent_team is otherwise invalid, the behavior is
   undefined.

   If any xaxis_team or yaxis_team on any PE in parent_team cannot be created,
   then both team handles on all PEs in parent_team will be assigned the value
   SHMEM_TEAM_INVALID and shmem_team_split_2d will return a nonzero value

Return Values
=============

   Zero on successful creation of all xaxis_teams and yaxis_teams; otherwise,
   nonzero.

Notes
=====

   Since the split may result in a 2D space with more points than there are
   members of the parent team, there may be a final, incomplete row of the 2D
   mapping of the parent team. This means that the resultant yteams may vary in
   size by up to 1 PE, and that there may be one resultant xteam of smaller
   size than all of the other xteams.

   The following grid shows the 12 teams that would result from splitting a
   parent team of size 10 with xrange of 3. The numbers in the grid cells are
   the PE numbers in the parent team. The rows are the xteams. The columns are
   the yteams.

   |               |   yteam | yteam   |   yteam   |
   |               |   x=0   | x=1     |   x=2     |
   |   xteam, y=0  |   0     | 1       |   2       |
   |   xteam, y=1  |   3     | 4       |   5       |
   |   xteam, y=2  |   6     | 7       |   8       |
   |   xteam, y=3  |   9     |         |           |

   It would be legal, for example, if PEs 0, 3, 6, 9 specified a different
   value for yaxis_config than all of the other PEs, as long as the
   configuration parameters match for all PEs in each of the new teams. See the
   description of team handles and predefined teams in Section 9.4 for more
   information about team handle semantics and usage.

Examples
========

   Example 12. The following example demonstrates the use of 2D Cartesian split
   in a C/C++ program. This example shows how multiple 2D splits can be used to
   generate a 3D Cartesian split.

.. code:: bash

   #include <shmem.h>
   #include <stdio.h>
   #include <math.h>

   /* Find x and y such that x * y == npes and abs(x - y) is minimized. */
   static void find_xy_dims(int npes, int *x, int *y) {
       for(int divider = ceil(sqrt(npes)); divider >= 1; divider--) {
           if (npes % divider == 0) {
               *x = divider;
               *y = npes / divider;
               return;
           }
       }
   }

   /* Find x, y, and z such that x * y * z == npes and
    * abs(x - y) + abs(x - z) + abs(y - z) is minimized. */
   static void find_xyz_dims(int npes, int *x, int *y, int *z) {
       for(int divider = ceil(cbrt(npes)); divider >= 1; divider--) {
           if (npes % divider == 0) {
               *x = divider;
               find_xy_dims(npes / divider, y, z);
               return;
           }
       }
   }

   int main(void) {
       int xdim, ydim, zdim;
       shmem_init();

       int mype = shmem_my_pe();
       int npes = shmem_n_pes();

       find_xyz_dims(npes, &xdim, &ydim, &zdim);

       if (shmem_my_pe() == 0) printf("xdim = %d, ydim = %d, zdim = %d\n", xdim, ydim, zdim);

       shmem_team_t xteam, yzteam, yteam, zteam;
       shmem_team_split_2d(SHMEM_TEAM_WORLD, xdim, NULL, 0, &xteam, NULL, 0, &yzteam);

       // yzteam is immediately ready to be used in collectives
       shmem_team_split_2d(yzteam, ydim, NULL, 0, &yteam, NULL, 0, &zteam);

       // We don’t need the yzteam anymore
       shmem_team_destroy(yzteam);
       int my_x = shmem_team_my_pe(xteam);
       int my_y = shmem_team_my_pe(yteam);
       int my_z = shmem_team_my_pe(zteam);

       for (int zdx = 0; zdx < zdim; zdx++) {
           for (int ydx = 0; ydx < ydim; ydx++) {
               for (int xdx = 0; xdx < xdim; xdx++) {
                   if ((my_x == xdx) && (my_y == ydx) && (my_z == zdx)) {
                       printf("(%d, %d, %d) is mype = %d\n", my_x, my_y, my_z, mype);
                   }
                   shmem_team_sync(SHMEM_TEAM_WORLD);
               }
           }
       }
       shmem_finalize();
       return 0;
   }

The example above splits SHMEM_TEAM_WORLD into a 3D team with dimensions
xdim, ydim, and zdim, where each dimension is calculated using the
functions, find_xy_dims and find_xyz_dims. When running with 12 PEs, the
dimensions are 3x2x2, respectively, and the first split of
SHMEM_TEAM_WORLD results in 4 xteams and 3 yzteams:

yzteam x = 0 x = 1 x = 2 xteam yz = 0 0 1 2 yz = 1 3 4 5 yz = 2 6 7 8 yz
= 3 9 10 11 The second split of yzteam for x = 0, ydim = 2 results in 2
yteams and 2 zteams: zteam y = 0 y = 1 yteam z = 0 0 3 z = 1 6 9 The
second split of yzteam for x = 1, ydim = 2 results in 2 yteams and 2
zteams: zteam y = 0 y = 1 yteam z = 0 1 4 z = 1 7 10 The second split of
yzteam for x = 2, ydim = 2 results in 2 yteams and 2 zteams: zteam y = 0
y = 1 yteam z = 0 2 5 z = 1 8 11

The final number of teams for each dimension are: • 4 xteams: these are
teams where (z,y) is fixed and x varies. • 6 yteams: these are teams
where (x,z) is fixed and y varies. • 6 zteams: these are teams where
(x,y) is fixed and z varies. The expected output with 12 PEs is: xdim =
3, ydim = 2, zdim = 2 (0, 0, 0) is mype = 0 (1, 0, 0) is mype = 1 (2, 0,
0) is mype = 2 (0, 1, 0) is mype = 3 (1, 1, 0) is mype = 4 (2, 1, 0) is
mype = 5 (0, 0, 1) is mype = 6 (1, 0, 1) is mype = 7 (2, 0, 1) is mype =
8 (0, 1, 1) is mype = 9 (1, 1, 1) is mype = 10 (2, 1, 1) is mype = 11

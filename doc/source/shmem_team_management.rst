Team Managment with Cray OpenSHMEMX
===================================

   There are several enviroment variables and team config options that can be
   used to control how SHMEM handles teams. This section gives details about
   these options and how they impact team based routines.

   TEAM MEMORY OPTIMIZATION
       To improve the usage of memory there are team options that enable teams
       to allocate less memory than the default. This is done by shrinking
       the size of the type used to store certain team variables. This reduces
       memory usage at the expense of reducing the maximum number of PEs that
       can be assigned to a team. To enable this setting change environment
       variable SHMEM_ENABLE_TEAM_OPT to 1. The level can be controlled
       globally by setting the environment variable SHMEM_TEAM_OPT_LEVEL,
       values 0 - 3. Where the number of bytes used to store a value is
       determined by subtracting the optimization level from 4 bytes. For
       instance at level 2, 256 PEs can be on a given team. At level 3, 16 PEs
       can be on a given team.

       The optimization level can also be controlled per team within the
       team_config_t given during team creation, by changing the value of
       opt_level. The value of opt_level is 0 by default. This requires the
       environment variable SHMEM_ENABLE_TEAM_OPT to be set.

Enviroment variables
--------------------

   SHMEM_ENABLE_TEAM_OPT
       Default: 0
       Description: Enables the use of team memory optimizations

   SHMEM_TEAM_OPT_LEVEL
       default: 0
       description: Determines the global default value for opt_level during
                    team creation.

Team config type options
------------------------

   num_contexts
       default: 0
       description: The total number of simultaneously existing contexts that
                    the program requests to create from this team

   opt_level
       default: 0
       description: The memory optimization level for values stored by this
                    team.

Examples
========

Global:
-------

.. code:: bash

   # turns on memory optimization
   export SHMEM_TEAM_MEM_OPT_ENABLE=1

   # Sets global default memory optimization level to 1
   export SHMEM_TEAM_OPT_LEVEL=1
   srun -N2 --n-tasks-per-node=4 ./team_mem_opt_test

Per Team:
---------

.. code:: c

   /*      team_mem_opt_test.c
    * ASSUMES SHMEM_TEAM_OPT_ENABLE=1
    * Otherwise no optimizations used
    */

   #include <stdlib.h>
   #include <shmem.h>
   #include <stdio.h>

   #include "team_utils.h"

   int main(int argc, char *argv[])
   {

       int rank, npes, errs = 0;
       int t_pe, t_size;
       shmem_team_t new_team;
       shmem_team_config_t config;

       shmem_init();

       rank = shmem_my_pe();
       npes = shmem_n_pes();

       /* forces the team to be setup with optimization level 2 */
       config.opt_level = 2;
       config.num_contexts = 1;

       /* create a team of all even ranked PEs from SHMEM_TEAM_WORLD */

       shmem_team_split_strided(SHMEM_TEAM_WORLD, 0, 2, npes / 2, &config, 0, &new_team);

       if (new_team != SHMEM_TEAM_INVALID) {

           t_size = shmem_team_n_pes(new_team);
           t_pe = shmem_team_my_pe(new_team);

           if ((rank % 2 != 0) || (rank / 2 != t_pe) || (npes / 2 != t_size)) {
               fprintf(stderr, "Global PE %d, Team PE %d, Team Size %d\n", rank, t_pe, t_size);
               shmem_global_exit(1);
           }
       }

       shmem_barrier_all();

       shmem_finalize();

       return 0;
   }

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

Examples
========

C/C++ Example
-------------

::

   The following example demonstrates the use of contexts for multiple teams
   in a C/C++ program. This example shows contexts being used to communicate
   within a team using team PE numbers, and across teams using translated
   PE numbers.

.. code:: c

   #include <stdio.h>
   #include <shmem.h>

   int main(void)
   {
       static int sum = 0, val_2, val_3;
       shmem_team_t team_2, team_3;
       shmem_ctx_t ctx_2, ctx_3;
       shmem_team_config_t conf;

       shmem_init();

       int npes = shmem_n_pes();
       int mype = shmem_my_pe();
       conf.num_contexts = 1;
       long cmask = SHMEM_TEAM_NUM_CONTEXTS;

       /* Create team_2 with PEs numbered 0, 2, 4, ... */
       int ret = shmem_team_split_strided(SHMEM_TEAM_WORLD, 0, 2, (npes + 1) / 2,
           &conf, cmask, &team_2);

       if (ret != 0) {
           printf("%d: Error creating team team_2 (%d)\n", mype, ret);
           shmem_global_exit(ret);
       }

       /* Create team_3 with PEs numbered 0, 3, 6, ... */
       ret = shmem_team_split_strided(SHMEM_TEAM_WORLD, 0, 3, (npes + 2) / 3,
           &conf, cmask, &team_3);

       if (ret != 0) {
           printf("%d: Error creating team team_3 (%d)\n", mype, ret);
           shmem_global_exit(ret);
       }

       /* Create a context on team_2. */
       ret = shmem_team_create_ctx(team_2, 0, &ctx_2);

       if (ret != 0 && team_2 != SHMEM_TEAM_INVALID) {
           printf("%d: Error creating context ctx_2 (%d)\n", mype, ret);
           shmem_global_exit(ret);
       }

       /* Create a context on team_3. */
       ret = shmem_team_create_ctx(team_3, 0, &ctx_3);

       if (ret != 0 && team_3 != SHMEM_TEAM_INVALID) {
           printf("%d: Error creating context ctx_3 (%d)\n", mype, ret);
           shmem_global_exit(ret);
       }

       /*
        * Within each team, put my PE number
        * to my neighbor in a ring-based manner.
        */
       if (ctx_2 != SHMEM_CTX_INVALID) {
           int pe = shmem_team_my_pe(team_2);
           shmem_ctx_int_put(ctx_2, &val_2, &pe, 1,
               (pe + 1) % shmem_team_n_pes(team_2));
       }

       if (ctx_3 != SHMEM_CTX_INVALID) {
           int pe = shmem_team_my_pe(team_3);
           shmem_ctx_int_put(ctx_3, &val_3, &pe, 1,
               (pe + 1) % shmem_team_n_pes(team_3));
       }

       /*
        * Quiet both contexts and synchronize
        * all PEs to complete the data transfers.
        */
       shmem_ctx_quiet(ctx_2);
       shmem_ctx_quiet(ctx_3);
       shmem_team_sync(SHMEM_TEAM_WORLD);

       /*
        * Sum the values among PEs that are in
        * both team_2 and team_3 on PE 0 with ctx_2.
        */
       if (team_3 != SHMEM_TEAM_INVALID && team_2 != SHMEM_TEAM_INVALID)
           shmem_ctx_int_atomic_add(ctx_2, &sum, val_2 + val_3, 0);

       /* Quiet the context and synchronize PEs to complete the operation. */
       shmem_ctx_quiet(ctx_2);
       shmem_team_sync(SHMEM_TEAM_WORLD);

       /* Validate the result. */
       if (mype == 0) {
           int vsum = 0;
           for (int i = 0; i < npes; i ++) {
               if (i % 2 == 0 && i % 3 == 0) {
                   vsum += ((i - 2) < 0) ? shmem_team_n_pes(team_2) - 1 :
                       shmem_team_translate_pe(SHMEM_TEAM_WORLD, i - 2, team_2);
                   vsum += ((i - 3) < 0) ? shmem_team_n_pes(team_3) - 1 :
                       shmem_team_translate_pe(SHMEM_TEAM_WORLD, i - 3, team_3);
               }
           }
           if (sum != vsum) {
               fprintf(stderr, "Unexpected result, npes = %d, vsum = %d,
                   sum = %d\n", shmem_n_pes(), vsum, sum);
               shmem_global_exit(1);
           }
       }
       /* Destroy contexts before teams. */
       shmem_ctx_destroy(ctx_2);
       shmem_team_destroy(team_2);
       shmem_ctx_destroy(ctx_3);
       shmem_team_destroy(team_3);
       shmem_finalize();
       return 0;
   }

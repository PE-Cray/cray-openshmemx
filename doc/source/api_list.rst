API List
========

OpenSHMEM v1.4 Standard Features
--------------------------------

.. toctree::
   :maxdepth: 2
   :hidden:

   shmem_init
   shmem_finalize
   shmem_global_exit
   shmem_my_pe
   shmem_n_pes
   shmem_info_get_name
   shmem_info_get_version
   shmem_pe_accessible
   shmem_addr_accessible
   shmem_malloc
   shmem_calloc
   shmem_ptr
   shmem_init_thread
   shmem_query_thread
   shmem_ctx_create
   shmem_ctx_destroy
   shmem_p
   shmem_put
   shmem_put_nbi
   shmem_iput
   shmem_g
   shmem_get
   shmem_get_nbi
   shmem_iget
   shmem_atomic_add
   shmem_atomic_and
   shmem_atomic_compare_swap
   shmem_atomic_fetch
   shmem_atomic_fetch_add
   shmem_atomic_fetch_and
   shmem_atomic_fetch_inc
   shmem_atomic_fetch_or
   shmem_atomic_fetch_xor
   shmem_atomic_inc
   shmem_atomic_or
   shmem_atomic_set
   shmem_atomic_swap
   shmem_atomic_xor
   shmem_alltoall
   shmem_alltoalls
   shmem_barrier
   shmem_barrier_all
   shmem_broadcast
   shmem_collect
   shmem_reductions
   shmem_sync
   shmem_sync_all
   shmem_test
   shmem_wait_until
   shmem_fence
   shmem_quiet
   shmem_lock
   shmem_cache

1. Library Setup and Initialization
    * :doc:`shmem_init <shmem_init>`
    * :doc:`shmem_finalize <shmem_finalize>`
    * :doc:`shmem_global_exit <shmem_global_exit>`
    * :doc:`shmem_my_pe <shmem_my_pe>`
    * :doc:`shmem_n_pes <shmem_n_pes>`
2. Library Query
    * :doc:`shmem_info_get_name <shmem_info_get_name>`
    * :doc:`shmem_info_get_version <shmem_info_get_version>`
    * :doc:`shmem_pe_accessible <shmem_pe_accessible>`
    * :doc:`shmem_addr_accessible <shmem_addr_accessible>`
3. Memory Management
    * :doc:`shmem_malloc  <shmem_malloc>`
    * :doc:`shmem_calloc  <shmem_calloc>`
    * :doc:`shmem_ptr  <shmem_ptr>`
4. Thread Support
    * :doc:`shmem_init_thread  <shmem_init_thread>`
    * :doc:`shmem_query_thread  <shmem_query_thread>`
5. Communication Management
    * :doc:`shmem_ctx_create  <shmem_ctx_create>`
    * :doc:`shmem_ctx_destroy  <shmem_ctx_destroy>`
6. Remote Memory Access
    * :doc:`shmem_p  <shmem_p>`
    * :doc:`shmem_put  <shmem_put>`
    * :doc:`shmem_iput  <shmem_iput>`
    * :doc:`shmem_g  <shmem_g>`
    * :doc:`shmem_get  <shmem_get>`
    * :doc:`shmem_iget  <shmem_iget>`
7. Non-blocking Remote Memory Access
    * :doc:`shmem_put_nbi  <shmem_put_nbi>`
    * :doc:`shmem_get_nbi  <shmem_get_nbi>`
8. Atomic Memory Operations
    * :doc:`shmem_atomic_add  <shmem_atomic_add>`
    * :doc:`shmem_atomic_and  <shmem_atomic_and>`
    * :doc:`shmem_atomic_compare_swap  <shmem_atomic_compare_swap>`
    * :doc:`shmem_atomic_fetch  <shmem_atomic_fetch>`
    * :doc:`shmem_atomic_fetch_add  <shmem_atomic_fetch_add>`
    * :doc:`shmem_atomic_fetch_and  <shmem_atomic_fetch_and>`
    * :doc:`shmem_atomic_fetch_inc  <shmem_atomic_fetch_inc>`
    * :doc:`shmem_atomic_fetch_or  <shmem_atomic_fetch_or>`
    * :doc:`shmem_atomic_fetch_xor  <shmem_atomic_fetch_xor>`
    * :doc:`shmem_atomic_inc  <shmem_atomic_inc>`
    * :doc:`shmem_atomic_or  <shmem_atomic_or>`
    * :doc:`shmem_atomic_set  <shmem_atomic_set>`
    * :doc:`shmem_atomic_swap  <shmem_atomic_swap>`
    * :doc:`shmem_atomic_xor  <shmem_atomic_xor>`
9. Collective Operations
    * :doc:`shmem_alltoall  <shmem_alltoall>`
    * :doc:`shmem_alltoalls  <shmem_alltoalls>`
    * :doc:`shmem_barrier  <shmem_barrier>`
    * :doc:`shmem_barrier_all  <shmem_barrier_all>`
    * :doc:`shmem_broadcast  <shmem_broadcast>`
    * :doc:`shmem_collect  <shmem_collect>`
    * :doc:`shmem_reductions  <shmem_reductions>`
    * :doc:`shmem_sync  <shmem_sync>`
    * :doc:`shmem_sync_all  <shmem_sync_all>`
10. Point-to-Point Synchronizations
     * :doc:`shmem_test  <shmem_test>`
     * :doc:`shmem_wait_until  <shmem_wait_until>`
11. Memory Ordering
     * :doc:`shmem_fence  <shmem_fence>`
     * :doc:`shmem_quiet  <shmem_quiet>`
12. Distributed Locks
     * :doc:`shmem_lock  <shmem_lock>`


Cray-OpenSHMEMX-specific Features
---------------------------------

.. toctree::
   :maxdepth: 2
   :hidden:

   shmemx_init_thread
   shmemx_thread_fence
   shmemx_thread_quiet
   shmemx_thread_register
   shmemx_thread_unregister
   shmemx_put_signal
   shmemx_put_signal_nb
   shmemx_team_my_pe
   shmemx_team_n_pes
   shmemx_team_split_2d
   shmemx_team_split_3d
   shmemx_team_split_color
   shmemx_team_split_strided
   shmemx_team_translate_pe
   shmemx_alltoallv
   shmemx_alltoallv_packed
   shmemx_team_alltoall
   shmemx_team_alltoallv
   shmemx_team_alltoallv_packed
   shmemx_team_barrier
   shmemx_team_destroy
   shmemx_team_reductions

1. Thread-hot Operations
    * :doc:`shmemx_init_thread  <shmemx_init_thread>`
    * :doc:`shmemx_thread_fence  <shmemx_thread_fence>`
    * :doc:`shmemx_thread_quiet  <shmemx_thread_quiet>`
    * :doc:`shmemx_thread_register  <shmemx_thread_register>`
    * :doc:`shmemx_thread_unregister  <shmemx_thread_unregister>`
2. put-with-signal (PWS)
    * :doc:`shmemx_put_signal  <shmemx_put_signal>`
    * :doc:`shmemx_put_signal_nb  <shmemx_put_signal_nb>`
3. Team Management
    * :doc:`shmemx_team_my_pe  <shmemx_team_my_pe>`
    * :doc:`shmemx_team_n_pes  <shmemx_team_n_pes>`
    * :doc:`shmemx_team_split_2d  <shmemx_team_split_2d>`
    * :doc:`shmemx_team_split_3d  <shmemx_team_split_3d>`
    * :doc:`shmemx_team_split_color  <shmemx_team_split_color>`
    * :doc:`shmemx_team_split_strided  <shmemx_team_split_strided>`
    * :doc:`shmemx_team_translate_pe  <shmemx_team_translate_pe>`
4. Team-based Collectives
    * :doc:`shmemx_alltoallv  <shmemx_alltoallv>`
    * :doc:`shmemx_alltoallv_packed  <shmemx_alltoallv_packed>`
    * :doc:`shmemx_team_alltoall  <shmemx_team_alltoall>`
    * :doc:`shmemx_team_alltoallv  <shmemx_team_alltoallv>`
    * :doc:`shmemx_team_alltoallv_packed  <shmemx_team_alltoallv_packed>`
    * :doc:`shmemx_team_barrier  <shmemx_team_barrier>`
    * :doc:`shmemx_team_destroy  <shmemx_team_destroy>`
    * :doc:`shmemx_team_reductions  <shmemx_team_reductions>`



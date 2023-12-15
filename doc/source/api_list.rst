API List
========

OpenSHMEM v1.5 Standard Features
--------------------------------

.. toctree::
   :maxdepth: 2
   :hidden:

   shmem_init
   shmem_my_pe
   shmem_n_pes
   shmem_finalize
   shmem_global_exit
   shmem_addr_accessible
   shmem_pe_accessible
   shmem_ptr
   shmem_info_get_version
   shmem_info_get_name
   start_pes
   shmem_init_thread
   shmem_query_thread
   shmem_malloc
   shmem_malloc_with_hints
   shmem_calloc
   shmem_team_my_pe
   shmem_team_n_pes
   shmem_team_get_config
   shmem_team_translate_pe
   shmem_team_split_strided
   shmem_team_split_2d
   shmem_team_destroy
   shmem_ctx_create
   shmem_team_create_ctx
   shmem_ctx_destroy
   shmem_ctx_get_team
   shmem_put
   shmem_p
   shmem_iput
   shmem_get
   shmem_g
   shmem_iget
   shmem_put_nbi
   shmem_get_nbi
   shmem_atomic_fetch
   shmem_atomic_set
   shmem_atomic_compare_swap
   shmem_atomic_swap
   shmem_atomic_fetch_inc
   shmem_atomic_inc
   shmem_atomic_fetch_add
   shmem_atomic_add
   shmem_atomic_fetch_and
   shmem_atomic_and
   shmem_atomic_fetch_or
   shmem_atomic_or
   shmem_atomic_fetch_xor
   shmem_atomic_xor
   shmem_atomic_fetch_nbi
   shmem_atomic_compare_swap_nbi
   shmem_atomic_swap_nbi
   shmem_atomic_fetch_inc_nbi
   shmem_atomic_fetch_add_nbi
   shmem_atomic_fetch_and_nbi
   shmem_atomic_fetch_or_nbi
   shmem_atomic_fetch_xor_nbi
   shmem_put_signal
   shmem_put_signal_nbi
   shmem_signal_fetch
   shmem_barrier_all
   shmem_barrier
   shmem_sync
   shmem_sync_all
   shmem_alltoall
   shmem_alltoalls
   shmem_broadcast
   shmem_collect
   shmem_reductions
   shmem_wait_until
   shmem_wait_until_all
   shmem_wait_until_any
   shmem_wait_until_some
   shmem_wait_until_all_vector
   shmem_wait_until_any_vector
   shmem_wait_until_some_vector
   shmem_test
   shmem_test_all
   shmem_test_any
   shmem_test_some
   shmem_test_all_vector
   shmem_test_any_vector
   shmem_test_some_vector
   shmem_signal_wait_until
   shmem_fence
   shmem_quiet
   shmem_lock
   shmem_cache

1. Library Setup and Initialization
   start_pes
    * :doc:`shmem_init <shmem_init>`
    * :doc:`shmem_finalize <shmem_finalize>`
    * :doc:`shmem_global_exit <shmem_global_exit>`
    * :doc:`shmem_my_pe <shmem_my_pe>`
    * :doc:`shmem_n_pes <shmem_n_pes>`
    * :doc:`start_pes <start_pes>`
2. Library Query
    * :doc:`shmem_info_get_name <shmem_info_get_name>`
    * :doc:`shmem_info_get_version <shmem_info_get_version>`
    * :doc:`shmem_pe_accessible <shmem_pe_accessible>`
    * :doc:`shmem_addr_accessible <shmem_addr_accessible>`
3. Memory Management
    * :doc:`shmem_malloc  <shmem_malloc>`
    * :doc:`shmem_calloc  <shmem_calloc>`
    * :doc:`shmem_malloc_with_hints <shmem_malloc_with_hints>`
    * :doc:`shmem_ptr  <shmem_ptr>`
4. Thread Support
    * :doc:`shmem_init_thread  <shmem_init_thread>`
    * :doc:`shmem_query_thread  <shmem_query_thread>`
5. Team Management Routines
    * :doc:`shmem_team_my_pe <shmem_team_my_pe>`
    * :doc:`shmem_team_n_pes <shmem_team_n_pes>`
    * :doc:`shmem_team_get_config <shmem_team_get_config>`
    * :doc:`shmem_team_translate_pe <shmem_team_translate_pe>`
    * :doc:`shmem_team_split_strided <shmem_team_split_strided>`
    * :doc:`shmem_team_split_2d <shmem_team_split_2d>`
    * :doc:`shmem_team_destroy <shmem_team_destroy>`
6. Communication Management
    * :doc:`shmem_ctx_create  <shmem_ctx_create>`
    * :doc:`shmem_team_create_ctx  <shmem_team_create_ctx>`
    * :doc:`shmem_ctx_destroy  <shmem_ctx_destroy>`
    * :doc:`shmem_ctx_get_team  <shmem_ctx_get_team>`
7. Remote Memory Access
    * :doc:`shmem_p  <shmem_p>`
    * :doc:`shmem_put  <shmem_put>`
    * :doc:`shmem_iput  <shmem_iput>`
    * :doc:`shmem_g  <shmem_g>`
    * :doc:`shmem_get  <shmem_get>`
    * :doc:`shmem_iget  <shmem_iget>`
8. Non-blocking Remote Memory Access
    * :doc:`shmem_put_nbi  <shmem_put_nbi>`
    * :doc:`shmem_get_nbi  <shmem_get_nbi>`
9. Atomic Memory Operations
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
10. Non-blocking Atomic Memory Operations
     * :doc:`shmem_atomic_fetch_nbi <shmem_atomic_fetch_nbi>`
     * :doc:`shmem_atomic_compare_swap_nbi <shmem_atomic_compare_swap_nbi>`
     * :doc:`shmem_atomic_swap_nbi <shmem_atomic_swap_nbi>`
     * :doc:`shmem_atomic_fetch_inc_nbi <shmem_atomic_fetch_inc_nbi>`
     * :doc:`shmem_atomic_fetch_add_nbi <shmem_atomic_fetch_add_nbi>`
     * :doc:`shmem_atomic_fetch_and_nbi <shmem_atomic_fetch_and_nbi>`
     * :doc:`shmem_atomic_fetch_or_nbi <shmem_atomic_fetch_or_nbi>`
     * :doc:`shmem_atomic_fetch_xor_nbi <shmem_atomic_fetch_xor_nbi>`
11. Signaling Operations
     * :doc:`shmem_put_signal <shmem_put_signal>`
     * :doc:`shmem_put_signal_nbi <shmem_put_signal_nbi>`
     * :doc:`shmem_signal_fetch <shmem_signal_fetch>`
12. Collective Operations
     * :doc:`shmem_alltoall  <shmem_alltoall>`
     * :doc:`shmem_alltoalls  <shmem_alltoalls>`
     * :doc:`shmem_barrier  <shmem_barrier>`
     * :doc:`shmem_barrier_all  <shmem_barrier_all>`
     * :doc:`shmem_broadcast  <shmem_broadcast>`
     * :doc:`shmem_collect  <shmem_collect>`
     * :doc:`shmem_reductions  <shmem_reductions>`
     * :doc:`shmem_sync  <shmem_sync>`
     * :doc:`shmem_sync_all  <shmem_sync_all>`
13. Point-to-Point Synchronizations
     * :doc:`shmem_wait_until <shmem_wait_until>`
     * :doc:`shmem_wait_until_all <shmem_wait_until_all>`
     * :doc:`shmem_wait_until_any <shmem_wait_until_any>`
     * :doc:`shmem_wait_until_some <shmem_wait_until_some>`
     * :doc:`shmem_wait_until_all_vector <shmem_wait_until_all_vector>`
     * :doc:`shmem_wait_until_any_vector <shmem_wait_until_any_vector>`
     * :doc:`shmem_wait_until_some_vector <shmem_wait_until_some_vector>`
     * :doc:`shmem_test <shmem_test>`
     * :doc:`shmem_test_all <shmem_test_all>`
     * :doc:`shmem_test_any <shmem_test_any>`
     * :doc:`shmem_test_some <shmem_test_some>`
     * :doc:`shmem_test_all_vector <shmem_test_all_vector>`
     * :doc:`shmem_test_any_vector <shmem_test_any_vector>`
     * :doc:`shmem_test_some_vector <shmem_test_some_vector>`
     * :doc:`shmem_signal_wait_until <shmem_signal_wait_until>`
14. Memory Ordering
     * :doc:`shmem_fence  <shmem_fence>`
     * :doc:`shmem_quiet  <shmem_quiet>`
15. Distributed Locks
     * :doc:`shmem_lock  <shmem_lock>`
16. Deprecated Cache Operations
     * :doc:`shmem_cache  <shmem_cache>`


Cray-OpenSHMEMX-specific Features
---------------------------------

.. toctree::
   :maxdepth: 2
   :hidden:

   shmemx_init_thread
   shmemx_thread_fence
   shmemx_thread_register
   shmemx_query_thread
   shmemx_thread_quiet
   shmemx_thread_unregister
   shmemx_session_start
   shmemx_session_stop
   shmemx_put_signal
   shmemx_put_signal_nb
   shmemx_signal_set
   shmemx_local_query
   shmemx_local_complete
   shmemx_pe_quiet
   shmemx_team_my_pe
   shmemx_team_n_pes
   shmemx_team_split_2d
   shmemx_team_split_strided
   shmemx_team_destroy
   shmemx_team_translate_pe
   shmemx_team_get_config
   shmemx_team_ctx_create
   shmemx_ctx_get_team
   shmemx_alltoallv
   shmemx_alltoallv_packed
   shmemx_team_alltoall
   shmemx_team_alltoallv
   shmemx_team_alltoallv_packed
   shmemx_team_barrier
   shmemx_team_reductions
   shmemx_add_nb
   shmemx_inc_nb
   shmemx_cswap_nb
   shmemx_fadd_nb
   shmemx_finc_nb
   shmemx_swap_nb
   shmemx_put_nb
   shmemx_get_nb
   shmemx_short_add
   shmemx_short_cswap
   shmemx_short_inc
   shmemx_short_fadd
   shmemx_short_swap
   shmemx_short_finc

1. Thread-hot Operations
    * :doc:`shmemx_init_thread  <shmemx_init_thread>`
    * :doc:`shmemx_thread_fence  <shmemx_thread_fence>`
    * :doc:`shmemx_thread_quiet  <shmemx_thread_quiet>`
    * :doc:`shmemx_thread_register  <shmemx_thread_register>`
    * :doc:`shmemx_thread_unregister  <shmemx_thread_unregister>`
    * :doc:`shmemx_query_thread <shmemx_query_thread>`
2. Sessions
    * :doc:`shmemx_session_start <shmemx_session_start>`
    * :doc:`shmemx_session_stop <shmemx_session_stop>`
3. Put-with-signal (PWS)
    * :doc:`shmemx_put_signal  <shmemx_put_signal>`
    * :doc:`shmemx_put_signal_nb  <shmemx_put_signal_nb>`
    * :doc:`shmemx_signal_set <shmemx_signal_set>`
4. Locality Operations
    * :doc:`shmemx_local_query <shmemx_local_query>`
    * :doc:`shmemx_local_complete <shmemx_local_complete>`
    * :doc:`shmemx_pe_quiet <shmemx_pe_quiet>`
5. Team Management
    * :doc:`shmemx_team_my_pe  <shmemx_team_my_pe>`
    * :doc:`shmemx_team_n_pes  <shmemx_team_n_pes>`
    * :doc:`shmemx_team_split_2d  <shmemx_team_split_2d>`
    * :doc:`shmemx_team_split_strided  <shmemx_team_split_strided>`
    * :doc:`shmemx_team_destroy <shmemx_team_destroy>`
    * :doc:`shmemx_team_translate_pe  <shmemx_team_translate_pe>`
    * :doc:`shmemx_team_get_config <shmemx_team_get_config>`
    * :doc:`shmemx_team_ctx_create <shmemx_team_ctx_create>`
    * :doc:`shmemx_ctx_get_team <shmemx_ctx_get_team>`
6. Team-based Collectives
    * :doc:`shmemx_alltoallv  <shmemx_alltoallv>`
    * :doc:`shmemx_alltoallv_packed  <shmemx_alltoallv_packed>`
    * :doc:`shmemx_team_alltoall  <shmemx_team_alltoall>`
    * :doc:`shmemx_team_alltoallv  <shmemx_team_alltoallv>`
    * :doc:`shmemx_team_alltoallv_packed  <shmemx_team_alltoallv_packed>`
    * :doc:`shmemx_team_barrier  <shmemx_team_barrier>`
    * :doc:`shmemx_team_reductions  <shmemx_team_reductions>`
7. Explicit Non-blocking Operations
    * :doc:`shmemx_add_nb <shmemx_add_nb>`
    * :doc:`shmemx_inc_nb <shmemx_inc_nb>`
    * :doc:`shmemx_cswap_nb <shmemx_cswap_nb>`
    * :doc:`shmemx_fadd_nb <shmemx_fadd_nb>`
    * :doc:`shmemx_finc_nb <shmemx_finc_nb>`
    * :doc:`shmemx_swap_nb <shmemx_swap_nb>`
    * :doc:`shmemx_put_nb <shmemx_put_nb>`
    * :doc:`shmemx_get_nb <shmemx_get_nb>`
8. Short Datatype Atomic Operations
    * :doc:`shmemx_short_add <shmemx_short_add>`
    * :doc:`shmemx_short_cswap <shmemx_short_cswap>`
    * :doc:`shmemx_short_inc <shmemx_short_inc>`
    * :doc:`shmemx_short_fadd <shmemx_short_fadd>`
    * :doc:`shmemx_short_swap <shmemx_short_swap>`
    * :doc:`shmemx_short_finc <shmemx_short_finc>`



Cray OpenSHMEMX
===============

OpenSHMEM is a Partitioned Global Address Space (PGAS) library interface
specification, which is the culmination of a standardization effort among many
implementers and users of SHMEM programming model. SHMEM has a long history as a
parallel programming model. It is extensively used since 1993, starting from
Cray T3D systems. For the past two decades SHMEM library implementation in Cray
systems evolved through different generations. The current generation of the
SHMEM implementation for Cray XC and XK systems is called Cray SHMEM. Cray SHMEM
is a proprietary SHMEM implementation from Cray Inc., which is OpenSHMEM
standards compliant.

The next evolution of OpenSHMEM implementation for current and future generation
Cray systems is called Cray OpenSHMEMX.

This repository contains public announcement information about the Cray
OpenSHMEMX software stack including release information, updated manpages,
performance optimization and tuning parameters, supported environments and
systems, and general backward compatibility details.

Supported Platforms
-------------------
Cray OpenSHMEMX is supported on both X86_64 and AARCH64 based Cray XC systems.

On X86_64 systems, Cray SHMEM is still the production-ready implementation. Cray
OpenSHMEMX is released as a separate product from Cray SHMEM with plans to
supersede the existing Cray SHMEM library in near future. Early access to Cray
OpenSHMEMX library is provided for users to start migrating their existing
applications to the new library.

On AARCH64 systems, Cray OpenSHMEMX is the only available and supported SHMEM
implementation by Cray Inc.

.. toctree::
   :maxdepth: 1
   :hidden:

   intro_shmem
   shmem_mem_manage
   shmem_multithreading
   shmem_init
   shmem_init_thread
   shmem_finalize
   shmem_global_exit
   shmem_my_pe
   shmem_n_pes
   shmem_info_get_name
   shmem_info_get_version
   shmem_pe_accessible
   shmem_addr_accessible
   shmem_query_thread
   shmem_malloc
   shmem_calloc
   shmem_ptr
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
   shmem_fence
   shmem_quiet
   shmem_test
   shmem_wait_until
   shmem_lock
   shmem_alltoall
   shmem_alltoalls
   shmem_barrier
   shmem_barrier_all
   shmem_broadcast
   shmem_collect
   shmem_reductions
   shmem_sync
   shmem_sync_all
   shmem_cache
   shmemx_init_thread
   shmemx_kind_align
   shmemx_kind_malloc
   shmemx_put_signal
   shmemx_put_signal_nb
   shmemx_alltoallv
   shmemx_alltoallv_packed
   shmemx_team_alltoall
   shmemx_team_alltoallv
   shmemx_team_alltoallv_packed
   shmemx_team_barrier
   shmemx_team_destroy
   shmemx_team_my_pe
   shmemx_team_n_pes
   shmemx_team_reductions
   shmemx_team_split_2d
   shmemx_team_split_3d
   shmemx_team_split_color
   shmemx_team_split_strided
   shmemx_team_translate_pe
   shmemx_thread_fence
   shmemx_thread_quiet
   shmemx_thread_register
   shmemx_thread_unregister


Release Notes
=============

Versioning Scheme
-----------------

Cray OpenSHMEMX release uses the A.B.C version format. A Major version, B Minor
version number and C is the release version number. This versioning system
doesnot extend prior to 8.0.0 release.

Major (A): This is the first integer in the string and this typically mentions 
a major change in the library like new OpenSHMEM standards compliance, or to a
end-user functionality. We can break compatibility with the previous released
versions, if the major version changes. hints: Support for a new processor
architecture or NIC or adding new environment variable or performance
improvements without any end-user visible functional change would not be a
reason to update the major version. In general, we should avoid breaking
compatility and a major version update doesn’t mean breaking compatibility.

Minor (B): The minor version number is the second integer. It denotes end-user
observable change without breaking compatibility. Adding new env variable,
support for new features, internal algorithms, changes in performance without
breaking compatibility forms the reason for updating the minor version.

Release (C): Last integer in the version string, typically denotes a bug-fix
without end-user obervable change.

.. _release-overview:

Release Overview
----------------

.. list-table:: Cray OpenSHMEMX Release Overview on HPE Cray EX and HPE Apollo Systems
    :header-rows: 1

    * - Release
      - OpenSHMEM Compliance
      - Release Date
    * - :ref:`Cray OpenSHMEMX v11.7.0 <cray-openshmemx-v11-7-0>`
      - OpenSHMEM v1.5
      - December 2023
    * - :ref:`Cray OpenSHMEMX v11.6.1 <cray-openshmemx-v11-6-1>`
      - OpenSHMEM v1.5
      - September 2023
    * - :ref:`Cray OpenSHMEMX v11.6.0 <cray-openshmemx-v11-6-0>`
      - OpenSHMEM v1.5
      - May 2023
    * - :ref:`Cray OpenSHMEMX v11.5.8 <cray-openshmemx-v11-5-8>`
      - OpenSHMEM v1.4
      - March 2023
    * - :ref:`Cray OpenSHMEMX v11.5.7 <cray-openshmemx-v11-5-7>`
      - OpenSHMEM v1.4
      - December 2022
    * - :ref:`Cray OpenSHMEMX v11.5.6 <cray-openshmemx-v11-5-6>`
      - OpenSHMEM v1.4
      - October 2022
    * - :ref:`Cray OpenSHMEMX v11.5.5 <cray-openshmemx-v11-5-5>`
      - OpenSHMEM v1.4
      - August 2022
    * - :ref:`Cray OpenSHMEMX v11.5.4 <cray-openshmemx-v11-5-4>`
      - OpenSHMEM v1.4
      - May 2022
    * - :ref:`Cray OpenSHMEMX v11.5.3 <cray-openshmemx-v11-5-3>`
      - OpenSHMEM v1.4
      - April 2022
    * - :ref:`Cray OpenSHMEMX v11.5.2 <cray-openshmemx-v11-5-2>`
      - OpenSHMEM v1.4
      - March 2022
    * - :ref:`Cray OpenSHMEMX v11.5.1 <cray-openshmemx-v11-5-1>`
      - OpenSHMEM v1.4
      - February 2022
    * - :ref:`Cray OpenSHMEMX v11.5.0 <cray-openshmemx-v11-5-0>`
      - OpenSHMEM v1.4
      - December 2021
    * - :ref:`Cray OpenSHMEMX v11.4.1 <cray-openshmemx-v11-4-1>`
      - OpenSHMEM v1.4
      - November 2021
    * - :ref:`Cray OpenSHMEMX v11.4.0 <cray-openshmemx-v11-4-0>`
      - OpenSHMEM v1.4
      - October 2021
    * - :ref:`Cray OpenSHMEMX v11.3.3 <cray-openshmemx-v11-3-3>`
      - OpenSHMEM v1.4
      - September 2021
    * - :ref:`Cray OpenSHMEMX v11.3.2 <cray-openshmemx-v11-3-2>`
      - OpenSHMEM v1.4
      - August 2021
    * - :ref:`Cray OpenSHMEMX v11.3.1 <cray-openshmemx-v11-3-1>`
      - OpenSHMEM v1.4
      - July 2021
    * - :ref:`Cray OpenSHMEMX v11.3.0 <cray-openshmemx-v11-3-0>`
      - OpenSHMEM v1.4
      - June 2021
    * - :ref:`Cray OpenSHMEMX v11.2.1 <cray-openshmemx-v11-2-1>`
      - OpenSHMEM v1.4
      - May 2021
    * - :ref:`Cray OpenSHMEMX v11.2.0 <cray-openshmemx-v11-2-0>`
      - OpenSHMEM v1.4
      - February 2021
    * - :ref:`Cray OpenSHMEMX v11.1.2 <cray-openshmemx-v11-1-2>`
      - OpenSHMEM v1.4
      - November 2020
    * - :ref:`Cray OpenSHMEMX v11.1.1 <cray-openshmemx-v11-1-1>`
      - OpenSHMEM v1.4
      - September 2020
    * - :ref:`Cray OpenSHMEMX v11.1.0 <cray-openshmemx-v11-1-0>`
      - OpenSHMEM v1.4
      - August 2020
    * - :ref:`Cray OpenSHMEMX v11.0.0 <cray-openshmemx-v11-0-0>`
      - OpenSHMEM v1.4
      - June 2020
    * - :ref:`Cray OpenSHMEMX v10.1.0 <cray-openshmemx-v10-1-0>`
      - OpenSHMEM v1.4
      - May 2020
    * - :ref:`Cray OpenSHMEMX v10.0.1 <cray-openshmemx-v10-0-1>`
      - OpenSHMEM v1.4
      - March 2020
    * - :ref:`Cray OpenSHMEMX v10.0.0 <cray-openshmemx-v10-0-0>`
      - OpenSHMEM v1.4
      - December 2019

.. list-table:: Cray OpenSHMEMX Release Overview on HPE Cray XC Systems
    :header-rows: 1

    * - Release
      - OpenSHMEM Compliance
      - Release Date
    * - :ref:`Cray OpenSHMEMX v9.1.1 <cray-openshmemx-v9-1-1>`
      - OpenSHMEM v1.4
      - August 2020
    * - :ref:`Cray OpenSHMEMX v9.1.0 <cray-openshmemx-v9-1-0>`
      - OpenSHMEM v1.4
      - June 2020
    * - :ref:`Cray OpenSHMEMX v9.0.0 <cray-openshmemx-v9-0-0>`
      - OpenSHMEM v1.4
      - December 2019
    * - :ref:`Cray OpenSHMEMX v8.0.1 <cray-openshmemx-v8-0-1>`
      - OpenSHMEM v1.4
      - July 2018
    * - :ref:`Cray OpenSHMEMX v8.0.0 <cray-openshmemx-v8-0-0>`
      - OpenSHMEM v1.4
      - June 2018

Release Details
---------------

.. _cray-openshmemx-v11-7-0:

Cray OpenSHMEMX v11.7.0
----------------------

::

  Major differences in Cray OpenSHMEMX v11.7.0 from Cray OpenSHMEMX
  version 11.6.1 includes the following:
    - Fix SMP and network flush issues in shmem_quiet operation
    - Add support for performant shmem_quiet
    - Add support for new SW collective engine (non-default - ready for
      evaluation)
    - Fix internal psync maintenance for shmem_team management
    - Fix return types for team-based allreduce operations
    - Add support for new tree-based allreduce algorithm
    - Fix team-based shmem_collect and shmem_collect operations for datatypes
      of size 1, 2, and 16 bytes
    - Fix pshmem APIs for put-with-signal operations

  The following are the major known issues in this release:
    - Support multithreaded team-create and team-destroy operation is not
    fully available
    - Support for C11-generic interface of the shmem_sync operation is not
    currently available

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-6-1:

Cray OpenSHMEMX v11.6.1
----------------------

::

  Major differences in Cray OpenSHMEMX v11.6.1 from Cray OpenSHMEMX
  version 11.6.0 includes the following:
    - Minor internal bugfixes
    - Updates to internal barrier algorithm selection policies
    - Fix HRP and single-transmit AMO usage with bundled sessions

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-6-0:

Cray OpenSHMEMX v11.6.0
----------------------

::

  Major differences in Cray OpenSHMEMX v11.6.0 from Cray OpenSHMEMX
  version 11.5.8 includes the following:
    - Official OpenSHMEM-1.5 compliance
    - Official support for new standard interfaces:
        - Team-management routines
        - Team-based collectives
        - Vector and list-based P2P synchronization operations
        - put-with-signal and signal fetch
        - Non-blocking fetching atomics
    - Official support for new implementation-specific extensions:
        - Sessions and session hints
        - Local completions and per-target completions
        - signal fetch
        - AMO support for short-datatypes
        - Non-blocking inc and add AMOs
    - The following operations were deprecated
        - Implementation-specific put-with-signals are deprecated with the
        new standard put-with-signal operations
        - Implementation-specific non-blocking puts and gets are
        deprecated with the standard non-blocking put and get operations
        - All team-based collectives and team management routines are
        deprecated with the new team-based collectives and team
        management operations

  The following bugs are fixed as part of the Cray OpenSHMEMX v11.6.0
  release:
    - Fixed team-based allreduce collective algorithm

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-8:

Cray OpenSHMEMX v11.5.8
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.8 from Cray OpenSHMEMX
  version 11.5.7 includes the following:
    - Several known internal bugs are fixed related to new introduced
      OpenSHMEM-1.5 features

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-7:

Cray OpenSHMEMX v11.5.7
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.7 from Cray OpenSHMEMX
  version 11.5.6 includes the following:

    - Add support for OpenSHMEM sessions-based bundling for NBI put-with-signal
    - Add support for OpenSHMEM sessions-based deep completion puts
    - Add support for all baseline collectives for supporting functional
    OpenSHMEM Team-based collectives
    - Add support for fine-grained traffic class (TCLASS) selection with
    OpenSHMEM context options
    - Add support for different memory management options for maintaining
    OpenSHMEM Team-member data at various memory footprint levels. Refer
    shmem_intro manpage for more details.

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-6:

Cray OpenSHMEMX v11.5.6
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.6 from Cray OpenSHMEMX
  version 11.5.5 includes the following:

    - No user-visible changes - internal code cleanup and tuning
    - Add support for SHMEM_SESSION_NO_CNCR_TACCESS and SHMEM_SESSION_OP_FAMO,
    SHMEM_SESSION_OP_AMO as new session options

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-5:

Cray OpenSHMEMX v11.5.5
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.5 from Cray OpenSHMEMX
  version 11.5.4 includes the following:

    - No user-visible changes - internal code cleanup and tuning

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-4:

Cray OpenSHMEMX v11.5.4
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.4 from Cray OpenSHMEMX
  version 11.5.3 includes the following:

    - Add support for extra timers in startup evaluation
    - Add support for shmemx_signal_set signaling operation

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-3:

Cray OpenSHMEMX v11.5.3
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.3 from Cray OpenSHMEMX
  version 11.5.2 includes the following:

    - Modified default value for SHMEM_MAX_CTX

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-2:

Cray OpenSHMEMX v11.5.2
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.2 from Cray OpenSHMEMX
  version 11.5.2 includes the following:

    - No explicit user-visible changes were added for HPE Slingshot NIC
    (Slingshot 11) or Industry standard NIC (Slingshot 10) support
    - Internal code cleanup and bugfix for Slingshot 11 NIC support

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-1:

Cray OpenSHMEMX v11.5.1
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.1 from Cray OpenSHMEMX
  version 11.5.0 includes the following:

    - Add early support for HPE Slingshot interconnect with HPE Slingshot NIC (Slingshot 11)
    - Continue support for HPE Slingshot interconnect with Industry Standard NIC (Slingshot 10)

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-5-0:

Cray OpenSHMEMX v11.5.0
----------------------

::

  Major differences in Cray OpenSHMEMX v11.5.0 from Cray OpenSHMEMX
  version 11.4.1 includes the following:

    - Added support for the following implementation-specific features:
        - OpenSHMEM session start and stop on a OpenSHMEM context
        - PE-based memory ordering (shmem_pe_quiet)
        - Local memory ordering

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-4-1:

Cray OpenSHMEMX v11.4.1
----------------------

::

  Major differences in Cray OpenSHMEMX v11.4.1 from Cray OpenSHMEMX
  version 11.4.0 includes the following:

    - No new features were added, mostly internal bug fix release

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-4-0:

Cray OpenSHMEMX v11.4.0
----------------------

::

  Major differences in Cray OpenSHMEMX v11.4.0 from Cray OpenSHMEMX
  version 11.3.3 includes the following:

    - No new features were added, mostly internal bug fix release
    - Changed the defaults of cetain internal env variables involved in
    FI_FENCE usage

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-3-3:

Cray OpenSHMEMX v11.3.3
----------------------

::

  Major differences in Cray OpenSHMEMX v11.3.3 from Cray OpenSHMEMX
  version 11.3.0 includes the following:

    - No new features were added, mostly internal bug fix release

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-3-2:

Cray OpenSHMEMX v11.3.2
----------------------

::

  Major differences in Cray OpenSHMEMX v11.3.2 from Cray OpenSHMEMX
  version 11.3.0 includes the following:

    - No new features were added, mostly internal bug fix release

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-3-1:

Cray OpenSHMEMX v11.3.1
----------------------

::

  Major differences in Cray OpenSHMEMX v11.3.1 from Cray OpenSHMEMX
  version 11.3.0 includes the following:

    - No new features were added, mostly internal bug fix release

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-3-0:

Cray OpenSHMEMX v11.3.0
----------------------

::

  Major differences in Cray OpenSHMEMX v11.3.0 from Cray OpenSHMEMX
  version 11.2.1 includes the following:

    - Deprecate short and unsigned short variants of shmem_wait_until/test
    - Add support for shmem_malloc_with_hints
    - Modify shmem broadcast semantics to broadcast to itself on the root PE
    - Add support for team management routines: shmem_team_my_pe,
    shmem_team_n_pes, shmem_team_get_config, shmem_team_translate_pe,
    shmem_team_split_strided, shmem_team_split_2d, and shmem_team_destroy
    - Add support for team-based context routines: shmem_team_create_ctx, and
    shmem_ctx_get_team
    - Introduce support for NBI AMOs
    - Introduce support for blocking and non-blocking put-with-signal
    - Add support for multiple element point-to-point synchronization
    - Add support for vectorized comparison values in the multiple element
    point-to-point synchronization
    - Add alpha support for team-based collectives

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-2-1:

Cray OpenSHMEMX v11.2.1
----------------------

::

    Major differences in Cray OpenSHMEMX v11.2.1 from Cray OpenSHMEMX
    version 11.2.0 includes the following:

    - Multiple internal fixes for optimized OFI support

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-2-0:

Cray OpenSHMEMX v11.2.0
----------------------

::

    Major differences in Cray OpenSHMEMX v11.2.0 from Cray OpenSHMEMX
    version 11.1.2 includes the following:

    - Allows installing multiple versions of Cray OpenSHMEMX on the same system

    - Removes unnecessary libtool files from the packaging

    - Multiple internal fixes to get OpenSHMEM-1.5 compliance

    - Multiple internal fixes to optimized OFI support

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-1-2:

Cray OpenSHMEMX v11.1.2
----------------------

::

    Major differences in Cray OpenSHMEMX v11.1.2 from Cray OpenSHMEMX
    version 11.1.1 includes the following:

    - Added LMOD support for Shasta Cray EX systems

    - Update copyright information

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-1-1:

Cray OpenSHMEMX v11.1.1
----------------------

::

    Major differences in Cray OpenSHMEMX v11.1.1 from Cray OpenSHMEMX
    version 11.1.0 includes the following:

    - Fixed barrier-like semantics in the OpenSHMEM memory management routines
    like shmem_malloc and shmem_calloc as per the OpenSHMEM-1.5 specification
    updates

    - Add support for using Cray OpenSHMEMX with multiple NICs per node

    - Deprecated short datatype-based wait and test operations

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-1-0:

Cray OpenSHMEMX v11.1.0
----------------------

::

    Major differences in Cray OpenSHMEMX v11.1.0 from Cray OpenSHMEMX
    version 11.0.0 includes the following:

    - Enabling manual-progress by default for OFI "verbs;ofi_rxm" provider

    - Allow using Cray OpenSHMEMX v11.1.0 on HPE Apollo systems as a beta  release.
    The initial beta release is not performant and it is provided as a functional
    test library

    - Fix padding issues on the symmetric heaps, to avoid internal library usage
    memory buffers to use the user-allocated symmetric heaps

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v11-0-0:

Cray OpenSHMEMX v11.0.0
-----------------------

::

    Major differences in Cray OpenSHMEMX v11.0.0 from Cray OpenSHMEMX
    version 10.1.0 includes the following:

    - Cray OpenSHMEMX v11.0.0 breaks compatibility with Cray OpenSHMEMX
      version 10.1.0, because we have increased the size of SHMEM_SYNC_SIZE

    - Enabling auto-progress by default for OFI "verbs;ofi_rxm" provider

    - Fix team-based barrier issue exposed through the active set-based alltoall
      collective communication operations

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v10-1-0:

Cray OpenSHMEMX v10.1.0
-----------------------

::

    Cray OpenSHMEMX v10.1.0 release is functional up to 512 nodes
    and 128 PEs per node using the "verbs;ofi_rxm" libfabric provider.
    There are some constraints to understand in getting full functionality
    and the best possible performance.

    - Cray OpenSHMEMX is highly dependent on the underlying libfabric and
    verbs software and configuration. Changes in newer, unreleased kernels
    are showing performance improvements and we expect some ongoing
    improvements. While we expect the latest versions to be most functional
    and performant, we do not maintain the versions and configuration
    information and defer to the responsible components for information.

    - The "verbs;ofi_rxm" provider does not support true one-sided progress.
    As a result, Cray OpenSHMEMX defaults to using manual progress with a
    separate progress thread per PE. While this functionally guarantees the
    progress semantics, it might cause a small amount of performance overhead.
    The user is encouraged to leave one or more hardware threads vacant in
    order to prevent contention between the application threads and the
    progress thread(s). The impact of oversubscription is highly system
    dependent but may be substantial in some cases, hence this recommendation.
    Also note, that using Slurm's "--hint=nomultithread" and not using
    "--exclusive" have both unexpectedly caused poor progress or hangs on
    some randomized all to all tests.

    - Atomic operations in "verbs;ofi_rxm" are software emulated within
    libfabrics. This can result in bottlenecks when atomic operations are
    highly contentious. Atomic operations, in particular, require strong two
    sided progress with the manual progress thread and will suffer from
    oversubscription of threads.

    - The currently supported systems enable PCIe relaxed ordering to the NIC
    which requires Cray OpenSHMEMX to perform "flush" operations before
    shmem_quiet() or shmem_fence() boundaries, adding some latency to RMA
    operations. The additional latency of the flush is amortized when many
    RMA operations to many different targets are used, but a simple serial
    shmem_put()/shmem_quiet() benchmark will measure the full latency effect
    of these flushes.

    - The "verbs;ofi_rxm" provider is connection based. Dynamically establishing
    connections across many nodes or with many PEs per node shows poor
    performance and ongoing problems which have been reported to the libfabrics
    developers. To improve overall performance and to work around the problems,
    set SHMEM_OFI_STARTUP_CONNECT=1 to create connections between all PEs in a
    coordinated manner at startup. This is particularly important for jobs
    requiring an all-to-all communication pattern.

    - Cray OpenSHMEMX supports OpenSHMEM contexts but defaults to 1 context per
    PE when using the "verbs;ofi_rxm" provider. This may be manually increased
    with the environment variable SHMEM_MAX_CTX=<n>. Note, however, that this
    should be set accurately for the number of contexts being used in the
    application. Too many idle contexts can cause performance degradation by
    unnecessarily taking too much time in the progress thread.

    - This is the first release with enhanced SMP support for shared memory maps
    using the DSMML library. These enhancements show improved performance for
    single node randomized RMA operations. Refer SHMEM_USE_DSMML and
    SHMEM_USE_DSMML_SSHEAP environment variables in intro_shmem(3) manpage.

    Major differences in Cray OpenSHMEMX v10.1.0 from Cray OpenSHMEMX
    version 10.0.1 includes the following:

    - DSMML is used as the default memory management layer in this release.

    - Full support for 512 nodes and 128 PEs per node.

    - Support for coordinated startup connections - SHMEM_OFI_STARTUP_CONNECT

    - Multicontext support for the "verbs;ofi_rxm" provider

    - Support for Shared Symmetric Heap (SSHEAP) using DSMML SSHEAP features
    for enhanced SMP support.

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v10-0-1:

Cray OpenSHMEMX v10.0.1
-----------------------

::

    Major differences in Cray OpenSHMEMX v10.0.1 from Cray OpenSHMEMX
    version 10.0.0 includes the following:

    - Added support for optimized connection management while using with
      libfabric/verbs provider. Optimizations includes enabling XRC by default
      and implement co-ordinated static all-to-all connection option.

    - Fixed multiple data validation and scalability issues.

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v10-0-0:

Cray OpenSHMEMX v10.0.0
-----------------------

::

    Cray OpenSHMEMX v10.0.0 is the initial package with support for
    libfabric and optimized for Cray Shasta product line.

    Major differences in Cray OpenSHMEMX v10.0.0 from the evaluation
    Cray OpenSHMEMX library on Cray XC systems includes the following:

    - Uses libfabric for network support

    - Early support for OpenSHMEM specification 1.5 features like OpenSHMEM
    Teams and Team-based Collectives

    The following features are removed in Cray OpenSHMEMX v10.0.0 when
    compared to Cray OpenSHMEMX 9.0.0 on XC systems:

    - Removed support for Cray-specific Teams and Team-based Collectives.
    Instead we support Teams feature using the early implementation of the
    OpenSHMEM Teams proposal.

    - Removed support for all Cray-specific routines with SHMEM prefix in their
    names. Instead all these routines are supported using the SHMEMX prefix.

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v9-1-1:

Cray OpenSHMEMX v9.1.1
----------------------

::

    The following bugfixes are handled in Cray OpenSHMEMX v9.1.1:

    - Minor bugfixes in supporting lmod

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v9-1-0:

Cray OpenSHMEMX v9.1.0
----------------------

::

    The following features are available in Cray OpenSHMEMX version
    v9.1.0 from Cray OpenSHMEMX 9.0.0:

    - Added support for lmod

    - Fixed missing pshmem routines

    The following bugfixes are handled in Cray OpenSHMEMX v9.1.0:

    - Fix memory ordering issues in using different memcpy (Cray optimized
    and system default) operations on both x86_64 and aarch64 platforms.

    - Fix for using -Wpedantic flag in the application level

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v9-0-0:

Cray OpenSHMEMX v9.0.0
----------------------

::

    The following features are available from Cray OpenSHMEMX 8.0.1:

    - Introducing locality awareness. On single-node jobs, enable using
    Cray OpenSHMEMX without initializing network transport options (DMAPP).
    Refer to locality awareness in intro_shmem(3) man page.

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v8-0-1:

Cray OpenSHMEMX v8.0.1
----------------------

::

    The following features are available in Cray OpenSHMEMX v8.0.1:

    - Support for Cray Thread-hot (THS) and OpenSHMEM communication contexts
    (CTX). In Cray OpenSHMEMX version 8.0.0, THS and CTX are two mutually
    exclusive features. From v8.0.1 THS and CTX can be used together
    in the same OpenSHMEM application

    - Support for different CLE operating system releases. By default, Cray
    OpenSHMEMX is supported in CLE06UP04 and above systems. To use Cray
    OpenSHMEMX on older CLE systems adding -cray-openshmemx-ctx compiler flag
    will automatically select the appropriate library. See intro_shmem(3)
    man page for more information

    - Multiple performance issues are fixed in v8.0.1 from version 8.0.0

:ref:`Jump To Release Overview <release-overview>`

.. _cray-openshmemx-v8-0-0:

Cray OpenSHMEMX v8.0.0
----------------------

::

    The following features were available in Cray OpenSHMEMX v8.0.0:

    - Cray OpenSHMEMX is OpenSHMEM 1.4 compliant with support for
    Communication contexts and sync operations, extended typed interface
    for RMA and AMO operations, bitwise AMOs, shmem_calloc, shmem_test
    and other OpenSHMEM-1.4 fixes

    - Initial support for XC50 with Cavium ThunderX2 Arm blades (AARCH64)

    - To provide complete functional backward compatibility, the following
    Cray specific flagship features are imported from Cray SHMEM and
    supported as part of the Cray OpenSHMEMX library.

        * Support for Teams and Team based collectives

        * Support for Thread-hot features along with thread-based memory
        ordering operations

        * Support for non-blocking atomic memory operations

        * Support for optimized put with signal RMA operation

        * Support for Cray specific Generic RMA and AMO routines

        * Support for local node queries

        * Support for alltoallv and alltoallv packed collectives

        * Support for Fortran Interface, using shmem.fh and shmemx.fh

        * Support for PRIVATE contexts through a separate library. On
    CLE version 6.0 UP06 we added support for context APIs in DMAPP. Using
    -cray-openshmemx-ctx compiler driver option on CLE6.0UP06 systems,
    will provide support for PRIVATE contexts in Cray OpenSHMEMX using the
    new features from DMAPP. Refer, Compiling and Launching section on the
    intro_shmem man page for more information on the compiler driver option

    - Cray OpenSHMEMX supports the OpenSHMEM deprecated Fortran Interface,
    using shmem.fh and shmemx.fh.

    - See the "Introducing Cray OpenSHMEMX" white paper for more information
    on the new Cray OpenSHMEMX software product from Cray Inc. More
    information on accessing the white paper are available in intro_shmem
    man page

    - Initial support for Cray OpenSHMEMX man pages are derived from OpenSHMEM
    standards specification document


:ref:`Jump To Release Overview <release-overview>`

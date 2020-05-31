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

.. list-table:: Cray OpenSHMEMX Release Overview on Cray XC Systems
    :header-rows: 1

    * - Release
      - OpenSHMEM Compliance 
      - Release Date
    * - :ref:`Cray OpenSHMEMX v8.0.0 <cray-openshmemx-v8-0-0>`
      - OpenSHMEM v1.4
      - June 2018
    * - :ref:`Cray OpenSHMEMX v8.0.1 <cray-openshmemx-v8-0-1>`
      - OpenSHMEM v1.4
      - July 2018
    * - :ref:`Cray OpenSHMEMX v9.0.0 <cray-openshmemx-v9-0-0>`
      - OpenSHMEM v1.4
      - December 2019
    * - :ref:`Cray OpenSHMEMX v9.1.0 <cray-openshmemx-v9-1-0>`
      - OpenSHMEM v1.4
      - June 2020

.. list-table:: Cray OpenSHMEMX Release Overview on Cray Shasta Systems
    :header-rows: 1

    * - Release
      - OpenSHMEM Compliance
      - Release Date
    * - :ref:`Cray OpenSHMEMX v10.0.0 <cray-openshmemx-v10-0-0>`
      - OpenSHMEM v1.4
      - December 2019
    * - :ref:`Cray OpenSHMEMX v10.0.1 <cray-openshmemx-v10-0-1>`
      - OpenSHMEM v1.4
      - March 2020
    * - :ref:`Cray OpenSHMEMX v10.1.0 <cray-openshmemx-v10-1-0>`
      - OpenSHMEM v1.4
      - May 2020
    * - :ref:`Cray OpenSHMEMX v11.0.0 <cray-openshmemx-v11-0-0>`
      - OpenSHMEM v1.4
      - June 2020


Release Details
---------------

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

.. _cray-openshmemx-v9-0-0:

Cray OpenSHMEMX v9.0.0
----------------------

::

    The following features are available from Cray OpenSHMEMX 8.0.1:

    - Introducing locality awareness. On single-node jobs, enable using
    Cray OpenSHMEMX without initializing network transport options (DMAPP).
    Refer to locality awareness in intro_shmem(3) man page.

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


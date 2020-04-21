Overview
========

::

    OpenSHMEM is a Partitioned Global Address Space (PGAS) library interface
    specification, which is the culmination of a standardization effort among
    many implementers and users of SHMEM programming model. SHMEM has a long
    history as a parallel programming model on Cray systems. For the past two
    decades SHMEM library implementation in Cray systems evolved through
    different generations. Cray OpenSHMEMX is a proprietary, OpenSHMEM
    specification compliant SHMEM implementation for current and future
    generation Cray systems.

    Cray OpenSHMEMX release version 8.0.0 is the first official release of
    the Cray OpenSHMEMX library, it is a proprietary SHMEM implementation from
    Cray Inc which is OpenSHMEM standards compliant.

    On Cray XC systems, Cray OpenSHMEMX is not released as a replacement
    library for the existing Cray SHMEM library. It is released as an
    evaluation product.

    On Cray Shasta systems, Cray OpenSHMEMX is the default production ready
    propreitary OpenSHMEM implementation from Cray Inc.

Description
===========

::

    The logically shared, distributed memory access (SHMEM) routines
    provide low-latency, high-bandwidth communication for use in highly
    parallelized scalable programs.

    The SHMEM data-passing library routines are similar to the message
    passing interface (MPI) library routines: they pass data between
    cooperating parallel processes. The SHMEM data-passing routines can be
    used in programs that perform computations in separate address spaces
    and that explicitly pass data to and from different processing
    elements (PEs) in the program.

    The SHMEM parallel programming model assumes an MPI-1 like group of
    processes that runs in parallel from job launch to job termination. No
    processes can be added or removed from this group and all processes
    execute the same application. Thus, SHMEM applications are of the SPMD
    (Single Program Multiple Data) type. SHMEM is a one-sided message
    passing model in which memory is private to each process.

    The SHMEM routines minimize the overhead associated with data passing
    requests, maximize bandwidth, and minimize data latency. Data latency
    is the length of time between a PE initiating a transfer of data and a
    PE being able to use the data.

    SHMEM routines support remote data transfer through put operations
    that transfer data to a different PE and get operations that transfer
    data from a different PE. Other supported operations are work-shared
    broadcast and reduction, barrier synchronization, and atomic memory
    operations.

    More information on the SHMEM programming model can be found in the
    OpenSHMEM standard specification documentation. http://openshmem.org

OpenSHMEM Compliance
====================

::

    Cray OpenSHMEMX is compliant with the OpenSHMEM API Specification Version
    1.4. All Cray specific extensions are prefixed with SHMEMX_ nomenclature
    and placed inside the shmemx.h and shmemx.fh header.

    The following are the list of Cray-specific features available in Cray
    OpenSHMEMX library:

    o  alltoallv and alltoallv_packed collective operation

    o  put with signal operation

    o  thread-hot multithreading features with thread-based memory ordering

    o  teams and team-based collectives

    o  local-node queries

Different Available Transport Layers
====================================

::

    Cray OpenSHMEMX is designed to be modular to support different transport
    layers for communication. The current version support the following
    transport layers:

    o  SMP-OFI - OFI for internode and XPMEM for intranode communication
    Support for XPMEM is available only on systems with XPMEM kernel.

Whitepapers
===========

::

    Refer Cray Programming Environment Github page:
    https://pe-cray.github.io/whitepapers/ for access to different whitepapers
    related to Cray OpenSHMEMX software stack.

OpenSHMEM C11-Generic Interfaces
================================

::

    The Cray OpenSHMEMX library supports the OpenSHMEM C11-Generic interface,
    which is new with OpenSHMEM V1.3. This interface does not add new
    functionality, but allows existing routines to be called with a
    generic name that maps to a type-specific routine based on the type of
    the arguments. Only certain programming environments support the
    C11-Generic interface. As of the time of the Cray OpenSHMEMX V8.0.0
    release, these include:

    o  CCE 8.5 or later; use the -hstd=c11 flag during compilation

    o  GNU 5.1 or later; no additional flags needed

    o  Intel 16.0 or later; use the -std=c11 or -std=c1x flag during
       compilation

    To use the C11-Generic interface, you must use a compiler that
    supports this feature and you must be sure that the first argument to
    the generic routine is one of the types in the list of the type-
    specific routines for that functionality. For example,

      long source[8], dest[8];
      shmem_get(dest, source, 8, 31);

    is a valid use of C11-Generic because shmem_long_get is one of the
    type-specific get routines.

Compiling and Launching a SHMEM Application on a Cray System
============================================================

::

    To invoke the compiler for all applications, including SHMEM
    applications, use either the cc, CC, or ftn command. Do not use
    vendor-specific compiler commands such as pgcc, as this may result in
    undefined behavior.

    Example:

    In the example below, an application is first compiled, and the
    resulting executable is then launched using 128 processes:

.. code:: bash

        cc -o test_shmem test_shmem.c
        srun -n 128 ./test_shmem

::

    See the srun(1) man page for more information

Support for Static and Dynamic linking
--------------------------------------

::

    Cray OpenSHMEMX supports both static and dynamic linking. Loading
    Cray OpenSHMEMX module file automatically retrieves the correct library to
    link and compile against.

    Example:

    In the example below, an application is first compiled with static linking.

.. code:: bash

        module load cray-openshmemx/<version>
        cc -o test_shmem test_shmem.c

::

    For dynamic building, users are expected to explicitly load the location
    of the Cray OpenSHMEMX in the LD_LIBRARY_PATH as shown in the example below:

.. code:: bash

        module load cray-openshmemx/<version>
        export LD_LIBRARY_PATH=$CRAY_OPENSHMEMX_DIR/lib64:$LD_LIBRARY_PATH
        cc -o test_shmem test_shmem.c

::

   NOTE: As of Cray OpenSHMEMX version 10.0.0, static builds are not supported
   in Cray Shasta systems.

General Notes
=============

Zero-length Data Transfer
-------------------------

::

    Per OpenSHMEM specification 1.2 Annex C, support for zero-length
    transfers is provided for zero-length get and put. Remote memory transfers
    for zero number of elements are accepted, and this support is provided for
    both block and non-blocking transfers. The usage of NULL pointers for data
    transfer usually leads to program abort, but for zero-length transfers,
    the usage of NULL pointers is accepted.

Managing Memory in Cray OpenSHMEMX
----------------------------------

::

    Refer shmem_mem_manage(3) for more information on managing memory in
    Cray OpenSHMEMX

Interconnect Specific Informations
----------------------------------

::

    On Cray Shasta systems, Cray OpenSHMEMX uses libfabric (OFI) for network
    based communication and data transfer operations.

Cray Thread-hot and OpenSHMEM Communication Contexts
----------------------------------------------------

::

    Refer to shmem_multithreading(3) man page for more information on the
    interacting with OpenSHMEM multithreading features, communication context
    and Cray-specific thread-hot features

Cray OpenSHMEMX Locality Awareness
----------------------------------

::

    Cray OpenSHMEMX version 9.0.0 and later provides support for locality
    awareness. On previous versions, we initialized both the network transport
    options (OFI) and on-node transport (XPMEM) options even on single-node jobs.
    We used environment variables like SHMEM_USE_SMP to toggle the use of
    on-node data transfers.

    On Cray OpenSHMEMX versions 9.0.0 and later, only on-node transport (XPMEM)
    options are initialized for single-node jobs. Users can toggle the usage using
    the following environment variable options: SHMEM_LOCALITY_ONNODE and
    SHMEM_LOCALITY_OFFNODE. Please refer these environment variables in the
    the following section, for more information.

Environment Variables
=====================

::

    The following environment variables affect SHMEM behavior.

OpenSHMEM Standard Specific Environment Variables
-------------------------------------------------

::

    SHMEM_SYMMETRIC_SIZE
              Controls the size (in bytes) per PE of the symmetric heap.
              Memory segments allocated by calls to shmem_malloc() or
              shpalloc() are taken from the symmetric heap. There is no
              other valid way to use memory from the symmetric heap. If
              there is not enough memory left in the symmetric heap to
              satisfy the shmem_malloc() or shpalloc() request, an error
              message is issued and the job is terminated.

              Note:  Data objects in the static data segment and bss
              segment are also symmetric objects but are not part of the
              symmetric heap and therefore are not counted in the size of
              the symmetric heap as determined by SHMEM_SYMMETRIC_SIZE.

              The value set in this environment variable is interpreted as
              a number of bytes, unless the number is followed by a char
              that acts as a multiplier, where:


              g or G multiplies by 2**30 (gigabytes)

              k or K multiplies by 2**10 (kilobytes)

              m or M multiplies by 2**20 (megabytes)

              For example, the string 20m returns the integer value
              20*2**20, or 20 megabytes.

              Only one multiplier is recognized, so 20kk will not produce
              the same value as 20m, nor will invalid strings such as 20MB
              produce the desired result.

              Floating point input is recognized during expansion, so that
              20.5m will produce 20.5*2**20, or 20.5 megabytes. Values are
              rounded to the nearest byte.

              Default: not set

    SHMEM_VERSION_DISPLAY
              If set, causes SHMEM to display the Cray OpenSHMEMX version
              number as well as the build date information.

              Default: not enabled

Cray OpenSHMEMX Setup and Running Specific Environment Variables
----------------------------------------------------------------

::

    SHMEM_ABORT_ON_ERROR
              If set, causes SHMEM to abort and produce a core dump when
              SHMEM detects an error. If not set, SHMEM instead calls
              exit() with a non-zero exit status. Note that the shell
              coredumpsize must be set appropriately to enable core dumps.

              Default: not enabled

    SHMEM_ENV_DISPLAY
              If set, causes SHMEM to display all SHMEM environment
              variables and their current settings at SHMEM initialization
              time.

              Default: not enabled

    SHMEM_ERROR_FILE
              To redirect error messages issued by the SHMEM library to
              stdout, set this variable to stdout.

              Default: stderr

    SHMEM_FREEMEM_THRESHOLD
              Sets the percentage of huge_page_freemem that SHMEM
              initialization allows to be allocated for the four SHMEM
              memory regions. Using a value too close to 100% risks having
              the job killed during execution because there is not enough
              memory left for other purposes.

              Default: 95

    SHMEM_MEMINFO_DISPLAY
              If set, causes SHMEM to display information about the job's
              memory allocation during initialization. For more
              information about SHMEM memory allocation and management,
              see the MANAGING MEMORY IN SHMEM section of this man page.

              Default: not enabled

    SHMEM_OPTIMIZED_MEMCPY
              Specified which version of memcpy to use. Valid values are:



              0         Use the system (glibc) version of memcpy.

              1         Use an optimized version of memcpy if one is
                        available for the processor being used. In this
                        release, an optimized version of memcpy() is
                        available only for Intel processors.

              2         Use a highly optimized version of memcpy if one is
                        available for the processor being used. In this
                        release, a highly optimized version of memcpy() is
                        available only for Intel Haswell, Broadwell and
                        KNL processors.

                        The optimized versions of memcpy may provide
                        better performance in some areas but may have
                        performance regressions in other areas.

                        The benefits may vary depending on the programming
                        environment and the communication pattern (e.g., a
                        point-to-point or all-to-all pattern) on the node.

              Default: 0

Cray OpenSHMEMX and Cray DSMML Interaction Environment Variables
----------------------------------------------------------------

::

   SHMEM_USE_DSMML
               Specifies the usage of Cray DSMML library as the symmetric
               heap memory management layer. There are two symmetric heap
               management layers available in Cray OpenSHMEMX: (1) internal
               module with basic functionalities, (2) Cray DSMML module with
               advanced and optimized features. By, default Cray DSMML is
               used as the symmetric heap management layer. If set, enables
               the use of Cray DSMML as the symmetric heap management layer
               in Cray OpenSHMEMX.

               Default: 1 (enabled)

   SHMEM_USE_DSMML_SSHEAP
               If set, enables the usage of shared symmetric heap (SSHEAP)
               based symmetric memory management operation. SSHEAP is an
               option available to perform on-node data transfer as a direct
               load/store operation. SSHEAP can be considered as a
               replacement for XPMEM and CMA based transfer operation. Usable
               only when SHMEM_USE_DSMML is enabled.

               Default: 1 (enabled)

Cray OpenSHMEMX Collectives Specific Environment Variables
----------------------------------------------------------

::

    SHMEM_ALLTOALL_BLOCK_SIZE
              Specifies the blocksize in bytes for shmem_alltoall and
              shmem_alltoallv to use when strip-mining the data transfers.
              For Cray XE systems, the default varies between 256 and
              1536, depending on the number of PEs being used per node. A
              higher number of PEs per node results in a lower blocksize.
              An optimal blocksize may be dependent on the specific
              network configuration. Valid blocksizes range from -1 to
              MAX_INT, in multiples of eight. The value is interpreted as
              bytes, unless the string ends with a K, indicating
              kilobytes, or M, indicating megabytes. A value of -1
              indicates use of the default value.

              Default: -1 (varies)

    SHMEM_ALLTOALL_SHORT_MSG
              Specifies the threshold in bytes at and below which SHMEM
              attempts to use the SMP-aware alltoall algorithm. A strip-
              mined, non-blocking PUT algorithm is used for larger
              transfers. The SMP-aware algorithm usually performs best for
              small alltoall transfers, but has additional restrictions.
              The SMP-aware algorithm will not be used if the PE subset is
              contained to one node or if the PE subset uses only one PE
              per node. In addition, all nodes in the subset must be
              identical in terms of number of PEs per node, with the
              exception of the last node in the set. The SMP-aware
              algorithm requires (number_of_nodes *
              number_of_PEs_per_node^2 * len_of_msg) extra bytes of
              symmetric memory. This can be controlled via the
              SHMEM_ALLTOALL_SYMBUF_SIZE environment variable.

              Default: 32 bytes

    SHMEM_ALLTOALL_SYMBUF_SIZE
              Specifies the amount of additional symmetric memory
              allocated during shmem initialization, to be used for the
              SMP-aware alltoall algorithm. The value is interpreted as
              bytes, unless the string ends in a K, indicating kilobytes,
              or M, indicating megabytes. See the SHMEM_ALLTOALL_SHORT_MSG
              environment variable description to determine how much
              memory is required.

              Default: 4M

    SHMEM_ALLTOALL_SYNC_FREQ
              Specifies the synchronization frequency (the number of
              outstanding requests) to use for the shmem_alltoall and
              shmem_alltoallv routines when using non-blocking
              transactions. For Gemini systems, the default varies between
              1 and 256, depending on the number of PEs being used per
              node and the blocksize of the transfers. A higher number of
              PEs per node results in a lower synchronization frequency.
              An optimal synchronization frequency may be dependent on the
              specific network configuration. A valid synchronization
              frequency is in the range of -1 to MAX_INT. A value of -1
              indicates use of the default values.

              Default: -1 (varies)

    SHMEM_ALLTOALL_USE_GETS
              By default, shmem_alltoall and shmem_alltoallv use PUTs. If
              this environment variable is set, GETs are used instead.
              This does not apply to the shmem_alltoallv_packed routine.

              Default: not set

    SHMEM_ALLTOALLV_TSIZE_CHK
              Setting this will enable additional error checking for the
              shmem_alltoallv and shmem_alltoallv_packed collective
              routines to help prevent overwriting data in the target
              array. If set to abort or trunc, the user must pass in the
              maximum number of bytes allowed from each PE in the t_sizes
              array for shmem_alltoallv. Using this data, the
              shmem_alltoallv routine will either abort if any PE plans to
              send more than the maximum bytes it is allowed, or truncate
              the data so that it fits in the maximum allowed bytes. If
              truncation occurs, the returned values in t_sizes will
              reflect the truncated values. Allowed values are none, abort
              or trunc.

              Default: none

              Note:  Setting this option may negatively affect
              performance, as additional communication may be necessary.

    SHMEM_COLL_OPT_OFF
              If set, disables collective optimizations that use
              architecture-specific algorithms for some SHMEM collective
              operations. By default, all available collective optimized
              algorithms are enabled.

              To disable all collective optimized algorithms, set
              SHMEM_COLL_OPT_OFF to 1.

              To disable optimized algorithms for selected SHMEM
              collectives, set the value to a comma-separated list of the
              desired collective names. Names are not case-sensitive. Any
              unrecognizable name is flagged with a warning message and
              ignored.

              The following collective names are recognized:
              shmem_alltoall(3), shmem_alltoallv(3),
              shmem_alltoallv_packed(3),shmem_and, shmem_barrier,
              shmem_barrier_all, shmem_broadcast, shmem_max, shmem_min,
              shmem_or, shmem_prod, shmem_sum, and shmem_xor.

              Default: all available collective optimized algorithms are
              enabled

    SHMEM_MASSIVE_BCAST_CUTOFF
              Controls the cutoff size (in bytes) at or above which the
              optimized broadcast algorithm for very large monolithic data
              buffers is enabled. This environment variable is applicable
              only if the SHMEM_USE_OPT_MASSIVE_BCAST environment variable
              is enabled. The value set in this environment variable is
              interpreted as a number of bytes, unless the number is
              followed by a char that acts as a multiplier. The suffixes
              K, M, and G are supported: K (kilobytes) multiplies by 2**10
              , M (megabytes) multiplies by 2**20 , and G (gigabytes)
              multiplies by 2**30. Valid values are between 0 and
              LONG_MAX.

              Default: 16777216 bytes

    SHMEM_REDUCE_CUTOFF_SIZE
              Controls the cutoff size (in bytes) at or above which the
              optimized reduction algorithm is used for collective
              reduction operation. This environment variable is applicable
              only if the SHMEM_USE_LARGE_OPT_REDUCE environment variable
              is enabled.

              The value set in this environment variable is interpreted as
              a number of bytes, unless the number is followed by a char
              that acts as a multiplier. The suffixes K, M, and G are
              supported: K (kilobytes) multiplies by 2**10, M (megabytes)
              multiplies by 2**20, and G (gigabytes) multiplies by 2**30.
              Valid values are between 0 and LONG_MAX.

              Default: 16384 bytes

    SHMEM_TEAM_FREE_ASSO_CHILD
              This variable ensures all active associated child teams are
              destroyed along with the parent team during a
              shmem_team_free operation. All associated team resources
              used by the parent and child teams are freed. Further
              attempt to destroy any child teams associated with this
              parent team will result in an invalid argument error. By
              default, only the parent team is destroyed during a
              shmem_team_free operation.

              Default: 0 (disabled)

    SHMEM_TEAM_SMP_REDUCE
              An optimized shared memory based reduction algorithm for
              team-based reduction operations. If set to 0, the default
              reduction algorithm is used for the team-based reduction
              operation. If set to 1, the shared memory based optimized
              reduction algorithm is used for the team-based reduction
              operation.

              Note:  This optimization is applicable only for team-based
              reduction and not for active-set based reduction operations.
              The usage of this environment variable is independent of
              SHMEM_COLL_OPT_OFF usage. This optimization is effective on
              teams which are distributed across more than one node and
              at least one node from this distribution has more than
              one-PE per node. If rank reordering is selected, this
              optimization will be disabled.

              Default: 0

    SHMEM_TEAMS_MEM_OPT_LEVEL
              Specifies the level of memory reduction optimizations that
              can be performed on maintaining SHMEM team members.

              Accepted Values: 0: No memory reduction optimizations are
              performed | 1: Based on the size of teams crated, team
              members are maintained in a tightly packed list to avoid
              memory wastage on free bits in those lists.

              Default: 0

    SHMEM_USE_LARGE_OPT_REDUCE
              An optimized reduction algorithm for large data sizes. If
              set to 0, the default reduction algorithm is used for all
              data sizes. If set to 1, an optimized reduction algorithm
              for large data sizes is used. The cutoff for the data size
              is set using SHMEM_REDUCE_CUTOFF_SIZE. The usage of this
              environment variable is independent of SHMEM_COLL_OPT_OFF
              usage.

              Default: 0

    SHMEM_USE_OPT_MASSIVE_BCAST
              An optimized broadcast algorithm for very large monolithic
              data sizes. If set to 0, the default broadcast algorithm
              selection is done based on the data sizes. If set to 1, an
              optimized algorithm is used. The algorithm enabled by this
              environment variable is tuned specifically for very large
              monolithic data sizes of 16MB and above. The cutoff data
              size is set using SHMEM_MASSIVE_BCAST_CUTOFF. The usage of
              this environment variable is independent of SHMEM_COLL_OPT_OFF
              usage.

              Default: 0

    SHMEM_USE_OPTIMIZED_VSMSG_BCAST
              If set, this variable enables the use of an optimized
              shmem_broadcast algorithm for small messages (<=
              (_SHMEM_BCAST_SYNC_SIZE - 1) * sizeof(long)). Setting this
              variable invalidates advice in the shmem_broadcast man page
              which suggests that you can alternate between only two pSync
              arrays on successive calls to shmem_broadcast. If set, the
              user must use some type of synchronization to guarantee that
              the pSync is no longer in use by a previous call to
              shmem_broadcast.

              Default: 0 (not enabled)

Cray OpenSHMEMX Multithreading Specific Environment Variables
-------------------------------------------------------------

::

    SHMEM_THREAD_SAFETY
              Environment variable to display the OpenSHMEM thread safety level
              This environment variable acts as output to retrieve the
              application thread-safety level during runtime

Cray OpenSHMEMX Communication Context Environment Variables
-----------------------------------------------------------

::

    SHMEM_MAX_CTX
              Sets the maximum number of contexts required per process, if
              known. If the programmer does not know how many contexts will be
              created, the environment variable should not be set. This
              environment variable should be set to the correct value to get
              optimal performance from both the single and multithreaded
              application.

              Default:
              Application initialized with SHMEM_THREAD_SINGLE - 1

              Application initialized with SHMEM_THREAD_MULTIPLE - Dynamically
              calculated maximum number of available network resource available
              per PE in the node. Number of available network resource depends
              on the total number of PEs per node.

Cray OpenSHMEMX - SMP Communication Layer Specific Environment Variables
------------------------------------------------------------------------

::

    SHMEM_LOCALITY_ONNODE
              Enables or disable on-node SMP copies via XPMEM. This variable
              is enabled by default if there are more than one PEs per node
              and the system supports XPMEM transport.

              Default: 0/1 (enabled/disabled) based on the job configuration

    SHMEM_LOCALITY_OFFNODE
              Enables or disables using off-node network data transfers. This
              variable is enabled by default, if the PEs span across multiple
              nodes.

              Default: 0/1 (enabled/disabled) based on the job configuration

    SHMEM_SMP_SIZE_LIMIT
              Sets the maximum size in bytes for on-node SMP copies via
              XPMEM. If set to zero, on-node copy is disabled and all
              traffic is routed through the OFI network. If set to
              a negative value, the maximum size is unlimited and all on-
              node traffic is routed through XPMEM. In the case of strided
              puts and gets, the size limit is compared to the actual
              number of bytes to be put or gotten. The value is
              interpreted as bytes, unless the string ends in a k or K,
              which indicates kilobytes, or an m or M, which indicates
              megabytes.

              Default: -1 (unlimited)

    SHMEM_USE_SMP
              Support for this environment variable is discontinued. Please
              refer to SHMEM_LOCALITY_ONNODE and SHMEM_LOCALITY_OFFNODE to
              achieve similar functionality.

              Enables or disable on-node SMP copies via XPMEM. If disabled,
              on-node copy is disabled and all traffic is routed through the
              network.

              Default: 1 (enabled)

Cray OpenSHMEMX Libfabric Transport Specific Environment Variables
------------------------------------------------------------------

::

   SHMEM_OFI_FABRIC_DISPLAY
              If set, detailed fabric information for the selected provider
              will be displayed during shmem_init.

              Default: not set

   SHMEM_OFI_PROVIDER_DISPLAY
              If set, more verbose output will be displayed during shmem_init
              to verify which libfabric provider has been selected, along with
              the name and address of the NIC being used. This may be helpful
              for debugging errors encountered during shmem_init.

              Default: not set

   SHMEM_OFI_USE_PROV_NAME
              Specifies the libfabric provider to use.  By default, the
              "verbs;ofi_rxm" provider is selected for Slingshot-10 systems,
              since that is the supported and optimized provider. For
              debugging purposes, other libfabric providers may be requested
              by setting this variable to the desired provider name (i.e.
              sockets).

              Default: "verbs;ofi_rxm" on Slingshot-10 systems

   SHMEM_OFI_USE_DOMAIN_NAME
              Specifies the libfabric domain to use.  By default, the default
              for the first matching provider will be used but this value can
              be set to select an alternative.

              Default: not set

   SHMEM_OFI_USE_FABRIC_NAME
              Specifies the libfabric fabric to use.  By default, the default
              for the first matching provider will be used but this value can
              be set to select an alternative.

              Default: not set

   SHMEM_OFI_GLOBAL_EXIT
              If not set or set to 1, enables the OpenSHMEM API Version 1.2
              routine shmem_global_exit(). If set to 0, shmem_global_exit() is
              disabled and a call to shmem_global_exit() behaves as a call to
              exit().

              Default: enabled

   SHMEM_OFI_STARTUP_CONNECT

              By default, OFI connections between ranks are set up on demand.
              This allows for optimal performance while minimizing memory
              requirements.  However, for jobs requiring an all-to-all
              communication pattern, it may be beneficial to
              create all OFI connections in a coordinated manner at startup.
              If set to 1, Cray OpenSHMEMX will create connections between all
              ranks in the job during shmem_init() or shmem_thread_init().

              Default: 0

   FI_OFI_RXM_USE_SRX

              This is a verbs;ofi_rxm libfabric ENV variable.  Set this to 1
              to instruct the provider to use shared receive queues.  Using
              shared receive queues can reduce the overall memory usage
              significantly, but may cause latency to increase slightly.
              Setting this to 1 is highly recommended when running jobs with
              all-to-all communication patterns.

              Default: For jobs sizes of < 64 ranks, default is 0
                       For job sizes of 64 ranks or larger, default is 1

   FI_VERBS_PREFER_XRC

              This is a verbs;ofi_rxm libfabric ENV variable.  Set this to 1
              to request use of the XRC (eXtended Reliable Connection)
              protocol.  Note FI_OFI_RXM_USE_SRX must also be set to 1 when
              requesting XRC.  Using the XRC protocol reduces the number of
              connections, hardware resources, and memory footprint for large
              scaling jobs that require a demanding communication pattern.  This
              environment variable is required when scaling jobs with an
              all-to-all communication pattern.

              Default: For jobs sizes of < 64 ranks, default is 0
                       For job sizes of 64 ranks or larger, default is 1

   FI_VERBS_MIN_RNR_TIMER

              This is a verbs;ofi_rxm libfabric ENV variable. This sets the
              minimum backoff time used when the Mellanox NICs experience
              congestion.  Allowable values are 0-31, with higher values corresponding
              to longer backoffs.  Setting this to 0 is not recommended, however, as
              that translates into a very large backoff and will adversely affect
              performance. Optimal value for Slingshot-10 systems are likely
              between 3 and 6.

              Default: 6

   FI_MR_CACHE_MAX_COUNT
              This defines the total number of memory regions that may be registered
              with the cache. If not set, a default limit is chosen. Setting this will
              reduce the number of regions that are registered, regardless of their size,
              which are not actively being used as part of a data transfer. Setting this
              to zero will disable registration caching.

              Default: not set

Managing Memory in Cray OpenSHMEMX
==================================

    A subset of the SHMEM environment variables deal specifically with how
    memory is allocated for use by SHMEM routines. This section describes
    how to use these environment variables.

    **The support for this environment variable is available only on x86_64
    based Cray systems and not on Aarch64 systems.**

    SHMEM classifies data objects as either local or remote, based on
    whether the data object being referenced is owned by the PE (that is,
    local to the PE) or owned by another PE (that is, remote to the PE).
    It also classifies data objects based on the memory region in which
    the object resides: either the data segment, the private heap, the
    symmetric heap, or the stack. As arguments to SHMEM routines, local
    objects must reside entirely within one of the four memory regions,
    while remote objects must reside entirely within either the data
    segment or symmetric heap.

    To examine SHMEM memory usage, set the SHMEM_MEMINFO_DISPLAY
    environment variable to a value of 1 or greater. Doing so causes SHMEM
    initialization to produce a set of messages similar to this example.

       LIBSMA INFO:
        min PEs per node           = 24           on nid 62
        max PEs per node           = 24           on nid 62
        min nominal node size      = 32768M = 32G on nid 62
        max nominal node size      = 32768M = 32G on nid 62
        min boot_freemem           = 32032M = 31G on nid 65
        max boot_freemem           = 32035M = 31G on nid 56
        min initial_freemem        = 31783M = 31G on nid 62
        max initial_freemem        = 31791M = 31G on nid 7
        min current_freemem        =  7532M =  7G on nid 62
        max current_freemem        =  7539M =  7G on nid 7
        huge page size             =  2048K
        huge pages reserved =12000 = 24000M = 23G
        min huge_page_freemem      =  6416M =  6G on nid 62
        max huge_page_freemem      =  6708M =  6G on nid 6
        min huge pages alloc=12125 = 24250M = 23G on nid 62
        max huge pages alloc=12125 = 24250M = 23G on nid 62
        -----------------------------------------------------------
        memory                                   size (decimal MiB)
        region   virtual address range           per proc  per node
        -------  ------------------------------  --------  --------
        text     0x000000400000..0x000000501fe8        1M       24M
        data     0x000000703000..0x000000745b68        0M        6M
        bss      0x000000745b68..0x000006b6d190      100M     2403M
        privheap 0x000006b6d190..0x000006b90000        0M        3M
        symheap  0x030000000000..0x030038400000      900M    21600M
        alltoall 0x0300384fda40..0x0300388fda40        4M       96M
        team     0x0300388fdac0..0x0300388fdca0        0M        0M
        stack    0x7ffffffe8000..0x7ffffffff000        0M        2M
        --total                                     1005M    24134M
        OS                                                     735M
        --total                                              24869M = 24G

   Understanding the LIBSMA INFO

     nominal node size
               The nominal node size is the total physical memory on the
               node, rounded to the nearest GiB. Since different compute
               notes in the system may have different amounts of physical
               memory, the minimum and maximum sizes across all nodes
               allocated to your job are shown. If these values differ from
               what you expected, examine your job submission resource
               settings.

     PEs per node
               The number of PEs per node is the active number of processes
               allocated to the node, not necessarily the number of
               physical cores on the node. Variations in the number of PEs
               per node normally indicate that the total number of PEs
               allocated for the job is not an integer multiple of the
               requested number of PEs per node, so there is at least one
               node with a smaller number of active PEs, or a heterogeneous
               set of nodes may have been allocated to the job where some
               nodes have fewer cores than others. This does not cause a
               problem for SHMEM memory allocation because fewer PEs per
               node means more, not less, memory is available to each of
               those PEs. The size of the allocated regions is still the
               same across all PEs in the job, but is limited to the
               minimum available memory across all PEs.

    boot_freemem
              This is the kernel-determined value of the amount of memory
              available to programs on the node at boot time, before any
              programs have run. This value remains unchanged while the
              system is running. The value will vary at least slightly
              from node to node. Large variations between the minimum and
              maximum value may indicate a problem.

    initial_freemem
              This is the kernel-determined value of the amount of memory
              that was free at the beginning of the startup of the current
              job. The difference between boot_freemem and initial_freemem
              is a measure of how much memory is not available to the
              application, either because of processes from previous jobs
              that for some reason are still running on the node or
              possibly because of memory leaks on the node. A qualifier to
              this is that from job run to job run, the kernel may be
              temporarily holding onto some memory that it may later free
              while the job is running. Significant differences (1 GB or
              more) probably indicate a serious problem on that node.

    current_freemem
              This is the value of the amount of memory that was free at
              the completion of SHMEM initialization. This value is based
              on the kernel-determined value of /proc/current_freemem at
              that time plus the amount of memory already allocated for
              text, data, bss, symmetric heap, private heap, and stack.
              Memory reserved (by the aprun -m option) but not allocated
              for any of the above memory regions is still considered free
              and is included in the current_freemem value. This memory is
              available for use later in the application for growing of
              the private heap or for stack variables. The value can be
              expected to vary slightly from node to node.

    huge_page_size
              The size in bytes of huge pages for those memory regions
              backed by huge pages.

    huge_pages_reserved
              The number of huge pages reserved and the size in bytes of
              the memory backed by huge pages. The usual method for
              reserving huge pages is by using the aprun -m size [h|hs]
              parameter. See the aprun man page for more information.

    huge_page_freemem
              This value is the amount of free memory in large-enough
              blocks to support the size of the huge pages. This value
              takes into account that memory can get fragmented and that
              the total amount of free memory in large-enough blocks may
              be less than the total amount of free memory. This value
              includes huge pages that have been reserved but not yet
              allocated, so this is a critical value for determining how
              many huge pages can be allocated. The difference between
              current_freemem and huge_pages_freemem is a measure of how
              much memory is fragmented.

    huge_pages_alloc
              This gives the values of both the number of huge pages
              allocated and the corresponding amount of memory in bytes
              (actually, in mebibytes). Pages may have been reserved but
              not yet allocated, and because CLE supports dynamic
              allocation of huge pages, the amount allocated may be more
              than the amount reserved.

              Note that the SHMEM symmetric heap is always backed by huge
              pages and the full XT_SYMMETRIC_HEAP_SIZE amount is
              considered allocated during SHMEM initialization. Therefore
              memory allocated for the symmetric heap is no longer free in
              the context of current_freemem or huge_page_freemem, but is
              only available through shmalloc() calls.

    A percentage (controlled by the SHMEM_FREEMEM_THRESHOLD environment
    variable) of the current_freemem value is displayed because the value
    at the time of SHMEM initialization does not reflect future growth of
    the heap or stack during program execution and there is no way for
    SHMEM to determine future growth. Therefore when initialization tries
    to determine if the program will oversubscribe memory by adding up the
    sizes of the four SHMEM memory regions, allowing allocation of 100% of
    the current available memory at this time would very likely lead to
    running out of memory later during execution.

    Instead, SHMEM allows allocation of a percentage of memory using the
    SHMEM_FREEMEM_THRESHOLD environment variable. On subsequent job
    launches, you can increase or decreased this value based on your
    knowledge of the program and experience running it. Since each node
    allocated to a job runs its own instance of the operating system,
    since each node may have different amounts of physical memory, and
    since Linux memory management is highly dynamic and not strictly
    deterministic, the amount of available memory on the node can vary
    slightly from node to node, or sometimes greatly. Given that the SHMEM
    programming model requires the size of the SHMEM regions to be the
    same for each PE, a variation in the available memory from node to
    node means that the minimum across all nodes is essentially all that
    is available per node for all PEs.

    The lower section of the message lines displays the virtual address
    ranges for the four SHMEM memory regions. Addresses are in some cases
    rounded to meet alignment requirements.

    text      The text segment is not, strictly speaking, a SHMEM memory
              region, but is displayed here because it is an important
              piece of the memory allocation picture. This includes
              executable text and read-only data.

    data      The initialized read/write data area.

    bss       The uninitialized read/write data area. Taken together, the
              data and bss regions comprise the SHMEM data segment.

    privheap  The private heap is the region of memory used primarily for
              data objects allocated with calls to malloc(). The private
              heap can grow as more memory is allocated. The value
              displayed by SHMEM is the value at the time that SHMEM
              initialization is complete, so it does not reflect any
              growth of the heap later in the job. If the application
              mallocs a significant amount of memory, this should be taken
              into consideration when looking at current_freemem and
              huge_page_freemem in the SHMEM display. SHMEM initialization
              can not know how much the private heap will grow.

    symheap   The symmetric heap is the region of memory SHMEM has
              registered with the network for data transfers of objects on
              the symmetric heap. Data objects on the symmetric heap are
              allocated for use by the program with calls to shmalloc() or
              shpalloc(). This is the only valid way to allocate objects
              from the symmetric heap. Use the XT_SYMMETRIC_HEAP_SIZE
              environment variable to control the size of this region.

    alltoall  The region of symmetric memory used for the shmem_alltoall
              routines. This is not part of the symmetric heap specified
              by XT_SYMMETRIC_HEAP_SIZE. See the
              SHMEM_ALLTOALL_SYMBUF_SIZE environment variable.

    team      The region of symmetric memory used for the SHMEM team
              routines. This is not part of the symmetric heap specified
              by XT_SYMMETRIC_HEAP_SIZE.

    stack     The SHMEM stack is the region of memory used for data
              objects allocated on the stack. The stack can grow as
              routines are entered and stack space is needed. The value
              displayed by SHMEM is the value at the time that SHMEM
              initialization is complete so it does not reflect any growth
              of the stack later in the job. If the application uses a
              significant amount of stack space, this should be taken into
              consideration when looking at current_freemem and
              huge_page_freemem in the SHMEM display. SHMEM initialization
              cannot know how much the stack will grow.

    The first --total line gives the sum of the four SHMEM memory regions
    plus the text segment. It does not necessarily include all memory used
    by the program during execution of the program. The program may cause
    parts of the stack or heap to grow.

    The size given for the OS is an estimate based on information provided
    by /proc/boot_freemem on CLE 3.0 systems or later. This size basically
    represents all of physical memory on the node not directly available
    to the running program.

    The second --total line gives the sum of all allocated memory on the
    node at the time of SHMEM initialization. The purpose is to give a
    rough idea of how much of the node's memory is being used and how much
    more could be potentially used if needed.

    The SHMEM memory regions are allocated for each and every PE. If there
    is more than one active PE per node, the amount of memory allocated
    per node is the per PE value times the number of active PEs per node,
    so the display shows both on a per process basis and a per node basis.
    The memory allocated to the OS is only on a per node basis.

Overcommitment of Memory

     Because Cray XE systems do not have swap space that would allow
     overcommitment of physical memory, SHMEM initialization attempts to
     detect overcommitment. A process cannot request a total amount of
     memory for the combined data, private heap, symmetric heap, and stack
     segments in excess of the available free memory on the node divided by
     the number of active processes on the node.

    You will most likely want to use as much of the physical memory on the
    node as possible for the program's statically and dynamically
    allocated data. If the total of all of the memory regions per PE times
    the number of active PEs per node exceeds the available physical
    memory, a message like this one displays:

       LIBSMA ERROR:
        The total requested size for the data segment, stack,
        SHMEM symmetric heap, and private heap per PE of 1500M,
        times the number of PEs per node of 24 is 36015M. This
        exceeds 27135M, which is 95% of the available memory that
        is in blocks large enough to support a page size of 2048K.
        Try per PE values for
          datasegment + privheap + XT_SYMMETRIC_HEAP_SIZE + stack
        that totals 1130M or less.
        Or reduce the number of PEs per node.
        Or try a smaller huge page size.

    The sizes recommended in this message are guidelines, not guarantees,
    but are likely to be safe. You must match the memory demands of the
    program with the physical memory of the node and the sizes of the
    SHMEM memory regions.

Out-of-Range Address Arguments

     Data objects that are used as arguments to SHMEM routines must lie
     entirely within the SHMEM memory regions. If this is not the case, a
     message like this one is displayed:

      LIBSMA ERROR: PE 0: put target 0x007fffff7fbb50 lies neither in data
         segment nor symmmetric heap
            remote dataseg [0x000000005bc000 .. 0x0000000063d000] - PE 0
            remote symheap [0x002aaaab210000 .. 0x002aaaac311000] - PE 0

    In this example the operation failed because the target of a put
    operation must be a remote object, and the address is clearly not in
    the range of either remote memory region.

    If you need more information to diagnose and resolve the problem set
    the SHMEM_MEMINFO_DISPLAY environment variable to display information
    about how your job's memory is allocated. For example, doing so would
    make it clear that the address in the error message shown above is for
    an object on the stack, which is not allowed as the target for a put
    operation.

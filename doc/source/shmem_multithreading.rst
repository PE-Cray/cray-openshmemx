Multithreading in Cray OpenSHMEMX
=================================

::

   This section specifies the interaction between the OpenSHMEM interfaces
   and user threads. It also describes the routines that can be used for
   initializing and querying the thread environment. There are four levels
   of threading defined by the OpenSHMEM specification.

   SHMEM_THREAD_SINGLE
       The OpenSHMEM program must not be multithreaded.

   SHMEM_THREAD_FUNNELED
       The OpenSHMEM program may be multithreaded. However, the program must
       ensure that only the main thread invokes the OpenSHMEM interfaces. The
       main thread is the thread that invokes either shmem_init or
       shmem_init_thread.

   SHMEM_THREAD_SERIALIZED
       The OpenSHMEM program may be multithreaded. However, the program must
       ensure that the OpenSHMEM interfaces are not invoked concurrently by
       multiple threads.

   SHMEM_THREAD_MULTIPLE
       The OpenSHMEM program may be multithreaded and any thread may invoke the
       OpenSHMEM interfaces.

   The following semantics apply to the usage of these models:

       In the SHMEM_THREAD_FUNNELED, SHMEM_THREAD_SERIALIZED, and
       SHMEM_THREAD_MULTIPLE thread levels, the shmem_init and
       shmem_finalize calls must be invoked by the same thread.

       Any OpenSHMEM operation initiated by a thread is considered an action
       of the PE as a whole. The symmetric heap and symmetric variables scope
       are not impacted by multiple threads invoking the OpenSHMEM interfaces.
       Each PE has a single symmetric data segment and symmetric heap that is
       shared by all threads within that PE.  For example, a thread invoking
       a memory allocation routine such as shmem_malloc allocates memory that
       is accessible by all threads of the PE. The requirement that the same
       symmetric heap operations must be executed by all PEs in the same order
       also applies in a threaded environment. Similarly, the completion of
       collective operations is not impacted by multiple threads. For example,
       shmem_barrier_all is completed when all PEs enter and exit the
       shmem_barrier_all call, even though only one thread in the PE is
       participating in the collective call.

       Blocking OpenSHMEM calls will only block the calling thread, allowing
       other threads, if available, to continue executing. The calling thread
       will be blocked until the event on which it is waiting occurs. Once the
       blocking call is completed, the thread is ready to continue execution.
       A blocked thread will not prevent progress of other threads on the same
       PE and will not prevent them from executing other OpenSHMEM calls when
       the thread level permits. In addition, a blocked thread will not
       prevent the progress of OpenSHMEM calls performed on other PEs.

       In the SHMEM_THREAD_MULTIPLE thread level, all OpenSHMEM calls are
       thread-safe. Any two concurrently running threads may make OpenSHMEM
       calls and the outcome will be as if the calls executed in some order,
       even if their execution is interleaved.

       In the SHMEM_THREAD_SERIALIZED and SHMEM_THREAD_MULTIPLE thread levels,
       if multiple threads call collective routines, including the symmetric
       heap management routines, it is the programmer's responsibility to
       ensure the correct ordering of collective calls.

Cray-specific Thread-hot Multithreading Features
------------------------------------------------

::

   Cray supports optimized thread-hot features with each thread allowed to
   register a separate resource using Cray-specific thread-hot routines like
   shmemx_thread_register(3) and shmemx_thread_unregister(3).

Interaction between Cray Thread-hot and OpenSHMEM Communication Context
-----------------------------------------------------------------------

::

   From Cray OpenSHMEMX version 8.0.1, Cray thread-hot and OpenSHMEM
   communication context features can be used together.

   Users are requested to understand the following option while using
   multithreading support in Cray OpenSHMEMX:

   On Default build using Cray OpenSHMEMX with SMP-OFI transport layer:

   o  If known, set SHMEM_MAX_CONTEXT to the required maximum contexts per PE

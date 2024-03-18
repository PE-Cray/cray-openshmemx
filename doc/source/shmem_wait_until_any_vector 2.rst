shmem_wait_until_any_vector
===========================

   Wait on an array of variables on the local PE until any one variable meets
   its specified wait condition.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   size_t shmem_wait_until_any_vector(TYPE *ivars, size_t nelems, const int *status,
               int cmp, TYPE *cmp_values);

where TYPE is one of the point-to-point synchronization types specified
by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   size_t shmem_TYPENAME_wait_until_any_vector(TYPE *ivars, size_t nelems,
               const int *status, int cmp, TYPE *cmp_values);

where TYPE is one of the point-to-point synchronization types and has a
corresponding TYPENAME specified by Table:1

Datatype Reference Table
========================

Table:11
--------

     |           TYPE          |      TYPENAME       |
     |-------------------------|---------------------|
     |   short                 |     short           |
     |   int                   |     int             |
     |   long                  |     long            |
     |   long long             |     longlong        |
     |   unsigned short        |     ushort          |
     |   unsigned int          |     uint            |
     |   unsigned long         |     ulong           |
     |   unsigned long long    |     ulonglong       |
     |   int32_t               |     int32           |
     |   int64_t               |     int64           |
     |   uint32_t              |     uint32          |
     |   uint64_t              |     uint64          |
     |   size_t                |     size            |
     |   ptrdiff_t             |     ptrdiff         |

Arguments
=========

   ivars       Local address of an array of remotely accessible data objects.
               The type of ivars should match that implied in the SYNOPSIS
               section.
   nelems      The number of elements in the ivars array.
   status      Local address of an optional mask array of length nelems that
               indicates which elements in ivars are excluded from the wait set.
   cmp         A comparison operator from Table 12 that compares elements of
               ivars with cmp_value.
   cmp_value   The value to be compared with the objects pointed to by ivars.
               The type of cmp_value should match that implied in the SYNOPSIS
               section.

Description
===========

   The shmem_wait_until_any_vector routine waits until any one entry in the
   wait set specified by ivars and status satisfies the wait condition at the
   calling PE. The ivars objects at the calling PE may be updated by an AMO
   performed by a thread located within the calling PE or within another PE.
   This routine compares each element of the ivars array in the wait set with
   each respective value in cmp_values according to the comparison operator
   cmp at the calling PE. The order in which these elements are waited upon is
   unspecified. If an entry i in ivars within the wait set satisfies the wait
   condition, a series of calls to shmem_wait_until_any_vector must eventually
   return i.

   The optional status is a mask array of length nelems where each element
   corresponds to the respective element in ivars and indicates whether the
   element is excluded from the wait set. Elements of status set to 0 will be
   included in the wait set, and elements set to 1 will be ignored. If all
   elements in status are set to 1 or nelems is 0, the wait set is empty and
   this routine returns SIZE_MAX. If status is a null pointer, it is ignored
   and all elements in ivars are included in the wait set. The ivars and
   status arrays must not overlap in memory.

   Implementations must ensure that shmem_wait_until_any_vector does not return
   before the update of the memory indicated by ivars is fully complete.

Return Values
=============

   shmem_wait_until_any_vector returns the index of an element in the ivars
   array that satisfies the wait condition. If the wait set is empty, this
   routine returns SIZE_MAX.

Notes
=====

   None.

Examples
========

The following C11 example demonstrates the use of
shmem_wait_until_any_vector to wait on values that differ between even
PEs and odd PEs. ## C/C++ Example

.. code:: bash

   #include <shmem.h>
   #include <stdlib.h>

   #define N 100

   int main(void) {
     int total_sum = 0;

     shmem_init();
     int mype = shmem_my_pe();
     int npes = shmem_n_pes();

     int *ivars = shmem_calloc(npes, sizeof(int));
     int *status = calloc(npes, sizeof(int));
     int *cmp_values = malloc(npes * sizeof(int));

     /* All odd PEs put 2 and all even PEs put 1 */
     for (int i = 0; i < npes; i++) {
       shmem_atomic_set(&ivars[mype], mype % 2 + 1, i);

       /* Set cmp_values to the expected values coming from each PE */
       cmp_values[i] = i % 2 + 1;
     }

     for (int i = 0; i < npes; i++) {
       size_t completed_idx =
           shmem_wait_until_any_vector(ivars, npes, status, SHMEM_CMP_EQ, cmp_values);
       status[completed_idx] = 1;
       total_sum += ivars[completed_idx];
     }

     /* check the result */
     int correct_result = npes + npes / 2;

     if (total_sum != correct_result) {
       shmem_global_exit(1);
     }

     shmem_finalize();
     return 0;
   }

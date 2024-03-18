shmem_wait_until_some_vector
============================

   Wait on an array of variables on the local PE until at least one variable
   meets the its specified wait condition.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   size_t shmem_wait_until_some_vector(TYPE *ivars, size_t nelems, size_t *indices,
                                       const int *status, int cmp, TYPE *cmp_values);

where TYPE is one of the point-to-point synchronization types specified
by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   size_t shmem_TYPENAME_wait_until_some_vector(TYPE *ivars, size_t nelems, size_t *indices,
                                                const int *status, int cmp, TYPE *cmp_values);

where TYPE is one of the point-to-point synchronization types and has a
corresponding TYPENAME specified by Table:1

Datatype Reference Table
========================

Table:1
-------

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
   indices     Local address of an array of indices of length at least nelems
               into ivars that satisfied the wait conditio
   status      Local address of an optional mask array of length nelems that
               indicates which elements in ivars are excluded from the wait set.
   cmp         A comparison operator from Table 12 that compares elements of
               ivars with cmp_value.
   cmp_values  Local address of an array of length nelems containing values to
               be compared with the respective objects in ivars. The type of
               cmp_values should match that implied in the SYNOPSIS section.

Description
===========

   The shmem_wait_until_some_vector routine waits until at least one entry in
   the wait set specified by ivars and status satisfies the wait condition at
   the calling PE. The ivars objects at the calling PE may be updated by an
   AMO performed by a thread located within the calling PE or within another
   PE. This routine compares each element of the ivars array in the wait set
   with each respective value in cmp_values according to the comparison
   operator cmp at the calling PE. This routine tests all elements of ivars in
   the wait set at least once, and the order in which the elements are waited
   upon is unspecified. Upon return, the indices array contains the indices of
   at least one element in the wait set that satisfied the wait condition
   during the call to shmem_wait_until_some_vector. The return value of
   shmem_wait_until_some_vector is equal to the total number of these
   satisfied elements. For a given return value N, the first N elements of the
   indices array contain those unique indices that satisfied the wait
   condition. These first N elements of indices may be unordered with respect
   to the corresponding indices of ivars. The array pointed to by indices must
   be at least nelems long. If an entry i in ivars within the wait set
   satisfies the wait condition, a series of calls to
   shmem_wait_until_some_vector must eventually include i in the indices
   array.

   The optional status is a mask array of length nelems where each element
   corresponds to the respective element in ivars and indicates whether the
   element is excluded from the wait set. Elements of status set to 0 will be
   included in the wait set, and elements set to 1 will be ignored. If all
   elements in status are set to 1 or nelems is 0, the wait set is empty and
   this routine returns 0. If status is a null pointer, it is ignored and all
   elements in ivars are included in the wait set. The ivars, indices, and
   status arrays must not overlap in memory. Implementations must ensure that
   shmem_wait_until_some_vector does not return before the update of the
   memory indicated by ivars is fully complete.

Return Values
=============

   shmem_wait_until_some_vector returns the number of indices returned in the
   indices array. If the wait set is empty, this routine returns 0.

Notes
=====

   None.

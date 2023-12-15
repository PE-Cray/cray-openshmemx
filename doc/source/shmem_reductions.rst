shmem_reductions
================

::

   The following functions perform reduction operations across all PEs in a
   set of PEs.

Definitions
===========

AND
---

::

   Performs a bitwise AND reduction across a set of PEs.

C11 Synopsis
------------

.. code:: bash

   int shmem_and_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                           size_t nreduce);

::

   where TYPE is one of the integer types supported for the AND operation as
   specified by Table:10.

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_and_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                                   size_t nreduce);

::

   where TYPE is one of the integer types supported for the AND operation and
   has a corresponding TYPENAME as specified by Table:11.

Deprecated Synopsis
-------------------

Deprecated C/C++ Synopsis
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

   void shmem_TYPENAME_and_to_all(TYPE *dest, const TYPE *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               TYPE *pWrk, long *pSync);

::

   where TYPE is one of the integer types supported for the AND operation and
   has a corresponding TYPENAME as specified by Table:9.

OR
--

::

   Performs a bitwise OR reduction across a set of PEs.

.. _c11-synopsis-1:

C11 Synopsis
------------

.. code:: bash

   int shmem_or_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                           size_t nreduce);

::

   where TYPE is one of the integer types supported for the OR operation as
   specified by Table:10.

.. _cc-synopsis-1:

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_or_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                                   size_t nreduce);

::

   where TYPE is one of the integer types supported for the OR operation and
   has a corresponding TYPENAME as specified by Table:11.

.. _deprecated-synopsis-1:

Deprecated Synopsis
-------------------

.. _deprecated-cc-synopsis-1:

Deprecated C/C++ Synopsis
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

   void shmem_TYPENAME_or_to_all(TYPE *dest, const TYPE *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               TYPE *pWrk, long *pSync);

::

   where TYPE is one of the integer types supported for the OR operation and
   has a corresponding TYPENAME as specified by Table:9.

XOR
---

::

   Performs a bitwise exclusive OR (XOR) reduction across a set of PEs.

.. _c11-synopsis-2:

C11 Synopsis
------------

.. code:: bash

   int shmem_xor_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                           size_t nreduce);

::

   where TYPE is one of the integer types supported for the XOR operation as
   specified by Table:10.

.. _cc-synopsis-2:

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_xor_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                                   size_t nreduce);

::

   where TYPE is one of the integer types supported for the XOR operation and
   has a corresponding TYPENAME as specified by Table:11.

.. _deprecated-synopsis-2:

Deprecated Synopsis
-------------------

.. _deprecated-cc-synopsis-2:

Deprecated C/C++ Synopsis
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

   void shmem_TYPENAME_xor_to_all(TYPE *dest, const TYPE *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               TYPE *pWrk, long *pSync);

::

   where TYPE is one of the integer types supported for the XOR operation and
   has a corresponding TYPENAME as specified by Table:9.

MAX
---

::

   Performs a maximum-value reduction across a set of PEs.

.. _c11-synopsis-3:

C11 Synopsis
------------

.. code:: bash

   int shmem_max_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                           size_t nreduce);

::

   where TYPE is one of the integer, or real types supported for the MAX
   operation as specified by Table:10.

.. _cc-synopsis-3:

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_max_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                                   size_t nreduce);

::

   where TYPE is one of the integer, or real types supported for the MAX
   operation and has a corresponding TYPENAME as specified by Table:11.

.. _deprecated-synopsis-3:

Deprecated Synopsis
-------------------

.. _deprecated-cc-synopsis-3:

Deprecated C/C++ Synopsis
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

   void shmem_TYPENAME_max_to_all(TYPE *dest, const TYPE *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               TYPE *pWrk, long *pSync);

::

   where TYPE is one of the integer, or real types supported for the MAX
   operation and has a corresponding TYPENAME as specified by Table:9.

MIN
---

::

   Performs a minimum-value reduction across a set of PEs.

.. _c11-synopsis-4:

C11 Synopsis
------------

.. code:: bash

   int shmem_min_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                           size_t nreduce);

::

   where TYPE is one of the integer, or real types supported for the MIN
   operation as specified by Table:10.

.. _cc-synopsis-4:

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_min_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                                   size_t nreduce);

::

   where TYPE is one of the integer, or real types supported for the MIN
   operation and has a corresponding TYPENAME as specified by Table:11.

.. _deprecated-synopsis-4:

Deprecated Synopsis
-------------------

.. _deprecated-cc-synopsis-4:

Deprecated C/C++ Synopsis
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

   void shmem_TYPENAME_min_to_all(TYPE *dest, const TYPE *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               TYPE *pWrk, long *pSync);

::

   where TYPE is one of the integer, or real types supported for the MIN
   operation and has a corresponding TYPENAME as specified by Table:9.

SUM
---

::

   Performs a sum reduction across a set of PEs.

.. _c11-synopsis-5:

C11 Synopsis
------------

.. code:: bash

   int shmem_sum_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                           size_t nreduce);

::

   where TYPE is one of the integer, real, or complex types supported for the
   SUM operation as specified by Table:10.

.. _cc-synopsis-5:

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_sum_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                                   size_t nreduce);

::

   where TYPE is one of the integer, real, or complex types supported for the
   SUM operation and has a corresponding TYPENAME as specified by Table:11.

.. _deprecated-synopsis-5:

Deprecated Synopsis
-------------------

.. _deprecated-cc-synopsis-5:

Deprecated C/C++ Synopsis
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

   void shmem_TYPENAME_sum_to_all(TYPE *dest, const TYPE *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               TYPE *pWrk, long *pSync);

::

   where TYPE is one of the integer, real, or complex types supported for the
   SUM operation and has a corresponding TYPENAME as specified by Table:9.

PROD
----

::

   Performs a product reduction across a set of PEs.

.. _c11-synopsis-6:

C11 Synopsis
------------

.. code:: bash

   int shmem_prod_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                           size_t nreduce);

::

   where TYPE is one of the integer, real, or complex types supported for the
   PROD operation as specified by Table:10.

.. _cc-synopsis-6:

C/C++ Synopsis
--------------

.. code:: bash

   int shmem_TYPENAME_prod_reduce(shmem_team_t team, TYPE *dest, const TYPE *source,
                                   size_t nreduce);

::

   where TYPE is one of the integer, real, or complex types supported for the
   PROD operation and has a corresponding TYPENAME as specified by Table:11.

.. _deprecated-synopsis-6:

Deprecated Synopsis
-------------------

.. _deprecated-cc-synopsis-6:

Deprecated C/C++ Synopsis
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

   void shmem_TYPENAME_prod_to_all(TYPE *dest, const TYPE *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               TYPE *pWrk, long *pSync);

::

   where TYPE is one of the integer, real, or complex types supported for the
   PROD operation and has a corresponding TYPENAME as specified by Table:9.

Datatype Reference Table
========================

Table:9
-------

::

   |        TYPE        |  TYPENAME  |      Operations Supporting TYPE     |
   |--------------------|------------|-------------------------------------|
   | unsigned char      | uchar      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | short              | short      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | unsigned short     | ushort     | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | int                | int        | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | unsigned int       | uint       | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | long               | long       | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | unsigned long      | ulong      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | long long          | longlong   | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | unsigned long long | ulonglong  | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | float              | float      |              | MAX, MIN | SUM, PROD |
   | double             | double     |              | MAX, MIN | SUM, PROD |
   | long double        | longdouble |              | MAX, MIN | SUM, PROD |
   | double _Complex    | complexd   |              |          | SUM, PROD |
   | float _Complex     | complexf   |              |          | SUM, PROD |

Table:10
--------

::

   |        TYPE        |  TYPENAME  |      Operations Supporting TYPE     |
   |--------------------|------------|-------------------------------------|
   | char               | char       |              | MAX, MIN | SUM, PROD |
   | signed char        | schar      |              | MAX, MIN | SUM, PROD |
   | short              | short      |              | MAX, MIN | SUM, PROD |
   | int                | int        |              | MAX, MIN | SUM, PROD |
   | long               | long       |              | MAX, MIN | SUM, PROD |
   | long long          | longlong   |              | MAX, MIN | SUM, PROD |
   | ptrdiff_t          | ptrdiff    |              | MAX, MIN | SUM, PROD |
   | unsigned char      | uchar      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | unsigned short     | ushort     | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | unsigned int       | uint       | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | unsigned long      | ulong      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | unsigned long long | ulonglong  | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | int8_t             | int8       | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | int16_t            | int16      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | int32_t            | int32      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | int64_t            | int64      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | uint8_t            | uint8      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | uint16_t           | uint16     | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | uint32_t           | uint32     | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | uint64_t           | uint64     | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | size_t             | size       | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | float              | float      |              | MAX, MIN | SUM, PROD |
   | double             | double     |              | MAX, MIN | SUM, PROD |
   | long double        | longdouble |              | MAX, MIN | SUM, PROD |
   | double _Complex    | complexd   |              |          | SUM, PROD |
   | float _Complex     | complexf   |              |          | SUM, PROD |

.. _table9-1:

Table:9
-------

::

   |        TYPE        |  TYPENAME  |      Operations Supporting TYPE     |
   |--------------------|------------|-------------------------------------|
   | short              | short      | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | int                | int        | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | long               | long       | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | long long          | longlong   | AND, OR, XOR | MAX, MIN | SUM, PROD |
   | float              | float      |              | MAX, MIN | SUM, PROD |
   | double             | double     |              | MAX, MIN | SUM, PROD |
   | long double        | longdouble |              | MAX, MIN | SUM, PROD |
   | double _Complex    | complexd   |              |          | SUM, PROD |
   | float _Complex     | complexf   |              |          | SUM, PROD |

Arguments
=========

::

   team        The team over which to perform the operation.
   dest        Symmetric address of an array, of length nreduce elements,
               to receive the result of the reduction routines. The type of
               dest should match that implied in the SYNOPSIS section.
   source      Symmetric address of an array, of length nreduce elements, that
               contains one element for each separate reduction routine. The
               type of source should match that implied in the
               SYNOPSIS section.
   nreduce     The number of elements in the dest and source arrays. In teams
               based API calls, nreduce must be of type size_t. In deprecated
               active-set based API calls, nreduce must be of type integer.

   ---Deprecated---------------------------------------------------

   PE_start    The lowest PE number of the active set of PEs.
   logPE_stride    The log (base 2) of the stride between consecutive PE
               numbers in the active set.
   PE_size     The number of PEs in the active set.
   pWrk        Symmetric address of a work array of size at least
               max(nreduce/2 + 1,SHMEM_REDUCE_MIN_WRKDATA_SIZE) elements.
   pSync       Symmetric address of a work array of size at least
               SHMEM_REDUCE_SYNC_SIZE.

Description
===========

::

   OpenSHMEM reduction routines are collective routines over an active set or
   existing OpenSHMEM team that compute one or more reductions across
   symmetric arrays on multiple PEs. A reduction performs an associative binary
   routine across a set of values.

   The nreduce argument determines the number of separate reductions to
   perform. The source array on all PEs participating in the reduction provides
   one element for each reduction. The results of the reductions are placed in
   the dest array on all PEs participating in the reduction.

   The source and dest arguments must either be the same symmetric address,
   or two different symmetric addresses corresponding to buffers that do not
   overlap in memory. That is, they must be completely overlapping or
   completely disjoint.

   Team-based reduction routines operate over all PEs in the provided team
   argument. All PEs in the provided team must participate in the reduction.
   If team compares equal to SHMEM_TEAM_INVALID or is otherwise invalid, the
   behavior is undefined.

   Active-set-based sync routines operate over all PEs in the active set
   defined by the PE_start, logPE_stride, PE_size triplet.

   As with all active set-based collective routines, each of these routines
   assumes that only PEs in the active set call the routine. If a PE not in
   the active set calls an active set-based collective routine, the
   behavior is undefined.

   The values of arguments nreduce, PE_start, logPE_stride, and PE_size must
   be equal on all PEs in the active set. The same pWrk and pSync work arrays
   must be passed to all PEs in the active set.

   Before any PE calls a reduction routine, the following conditions must
   be ensured:
       • The dest array on all PEs participating in the reduction is ready to
           accept the results of the reduction.
       • If using active-set-based routines, the pWrk and pSync arrays on all
           PEs in the active set are not still in use from a prior call to a
           collective OpenSHMEM routine.
   Otherwise, the behavior is undefined.

   Upon return from a reduction routine, the following are true for
   the local PE:
       • The dest array is updated and the source array may be safely reused.
       • If using active-set-based routines, the values in the pSync array are
           restored to the original values.

   The complex-typed interfaces are only provided for sum and product
   reductions. When the C translation environment does not support
   complex types 7, an OpenSHMEM implementation is not required to provide
   support for these complex-typed interfaces.

Return Values
=============

::

   Zero on successful local completion. Nonzero otherwise.

Examples
========

C11 Example
-----------

::

   In the following example, each PE intializes an array of random
   integers with values between 0 and npes−1, inclusively. An OR reduction
   then tracks the array indices where maximal values occur (maximal values
   equal npes−1), and a SUM reduction counts the total number of maximal values
   across all PEs.

.. code:: bash

   #include <shmem.h>
   #include <stdio.h>
   #include <stdlib.h>

   #define NELEMS 32

   int main(void) {
       shmem_init();
       int mype = shmem_my_pe();
       int npes = shmem_n_pes();

       int *values = shmem_malloc(NELEMS * sizeof(int));

       unsigned char *value_is_maximal = shmem_malloc(NELEMS * sizeof(unsigned char));
       unsigned char *value_is_maximal_all = shmem_malloc(NELEMS * sizeof(unsigned char));

       static int maximal_values_count = 0;
       static int maximal_values_total;

       srand((unsigned)mype);

       for (int i = 0; i < NELEMS; i++) {
           values[i] = rand() % npes;

           /* Track and count instances of maximal values (i.e., values equal to (npes-1)) */
           value_is_maximal[i] = (values[i] == (npes - 1)) ? 1 : 0;
           maximal_values_count += value_is_maximal[i];
       }

       /* Wait for all PEs to initialize reductions arrays */
       shmem_sync(SHMEM_TEAM_WORLD);

       shmem_or_reduce(SHMEM_TEAM_WORLD, value_is_maximal_all, value_is_maximal, NELEMS);
       shmem_sum_reduce(SHMEM_TEAM_WORLD, &maximal_values_total, &maximal_values_count, 1);

       if (mype == 0) {
           printf("Found %d maximal random numbers across all PEs.\n", maximal_values_total);
           printf("A maximal number occured (at least once) at the following indices:\n");
           for (int i = 0; i < NELEMS; i++) {
               if (value_is_maximal_all[i] == 1) {
                   printf("%d ", i);
               }
           }
           printf("\n");
       }
       shmem_finalize();
       return 0;
   }

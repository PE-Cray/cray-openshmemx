shmem_reductions
=======

::

   The following functions perform reduction operations across all
   PEs in a set of PEs.

Definitions
-----------

Performs a bitwise AND reduction across a set of PEs. ### C/C++ Synopsis

.. code:: bash

   void shmem_short_and_to_all(short *dest, const short *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               short *pWrk, long *pSync);
   void shmem_int_and_to_all(int *dest, const int *source, int nreduce,
                             int PE_start, int logPE_stride, int PE_size,
                             int *pWrk, long *pSync);
   void shmem_long_and_to_all(long *dest, const long *source, int nreduce,
                              int PE_start, int logPE_stride, int PE_size,
                              long *pWrk, long *pSync);
   void shmem_longlong_and_to_all(long long *dest, const long long *source,
                                  int nreduce, int PE_start, int logPE_stride,
                                  int PE_size, long long *pWrk, long *pSync);

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_INT4_AND_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_INT8_AND_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)

Performs a maximum-value reduction across a set of

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_short_max_to_all(short *dest, const short *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               short *pWrk, long *pSync);
   void shmem_int_max_to_all(int *dest, const int *source, int nreduce,
                             int PE_start, int logPE_stride, int PE_size,
                             int *pWrk, long *pSync);
   void shmem_double_max_to_all(double *dest, const double *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               double *pWrk, long *pSync);
   void shmem_float_max_to_all(float *dest, const float *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               float *pWrk, long *pSync);
   void shmem_long_max_to_all(long *dest, const long *source, int nreduce,
                              int PE_start, int logPE_stride, int PE_size,
                              long *pWrk, long *pSync);
   void shmem_longdouble_max_to_all(long double *dest, const long double *source,
                                    int nreduce, int PE_start, int logPE_stride,
                                    int PE_size, long double *pWrk, long *pSync);
   void shmem_longlong_max_to_all(long long *dest, const long long *source,
                                  int nreduce, int PE_start, int logPE_stride,
                                  int PE_size, long long *pWrk, long *pSync);

.. _deprecated-fortran-synopsis-1:

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_INT4_MAX_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_INT8_MAX_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_REAL4_MAX_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_REAL8_MAX_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_REAL16_MAX_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                                PE_size, pWrk, pSync)

Performs a minimum-value reduction across a set of
PEs.:raw-latex:`\newline` ### C/C++ Synopsis

.. code:: bash

   void shmem_short_min_to_all(short *dest, const short *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               short *pWrk, long *pSync);
   void shmem_int_min_to_all(int *dest, const int *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               int *pWrk, long *pSync);
   void shmem_double_min_to_all(double *dest, const double *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               double *pWrk, long *pSync);
   void shmem_float_min_to_all(float *dest, const float *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               float *pWrk, long *pSync);
   void shmem_long_min_to_all(long *dest, const long *source, int nreduce,
                              int PE_start, int logPE_stride, int PE_size,
                              long *pWrk, long *pSync);
   void shmem_longdouble_min_to_all(long double *dest, const long double *source,
                                    int nreduce, int PE_start, int logPE_stride,
                                    int PE_size, long double *pWrk, long *pSync);
   void shmem_longlong_min_to_all(long long *dest, const long long *source,
                                  int nreduce, int PE_start, int logPE_stride,
                                  int PE_size, long long *pWrk, long *pSync);

.. _deprecated-fortran-synopsis-2:

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_INT4_MIN_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_INT8_MIN_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_REAL4_MIN_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_REAL8_MIN_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_REAL16_MIN_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)

Performs a sum reduction across a set of PEs.:raw-latex:`\newline` ###
C/C++ Synopsis

.. code:: bash

   void shmem_complexd_sum_to_all(double _Complex *dest,
                                  const double _Complex *source, int nreduce,
                                  int PE_start, int logPE_stride, int PE_size,
                                  double _Complex *pWrk, long *pSync);
   void shmem_complexf_sum_to_all(float _Complex *dest,
                                  const float _Complex *source, int nreduce,
                                  int PE_start, int logPE_stride, int PE_size,
                                  float _Complex *pWrk, long *pSync);
   void shmem_short_sum_to_all(short *dest, const short *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               short *pWrk, long *pSync);
   void shmem_int_sum_to_all(int *dest, const int *source, int nreduce,
                             int PE_start, int logPE_stride, int PE_size,
                             int *pWrk, long *pSync);
   void shmem_double_sum_to_all(double *dest, const double *source, int nreduce,
                                int PE_start, int logPE_stride, int PE_size,
                                double *pWrk, long *pSync);
   void shmem_float_sum_to_all(float *dest, const float *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               float *pWrk, long *pSync);
   void shmem_long_sum_to_all(long *dest, const long *source, int nreduce,
                             int PE_start, int logPE_stride,int PE_size,
                             long *pWrk, long *pSync);
   void shmem_longdouble_sum_to_all(long double *dest, const long double *source,
                                    int nreduce, int PE_start, int logPE_stride,
                                    int PE_size, long double *pWrk, long *pSync);
   void shmem_longlong_sum_to_all(long long *dest, const long long *source,
                                  int nreduce, int PE_start, int logPE_stride,
                                  int PE_size, long long *pWrk, long *pSync);

.. _deprecated-fortran-synopsis-3:

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_COMP4_SUM_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                               PE_size, pWrk, pSync)
   CALL SHMEM_COMP8_SUM_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                               PE_size, pWrk, pSync)
   CALL SHMEM_INT4_SUM_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                               PE_size, pWrk, pSync)
   CALL SHMEM_INT8_SUM_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                               PE_size, pWrk, pSync)
   CALL SHMEM_REAL4_SUM_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                               PE_size, pWrk, pSync)
   CALL SHMEM_REAL8_SUM_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                               PE_size, pWrk, pSync)
   CALL SHMEM_REAL16_SUM_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                               PE_size, pWrk, pSync)

Performs a product reduction across a set of PEs.:raw-latex:`\newline`
### C/C++ Synopsis

.. code:: bash

   void shmem_complexd_prod_to_all(double _Complex *dest,
                                   const double _Complex *source, int nreduce,
                                   int PE_start, int logPE_stride, int PE_size,
                                   double _Complex *pWrk, long *pSync);
   void shmem_complexf_prod_to_all(float _Complex *dest,
                                   const float _Complex *source, int nreduce,
                                   int PE_start, int logPE_stride, int PE_size,
                                   float _Complex *pWrk, long *pSync);
   void shmem_short_prod_to_all(short *dest, const short *source, int nreduce,
                                int PE_start, int logPE_stride, int PE_size,
                                short *pWrk, long *pSync);
   void shmem_int_prod_to_all(int *dest, const int *source, int nreduce,
                              int PE_start, int logPE_stride, int PE_size,
                              int *pWrk, long *pSync);
   void shmem_double_prod_to_all(double *dest, const double *source, int nreduce,
                                 int PE_start, int logPE_stride, int PE_size,
                                 double *pWrk, long *pSync);
   void shmem_float_prod_to_all(float *dest, const float *source, int nreduce,
                                int PE_start, int logPE_stride, int PE_size,
                                float *pWrk, long *pSync);
   void shmem_long_prod_to_all(long *dest, const long *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               long *pWrk, long *pSync);
   void shmem_longdouble_prod_to_all(long double *dest, const long double *source,
                                     int nreduce, int PE_start, int logPE_stride,
                                     int PE_size, long double *pWrk, long *pSync);
   void shmem_longlong_prod_to_all(long long *dest, const long long *source,
                                   int nreduce, int PE_start, int logPE_stride,
                                   int PE_size, long long *pWrk, long *pSync);

.. _deprecated-fortran-synopsis-4:

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_COMP4_PROD_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                                PE_size, pWrk, pSync)
   CALL SHMEM_COMP8_PROD_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                                PE_size, pWrk, pSync)
   CALL SHMEM_INT4_PROD_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                                PE_size, pWrk, pSync)
   CALL SHMEM_INT8_PROD_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                                PE_size, pWrk, pSync)
   CALL SHMEM_REAL4_PROD_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                                PE_size, pWrk, pSync)
   CALL SHMEM_REAL8_PROD_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                                PE_size, pWrk, pSync)
   CALL SHMEM_REAL16_PROD_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                                PE_size, pWrk, pSync)

Performs a bitwise OR reduction across a set of
PEs.:raw-latex:`\newline` ### C/C++ Synopsis

.. code:: bash

   void shmem_short_or_to_all(short *dest, const short *source, int nreduce,
                              int PE_start, int logPE_stride, int PE_size,
                              short *pWrk, long *pSync);
   void shmem_int_or_to_all(int *dest, const int *source, int nreduce,
                            int PE_start, int logPE_stride, int PE_size,
                            int *pWrk, long *pSync);
   void shmem_long_or_to_all(long *dest, const long *source, int nreduce,
                             int PE_start, int logPE_stride, int PE_size,
                             long *pWrk, long *pSync);
   void shmem_longlong_or_to_all(long long *dest, const long long *source,
                                 int nreduce, int PE_start, int logPE_stride,
                                 int PE_size, long long *pWrk, long *pSync);

.. _deprecated-fortran-synopsis-5:

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_INT4_OR_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                             PE_size, pWrk, pSync)
   CALL SHMEM_INT8_OR_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                             PE_size, pWrk, pSync)

Performs a bitwise exclusive OR (XOR) reduction across a set of
PEs.:raw-latex:`\newline` ### C/C++ Synopsis

.. code:: bash

   void shmem_short_xor_to_all(short *dest, const short *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               short *pWrk, long *pSync);
   void shmem_int_xor_to_all(int *dest, const int *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               int *pWrk, long *pSync);
   void shmem_long_xor_to_all(long *dest, const long *source, int nreduce,
                               int PE_start, int logPE_stride, int PE_size,
                               long *pWrk, long *pSync);
   void shmem_longlong_xor_to_all(long long *dest, const long long *source,
                               int nreduce, int PE_start, int logPE_stride,
                               int PE_size, long long *pWrk, long *pSync);

.. _deprecated-fortran-synopsis-6:

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_INT4_XOR_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)
   CALL SHMEM_INT8_XOR_TO_ALL(dest, source, nreduce, PE_start, logPE_stride,
                              PE_size, pWrk, pSync)

Arguments
---------

::

   dest        A symmetric array, of length nreduce elements, to receive the
               result of the reduction routines.  The data type of dest varies
               with the version of the reduction routine being called.  When
               calling from C/C++, refer to the SYNOPSIS section for data type
               information.
   source      A symmetric array, of length nreduce elements, that contains one
               element for each separate reduction routine.  The source
               argument must have the same data type as dest.
   nreduce     The number of elements in the dest and source arrays. nreduce
               must be of type integer.  When using Fortran, it must be a
               default integer value.
   PE_start    The lowest PE number of the active set of PEs.  PE_start must be
               of type integer.  When using Fortran, it must be a default
               integer value.
   logPE_stride    The log (base 2) of the stride between consecutive PE
               numbers in the active set.  logPE_stride must be of type integer.
               When using Fortran, it must be a default integer value.
   PE_size     The number of PEs in the active set. PE_size must be of type
               integer.  When using Fortran, it must be a default integer value.
   pWrk        A symmetric work array of size at least
               max(nreduce/2 + 1, SHMEM_REDUCE_MIN_WRKDATA_SIZE)
               elements.
   pSync       A symmetric work array of size SHMEM_REDUCE_SYNC_SIZE.
               In  C/C++, pSync must be an array of elements of type long.
               In Fortran, pSync must be an array of elements of default integer
               type. Every element of this array must be initialized with the value
               SHMEM_SYNC_VALUE before any of the PEs in the active set enter the
               routine.

Description
-----------

::

   OpenSHMEM reduction routines compute one or more reductions across symmetric
   arrays on multiple PEs.  A reduction performs an associative binary routine
   across a set of values.

   The nreduce argument determines the number of separate reductions to
   perform.  The source array on all PEs in the active set provides one
   element for each reduction.  The results of the reductions are placed in the
   dest array on all PEs in the active set.  The active set is defined
   by the PE_start, logPE_stride, PE_size triplet.

   The source and dest arrays may be the same array, but they may not be
   overlapping arrays.

   As with all OpenSHMEM collective routines, each of these routines assumes
   that only PEs in the active set call the routine.  If a PE not in
   the active set calls an OpenSHMEM collective routine, the behavior is undefined.

   The values of arguments nreduce, PE_start, logPE_stride, and PE_size must be
   equal on all PEs in the active set. The same dest and source arrays, and the
   same pWrk and pSync work arrays, must be passed to all PEs in the active set.

   Before any PE calls a reduction routine, the following conditions must be ensured:
   1. The pWrk and pSync arrays on all PEs in the active set are not still in
   use from a prior call to a collective OpenSHMEM routine.
   2. The dest array on all PEs in the active set is ready to accept the results
   of the reduction.
   Otherwise, the behavior is undefined.

   Upon return from a reduction routine, the following are true for the local
   PE: The dest array is updated and the "source" array may be safely reused.
   The values in the pSync array are restored to the original values.

   The complex-typed interfaces are only provided for sum and product reductions.
   When the C translation environment does not support complex types
   That is, under C language standards prior to C99 or under C11
   when __STDC_NO_COMPLEX__ is defined to 1, an OpenSHMEM implementation is not
   required to provide support for these complex-typed interfaces.



   When calling from Fortran, the dest date types are as follows:
   |        Routine        |                    Data type of dest                         |
   |-----------------------|--------------------------------------------------------------|
   |shmem_int8_and_to_all  |Integer, with an element size of 8 bytes.                     |
   |shmem_int4_and_to_all  |Integer, with an element size of 4 bytes.                     |
   |shmem_comp8_max_to_all |Complex, with an element size equal to two 8-byte real values.|
   |shmem_int4_max_to_all  |Integer, with an element size of 4 bytes.                     |
   |shmem_int8_max_to_all  |Integer, with an element size of 8 bytes.                     |
   |shmem_real4_max_to_all |Real, with an element size of 4 bytes.                        |
   |shmem_real16_max_to_all|Real, with an element size of 16 bytes.                       |
   |shmem_int4_min_to_all  |Integer, with an element size of 4 bytes.                     |
   |shmem_int8_min_to_all  |Integer, with an element size of 8 bytes.                     |
   |shmem_real4_min_to_all |Real, with an element size of 4 bytes.                        |
   |shmem_real8_min_to_all |Real, with an element size of 8 bytes.                        |
   |shmem_real16_min_to_all|Real,with an element size of 16 bytes.                        |
   |shmem_comp4_sum_to_all |Complex, with an element size equal to two 4-byte real values.|
   |shmem_comp8_sum_to_all |Complex, with an element size equal to two 8-byte real values.|
   |shmem_int4_sum_to_all  |Integer, with an element size of 4 bytes.                     |
   |shmem_int8_sum_to_all  |Integer, with an element size of 8 bytes.                     |
   |shmem_real4_sum_to_all |Real, with an element size of 4 bytes.                        |
   |shmem_real8_sum_to_all |Real, with an element size of 8 bytes.                        |
   |shmem_real16_sum_to_all|Real, with an element size of 16 bytes.                       |
   |shmem_comp4_prod_to_all|Complex, with an element size equal to two 4-byte real values.|
   |shmem_comp8_prod_to_all|Complex, with an element size equal to two 8-byte real values.|
   |shmem_int4_prod_to_all |Integer, with an element size of 4 bytes.                     |
   |shmem_int8_prod_to_all |Integer, with an element size of 8 bytes.                     |
   |shmem_real4_prod_to_all|Real, with an element size of 4 bytes.                        |
   |shmem_real8_prod_to_all|Real, with an element size of 8 bytes.                        |
   |shmem_real16_prod_to_al|Real, with an element size of 16 bytes.                       |
   |shmem_int8_or_to_all   |Integer, with an element size of 8 bytes.                     |
   |shmem_int4_or_to_all   |Integer, with an element size of 4 bytes.                     |
   |shmem_int8_xor_to_all  |Integer, with an element size of 8 bytes.                     |
   |shmem_int4_xor_to_all  |Integer, with an element size of 4 bytes.                     |

Return Values
-------------

::

   None.

Notes
-----

::

   All OpenSHMEM reduction routines reset the values in pSync before they
   return, so a particular pSync buffer need only be initialized the first
   time it is used. The user must ensure that the pSync array is not being
   updated on any PE in the active set while any of the PEs participate in
   processing of an OpenSHMEM reduction routine. Be careful to avoid the
   following situations: If the pSync array is initialized at run time, some
   type of synchronization is needed to ensure that all PEs in the working set
   have initialized pSync before any of them enter an OpenSHMEM routine called
   with the pSync synchronization array. A pSync or pWrk array can be
   reused in a subsequent reduction routine call only if none of the PEs in
   the active set are still processing a prior reduction routine call that used
   the same pSync or pWrk arrays. In general, this can be assured only
   by doing some type of synchronization.

Examples
--------

Fortran Example
---------------

::

   This Fortran reduction example statically initializes the pSync array
   and finds the logical AND of the integer variable FOO across all
   even PEs.

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_REDUCE_SYNC_SIZE)
   DATA PSYNC /SHMEM_REDUCE_SYNC_SIZE*SHMEM_SYNC_VALUE/
   PARAMETER (NR-1)
   INTEGER*4 PWRK(MAX(NR/2+1,SHMEM_REDUCE_MIN_WRKDATA_SIZE))
   INTEGER FOO, FOOAND
   SAVE FOO, FOOAND, PWRK
   INTRINSIC SHMEM_MY_PE()

   FOO - SHMEM_MY_PE()
   IF ( MOD(SHMEM_MY_PE() .EQ. 0) THEN
       IF ( MOD(SHMEM_N_PES()(),2) .EQ. 0) THEN
          CALL SHMEM_INT8_AND_TO_ALL(FOOAND, FOO, NR, 0, 1, NPES/2, &
        PWRK, PSYNC)
       ELSE
          CALL SHMEM_INT8_AND_TO_ALL(FOOAND, FOO, NR, 0, 1, NPES/2+1, &
        PWRK, PSYNC)

       ENDIF
       PRINT*,'Result on PE ',SHMEM_MY_PE(),' is ',FOOAND
   ENDIF

::

   This Fortran example statically initializes the pSync array and finds
   the maximum value of real variable FOO across all even PEs.

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_REDUCE_SYNC_SIZE)
   DATA PSYNC /SHMEM_REDUCE_SYNC_SIZE*SHMEM_SYNC_VALUE/
   PARAMETER (NR-1)
   REAL FOO, FOOMAX, PWRK(MAX(NR/2+1,SHMEM_REDUCE_MIN_WRKDATA_SIZE))
   COMMON /COM/ FOO, FOOMAX, PWRK
   INTRINSIC SHMEM_MY_PE()

   IF ( MOD(SHMEM_MY_PE() .EQ. 0) THEN
          CALL SHMEM_REAL8_MAX_TO_ALL(FOOMAX, FOO, NR, 0, 1, N$PES/2,
   &    PWRK, PSYNC)
          PRINT*,'Result on PE ',SHMEM_MY_PE(),' is ',FOOMAX
   ENDIF

::

   This Fortran example statically initializes the pSync array and finds
   the minimum value of real variable FOO across all the even PEs.

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_REDUCE_SYNC_SIZE)
   DATA PSYNC /SHMEM_REDUCE_SYNC_SIZE*SHMEM_SYNC_VALUE/
   PARAMETER (NR-1)
   REAL FOO, FOOMIN, PWRK(MAX(NR/2+1,SHMEM_REDUCE_MIN_WRKDATA_SIZE))
   COMMON /COM/ FOO, FOOMIN, PWRK
   INTRINSIC SHMEM_MY_PE()

   IF ( MOD(SHMEM_MY_PE() .EQ. 0) THEN
          CALL SHMEM_REAL8_MIN_TO_ALL(FOOMIN, FOO, NR, 0, 1, N$PES/2,
   &    PWRK, PSYNC)
          PRINT*,'Result on PE ',SHMEM_MY_PE(),' is ',FOOMIN
   ENDIF

::

   This Fortran example statically initializes the pSync array and finds
   the sum of the real variable FOO across all even PEs.

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_REDUCE_SYNC_SIZE)
   DATA PSYNC /SHMEM_REDUCE_SYNC_SIZE*SHMEM_SYNC_VALUE/
   PARAMETER (NR-1)
   REAL FOO, FOOSUM, PWRK(MAX(NR/2+1,SHMEM_REDUCE_MIN_WRKDATA_SIZE))
   COMMON /COM/ FOO, FOOSUM, PWRK
   INTRINSIC SHMEM_MY_PE()

   IF ( MOD(SHMEM_MY_PE() .EQ. 0) THEN
          CALL SHMEM_INT4_SUM_TO_ALL(FOOSUM, FOO, NR, 0, 1, N$PES/2,
   &    PWRK, PSYNC)
          PRINT*,'Result on PE ',SHMEM_MY_PE(),' is ',FOOSUM
   ENDIF

::

   This Fortran example statically initializes the pSync array and finds
   the product of the real variable FOO across all the even PEs.

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_REDUCE_SYNC_SIZE)
   DATA PSYNC /SHMEM_REDUCE_SYNC_SIZE*SHMEM_SYNC_VALUE/
   PARAMETER (NR-1)
   REAL FOO, FOOPROD, PWRK(MAX(NR/2+1,SHMEM_REDUCE_MIN_WRKDATA_SIZE))
   COMMON /COM/ FOO, FOOPROD, PWRK
   INTRINSIC SHMEM_MY_PE()

   IF ( MOD(SHMEM_MY_PE() .EQ. 0) THEN
           CALL SHMEM_COMP8_PROD_TO_ALL(FOOPROD, FOO, NR, 0, 1, N$PES/2,
   &    PWRK, PSYNC)
           PRINT*,'Result on PE ',SHMEM_MY_PE(),' is ',FOOPROD
   ENDIF

::

   This Fortran example statically initializes the pSync array and finds
   the logical OR of the integer variable FOO across all even PEs.

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_REDUCE_SYNC_SIZE)
   DATA PSYNC /SHMEM_REDUCE_SYNC_SIZE*SHMEM_SYNC_VALUE/
   PARAMETER (NR-1)
   REAL PWRK(MAX(NR/2+1,SHMEM_REDUCE_MIN_WRKDATA_SIZE))
   INTEGER FOO, FOOOR
   COMMON /COM/ FOO, FOOOR, PWRK
   INTRINSIC SHMEM_MY_PE()

   IF ( MOD(SHMEM_MY_PE() .EQ. 0) THEN
           CALL SHMEM_INT8_OR_TO_ALL(FOOOR, FOO, NR, 0, 1, N$PES/2,
   &    PWRK, PSYNC)
           PRINT*,'Result on PE ',SHMEM_MY_PE(),' is ',FOOOR
   ENDIF

::

   This Fortran example statically initializes the pSync array and
   computes the exclusive XOR of variable FOO across all even
   PEs.

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER PSYNC(SHMEM_REDUCE_SYNC_SIZE)
   DATA PSYNC /SHMEM_REDUCE_SYNC_SIZE*SHMEM_SYNC_VALUE/
   PARAMETER (NR-1)
   REAL FOO, FOOXOR, PWRK(MAX(NR/2+1,SHMEM_REDUCE_MIN_WRKDATA_SIZE))
   COMMON /COM/ FOO, FOOXOR, PWRK
   INTRINSIC SHMEM_MY_PE()

   IF ( MOD(SHMEM_MY_PE() .EQ. 0) THEN
          CALL SHMEM_REAL8_XOR_TO_ALL(FOOXOR, FOO, NR, 0, 1, N$PES/2,
   &    PWRK, PSYNC)
          PRINT*,'Result on PE ',SHMEM_MY_PE(),' is ',FOOXOR
   ENDIF

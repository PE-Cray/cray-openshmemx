shmem_wait_until
================

::

   Wait for a variable on the local PE to change.

Definitions
===========

C11 Synopsis
------------

.. code:: bash

   void shmem_wait_until(TYPE *ivar, int cmp, TYPE cmp_value);

where TYPE is one of the point-to-point synchronization types specified
by Table:1

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_TYPENAME_wait_until(TYPE *ivar, int cmp, TYPE cmp_value);

where TYPE is one of the point-to-point synchronization types and has a
corresponding TYPENAME specified by Table:1

Deprecated Synopsis
===================

Deprecated C11 Synopsis
-----------------------

.. code:: bash

   void shmem_wait_until(long *ivar, int cmp, long cmp_value);
   void shmem_wait(long *ivar, long cmp_value);
   void shmem_TYPENAME_wait(TYPE *ivar, TYPE cmp_value);

where TYPE is one of ``short``, ``int``, ``long``, ``long long`` and has
a corresponding TYPENAME specified by Table:1

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CALL SHMEM_INT4_WAIT(ivar, cmp_value)
   CALL SHMEM_INT4_WAIT_UNTIL(ivar, cmp, cmp_value)
   CALL SHMEM_INT8_WAIT(ivar, cmp_value)
   CALL SHMEM_INT8_WAIT_UNTIL(ivar, cmp, cmp_value)
   CALL SHMEM_WAIT(ivar, cmp_value)
   CALL SHMEM_WAIT_UNTIL(ivar, cmp, cmp_value)

Datatype Reference Table
========================

Table:1
-------

::

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

::

   ivar        A remotely accessible integer variable. When using  C/C++,
               the type of ivar should match that implied in the SYNOPSIS
               section.
   cmp         The compare operator that compares ivar with cmp_value. When
               using Fortran, it must  be of default kind. When using C/C++, it
               must be of type `int`.
   cmp_value   cmp_value must be of type integer.  When using  C/C++, the type
               of cmp_value should match that implied in the SYNOPSIS section.
               When using Fortran, cmp_value must be an integer of the same size
               and kind as ivar.

Comparision Constants
=====================

::

     |     Constant Name    |          Comparison          |
     |----------------------|------------------------------|
     | SHMEM_CMP_EQ         |  Equal                       |
     | SHMEM_CMP_NE         |  Not equal                   |
     | SHMEM_CMP_GT         |  Greater than                |
     | SHMEM_CMP_GE         |  Greater than or equal to    |
     | SHMEM_CMP_LT         |  Less than                   |
     | SHMEM_CMP_LE         |  Less than or equal to       |

Description
===========

::

   shmem_wait and shmem_wait_until wait for ivar to be changed by a write or an
   atomic operation issued by a PE.These  routines can be used for point-to-point
   direct synchronization.  A call to shmem_wait does not return until a PE
   writes a value not equal to cmp_value into ivar on the waiting PE.  A call
   to shmem_wait_until does not return until a PE changes ivar to satisfy the
   condition implied by cmp and cmp_value. The shmem_wait routines return when
   ivar is no longer equal to cmp_value. The shmem_wait_until routines return
   when the compare condition is true. The compare condition is defined by the
   ivar  argument  compared with the cmp_value using the comparison operator
   cmp.

   When using Fortran, ivar must be a specific sized integer type
   according to the routine being called, as follows:
   |               Routine                |      Data type      |
   |--------------------------------------|---------------------|
   |shmem_wait, shmem_wait_until          |default INTEGER      |
   |shmem_int4_wait, shmem_int4_wait_until|INTEGER*4            |
   |shmem_int8_wait, shmem_int8_wait_until|INTEGER*8            |

Return Values
=============

::

   None.

Notes
=====

::

   As of OpenSHMEM[1.4], the shmem_wait routine is deprecated, however, shmem_wait
   is equivalent to shmem_wait_until where cmp is SHMEM_CMP_NE. Implementations
   must ensure that shmem_wait and shmem_wait_until do not return before the
   update of the memory indicated by ivar is fully complete.  Partial updates
   to the memory must not cause shmem_wait or shmem_wait_until to return.

Examples
========

Fortran Example
---------------

The following call returns when variable ivar is not equal to 100:

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER*8 IVAR
   CALL SHMEM_INT8_WAIT(IVAR, INTEGER*8(100))

The following call to SHMEM_INT8_WAIT_UNTIL is equivalent to the call to
SHMEM_INT8_WAIT in example 1:

.. code:: bash

   INCLUDE "shmem.fh"

   INTEGER*8 IVAR
   CALL SHMEM_INT8_WAIT_UNTIL(IVAR, SHMEM_CMP_NE, INTEGER*8(100))

The following Fortran example is in the context of a subroutine:

.. code:: bash

   INCLUDE "shmem.fh"

   SUBROUTINE EXAMPLE()
   INTEGER FLAG_VAR
   COMMON/FLAG/FLAG_VAR
   . . .
   FLAG_VAR = FLAG_VALUE    !  initialize the event variable
   . . .
   IF (FLAG_VAR .EQ.  FLAG_VALUE) THEN
            CALL SHMEM_WAIT(FLAG_VAR, FLAG_VALUE)
   ENDIF
   FLAG_VAR = FLAG_VALUE    !  reset the event variable for next time
   . . .
   END

C/C++ Example
-------------

The following C/C++ call waits until the value in ivar is set to be less
than zero by a transfer from a remote PE:

.. code:: bash

   #include <stdio.h>
   #include <shmem.h>

   int ivar;
   shmem_int_wait_until(&ivar, SHMEM_CMP_LT, 0);

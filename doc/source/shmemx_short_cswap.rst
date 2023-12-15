shmemx_short_cswap
==================

::

   Performs an atomic cswap to a remote short data object.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   short shmemx_short_cswap(short *target, short cond, short value, int pe);

Arguments
=========

::

   target  The remotely accessible short data object to be updated on the
           remote PE. When using  C/C++, the type of target should match that
           implied in the SYNOPSIS section.
   cond    cond is compared to the remote target value. If cond and the remote
           target are equal, then value is swapped into the remote target;
           otherwise, the remote target is unchanged. In either case, the old
           value of the remote target is returned as the routine return value.
           cond must be of type short.
   value   The value to be atomically written to the remote PE. value is of
           type short.
   pe      An integer that indicates the PE number on which target is to be
           updated.

Description
===========

::

   shmemx_short_cswap performs an atomic conditional swap operation. It writes
   value into target on PE if the condition is met and returns the previous
   contents of target as an atomic operation.

Return Values
=============

::

   The content that had been at the target address on the remote PE prior to
   the swap is returned.

Notes
=====

::

   None.

shmemx_short_fadd
=================

   Performs an atomic fetch and add to a remote short data object.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   short shmemx_short_fadd(short *target, short value, int pe);

Arguments
=========

   target  The remotely accessible short data object to be updated on the
           remote PE. When using  C/C++, the type of target should match that
           implied in the SYNOPSIS section.
   value   The value to be atomically written to the remote PE. value is of
           type short.
   pe      An integer that indicates the PE number on which target is to be
           updated.

Description
===========

   shmemx_short_fadd performs an atomic fetch and add. It adds value to target
   on PE and returns the previous contents of target as an atomic operation.

Return Values
=============

   The content that had been at the target address on the remote PE prior to
   the add is returned.

Notes
=====

   None.

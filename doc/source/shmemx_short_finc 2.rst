shmemx_short_finc
=================

   Performs an atomic fetch and increment to a remote short data object.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   short shmemx_short_finc(short *target, int pe);

Arguments
=========

   target  The remotely accessible short data object to be updated on the
           remote PE. When using  C/C++, the type of target should match that
           implied in the SYNOPSIS section.
   pe      An integer that indicates the PE number on which target is to be
           updated.

Description
===========

   shmemx_short_finc performs an atomic fetch and increment. It incrementes the
   value of target on PE and returns the previous contents of target as an
   atomic operation.

Return Values
=============

   The content that had been at the target address on the remote PE prior to
   the increment is returned.

Notes
=====

   None.

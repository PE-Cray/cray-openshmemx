shmemx_short_add
================

::

   Performs an atomic add to a remote short data object.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_short_add(short *target, short value, int pe);

Arguments
=========

::

   target  The remotely accessible short data object to be updated on the
           remote PE. When using  C/C++, the type of target should match that
           implied in the SYNOPSIS section.
   value   The value to be atomically written to the remote PE. value is of
           type short.
   pe      An integer that indicates the PE number on which target is to be
           updated.

Description
===========

::

   shmemx_short_add performs an atomic add. It adds value to target
   on PE.

Return Values
=============

::

   None.

Notes
=====

::

   None.

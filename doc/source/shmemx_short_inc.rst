shmemx_short_inc
================

::

   Performs an atomic increment to a remote short data object.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmemx_short_inc(short *target, int pe);

Arguments
=========

::

   target  The remotely accessible short data object to be updated on the
           remote PE. When using  C/C++, the type of target should match that
           implied in the SYNOPSIS section.
   pe      An integer that indicates the PE number on which target is to be
           updated.

Description
===========

::

   shmemx_short_inc performs an atomic increment. It incrementes the
   value of target on PE.

Return Values
=============

::

   None.

Notes
=====

::

   None.

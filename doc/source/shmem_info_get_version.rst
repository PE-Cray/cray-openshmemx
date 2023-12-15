shmem_info_get_version
======================

::

   Returns the major and minor version of the library implementation.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_info_get_version(int *major, int *minor);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   INTEGER MAJOR, MINOR
   CALL SHMEM_INFO_GET_VERSION(MAJOR, MINOR)

Arguments
=========

::

   major   The major version of the OpenSHMEM Specification in use.
   minor   The minor version of the OpenSHMEM Specification in use.

Description
===========

::

   This routine returns the major and minor version of the OpenSHMEM Specification
   in use.  For a given library implementation, the major and minor version
   returned by these calls are consistent with the library constants
   SHMEM_MAJOR_VERSION and SHMEM_MINOR_VERSION.

Return Values
=============

::

   None.

Notes
=====

::

   None.

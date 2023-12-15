shmem_info_get_name
===================

::

   This routine returns the vendor defined name string that is consistent
   with the library constant SHMEM_VENDOR_STRING.

Definitions
===========

C/C++ Synopsis
--------------

.. code:: bash

   void shmem_info_get_name(char *name);

Deprecated Synopsis
===================

Deprecated Fortran Synopsis
---------------------------

.. code:: bash

   CHARACTER *(*)NAME
   CALL SHMEM_INFO_GET_NAME(NAME)

Arguments
=========

::

   name    The vendor defined string.

Description
===========

::

   This routine returns the vendor defined name string of size defined by the
   library constant SHMEM_MAX_NAME_LEN. The program calling this function provides
   the name memory buffer of at least size SHMEM_MAX_NAME_LEN. The implementation
   copies the vendor defined string of size at most SHMEM_MAX_NAME_LEN to name.
   In  C/C++, the string is terminated by a null character.  In Fortran, the
   string of size less than SHMEM_MAX_NAME_LEN is padded with blank characters
   up to size SHMEM_MAX_NAME_LEN. If the name memory buffer is provided with
   size less than SHMEM_MAX_NAME_LEN, behavior is undefined. For a given library
   implementation, the vendor string returned is consistent with the library
   constant SHMEM_VENDOR_STRING.

Return Values
=============

::

   None.

Notes
=====

::

   None.

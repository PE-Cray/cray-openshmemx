Cray OpenSHMEMX
===============

OpenSHMEM is a Partitioned Global Address Space (PGAS) library interface
specification, which is the culmination of a standardization effort among many
implementers and users of SHMEM programming model. SHMEM has a long history as a
parallel programming model. It is extensively used since 1993, starting from
Cray T3D systems. For the past two decades SHMEM library implementation in Cray
systems evolved through different generations. The current generation of the
SHMEM implementation for Cray XC and XK systems is called Cray SHMEM. Cray SHMEM
is a proprietary SHMEM implementation from Cray Inc., which is OpenSHMEM
standards compliant.

The next evolution of OpenSHMEM implementation for current and future generation
Cray systems is called Cray OpenSHMEMX.

This repository contains public announcement information about the Cray
OpenSHMEMX software stack including release information, updated manpages,
performance optimization and tuning parameters, supported environments and
systems, and general backward compatibility details.

Supported Platforms
-------------------
Cray OpenSHMEMX is supported on both X86_64 and AARCH64 based Cray XC systems.

On X86_64 systems, Cray SHMEM is still the production-ready implementation. Cray
OpenSHMEMX is released as a separate product from Cray SHMEM with plans to
supersede the existing Cray SHMEM library in near future. Early access to Cray
OpenSHMEMX library is provided for users to start migrating their existing
applications to the new library.

On AARCH64 systems, Cray OpenSHMEMX is the only available and supported SHMEM
implementation by Cray Inc.

.. toctree::
   :maxdepth: 2
   :caption: Contents:


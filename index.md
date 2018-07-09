## Description
OpenSHMEM is a Partitioned Global Address Space (PGAS) library interface specification,
which is the culmination of a standardization effort among many implementers and users
of SHMEM programming model. SHMEM has a long history as a parallel programming model.
It is extensively used since 1993, starting from Cray T3D systems. For the past two
decades SHMEM library implementation in Cray systems evolved through different
generations. The current generation of the SHMEM implementation for Cray XC and XK
systems is called Cray SHMEM. Cray SHMEM is a proprietary SHMEM implementation from
Cray Inc., which is OpenSHMEM standards compliant.

The next evolution of OpenSHMEM implementation for current and future generation Cray
systems is called Cray OpenSHMEMX.

This repository contains public announcement information about Cray OpenSHMEMX
software stack including topics like release information, performance optimization
and tuning parameters, supported environments and systems, and general backward
compatibility details.


## Release Information

### Version 8.0.0
Version 8.0.0 is the first official release of the Cray OpenSHMEMX library.

The following features were available in Cray OpenSHMEMX 8.0.0:

    - Cray OpenSHMEMX is OpenSHMEM 1.4 compliant with support for Communication
    contexts and sync operations, extended typed interface for RMA and AMO
    operations, bitwise AMOs, shmem_calloc, and shmem_test

    - Initial support for XC50 with Cavium ThunderX2 Arm blades (AARCH64)

    - To provide complete functional backward compatibility, the following
    Cray specific flagship features are imported from Cray SHMEM and
    supported as part of the Cray OpenSHMEMX library.

        * Support for Teams and Team based collectives

        * Support for Thread-hot features along with thread-based memory
        ordering operations

        * Support for non-blocking atomic memory operations

        * Support for optimized put with signal RMA operation

        * Support for Cray specific Generic RMA and AMO routines

        * Support for local node queries

        * Support for alltoallv and alltoallv packed collectives

    - Cray OpenSHMEMX supports the OpenSHMEM deprecated Fortran Interface,
    using shmem.fh and shmemx.fh.

    - See "[Introducing Cray OpenSHMEMX](https://pe-cray.github.io/whitepapers/)"
    white paper for more information on the new Cray OpenSHMEMX software product
    from Cray Inc.

    - Initial support for Cray OpenSHMEMX man pages are derived from OpenSHMEM
    standards specification document


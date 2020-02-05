## Description
<p align="justify">
OpenSHMEM is a Partitioned Global Address Space (PGAS) library interface specification,
which is the culmination of a standardization effort among many implementers and users
of SHMEM programming model. SHMEM has a long history as a parallel programming model.
It is extensively used since 1993, starting from Cray T3D systems. For the past two
decades SHMEM library implementation in Cray systems evolved through different
generations. The current generation of the SHMEM implementation for Cray XC and XK
systems is called Cray SHMEM. Cray SHMEM is a proprietary SHMEM implementation from
Cray Inc., which is OpenSHMEM standards compliant.
</p>

<p align="justify">
The next evolution of OpenSHMEM implementation for current and future generation Cray
systems is called Cray OpenSHMEMX.
</p>

<p align="justify">
This repository contains public announcement information about the Cray OpenSHMEMX
software stack including release information, updated manpages, performance
optimization and tuning parameters, supported environments and systems, and general
backward compatibility details.
</p>

## Supported Platforms
Cray OpenSHMEMX is supported on both X86_64 and AARCH64 based Cray XC systems.

1. On X86_64 systems, Cray SHMEM is still the production-ready implementation. 
Cray OpenSHMEMX is released as a separate product from Cray SHMEM with plans 
to supersede the existing Cray SHMEM library in near future. Early access to 
Cray OpenSHMEMX library is provided for users to start migrating their existing 
applications to the new library.

2. On AARCH64 systems, Cray OpenSHMEMX is the only available
and supported SHMEM implementation by Cray Inc.

## Manpage
Recent updated manpage corresponding to the latest released
version (version-9.0.0) can be accessed [here](man/main.html).

## Publications/Reference
The proper citation of Cray OpenSHMEMX is:
Naveen Namashivayam, Bob Cernohous, Dan Pou, and Mark Pagel, "OpenSHMEM 2018: Fifth Workshop on OpenSHMEM and Related Technologies." Baltimore, MD, August, 2018. "Introducing Cray OpenSHMEMX - A Modular Multi-Communication Layer OpenSHMEM Implementation."

The corresponding Bibtex is:
```
@inproceedings{naveen:openshmem:2018:crayopenshmemx,
    author = {Naveen Namashivayam and Bob Cernohous and Dan Pou and Mark Pagel},
    title  = {Introducing Cray OpenSHMEMX - A Modular Multi-Communication Layer OpenSHMEM Implementation},
    booktitle = {OpenSHMEM 2018: Fifth Workshop on OpenSHMEM and Related Technologies},
    month = Aug,
    year = {2018},
    location = {Baltimore, MD, USA},
}
```

## Release Information
1. [Cray OpenSHMEMX - version 8.0.0](#version-8.0.0)
2. [Cray OpenSHMEMX - version 8.0.1](#version-8.0.1)
3. [Cray OpenSHMEMX - version 9.0.0](#version-9.0.0)

### Version-9.0.0
Cray OpenSHMEMX version 9.0.0 is released on December 2019.

The following features are added with Cray OpenSHMEMX 9.0.0:

1. Introducing locality awareness. On single-node jobs, enable using
Cray OpenSHMEMX without initializing network transport options (DMAPP).
Refer to locality awareness in intro_shmem(3) man page.

The following bugfixes are handled in Cray OpenSHMEMX 9.0.0:

1. Fix memory ordering issues in using different memcpy (Cray optimized
and system default) operations on both x86_64 and aarch64 platforms.

2. Fix for using -Wpedantic flag in the application level

The following features are removed from Cray OpenSHMEMX 8.0.1:

1. Support for SHMEM_USE_SMP environment variable is discontinued. Instead
use SHMEM_LOCALITY_ONNODE and SHMEM_LOCALITY_OFFNODE environment variables
to get similar functionality. This version breaks compatibility with Cray
OpenSHMEMX/8.0.1.

### Version-8.0.1
Cray OpenSHMEMX version 8.0.1 is released on July 2018.

The following features are released with Cray OpenSHMEMX 8.0.1:

1. Support for Cray Thread-hot (THS) and OpenSHMEM communication contexts
(CTX). In Cray OpenSHMEMX version 8.0.0, THS and CTX are two mutually
exclusive features. From 8.0.1 THS and CTX can be used together in the same 
OpenSHMEM application. Please refer to "[Updating Cray Thread-Hot Semantics 
for OpenSHMEM v1.4](https://pe-cray.github.io/whitepapers/)" for 
more information on using THS and CTX features together.

2. Support for different CLE operating system releases. By default, Cray
OpenSHMEMX is supported in CLE 6.0 UP05 and above systems. To use Cray
OpenSHMEMX on older CLE systems adding -cray-openshmemx-ctx compiler flag
will automatically select the appropriate library. See the intro_shmem(3)
man page and "[Cray OpenSHMEMX (SMP-DMAPP) on Different CLE 
Versions](https://pe-cray.github.io/whitepapers/)" whitepaper for more 
information on usage details.

3. Multiple performance issues are fixed in 8.0.1 from version 8.0.0

### Version-8.0.0
Version 8.0.0 is the first official release of the Cray OpenSHMEMX library.

The following features are released with Cray OpenSHMEMX 8.0.0:
1. Cray OpenSHMEMX is OpenSHMEM 1.4 compliant with support for Communication
contexts and sync operations, extended typed interface for RMA and AMO
operations, bitwise AMOs, shmem_calloc, and shmem_test

2. Initial support for XC50 with Cavium ThunderX2 Arm blades (AARCH64)

3. To provide complete functional backward compatibility, the following
Cray-specific flagship features are imported from Cray SHMEM and supported as
part of the Cray OpenSHMEMX library.
    * Support for Teams and Team based collectives

    * Support for Thread-hot features along with thread-based memory
    ordering operations

    * Support for non-blocking atomic memory operations

    * Support for optimized put with signal RMA operation

    * Support for Cray-specific Generic RMA and AMO routines

    * Support for local node queries

    * Support for alltoallv and alltoallv packed collectives

4. Cray OpenSHMEMX supports the OpenSHMEM deprecated Fortran Interface, using
shmem.fh and shmemx.fh header files.

5.  See "[Introducing Cray OpenSHMEMX](https://pe-cray.github.io/whitepapers/)"
for more information on the new Cray OpenSHMEMX software product from Cray Inc.

6. Initial support for Cray OpenSHMEMX man pages are derived from OpenSHMEM
standards specification document

### Versioning Scheme
Cray OpenSHMEMX release uses the A.B.C version format. A Major version,
B Minor version number and C is the release version number. This versioning
system doesnot extend prior to 8.0.0 release.

Major (A): This is the first integer in the string and this typically mentions
a major change in the library like new OpenSHMEM standards compliance, or to a
end-user functionality. We can break compatibility with the previous released 
versions, if the major version changes.
  hints: Support for a new processor architecture or NIC or adding new
  environment variable or performance improvements without any end-user
  visible functional change would not be a reason to update the major
  version. In general, we should avoid breaking compatility and a major
  version update doesn't mean breaking compatibility.

Minor (B): The minor version number is the second integer. It denotes end-user
observable change without breaking compatibility. Adding new env variable,
support for new features, internal algorithms, changes in performance without
breaking compatibility forms the reason for updating the minor version.

Release (C): Last integer in the version string, typically denotes a bug-fix
without end-user obervable change.

Identifier (D): Again a numerical string to denote the build number for internal
development and test release. Usually this is not released to the users, all
user visible version identifiers are zero indexed. Any other identifier shared
with users are temporary releases and should be replaced by the next available
release.

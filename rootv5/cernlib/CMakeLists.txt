## CMake project file for cernlib

################################################################################
## PROJECT: cernlib
################################################################################
cmake_minimum_required (VERSION 2.8)
project (cernlib)
set (CERNLIB_MAJOR_VERSION 1)
set (CERNLIB_MINOR_VERSION 0)
set (CERNLIB_PATCH_VERSION 0)
set (CERNLIB_VERSION
  ${CERNLIB_MAJOR_VERSION}.${CERNLIB_MINOR_VERSION}.${CERNLIB_PATCH_VERSION})
set (CERNLIB_SOVERSION ${CERNLIB_MAJOR_VERSION})

################################################################################
## CMAKE Settings
################################################################################
include(cmake/options.cmake)
include(cmake/compiler.cmake)

################################################################################
## Add subdirectories
################################################################################
set (TARGETS "")
add_subdirectory(geant321)
add_subdirectory(packlib)
add_subdirectory(mathlib)
add_subdirectory(mclibs)
add_subdirectory(cfortran)
add_subdirectory(pawlib)


################################################################################
## Prepare the project to be EXPORTed, generate configuration files
################################################################################
include(cmake/export.cmake)

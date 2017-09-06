# - Config file for the cernlib package
# It defines the following variables
# CERNLIB_LIBRARIES     - libraries to link against
# CERNLIB_INCLUDE_DIR   - project include directory
# CERNLIB_DEFINITIONS       - cernlib defines needed to compile with cernlib
#                             headers
# CERNLIB_*_LIBRARY     - single cernlib libraries (e.g.
#                             CERNLIB_GEANT321_LIBRARY)
# CERNLIB_*_INCLUDE_DIR - project component include dir (e.g.
#                             CERNLIB_kernlib_INCLUDE_DIR)

# enable languages
enable_language(Fortran C)

# Compute paths
get_filename_component(CERNLIB_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
set(CERNLIB_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib")

# Cernlib defines
set(CERNLIB_DEFINITIONS "-DCERNLIB_LINUX;-DCERNLIB_UNIX;-DCERNLIB_LNX;-DCERNLIB_QMGLIBC;-DLinux;-DCERNLIB_TYPE")

# Our library dependencies (contains definitions for IMPORTED targets)
if (NOT TARGET cernlib_packlib AND
    NOT TARGET cernlib_mathlib AND
    NOT TARGET cernlib_geant321 AND
    NOT cernlib_BINARY_DIR)
  include("${CERNLIB_CMAKE_DIR}/cernlib-targets.cmake")
endif()

# These are IMPORTED targets created by bosIO-targets.cmake
# all libraries are mentioned twice to satisfy gcc in the case of
# cross-dependencies
set(CERNLIB_LIBRARIES
  packlib
  mathlib
  mclibs
  geant)
set(CERNLIB_LIBRARIES ${CERNLIB_LIBRARIES} ${CERNLIB_LIBRARIES})

## packlib
set(CERNLIB_packlib_LIBRARY "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/cernlib_packlib")
set(CERNLIB_packlib_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/packlib")
set(CERNLIB_cspack_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/cspack")
set(CERNLIB_epio_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/epio")
set(CERNLIB_ffread_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/ffread")
set(CERNLIB_hbook_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/hbook")
set(CERNLIB_zebra_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/zebra")
set(CERNLIB_kernlib_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/kernlib")
set(CERNLIB_kernbit_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/kernbit")
set(CERNLIB_kernnum_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/kernnum")
set(CERNLIB_kerngen_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/kerngen")

## mathlib
set(CERNLIB_mathlib_LIBRARY cernlib_mathlib)
set(CERNLIB_gen_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/gen")

## mclibs
set(CERNLIB_mclibs_LIBRARY cernlib_mclibs)
set(CERNLIB_pdf_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/pdf")

## geant321
set(CERNLIB_geant321_LIBRARY cernlib_geant321)
set(CERNLIB_geant321_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/geant321")

## cfortran
set(CERNLIB_cfortran_INCLUDE_DIR "${CERNLIB_CMAKE_DIR}/../../../include/cernlib/cfortran")

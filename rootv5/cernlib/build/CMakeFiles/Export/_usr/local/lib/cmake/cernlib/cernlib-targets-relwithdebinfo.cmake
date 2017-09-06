#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "geant" for configuration "RelWithDebInfo"
set_property(TARGET geant APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(geant PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "Fortran"
  IMPORTED_LOCATION_RELWITHDEBINFO "/usr/local/lib/libgeant.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS geant )
list(APPEND _IMPORT_CHECK_FILES_FOR_geant "/usr/local/lib/libgeant.a" )

# Import target "packlib" for configuration "RelWithDebInfo"
set_property(TARGET packlib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(packlib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "C;Fortran"
  IMPORTED_LOCATION_RELWITHDEBINFO "/usr/local/lib/libpacklib.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS packlib )
list(APPEND _IMPORT_CHECK_FILES_FOR_packlib "/usr/local/lib/libpacklib.a" )

# Import target "mathlib" for configuration "RelWithDebInfo"
set_property(TARGET mathlib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(mathlib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "Fortran"
  IMPORTED_LOCATION_RELWITHDEBINFO "/usr/local/lib/libmathlib.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS mathlib )
list(APPEND _IMPORT_CHECK_FILES_FOR_mathlib "/usr/local/lib/libmathlib.a" )

# Import target "mclibs" for configuration "RelWithDebInfo"
set_property(TARGET mclibs APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(mclibs PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "Fortran"
  IMPORTED_LOCATION_RELWITHDEBINFO "/usr/local/lib/libmclibs.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS mclibs )
list(APPEND _IMPORT_CHECK_FILES_FOR_mclibs "/usr/local/lib/libmclibs.a" )

# Import target "pawlib" for configuration "RelWithDebInfo"
set_property(TARGET pawlib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(pawlib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "C"
  IMPORTED_LOCATION_RELWITHDEBINFO "/usr/local/lib/libpawlib.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS pawlib )
list(APPEND _IMPORT_CHECK_FILES_FOR_pawlib "/usr/local/lib/libpawlib.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

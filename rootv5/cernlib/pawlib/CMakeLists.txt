################################################################################
## CMAKE Settings
################################################################################
set (LIBRARY "pawlib")
set (TARGETS ${TARGETS} ${LIBRARY} PARENT_SCOPE)

################################################################################
## Sources and install headers
################################################################################
file (GLOB SOURCES "*/*/*.F")
file (GLOB SOURCES "*/*/*.c")

################################################################################
## Include directories
################################################################################
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories("sigma" "comis" "paw")

################################################################################
## Compile and Link
################################################################################
add_library(${LIBRARY} STATIC ${SOURCES})
set_target_properties(${LIBRARY} PROPERTIES
  VERSION ${CERNLIB_VERSION}
  SOVERSION ${CERNLIB_SOVERSION})

################################################################################
## Export and Install
################################################################################
install(TARGETS ${LIBRARY}
  EXPORT "${PROJECT_NAME}-targets"
  RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT bin
  LIBRARY DESTINATION "${INSTALL_LIB_DIR}" COMPONENT lib
  ARCHIVE DESTINATION "${INSTALL_LIB_DIR}" COMPONENT lib)
## install the headers
install(DIRECTORY "pawlib"
  DESTINATION "${INSTALL_INCLUDE_DIR}" COMPONENT dev)

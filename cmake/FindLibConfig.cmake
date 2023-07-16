# Find the LibConfig includes and library
#
# This module defines
# LIBCONFIG_INCLUDE_DIR, where to find cppunit include files, etc.
# LIBCONFIG_LIBRARIES, the libraries to link against to use LibConfig.
# LIBCONFIG_STATIC_LIBRARIY_PATH
# LIBCONFIG_FOUND, If false, do not try to use LibConfig.

# also defined, but not for general use are
# LIBCONFIG_LIBRARY, where to find the LibConfig library.

#MESSAGE("Searching for libconfig library")

FIND_PATH(LIBCONFIG_INCLUDE_DIR libconfig.h
  /usr/local/include
  /usr/include
  /usr/lib/x86_64-linux-gnu/
)

FIND_LIBRARY(LIBCONFIG_LIBRARY config
  /usr/local/lib
  /usr/lib
  /usr/lib/x86_64-linux-gnu/
)


FIND_LIBRARY(LIBCONFIG_STATIC_LIBRARY "libconfig${CMAKE_STATIC_LIBRARY_SUFFIX}"
  /usr/local/lib
  /usr/lib
  /usr/lib/x86_64-linux-gnu/
)


IF(LIBCONFIG_INCLUDE_DIR)
  IF(LIBCONFIG_LIBRARY)
    SET(LIBCONFIG_FOUND TRUE)
    SET(LIBCONFIG_LIBRARIES ${LIBCONFIG_LIBRARY})
    SET(LIBCONFIG_STATIC_LIBRARY_PATH ${LIBCONFIG_STATIC_LIBRARY})
  ENDIF(LIBCONFIG_LIBRARY)
ENDIF(LIBCONFIG_INCLUDE_DIR)

MARK_AS_ADVANCED(LIBCONFIG_INCLUDE_DIR LIBCONFIG_LIBRARY LIBCONFIG_STATIC_LIBRARY)

#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Findtinyxml2
# ----------------
#
# Find the tinyxml2 library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``tinyxml::tinyxml2``,
# if tinyxml2 has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   TINYXML2_INCLUDE_DIRS - Include directories for tinyxml2.
#   TINYXML2_LIBRARIES - Libraries to link against tinyxml2.
#   TINYXML2_VERSION - Version of tinyxml2.
#   tinyxml2_FOUND - True if tinyxml2 has been found and can be used.

include(FindPackageHandleStandardArgs)

# Look for the header file.
find_path(TINYXML2_INCLUDE_DIR
    NAMES
        tinyxml2.h
    HINTS
        "${TINYXML2_LOCATION}/include"
        "$ENV{TINYXML2_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/tinyxml2/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of tinyxml2 resides")
mark_as_advanced(TINYXML2_INCLUDE_DIR)

if (TINYXML2_INCLUDE_DIR)
    # Tease the TINYXML2_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    set(TINYXML2_VERSION_FILE tinyxml2.h)

    parse_version_custom_var(${TINYXML2_INCLUDE_DIR} ${TINYXML2_VERSION_FILE} TINYXML2_VERSION_MAJOR TINYXML2_MAJOR_VERSION)
    parse_version_custom_var(${TINYXML2_INCLUDE_DIR} ${TINYXML2_VERSION_FILE} TINYXML2_VERSION_MINOR TINYXML2_MINOR_VERSION)
    parse_version_custom_var(${TINYXML2_INCLUDE_DIR} ${TINYXML2_VERSION_FILE} TINYXML2_VERSION_PATCH TINYXML2_PATCH_VERSION)

    set(TINYXML2_VERSION "${TINYXML2_VERSION_MAJOR}.${TINYXML2_VERSION_MINOR}.${TINYXML2_VERSION_PATCH}")
endif (TINYXML2_INCLUDE_DIR)

# Look for the library file.
find_library(TINYXML2_tinyxml2_LIBRARY
    NAMES
        libtinyxml2
        tinyxml2
    HINTS
        "${TINYXML2_LOCATION}/lib"
        "$ENV{TINYXML2_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/tinyxml2/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to tinyxml2 library.")
mark_as_advanced(TINYXML2_tinyxml2_LIBRARY)

find_package_handle_standard_args(tinyxml2
    REQUIRED_VARS TINYXML2_tinyxml2_LIBRARY TINYXML2_INCLUDE_DIR
    VERSION_VAR TINYXML2_VERSION)

if (tinyxml2_FOUND)
  set(TINYXML2_LIBRARIES ${TINYXML2_tinyxml2_LIBRARY})
  set(TINYXML2_INCLUDE_DIRS ${TINYXML2_INCLUDE_DIR})

  if (NOT TARGET tinyxml::tinyxml2)
    add_library(tinyxml::tinyxml2 UNKNOWN IMPORTED)
    set_target_properties(tinyxml::tinyxml2 PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${TINYXML2_INCLUDE_DIRS}")

    set_property(TARGET tinyxml::tinyxml2 APPEND PROPERTY IMPORTED_LOCATION "${TINYXML2_tinyxml2_LIBRARY}")
  endif ()
endif ()

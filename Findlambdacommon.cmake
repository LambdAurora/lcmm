#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Findlambdacommon
# ----------------
#
# Find the λcommon library and its C wrapper.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``AperLambda::lambdacommon`` and ``AperLambda::clambdacommon``,
# if λcommon has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   LAMBDACOMMON_INCLUDE_DIRS - Include directories for λcommon.
#   LAMBDACOMMON_LIBRARIES - Libraries to link against λcommon.
#   LAMBDACOMMON_INFO_EXECUTABLE - The λcommon info executable.
#   LAMBDACOMMON_VERSION - Version of λcommon.
#   lambdacommon_FOUND - True if λcommon has been found and can be used.

include(FindPackageHandleStandardArgs)

# Look for the header file.
find_path(LAMBDACOMMON_INCLUDE_DIR
    NAMES
        lambdacommon/lambdacommon.h
    HINTS
        "${LAMBDACOMMON_LOCATION}/include"
        "$ENV{LAMBDACOMMON_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/lambdacommon/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of λcommon resides")
mark_as_advanced(LAMBDACOMMON_INCLUDE_DIR)

if (LAMBDACOMMON_INCLUDE_DIR)
    # Tease the LAMBDACOMMON_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    set(LAMBDACOMMON_VERSION_FILE lambdacommon/lambdacommon.h)
    if (EXISTS "${LAMBDACOMMON_INCLUDE_DIR}/lambdacommon/lambdacommon_version.h")
      set(LAMBDACOMMON_VERSION_FILE lambdacommon/lambdacommon_version.h)
    endif ()

    parse_version(${LAMBDACOMMON_INCLUDE_DIR} ${LAMBDACOMMON_VERSION_FILE} LAMBDACOMMON_VERSION_MAJOR)
    parse_version(${LAMBDACOMMON_INCLUDE_DIR} ${LAMBDACOMMON_VERSION_FILE} LAMBDACOMMON_VERSION_MINOR)
    parse_version(${LAMBDACOMMON_INCLUDE_DIR} ${LAMBDACOMMON_VERSION_FILE} LAMBDACOMMON_VERSION_PATCH)
    parse_version_type(${LAMBDACOMMON_INCLUDE_DIR} ${LAMBDACOMMON_VERSION_FILE} LAMBDACOMMON_VERSION_TYPE)

    if (LAMBDACOMMON_VERSION_TYPE STREQUAL "Release")
      set(LAMBDACOMMON_VERSION "${LAMBDACOMMON_VERSION_MAJOR}.${LAMBDACOMMON_VERSION_MINOR}.${LAMBDACOMMON_VERSION_PATCH}")
    else ()
      set(LAMBDACOMMON_VERSION "${LAMBDACOMMON_VERSION_TYPE}${LAMBDACOMMON_VERSION_MAJOR}.${LAMBDACOMMON_VERSION_MINOR}.${LAMBDACOMMON_VERSION_PATCH}")
    endif ()
endif (LAMBDACOMMON_INCLUDE_DIR)

# Look for the lambdacommon_info executable.
find_program(LAMBDACOMMON_INFO_EXECUTABLE
    NAMES
        lambdacommon_info
    HINTS
        "${LAMBDACOMMON_LOCATION}/bin"
        "$ENV{LAMBDACOMMON_LOCATION}/bin"
    PATHS
        "$ENV{PROGRAMFILES}/lambdacommon/bin"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to λcommon_info executable.")
mark_as_advanced(LAMBDACOMMON_INFO_EXECUTABLE)

# Look for the library file.
find_library(LAMBDACOMMON_lambdacommon_LIBRARY
    NAMES
        liblambdacommon
        lambdacommon
    HINTS
        "${LAMBDACOMMON_LOCATION}/lib"
        "$ENV{LAMBDACOMMON_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/lambdacommon/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to λcommon library.")
mark_as_advanced(LAMBDACOMMON_lambdacommon_LIBRARY)

find_library(LAMBDACOMMON_clambdacommon_LIBRARY
        NAMES
        libclambdacommon
        clambdacommon
        HINTS
        "${LAMBDACOMMON_LOCATION}/lib"
        "$ENV{LAMBDACOMMON_LOCATION}/lib"
        PATHS
        "$ENV{PROGRAMFILES}/lambdacommon/lib"
        /usr/local/lib
        /usr/lib
        /lib
        DOC
        "The absolute path to λcommon C wrapper library.")
mark_as_advanced(LAMBDACOMMON_clambdacommon_LIBRARY)

find_package_handle_standard_args(lambdacommon
    REQUIRED_VARS LAMBDACOMMON_lambdacommon_LIBRARY LAMBDACOMMON_clambdacommon_LIBRARY LAMBDACOMMON_INCLUDE_DIR
    VERSION_VAR LAMBDACOMMON_VERSION)

if (lambdacommon_FOUND)
  set(LAMBDACOMMON_LIBRARIES ${LAMBDACOMMON_lambdacommon_LIBRARY} ${LAMBDACOMMON_clambdacommon_LIBRARY})
  set(LAMBDACOMMON_INCLUDE_DIRS ${LAMBDACOMMON_INCLUDE_DIR})

  if (LAMBDACOMMON_INFO_EXECUTABLE)
    if (NOT "${LAMBDACOMMON_INFO_EXECUTABLE}" STREQUAL "${LAMBDACOMMON_INFO_MESSAGE}")
      message(STATUS "lambdacommon -> Executable lambdacommon_info - found")

      set(LAMBDACOMMON_INFO_MESSAGE "${LAMBDACOMMON_INFO_EXECUTABLE}" CACHE INTERNAL "Details about finding lambdacommon_info")
    endif ()
  else ()
    if (NOT "${LAMBDACOMMON_INFO_EXECUTABLE}" STREQUAL "${LAMBDACOMMON_INFO_MESSAGE}")
      message(STATUS "lambdacommon -> Executable lambdacommon_info - not found")

      set(LAMBDACOMMON_INFO_MESSAGE "${LAMBDACOMMON_INFO_EXECUTABLE}" CACHE INTERNAL "Details about finding lambdacommon_info")
    endif ()
  endif ()

  if (NOT TARGET AperLambda::lambdacommon)
    add_library(AperLambda::lambdacommon UNKNOWN IMPORTED)
    set_target_properties(AperLambda::lambdacommon PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LAMBDACOMMON_INCLUDE_DIRS}")

    set_property(TARGET AperLambda::lambdacommon APPEND PROPERTY IMPORTED_LOCATION "${LAMBDACOMMON_lambdacommon_LIBRARY}")
  endif ()
  if (NOT TARGET AperLambda::clambdacommon)
    add_library(AperLambda::clambdacommon UNKNOWN IMPORTED)
    set_target_properties(AperLambda::clambdacommon PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LAMBDACOMMON_INCLUDE_DIRS}")

    set_property(TARGET AperLambda::clambdacommon APPEND PROPERTY IMPORTED_LOCATION "${LAMBDACOMMON_clambdacommon_LIBRARY}")
  endif ()
endif ()

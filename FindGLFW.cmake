#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindGLFW
# --------
#
# Find the GLFW library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``GLFW::GLFW``,
# if GLFW has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   GLFW_INCLUDE_DIRS - Include directories for GLFW.
#   GLFW_LIBRARIES - Libraries to link against GLFW.
#   GLFW_FOUND - True if GLFW has been found and can be used.

include(FindPackageHandleStandardArgs)

# Look for the header file.
find_path(GLFW_INCLUDE_DIR
    NAMES
        GLFW/glfw3.h
    HINTS
        "${GLFW_LOCATION}/include"
        "$ENV{GLFW_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/GLFW/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where GLFW/glfw3.h resides")
mark_as_advanced(GLFW_INCLUDE_DIR)

if (GLFW_INCLUDE_DIR)
    # Tease the GLFW_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    parse_version(${GLFW_INCLUDE_DIR} GLFW/glfw3.h GLFW_VERSION_MAJOR)
    parse_version(${GLFW_INCLUDE_DIR} GLFW/glfw3.h GLFW_VERSION_MINOR)
    parse_version(${GLFW_INCLUDE_DIR} GLFW/glfw3.h GLFW_VERSION_REVISION)

    set(GLFW_VERSION "${GLFW_VERSION_MAJOR}.${GLFW_VERSION_MINOR}.${GLFW_VERSION_REVISION}")
endif (GLFW_INCLUDE_DIR)

# Look for the library file.
find_library(GLFW_glfw_LIBRARY
    NAMES
        libglfw
        glfw3
        glfw
    HINTS
        "${GLFW_LOCATION}/lib"
        "$ENV{GLFW_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/GLFW/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to GLFW library.")
mark_as_advanced(GLFW_glfw_LIBRARY)

find_package_handle_standard_args(GLFW
    REQUIRED_VARS GLFW_glfw_LIBRARY GLFW_INCLUDE_DIR
    VERSION_VAR GLFW_VERSION)

if (GLFW_FOUND)
  set(GLFW_INCLUDE_DIRS ${GLFW_INCLUDE_DIR})
  set(GLFW_LIBRARIES ${GLFW_glfw_LIBRARY})

  if (NOT TARGET GLFW::GLFW)
    add_library(GLFW::GLFW UNKNOWN IMPORTED)
    set_target_properties(GLFW::GLFW PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${GLFW_INCLUDE_DIRS}")

    set_property(TARGET GLFW::GLFW APPEND PROPERTY IMPORTED_LOCATION "${GLFW_LIBRARIES}")
  endif ()
endif ()

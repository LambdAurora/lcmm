#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindGLEW
# --------
#
# Find the GLEW library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``GLEW::GLEW``,
# if GLEW has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   GLEW_INCLUDE_DIRS - Include directories for GLEW.
#   GLEW_LIBRARIES - Libraries to link against GLEW.
#   GLEW_FOUND - True if GLEW has been found and can be used.

include(FindPackageHandleStandardArgs)
include(SelectLibraryConfigurations)

# Look for the header file.
find_path(GLEW_INCLUDE_DIR
    NAMES
        GL/glew.h
    HINTS
        "${GLEW_LOCATION}/include"
        "$ENV{GLEW_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/GLEW/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where GL/glew.h resides")
mark_as_advanced(GLEW_INCLUDE_DIR)

# Look for the library release file.
find_library(GLEW_LIBRARY_RELEASE
    NAMES
        GLEW
        glew32
        glew
        glew32s
    HINTS
        "${GLEW_LOCATION}/lib"
        "$ENV{GLEW_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/GLEW/lib"
        /usr/local/lib
        /usr/lib
        /lib
    PATH_SUFFIXES
        lib64
    DOC
        "The absolute path to GLEW Release library.")

# Look for the library debug file.
find_library(GLEW_LIBRARY_DEBUG
    NAMES
        GLEWd
        glew32d
        glewd
    HINTS
        "${GLEW_LOCATION}/lib"
        "$ENV{GLEW_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/GLEW/lib"
        /usr/local/lib
        /usr/lib
        /lib
    PATH_SUFFIXES
        lib64
    DOC
        "The absolute path to GLEW Debug library.")

# Select the library configuration for GLEW.
select_library_configurations(GLEW)

find_package_handle_standard_args(GLEW
    REQUIRED_VARS GLEW_LIBRARY GLEW_INCLUDE_DIR
    VERSION_VAR GLEW_VERSION)

if (GLEW_FOUND)
  set(GLEW_INCLUDE_DIRS ${GLEW_INCLUDE_DIR})
  set(GLEW_LIBRARIES ${GLEW_LIBRARY})

  if (NOT TARGET GLEW::GLEW)
    add_library(GLEW::GLEW UNKNOWN IMPORTED)
    set_target_properties(GLEW::GLEW PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${GLEW_INCLUDE_DIRS}")

    if (GLEW_LIBRARY_RELEASE)
      set_property(TARGET GLEW::GLEW APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
      set_target_properties(GLEW::GLEW PROPERTIES IMPORTED_LOCATION_RELEASE "${GLEW_LIBRARY_RELEASE}")
    endif ()

    if (GLEW_LIBRARY_DEBUG)
      set_property(TARGET GLEW::GLEW APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
      set_target_properties(GLEW::GLEW PROPERTIES IMPORTED_LOCATION_DEBUG "${GLEW_LIBRARY_DEBUG}")
    endif ()

    if (NOT GLEW_LIBRARY_RELEASE AND NOT GLEW_LIBRARY_DEBUG)
      set_property(TARGET GLEW::GLEW APPEND PROPERTY IMPORTED_LOCATION "${GLEW_LIBRARY}")
    endif ()
  endif ()
endif ()

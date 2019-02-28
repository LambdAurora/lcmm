#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Findcpptoml
# ----------------
#
# Find the cpptoml library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``cpptoml::cpptoml``,
# if cpptoml has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   CPPTOML_INCLUDE_DIRS - Include directories for cpptoml.
#   cpptoml_FOUND - True if cpptoml has been found and can be used.

# Look for the header file.
find_path(CPPTOML_INCLUDE_DIR
    NAMES
        cpptoml.h
    HINTS
        "${CPPTOML_LOCATION}/include"
        "$ENV{CPPTOML_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/cpptoml/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of cpptoml resides")
mark_as_advanced(CPPTOML_INCLUDE_DIR)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(cpptoml
    REQUIRED_VARS CPPTOML_INCLUDE_DIR)

if (cpptoml_FOUND)
  set(CPPTOML_INCLUDE_DIRS ${CPPTOML_INCLUDE_DIR})

  if (NOT TARGET cpptoml::cpptoml)
    add_library(cpptoml::cpptoml UNKNOWN IMPORTED)
    set_target_properties(cpptoml::cpptoml PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${CPPTOML_INCLUDE_DIRS}")
  endif ()
endif ()

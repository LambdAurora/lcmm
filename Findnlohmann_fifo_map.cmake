#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Findnlohmann_fifo_map
# ----------------
#
# Find the nlohmann_fifo_map library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``nlohmann::fifo_map``,
# if nlohmann_fifo_map has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   NLOHMANN_FIFO_MAP_INCLUDE_DIRS - Include directories for nlohmann_fifo_map.
#   NLOHMANN_FIFO_MAP_VERSION - Version of nlohmann_fifo_map.
#   nlohmann_fifo_map_FOUND - True if nlohmann_fifo_map has been found and can be used.

# Look for the header file.
find_path(NLOHMANN_FIFO_MAP_INCLUDE_DIR
    NAMES
        nlohmann/fifo_map.hpp
        fifo_map.hpp
    HINTS
        "${NLOHMANN_FIFO_MAP_LOCATION}/include"
        "$ENV{NLOHMANN_FIFO_MAP_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/nlohmann/include"
        "$ENV{PROGRAMFILES}/nlohmann/fifo_map/include"
        "$ENV{PROGRAMFILES}/nlohmann_fifo_map/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of nlohmann_fifo_map resides")
mark_as_advanced(NLOHMANN_FIFO_MAP_INCLUDE_DIR)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(nlohmann_fifo_map
    REQUIRED_VARS NLOHMANN_FIFO_MAP_INCLUDE_DIR)

if (nlohmann_fifo_map_FOUND)
  set(NLOHMANN_FIFO_MAP_INCLUDE_DIRS ${NLOHMANN_FIFO_MAP_INCLUDE_DIR})

  if (NOT TARGET nlohmann::fifo_map)
    add_library(nlohmann::fifo_map UNKNOWN IMPORTED)
    set_target_properties(nlohmann::fifo_map PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${NLOHMANN_FIFO_MAP_INCLUDE_DIRS}")
  endif ()
endif ()

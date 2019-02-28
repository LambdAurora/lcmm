#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

# FindSOIL.cmake
# This script will find the library SOIL.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   SOIL_INCLUDE_DIRS - Include directories for SOIL.
#   SOIL_LIBRARIES - Libraries to link against SOIL.
#   SOIL_FOUND - True if SOIL has been found and can be used.

# Look for the header file.
find_path(SOIL_INCLUDE_DIR
    NAMES
        SOIL/SOIL.h
    HINTS
        "${SOIL_LOCATION}/include"
        "$ENV{SOIL_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/SOIL/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of SOIL resides")
mark_as_advanced(SOIL_INCLUDE_DIR)

FIND_LIBRARY(SOIL_SOIL_LIBRARY
    NAMES
        libSOIL
        SOIL
    HINTS
        "${SOIL_LOCATION}/lib"
        "$ENV{SOIL_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/SOIL/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to SOIL library.")
mark_as_advanced(SOIL_SOIL_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SOIL DEFAULT_MSG SOIL_SOIL_LIBRARY SOIL_INCLUDE_DIR)

set(SOIL_INCLUDE_DIRS ${SOIL_INCLUDE_DIR})
set(SOIL_LIBRARIES ${SOIL_SOIL_LIBRARY})

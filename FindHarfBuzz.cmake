#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

# FindHarfBuzz.cmake
# This script will find the library HarfBuzz.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   HARFBUZZ_INCLUDE_DIRS - Include directories for HarfBuzz.
#   HARFBUZZ_LIBRARIES - Libraries to link against HarfBuzz.
#   HARFBUZZ_FOUND - True if HarfBuzz has been found and can be used.

include(FindPackageHandleStandardArgs)

# Look for the header file.
find_path(HARFBUZZ_INCLUDE_DIR
    NAMES
        harfbuzz/hb.h
    HINTS
        "${HARFBUZZ_LOCATION}/include"
        "$ENV{HARFBUZZ_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/HarfBuzz/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of HarfBuzz resides")
mark_as_advanced(HARFBUZZ_INCLUDE_DIR)

if (HarfBuzz_INCLUDE_DIR)
    # Tease the HARFBUZZ_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    parse_version(${HARFBUZZ_INCLUDE_DIR} harfbuzz/hb-version.h HB_VERSION_MAJOR)
    parse_version(${HARFBUZZ_INCLUDE_DIR} harfbuzz/hb-version.h HB_VERSION_MINOR)
    parse_version(${HARFBUZZ_INCLUDE_DIR} harfbuzz/hb-version.h HB_VERSION_MICRO)

    set(HARFBUZZ_VERSION "${HB_VERSION_MAJOR}.${HB_VERSION_MINOR}.${HB_VERSION_MICRO}")
endif ()

# Look for the library file.
find_library(HARFBUZZ_HarfBuzz_LIBRARY
    NAMES
        libharfbuzz
        harfbuzz
    HINTS
        "${HARFBUZZ_LOCATION}/lib"
        "$ENV{HARFBUZZ_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/HarfBuzz/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to HarfBuzz library.")
mark_as_advanced(HARFBUZZ_HarfBuzz_LIBRARY)

find_package_handle_standard_args(HarfBuzz
    REQUIRED_VARS HARFBUZZ_HarfBuzz_LIBRARY HARFBUZZ_INCLUDE_DIR
    VERSION_VAR HARFBUZZ_VERSION)

mark_as_advanced(HarfBuzz_FOUND)

set(HARFBUZZ_FOUND ${HarfBuzz_FOUND})
set(HARFBUZZ_LIBRARIES ${HARFBUZZ_HarfBuzz_LIBRARY})
set(HARFBUZZ_INCLUDE_DIRS ${HARFBUZZ_INCLUDE_DIR})

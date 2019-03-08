#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Findkaguya
# ----------------
#
# Find the kaguya library, a C++ binding to Lua.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   KAGUYA_INCLUDE_DIRS - Include directories for kaguya.
#   kaguya_FOUND - True if kaguya has been found and can be used.

# Look for the header file.
find_path(KAGUYA_INCLUDE_DIR
    NAMES
        kaguya/kaguya.hpp
    HINTS
        "${KAGUYA_LOCATION}/include"
        "$ENV{KAGUYA_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/kaguya/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of kaguya resides")
mark_as_advanced(KAGUYA_INCLUDE_DIR)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(kaguya
    REQUIRED_VARS KAGUYA_INCLUDE_DIR)

if (kaguya_FOUND)
  set(KAGUYA_INCLUDE_DIRS ${KAGUYA_INCLUDE_DIR})
endif ()

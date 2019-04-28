#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindXCB
# ----------------
#
# Find the XCB library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``freedesktop::XCB``,
# if XCB has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   XCB_INCLUDE_DIRS - Include directories for XCB.
#   XCB_LIBRARIES - Libraries to link against XCB.
#   XCB_FOUND - True if XCB has been found and can be used.

# Look for the header file.
find_path(XCB_INCLUDE_DIR
    NAMES
        xcb/xcb.h
    HINTS
        "${XCB_LOCATION}/include"
        "$ENV{XCB_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/xcb/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of XCB resides")
mark_as_advanced(XCB_INCLUDE_DIR)

FIND_LIBRARY(XCB_xcb_LIBRARY
    NAMES
        libxcb
        xcb
    HINTS
        "${XCB_LOCATION}/lib"
        "$ENV{XCB_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/xcb/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to XCB library.")
mark_as_advanced(XCB_xcb_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(XCB
    REQUIRED_VARS XCB_xcb_LIBRARY XCB_INCLUDE_DIR)

if (XCB_FOUND)
  set(XCB_LIBRARIES ${XCB_xcb_LIBRARY})
  set(XCB_INCLUDE_DIRS ${XCB_INCLUDE_DIR})

  if (NOT TARGET freedesktop::XCB)
    add_library(freedesktop::XCB UNKNOWN IMPORTED)
    set_target_properties(freedesktop::XCB PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${XCB_INCLUDE_DIRS}")

    set_property(TARGET freedesktop::XCB APPEND PROPERTY IMPORTED_LOCATION "${XCB_XCB_LIBRARY}")
  endif ()
endif ()

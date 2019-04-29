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
# This module defines the :prop_tgt:`IMPORTED` target ``freedesktop::libxcb``,
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

include(FindPackageHandleStandardArgs)

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

find_library(XCB_xcb_LIBRARY
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

find_package_handle_standard_args(XCB
    REQUIRED_VARS XCB_xcb_LIBRARY XCB_INCLUDE_DIR)

if (XCB_FOUND)
  set(XCB_LIBRARIES ${XCB_xcb_LIBRARY})
  set(XCB_INCLUDE_DIRS ${XCB_INCLUDE_DIR})

  if (NOT TARGET freedesktop::libxcb)
    add_library(freedesktop::libxcb UNKNOWN IMPORTED)
    set_target_properties(freedesktop::libxcb PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${XCB_INCLUDE_DIRS}")

    set_property(TARGET freedesktop::libxcb APPEND PROPERTY IMPORTED_LOCATION "${XCB_XCB_LIBRARY}")
  endif ()
endif ()

foreach (XCB_COMPONENT ${XCB_FIND_COMPONENTS})
  # Generate upper string of the component name.
  string(TOLOWER ${XCB_COMPONENT} XCB_COMPONENT_LOWER)
  string(TOUPPER ${XCB_COMPONENT} XCB_COMPONENT_UPPER)

  # Find the specific component.
  find_library(XCB_${XCB_COMPONENT_LOWER}_LIBRARY
      NAMES
          libxcb-${XCB_COMPONENT_LOWER}
          xcb-${XCB_COMPONENT_LOWER}
      HINTS
          "${XCB_LOCATION}/lib"
          "$ENV{XCB_LOCATION}/lib"
      PATHS
          /usr/local/lib
          /usr/lib
          /lib
      DOC
          "The absolute path to XCB ${XCB_COMPONENT} component library.")
  mark_as_advanced(XCB_${XCB_COMPONENT_LOWER}_LIBRARY)

  find_package_handle_standard_args(XCB_${XCB_COMPONENT_UPPER}
      REQUIRED_VARS XCB_${XCB_COMPONENT_LOWER}_LIBRARY XCB_INCLUDE_DIR)

  if (XCB_${XCB_COMPONENT_UPPER}_FOUND)
    set(XCB_LIBRARIES ${XCB_LIBRARIES} ${XCB_${XCB_COMPONENT_LOWER}_LIBRARY})

    if (NOT TARGET freedesktop::libxcb_${XCB_COMPONENT_LOWER})
      add_library(freedesktop::libxcb_${XCB_COMPONENT_LOWER} UNKNOWN IMPORTED)
      set_target_properties(freedesktop::libxcb_${XCB_COMPONENT_LOWER} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${XCB_INCLUDE_DIRS}")

      set_property(TARGET freedesktop::libxcb_${XCB_COMPONENT_LOWER} APPEND PROPERTY IMPORTED_LOCATION "${XCB_${XCB_COMPONENT_LOWER}_LIBRARY}")
    endif ()
  endif ()
endforeach ()

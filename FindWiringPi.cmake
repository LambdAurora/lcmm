#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindWiringPi
# ----------------
#
# Find the WiringPi GPIO library for the Raspberry Pi.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``drogon::WiringPi``,
# if WiringPi has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   WIRINGPI_INCLUDE_DIRS - Include directories for WiringPi.
#   WIRINGPI_LIBRARIES - Libraries to link against WiringPi.
#   WIRINGPI_VERSION - Version of WiringPi.
#   WiringPi_FOUND - True if WiringPi has been found and can be used.

# Look for the header file.
find_path(WIRINGPI_INCLUDE_DIR
    NAMES
        wiringPi.h
    HINTS
        "${WIRINGPI_LOCATION}/include"
        "$ENV{WIRINGPI_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/wiringPi/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of WiringPi resides")
mark_as_advanced(WIRINGPI_INCLUDE_DIR)

FIND_LIBRARY(WIRINGPI_wiringPi_LIBRARY
    NAMES
        libwiringPi
        wiringPi
    HINTS
        "${WIRINGPI_LOCATION}/lib"
        "$ENV{WIRINGPI_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/wiringPi/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to WiringPi library.")
mark_as_advanced(WIRINGPI_wiringPi_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(WiringPi
    REQUIRED_VARS WIRINGPI_wiringPi_LIBRARY WIRINGPI_INCLUDE_DIR)

if (WiringPi_FOUND)
  set(WIRINGPI_LIBRARIES ${WIRINGPI_wiringPi_LIBRARY})
  set(WIRINGPI_INCLUDE_DIRS ${WIRINGPI_INCLUDE_DIR})

  if (NOT TARGET drogon::WiringPi)
    add_library(drogon::WiringPi UNKNOWN IMPORTED)
    set_target_properties(drogon::WiringPi PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${WIRINGPI_INCLUDE_DIRS}")

    set_property(TARGET drogon::WiringPi APPEND PROPERTY IMPORTED_LOCATION "${WIRINGPI_wiringPi_LIBRARY}")
  endif ()
endif ()

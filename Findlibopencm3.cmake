#
# Copyright © 2020 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Findlibopencm3
# ----------------
#
# Find the libopencm3 library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``libopencm3::<C>`` where <C> is the specified component,
# if libopencm3 has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   libopencm3_INCLUDE_DIRS - Include directories for libopencm3.
#   libopencm3_LIBRARIES - Libraries to link against libopencm3 (not recommended to be used to link but only for listing).
#   libopencm3_<C>_LIBRARY - Library to link against component <C>.
#   libopencm3_FOUND - True if libopencm3 has been found and can be used.
#   libopencm3_<C>_FOUND - True if component <C> was found.

include(FindPackageHandleStandardArgs)

# Look for the header file.
find_path(libopencm3_INCLUDE_DIR
    NAMES
        libopencm3/cm3/common.h
    HINTS
        "${libopencm3_ROOT}/include"
        "$ENV{libopencm3_ROOT}/include"
    PATHS
        "$ENV{PROGRAMFILES}/libopencm3/include"
        "${CMAKE_FIND_ROOT_PATH}/include"
        /usr/include
        /usr/local/include
        /opt/local/include
        /sw/include
    DOC
        "The directory where header files of libopencm3 resides"
    NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(libopencm3_INCLUDE_DIR)

set(libopencm3_LIBRARIES)

foreach (component IN LISTS libopencm3_FIND_COMPONENTS)
    string(TOLOWER ${component} component)

    # Look for the library file.
    find_library(libopencm3_${component}_LIBRARY
        NAMES
            "libopencm3_${component}.a"
        HINTS
            "${libopencm3_ROOT}/lib"
            "$ENV{libopencm3_ROOT}/lib"
        PATHS
            "$ENV{PROGRAMFILES}/libopencm3/lib"
            "${CMAKE_FIND_ROOT_PATH}/lib"
            /usr/local/lib
            /usr/lib
            /lib
        DOC
            "The absolute path to libopencm3 ${component} library."
        NO_CMAKE_FIND_ROOT_PATH)
    mark_as_advanced(libopencm3_${component}_LIBRARY)

    if (libopencm3_${component}_LIBRARY)
        set(libopencm3_${component}_FOUND true)
    endif ()

    list(APPEND libopencm3_LIBRARIES "${libopencm3_${component}_LIBRARY}")
endforeach ()

find_package_handle_standard_args(libopencm3
    REQUIRED_VARS libopencm3_LIBRARIES libopencm3_INCLUDE_DIR)

if (libopencm3_FOUND)
    set(libopencm3_INCLUDE_DIRS ${libopencm3_INCLUDE_DIR})

    foreach (component IN LISTS libopencm3_FIND_COMPONENTS)
        string(TOLOWER ${component} component)

        if (libopencm3_${component}_FOUND)
            if (NOT TARGET libopencm3::${component})
                add_library(libopencm3::${component} UNKNOWN IMPORTED)
                set_target_properties(libopencm3::${component} PROPERTIES
                    INTERFACE_INCLUDE_DIRECTORIES "${libopencm3_INCLUDE_DIRS}")

                set_property(TARGET libopencm3::${component} APPEND PROPERTY IMPORTED_LOCATION "${libopencm3_${component}_LIBRARY}")
            endif ()
        endif ()
    endforeach ()
endif ()

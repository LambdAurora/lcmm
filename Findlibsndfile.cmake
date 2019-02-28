#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Findlibsndfile
# --------
#
# Find the libsndfile library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``MegaNerd::libsndfile``,
# if libsndfile has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   libsndfile_INCLUDE_DIRS - Include directories for libsndfile.
#   libsndfile_LIBRARIES - Libraries to link against libsndfile.
#   libsndfile_FOUND - True if libsndfile has been found and can be used.

# Look for the header file.
find_path(libsndfile_INCLUDE_DIR
    NAMES
        sndfile.h
    HINTS
        "${libsndfile_LOCATION}/include"
        "$ENV{libsndfile_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/Mega-Nerd/libsndfile/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where libsndfile/libsndfile3.h resides")
mark_as_advanced(libsndfile_INCLUDE_DIR)

FIND_LIBRARY(libsndfile_libsndfile_LIBRARY
    NAMES
        libsndfile
        libsndfile-1
        sndfile
    HINTS
        "${libsndfile_LOCATION}/lib"
        "$ENV{libsndfile_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/Mega-Nerd/libsndfile/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to libsndfile library.")
mark_as_advanced(libsndfile_libsndfile_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libsndfile
    REQUIRED_VARS libsndfile_libsndfile_LIBRARY libsndfile_INCLUDE_DIR
    VERSION_VAR libsndfile_VERSION)

if (libsndfile_FOUND)
  set(libsndfile_INCLUDE_DIRS ${libsndfile_INCLUDE_DIR})
  set(libsndfile_LIBRARIES ${libsndfile_libsndfile_LIBRARY})

  if (NOT TARGET MegaNerd::libsndfile)
    add_library(MegaNerd::libsndfile UNKNOWN IMPORTED)
    set_target_properties(MegaNerd::libsndfile PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${libsndfile_INCLUDE_DIRS}")

    set_property(TARGET MegaNerd::libsndfile APPEND PROPERTY IMPORTED_LOCATION "${libsndfile_LIBRARIES}")
  endif ()
endif ()

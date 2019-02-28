#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindSDL2_ttf
# ----------------
#
# Find the SDL2's TTF extension library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``SDL2::SDL2ttf``,
# if SDL2_ttf has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   SDL2_TTF_INCLUDE_DIRS - Include directories for SDL2_ttf.
#   SDL2_TTF_LIBRARIES - Libraries to link against SDL2_ttf.
#   SDL2_TTF_VERSION - Version of SDL2_ttf.
#   SDL2_ttf_FOUND - True if SDL2_ttf has been found and can be used.

# Look for the header file.
find_path(SDL2_TTF_INCLUDE_DIR
    NAMES
        SDL2/SDL_ttf.h
    HINTS
        "${SDL2_LOCATION}/include"
        "$ENV{SDL2_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/SDL2/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of SDL2_ttf resides")
mark_as_advanced(SDL2_TTF_INCLUDE_DIR)

if (SDL2_TTF_INCLUDE_DIR)
    # Tease the SDL2_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    parse_version_custom_var(${SDL2_TTF_INCLUDE_DIR} SDL2/SDL_ttf.h SDL2_TTF_VERSION_MAJOR SDL_TTF_MAJOR_VERSION)
    parse_version_custom_var(${SDL2_TTF_INCLUDE_DIR} SDL2/SDL_ttf.h SDL2_TTF_VERSION_MINOR SDL_TTF_MINOR_VERSION)
    parse_version_custom_var(${SDL2_TTF_INCLUDE_DIR} SDL2/SDL_ttf.h SDL2_TTF_VERSION_PATCH SDL_TTF_PATCHLEVEL)

    set(SDL2_TTF_VERSION "${SDL2_TTF_VERSION_MAJOR}.${SDL2_TTF_VERSION_MINOR}.${SDL2_TTF_VERSION_PATCH}")
endif (SDL2_TTF_INCLUDE_DIR)

FIND_LIBRARY(SDL2_SDL2ttf_LIBRARY
    NAMES
        libSDL2_ttf
        SDL2_ttf
    HINTS
        "${SDL2_LOCATION}/lib"
        "$ENV{SDL2_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/SDL2/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to SDL2_ttf library.")
mark_as_advanced(SDL2_SDL2ttf_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2_ttf
    REQUIRED_VARS SDL2_SDL2ttf_LIBRARY SDL2_TTF_INCLUDE_DIR
    VERSION_VAR SDL2_TTF_VERSION)

if (SDL2_ttf_FOUND)
  set(SDL2_TTF_LIBRARIES ${SDL2_SDL2ttf_LIBRARY})
  set(SDL2_TTF_INCLUDE_DIRS ${SDL2_TTF_INCLUDE_DIR})

  if (NOT TARGET SDL2::SDL2ttf)
    add_library(SDL2::SDL2ttf UNKNOWN IMPORTED)
    set_target_properties(SDL2::SDL2ttf PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${SDL2_TTF_INCLUDE_DIRS}")

    set_property(TARGET SDL2::SDL2ttf APPEND PROPERTY IMPORTED_LOCATION "${SDL2_SDL2ttf_LIBRARY}")
  endif ()
endif ()

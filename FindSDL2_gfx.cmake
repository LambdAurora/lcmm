#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindSDL2_gfx
# ----------------
#
# Find the SDL2's gfx extension library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``SDL2::SDL2gfx``,
# if SDL2_gfx has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   SDL2_GFX_INCLUDE_DIRS - Include directories for SDL2_gfx.
#   SDL2_GFX_LIBRARIES - Libraries to link against SDL2_gfx.
#   SDL2_GFX_VERSION - Version of SDL2_gfx.
#   SDL2_gfx_FOUND - True if SDL2_gfx has been found and can be used.

include(FindPackageHandleStandardArgs)

# Look for the header file.
find_path(SDL2_GFX_INCLUDE_DIR
    NAMES
        SDL2/SDL2_gfxPrimitives.h
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
        "The directory where headers files of SDL2_gfx resides")
mark_as_advanced(SDL2_GFX_INCLUDE_DIR)

if (SDL2_GFX_INCLUDE_DIR)
    # Tease the SDL2_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    parse_version_custom_var(${SDL2_GFX_INCLUDE_DIR} SDL2/SDL2_gfxPrimitives.h SDL2_GFX_VERSION_MAJOR SDL2_GFXPRIMITIVES_MAJOR)
    parse_version_custom_var(${SDL2_GFX_INCLUDE_DIR} SDL2/SDL2_gfxPrimitives.h SDL2_GFX_VERSION_MINOR SDL2_GFXPRIMITIVES_MINOR)
    parse_version_custom_var(${SDL2_GFX_INCLUDE_DIR} SDL2/SDL2_gfxPrimitives.h SDL2_GFX_VERSION_PATCH SDL2_GFXPRIMITIVES_MICRO)

    set(SDL2_GFX_VERSION "${SDL2_GFX_VERSION_MAJOR}.${SDL2_GFX_VERSION_MINOR}.${SDL2_GFX_VERSION_PATCH}")
endif (SDL2_GFX_INCLUDE_DIR)

find_library(SDL2_SDL2gfx_LIBRARY
    NAMES
        libSDL2_gfx
        SDL2_gfx
    HINTS
        "${SDL2_LOCATION}/lib"
        "$ENV{SDL2_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/SDL2/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to SDL2_gfx library.")
mark_as_advanced(SDL2_SDL2gfx_LIBRARY)

find_package_handle_standard_args(SDL2_gfx
    REQUIRED_VARS SDL2_SDL2gfx_LIBRARY SDL2_GFX_INCLUDE_DIR
    VERSION_VAR SDL2_GFX_VERSION)

if (SDL2_gfx_FOUND)
  set(SDL2_GFX_LIBRARIES ${SDL2_SDL2gfx_LIBRARY})
  set(SDL2_GFX_INCLUDE_DIRS ${SDL2_GFX_INCLUDE_DIR})

  if (NOT TARGET SDL2::SDL2gfx)
    add_library(SDL2::SDL2gfx UNKNOWN IMPORTED)
    set_target_properties(SDL2::SDL2gfx PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${SDL2_GFX_INCLUDE_DIRS}")

    set_property(TARGET SDL2::SDL2gfx APPEND PROPERTY IMPORTED_LOCATION "${SDL2_SDL2gfx_LIBRARY}")
  endif ()
endif ()

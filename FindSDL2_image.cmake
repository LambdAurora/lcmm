#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindSDL2_image
# ----------------
#
# Find the SDL2's image extension library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``SDL2::SDL2image``,
# if SDL2_image has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   SDL2_IMAGE_INCLUDE_DIRS - Include directories for SDL2_image.
#   SDL2_IMAGE_LIBRARIES - Libraries to link against SDL2_image.
#   SDL2_IMAGE_VERSION - Version of SDL2_image.
#   SDL2_image_FOUND - True if SDL2_image has been found and can be used.

# Look for the header file.
find_path(SDL2_IMAGE_INCLUDE_DIR
    NAMES
        SDL2/SDL_image.h
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
        "The directory where headers files of SDL2_image resides")
mark_as_advanced(SDL2_IMAGE_INCLUDE_DIR)

if (SDL2_IMAGE_INCLUDE_DIR)
    # Tease the SDL2_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    parse_version_custom_var(${SDL2_IMAGE_INCLUDE_DIR} SDL2/SDL_image.h SDL2_IMAGE_VERSION_MAJOR SDL_IMAGE_MAJOR_VERSION)
    parse_version_custom_var(${SDL2_IMAGE_INCLUDE_DIR} SDL2/SDL_image.h SDL2_IMAGE_VERSION_MINOR SDL_IMAGE_MINOR_VERSION)
    parse_version_custom_var(${SDL2_IMAGE_INCLUDE_DIR} SDL2/SDL_image.h SDL2_IMAGE_VERSION_PATCH SDL_IMAGE_PATCHLEVEL)

    set(SDL2_IMAGE_VERSION "${SDL2_IMAGE_VERSION_MAJOR}.${SDL2_IMAGE_VERSION_MINOR}.${SDL2_IMAGE_VERSION_PATCH}")
endif (SDL2_IMAGE_INCLUDE_DIR)

FIND_LIBRARY(SDL2_SDL2image_LIBRARY
    NAMES
        libSDL2_image
        SDL2_image
    HINTS
        "${SDL2_LOCATION}/lib"
        "$ENV{SDL2_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/SDL2/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to SDL2_image library.")
mark_as_advanced(SDL2_SDL2image_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2_image
    REQUIRED_VARS SDL2_SDL2image_LIBRARY SDL2_IMAGE_INCLUDE_DIR
    VERSION_VAR SDL2_IMAGE_VERSION)

if (SDL2_image_FOUND)
  set(SDL2_IMAGE_LIBRARIES ${SDL2_SDL2image_LIBRARY})
  set(SDL2_IMAGE_INCLUDE_DIRS ${SDL2_IMAGE_INCLUDE_DIR})

  if (NOT TARGET SDL2::SDL2image)
    add_library(SDL2::SDL2image UNKNOWN IMPORTED)
    set_target_properties(SDL2::SDL2image PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${SDL2_IMAGE_INCLUDE_DIRS}")

    set_property(TARGET SDL2::SDL2image APPEND PROPERTY IMPORTED_LOCATION "${SDL2_SDL2image_LIBRARY}")
  endif ()
endif ()

#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindSDL2_mixer
# ----------------
#
# Find the SDL2's mixer extension library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``SDL2::SDL2mixer``,
# if SDL2_mixer has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   SDL2_MIXER_INCLUDE_DIRS - Include directories for SDL2_mixer.
#   SDL2_MIXER_LIBRARIES - Libraries to link against SDL2_mixer.
#   SDL2_MIXER_VERSION - Version of SDL2_mixer.
#   SDL2_mixer_FOUND - True if SDL2_mixer has been found and can be used.

# Look for the header file.
find_path(SDL2_MIXER_INCLUDE_DIR
    NAMES
        SDL2/SDL_mixer.h
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
        "The directory where headers files of SDL2_mixer resides")
mark_as_advanced(SDL2_MIXER_INCLUDE_DIR)

if (SDL2_MIXER_INCLUDE_DIR)
    # Tease the SDL2_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    parse_version_custom_var(${SDL2_MIXER_INCLUDE_DIR} SDL2/SDL_mixer.h SDL2_MIXER_VERSION_MAJOR SDL_MIXER_MAJOR_VERSION)
    parse_version_custom_var(${SDL2_MIXER_INCLUDE_DIR} SDL2/SDL_mixer.h SDL2_MIXER_VERSION_MINOR SDL_MIXER_MINOR_VERSION)
    parse_version_custom_var(${SDL2_MIXER_INCLUDE_DIR} SDL2/SDL_mixer.h SDL2_MIXER_VERSION_PATCH SDL_MIXER_PATCHLEVEL)

    set(SDL2_MIXER_VERSION "${SDL2_MIXER_VERSION_MAJOR}.${SDL2_MIXER_VERSION_MINOR}.${SDL2_MIXER_VERSION_PATCH}")
endif (SDL2_MIXER_INCLUDE_DIR)

FIND_LIBRARY(SDL2_SDL2mixer_LIBRARY
    NAMES
        libSDL2_mixer
        SDL2_mixer
    HINTS
        "${SDL2_LOCATION}/lib"
        "$ENV{SDL2_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/SDL2/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to SDL2_mixer library.")
mark_as_advanced(SDL2_SDL2mixer_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2_mixer
    REQUIRED_VARS SDL2_SDL2mixer_LIBRARY SDL2_MIXER_INCLUDE_DIR
    VERSION_VAR SDL2_MIXER_VERSION)

if (SDL2_mixer_FOUND)
  set(SDL2_MIXER_LIBRARIES ${SDL2_SDL2mixer_LIBRARY})
  set(SDL2_MIXER_INCLUDE_DIRS ${SDL2_MIXER_INCLUDE_DIR})

  if (NOT TARGET SDL2::SDL2mixer)
    add_library(SDL2::SDL2mixer UNKNOWN IMPORTED)
    set_target_properties(SDL2::SDL2mixer PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${SDL2_MIXER_INCLUDE_DIRS}")

    set_property(TARGET SDL2::SDL2mixer APPEND PROPERTY IMPORTED_LOCATION "${SDL2_SDL2mixer_LIBRARY}")
  endif ()
endif ()

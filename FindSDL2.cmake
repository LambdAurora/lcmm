#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindSDL2
# ----------------
#
# Find the SDL2 library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``SDL2::SDL2``, ``SDL2::SDL2main`` and ``SDL2::SDL2test``,
# if SDL2 has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   SDL2_INCLUDE_DIRS - Include directories for SDL2.
#   SDL2_LIBRARIES - Libraries to link against SDL2.
#   SDL2_VERSION - Version of SDL2.
#   SDL2_ADDITIONAL_LINK_LIBRARIES - Additional libraries to link to make SDL2 works.
#   SDL2_FOUND - True if SDL2 has been found and can be used.

# Look for the header file.
find_path(SDL2_INCLUDE_DIR
    NAMES
        SDL2/SDL.h
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
        "The directory where headers files of SDL2 resides")
mark_as_advanced(SDL2_INCLUDE_DIR)

if (SDL2_INCLUDE_DIR)
    # Tease the SDL2_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    parse_version_custom_var(${SDL2_INCLUDE_DIR} SDL2/SDL_version.h SDL2_VERSION_MAJOR SDL_MAJOR_VERSION)
    parse_version_custom_var(${SDL2_INCLUDE_DIR} SDL2/SDL_version.h SDL2_VERSION_MINOR SDL_MINOR_VERSION)
    parse_version_custom_var(${SDL2_INCLUDE_DIR} SDL2/SDL_version.h SDL2_VERSION_PATCH SDL_PATCHLEVEL)

    set(SDL2_VERSION "${SDL2_VERSION_MAJOR}.${SDL2_VERSION_MINOR}.${SDL2_VERSION_PATCH}")
endif (SDL2_INCLUDE_DIR)

FIND_LIBRARY(SDL2_SDL2_LIBRARY
    NAMES
        libSDL2
        SDL2
    HINTS
        "${SDL2_LOCATION}/lib"
        "$ENV{SDL2_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/SDL2/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to SDL2 library.")
mark_as_advanced(SDL2_SDL2_LIBRARY)

FIND_LIBRARY(SDL2_SDL2main_LIBRARY
        NAMES
        libSDL2main
        SDL2main
        HINTS
        "${SDL2_LOCATION}/lib"
        "$ENV{SDL2_LOCATION}/lib"
        PATHS
        "$ENV{PROGRAMFILES}/SDL2/lib"
        /usr/local/lib
        /usr/lib
        /lib
        DOC
      "The absolute path to SDL2main library.")
mark_as_advanced(SDL2_SDL2main_LIBRARY)

FIND_LIBRARY(SDL2_SDL2test_LIBRARY
        NAMES
        libSDL2_test
        libSDL2test
        SDL2_test
        SDL2test
        HINTS
        "${SDL2_LOCATION}/lib"
        "$ENV{SDL2_LOCATION}/lib"
        PATHS
        "$ENV{PROGRAMFILES}/SDL2/lib"
        /usr/local/lib
        /usr/lib
        /lib
        DOC
      "The absolute path to SDL2test library.")
mark_as_advanced(SDL2_SDL2test_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2
    REQUIRED_VARS SDL2_SDL2_LIBRARY SDL2_SDL2main_LIBRARY SDL2_INCLUDE_DIR
    VERSION_VAR SDL2_VERSION)

if (SDL2_FOUND)
  set(SDL2_ADDITIONAL_LINK_LIBRARIES "")

  if (MINGW)
    set(SDL2_ADDITIONAL_LINK_LIBRARIES "-lmingw32" ${SDL2_ADDITIONAL_LINK_LIBRARIES})
  endif ()

  if (APPLE)
    set(SDL2_ADDITIONAL_LINK_LIBRARIES ${SDL2_ADDITIONAL_LINK_LIBRARIES} "-framework Cocoa")
  endif ()


  set(SDL2_LIBRARIES ${SDL2_SDL2_LIBRARY} ${SDL2_SDL2main_LIBRARY})
  set(SDL2_INCLUDE_DIRS ${SDL2_INCLUDE_DIR})

  if (NOT TARGET SDL2::SDL2)
    add_library(SDL2::SDL2 UNKNOWN IMPORTED)
    set_target_properties(SDL2::SDL2 PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${SDL2_INCLUDE_DIRS}")

    set_property(TARGET SDL2::SDL2 APPEND PROPERTY IMPORTED_LOCATION "${SDL2_SDL2_LIBRARY}")
  endif ()

  if (NOT TARGET SDL2::SDL2main)
    add_library(SDL2::SDL2main UNKNOWN IMPORTED)
    set_target_properties(SDL2::SDL2main PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${SDL2_INCLUDE_DIRS}")

    set_property(TARGET SDL2::SDL2main APPEND PROPERTY IMPORTED_LOCATION "${SDL2_SDL2main_LIBRARY}")
  endif ()

  if (NOT TARGET SDL2::SDL2test AND SDL2_SDL2test_LIBRARY)
    add_library(SDL2::SDL2test UNKNOWN IMPORTED)
    set_target_properties(SDL2::SDL2test PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${SDL2_INCLUDE_DIRS}")

    set_property(TARGET SDL2::SDL2test APPEND PROPERTY IMPORTED_LOCATION "${SDL2_SDL2test_LIBRARY}")
  endif ()
endif ()

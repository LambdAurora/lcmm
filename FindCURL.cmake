#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindCURL
# ----------------
#
# Find the CURL library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``CURL::libcurl``,
# if CURL has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   CURL_INCLUDE_DIRS - Include directories for CURL.
#   CURL_LIBRARIES - Libraries to link against CURL.
#   CURL_VERSION - Version of CURL.
#   CURL_FOUND - True if CURL has been found and can be used.

# Look for the header file.
find_path(CURL_INCLUDE_DIR
    NAMES
        curl/curl.h
    HINTS
        "${CURL_LOCATION}/include"
        "$ENV{CURL_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/curl/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of CURL resides")
mark_as_advanced(CURL_INCLUDE_DIR)

if (CURL_INCLUDE_DIR)
    # Tease the CURL_VERSION numbers from the lib headers
    include(utils/ParseVersion)

    parse_version_custom_var(${CURL_INCLUDE_DIR} curl/curlver.h CURL_VERSION_MAJOR LIBCURL_VERSION_MAJOR)
    parse_version_custom_var(${CURL_INCLUDE_DIR} curl/curlver.h CURL_VERSION_MINOR LIBCURL_VERSION_MINOR)
    parse_version_custom_var(${CURL_INCLUDE_DIR} curl/curlver.h CURL_VERSION_PATCH LIBCURL_VERSION_PATCH)

    set(CURL_VERSION "${CURL_VERSION_MAJOR}.${CURL_VERSION_MINOR}.${CURL_VERSION_PATCH}")
endif (CURL_INCLUDE_DIR)

FIND_LIBRARY(CURL_libcurl_LIBRARY
    NAMES
        curl
        libcurl
        libcurl_imp
    HINTS
        "${CURL_LOCATION}/lib"
        "$ENV{CURL_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/curl/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to CURL library.")
mark_as_advanced(CURL_curl_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CURL
    REQUIRED_VARS CURL_libcurl_LIBRARY CURL_INCLUDE_DIR
    VERSION_VAR CURL_VERSION)

if (CURL_FOUND)
  set(CURL_LIBRARIES ${CURL_libcurl_LIBRARY})
  set(CURL_INCLUDE_DIRS ${CURL_INCLUDE_DIR})

  if (NOT TARGET CURL::libcurl)
    add_library(CURL::libcurl UNKNOWN IMPORTED)
    set_target_properties(CURL::libcurl PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${CURL_INCLUDE_DIRS}")

    set_property(TARGET CURL::libcurl APPEND PROPERTY IMPORTED_LOCATION "${CURL_libcurl_LIBRARY}")
  endif ()
endif ()

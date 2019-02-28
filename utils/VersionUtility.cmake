#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Versionutility
# ----------------
#
# An utility to make versioning easier.

# Generate a raw version header.
function (generate_version_header_raw VERSION_MAJOR VERSION_MINOR VERSION_PATCH VERSION_TYPE INPUT_FILE OUTPUT_FILE)
  configure_file(
    "${INPUT_FILE}"
    "${OUTPUT_FILE}"
  IMMEDIATE @ONLY)
endfunction ()

# Generate a version header.
function (generate_version_header TARGET_VAR_NAME TARGET_NAME VERSION_MAJOR VERSION_MINOR VERSION_PATCH VERSION_TYPE)
  configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/templates/version.h.in"
    "${CMAKE_BINARY_DIR}/exports/${TARGET_NAME}_version.h"
  IMMEDIATE @ONLY)
endfunction ()

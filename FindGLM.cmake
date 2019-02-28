#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

# FindGLM.cmake
# This script will find the library GLM (OpenGL Mathematics).
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   GLM_INCLUDE_DIRS - Include directories for GLM (OpenGL Mathematics).
#   GLM_FOUND - True if GLM (OpenGL Mathematics) has been found and can be used.

# Look for the header file.
find_path(GLM_INCLUDE_DIR
    NAMES
        glm/glm.hpp
    HINTS
        "${GLM_LOCATION}/include"
        "$ENV{GLM_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/GLM/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where headers files of GLM (OpenGL Mathematics) resides")
mark_as_advanced(GLM_INCLUDE_DIR)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLM DEFAULT_MSG GLM_INCLUDE_DIR)

set(GLM_INCLUDE_DIRS ${GLM_INCLUDE_DIR})

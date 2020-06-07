#
# Copyright © 2020 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Lambda
# ----------------
#
# Enhance CMake by adding more variables, etc..

# Set some useful variables.
if (CMAKE_SYSTEM_NAME MATCHES "Android" OR CMAKE_ANDROID_NDK)
    set(LAMBDA_ANDROID true)
elseif (CMAKE_SYSTEM_NAME MATCHES "Emscripten")
    set(LAMBDA_WASM true)
endif ()
if (WIN32)
    set(LAMBDA_WINDOWS true)
elseif (UNIX AND APPLE)
    set(LAMBDA_APPLE true)
elseif (UNIX AND NOT APPLE)
    set(LAMBDA_LINUX true)
    execute_process(COMMAND uname -o COMMAND tr -d '\n' OUTPUT_VARIABLE OPERATING_SYSTEM)
    if (${OPERATING_SYSTEM} MATCHES "Android")
        set(LAMBDA_ANDROID true)
        set(LAMBDA_ANDROID_TERMUX true)
    endif ()
endif ()
set(LAMBDA_SYSTEM_ARCH "${CMAKE_SYSTEM_PROCESSOR}")

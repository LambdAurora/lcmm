#
# Copyright © 2020 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# Otterpill
# ----------------
#
# An utility for developing with the Otterpill.

include(embedded/embedded)
include(embedded/dfu)

function(add_otterpill_executable TARGET SOURCES)
    set(_SOURCES ${SOURCES} ${ARGN})
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DSTM32F072xB" PARENT_SCOPE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DSTM32F072xB" PARENT_SCOPE)

    add_embedded_executable(${TARGET} ${_SOURCES})
    add_dfu_target(${TARGET} 0 "0x08000000:leave")
endfunction()

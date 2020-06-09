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

    add_embedded_executable(${TARGET} ${_SOURCES})
    target_compile_definitions(${TARGET}.elf PUBLIC STM32F0 STM32F072xB)

    add_dfu_target(${TARGET} 0 "0x08000000:leave")
endfunction()

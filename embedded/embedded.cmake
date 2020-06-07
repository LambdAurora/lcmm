#
# Copyright © 2020 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# embedded
# ----------------
#
# An utility for embedded projects.

function(add_embedded_executable TARGET SOURCES)
    set(_SOURCES ${SOURCES} ${ARGN})

    # Create an ELF executable.
    add_executable(${TARGET}.elf ${_SOURCES})

    # Add a custom target that converts the generated ELF file to a hex file.
    add_custom_target(${TARGET}.hex ALL DEPENDS ${TARGET}.elf COMMAND ${CMAKE_OBJCOPY} -Oihex ${TARGET}.elf ${TARGET}.hex)

    # Add a custom target that converts the generated ELF file to a binary.
    add_custom_target(${TARGET}.bin ALL DEPENDS ${TARGET}.elf COMMAND ${CMAKE_OBJCOPY} -Obinary ${TARGET}.elf ${TARGET}.bin)
endfunction()

function(set_linker_script LINKER_SCRIPT)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T${LINKER_SCRIPT}" PARENT_SCOPE)
endfunction()

#
# Copyright © 2020 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

# Target definition
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Flags
set(FLAGS_ARCHITECTURE -mthumb)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FLAGS_ARCHITECTURE}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAGS_ARCHITECTURE}")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${FLAGS_ARCHITECTURE}")

# Compiler
set(TOOLCHAIN arm-none-eabi)
set(CMAKE_C_COMPILER ${TOOLCHAIN}-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN}-g++)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_OBJCOPY ${TOOLCHAIN}-objcopy)
set(CMAKE_SIZE ${TOOLCHAIN}-size)
set(CMAKE_EXE_LINKER_FLAGS_INIT "${FLAGS_ARCHITECTURE} --specs=nosys.specs --specs=nano.specs")

# Paths and prefixes
execute_process(
    COMMAND ${CMAKE_C_COMPILER} -print-file-name=libc.a
    OUTPUT_VARIABLE CMAKE_INSTALL_PREFIX
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
get_filename_component(CMAKE_INSTALL_PREFIX
    "${CMAKE_INSTALL_PREFIX}" PATH
)
get_filename_component(CMAKE_INSTALL_PREFIX
    "${CMAKE_INSTALL_PREFIX}/.." REALPATH
)
set(CMAKE_INSTALL_PREFIX  ${CMAKE_INSTALL_PREFIX} CACHE FILEPATH
    "Install path prefix, prepended onto install directories.")

set(CMAKE_FIND_ROOT_PATH ${CMAKE_INSTALL_PREFIX})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

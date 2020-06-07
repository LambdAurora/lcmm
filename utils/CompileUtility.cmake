#
# Copyright © 2020 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# CompileUtility
# ----------------
#
# An utility to make compiling easier.

include(Lambda)

# Checks if march flag is available.
function (has_march OUTPUT_VAR)
    if (LAMBDA_ANDROID OR LAMBDA_WASM OR MSVC OR CMAKE_CROSSCOMPILING)
        set(${OUTPUT_VAR} false PARENT_SCOPE)
    else ()
        set(${OUTPUT_VAR} true PARENT_SCOPE)
    endif ()
endfunction ()

# Checks if mtune flag is available.
function (has_mtune OUTPUT_VAR)
    if (LAMBDA_ANDROID OR LAMBDA_WASM OR MSVC OR CMAKE_CROSSCOMPILING)
        set(${OUTPUT_VAR} false PARENT_SCOPE)
    else ()
        set(${OUTPUT_VAR} true PARENT_SCOPE)
    endif ()
endfunction ()

function (get_arg_prefix OUTPUT_VAR)
    if (MSVC)
        set(${OUTPUT_VAR} "/" PARENT_SCOPE)
    else ()
        set(${OUTPUT_VAR} "-" PARENT_SCOPE)
    endif ()
endfunction ()

function (generate_flags FLAGS_VAR ARCH OPTIMIZATION_LEVEL FAST_MATH)
    get_arg_prefix(ARG_PREFIX)
    has_march(HAS_MARCH)
    has_mtune(HAS_MTUNE)

    set(OUTPUT_VAR "")

    # Optimization
    set(OUTPUT_VAR "${OUTPUT_VAR} ${ARG_PREFIX}O${OPTIMIZATION_LEVEL}")

    # Arch
    if (HAS_MARCH AND ARCH)
        # Make it compiles on RISC-V CPU.
        if (${LAMBDA_SYSTEM_ARCH} MATCHES "riscv" AND "${ARCH}" STREQUAL "native")
            # SKIP
        else ()
            set(OUTPUT_VAR "${OUTPUT_VAR} -march=${ARCH}")
        endif ()
    endif ()

    if (HAS_MTUNE AND ARCH)
        # Make it compiles on RISC-V CPU.
        if (${LAMBDA_SYSTEM_ARCH} MATCHES "riscv" AND "${ARCH}" STREQUAL "native")
            # SKIP
        else ()
            set(OUTPUT_VAR "${OUTPUT_VAR} -mtune=${ARCH}")
        endif ()
    endif ()

    if (FAST_MATH AND NOT MSVC)
        set(OUTPUT_VAR "${OUTPUT_VAR} -ffast-math")
    endif ()

    if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(OUTPUT_VAR "${OUTPUT_VAR} -D__extern_always_inline=\"extern __always_inline\"")
    elseif (MSVC)
        set(OUTPUT_VAR "${OUTPUT_VAR} /std:c++${CMAKE_CXX_STANDARD}")
    endif ()

    set(${FLAGS_VAR} ${OUTPUT_VAR} PARENT_SCOPE)
endfunction ()

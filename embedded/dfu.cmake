#
# Copyright © 2020 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# dfu
# ----------------
#
# An utility for DFU flash target.

# Add the DFU target if it doesn't exist.
function(add_dfu_target TARGET ALT_SETTING DFUSE_ADDRESS)
    if (NOT TARGET ${TARGET}.dfu)
        add_custom_target(${TARGET}.dfu DEPENDS ${TARGET}.bin
            COMMAND rm -f ${TARGET}.dfu
            COMMAND cp ${TARGET}.bin ${TARGET}.dfu
            COMMAND dfu-suffix -a ${TARGET}.dfu # To make DFU util happy.
            COMMAND dfu-util -a ${ALT_SETTING} -s ${DFUSE_ADDRESS} -D ${TARGET}.dfu)
    endif ()
endfunction()

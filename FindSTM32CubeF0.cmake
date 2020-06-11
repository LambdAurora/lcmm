#
# Copyright © 2020 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindSTM32CubeF0
# ----------------
#
# Find the STM32CubeF0 library.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   STM32CubeF0_INCLUDE_DIRS - Include directories for STM32CubeF0.
#   STM32CubeF0_SOURCES - Source files to compile with.
#   STM32CubeF0_FOUND - True if STM32CubeF0 has been found and can be used.
#   STM32CubeF0_<C>_FOUND - True if component <C> was found.

include(FindPackageHandleStandardArgs)

# Look for the header files.
find_path(STM32CubeF0_HAL_INCLUDE_DIR
    NAMES
        stm32f0xx_hal_def.h
        stm32f0xx_hal_cortex.h
    HINTS
        "${STM32CubeF0_ROOT}/Drivers/STM32F0xx_HAL_Driver"
        "$ENV{STM32CubeF0_ROOT}/Drivers/STM32F0xx_HAL_Driver"
    PATHS
        "$ENV{PROGRAMFILES}/STM32CubeF0/Drivers/STM32F0xx_HAL_Driver"
        "${CMAKE_FIND_ROOT_PATH}/include"
        /usr/include
        /usr/local/include
        /opt/local/include
        /sw/include
    DOC
        "The directory where header files of STM32CubeF0 HAL drivers resides"
    PATH_SUFFIXES
        "Inc"
        "include"
    NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(STM32CubeF0_HAL_INCLUDE_DIR)

find_path(STM32CubeF0_CMSIS_INCLUDE_DIR
    NAMES
        cmsis_version.h
    HINTS
        "${STM32CubeF0_ROOT}/Drivers/CMSIS"
        "$ENV{STM32CubeF0_ROOT}/Drivers/CMSIS"
    PATHS
        "$ENV{PROGRAMFILES}/STM32CubeF0/Drivers/CMSIS"
        "${CMAKE_FIND_ROOT_PATH}/include"
        /usr/include
        /usr/local/include
        /opt/local/include
        /sw/include
    DOC
        "The directory where header files of STM32CubeF0 CMSIS resides"
    PATH_SUFFIXES
        "Include"
        "include"
    NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(STM32CubeF0_CMSIS_INCLUDE_DIR)

find_path(STM32CubeF0_CMSIS_DEVICE_INCLUDE_DIR
    NAMES
        stm32f0xx.h
    HINTS
        "${STM32CubeF0_ROOT}/Drivers/CMSIS/Device/ST/STM32F0xx"
        "$ENV{STM32CubeF0_ROOT}/Drivers/CMSIS/Device/ST/STM32F0xx"
    PATHS
        "$ENV{PROGRAMFILES}/STM32CubeF0/Drivers/CMSIS/Device/ST/STM32F0xx"
        "${CMAKE_FIND_ROOT_PATH}/include"
        /usr/include
        /usr/local/include
        /opt/local/include
        /sw/include
    DOC
        "The directory where header files of STM32CubeF0 CMSIS device resides"
    PATH_SUFFIXES
        "Include"
        "include"
    NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(STM32CubeF0_CMSIS_DEVICE_INCLUDE_DIR)

# Look for the source files
find_path(STM32CubeF0_HAL_SOURCE_DIR
    NAMES
        stm32f0xx_hal.c
    HINTS
        "${STM32CubeF0_ROOT}/Drivers/STM32F0xx_HAL_Driver"
        "$ENV{STM32CubeF0_ROOT}/Drivers/STM32F0xx_HAL_Driver"
    PATHS
        "$ENV{PROGRAMFILES}/STM32CubeF0/Drivers/STM32F0xx_HAL_Driver"
    DOC
        "The directory where source files of STM32CubeF0 HAL drivers resides"
    PATH_SUFFIXES
        "Src"
        "src"
    NO_CMAKE_FIND_ROOT_PATH)
mark_as_advanced(STM32CubeF0_HAL_SOURCE_DIR)

set(STM32CubeF0_COMPONENTS)

foreach (component IN LISTS STM32CubeF0_FIND_COMPONENTS)
    string(TOUPPER ${component} component)
    set(component_varname ${component})

    if (component STREQUAL "USB")
        set(component_look_for "usbd_core")
        set(component_path "Middlewares/ST/STM32_USB_Device_Library/Core")
    elseif (component STREQUAL "CDC")
        set(component "USB_${component}")
        set(component_varname "USB_${component}")

        set(component_look_for "usbd_cdc")
        set(component_path "Middlewares/ST/STM32_USB_Device_Library/Class/CDC")
    elseif (component STREQUAL "HID")
        set(component "USB ${component}")
        set(component_varname "USB_${component}")

        set(component_look_for "usbd_hid")
        set(component_path "Middlewares/ST/STM32_USB_Device_Library/Class/HID")
    endif ()

    # Look for the header files.
    find_path(STM32CubeF0_${component_vername}_INCLUDE_DIR
        NAMES
            "${component_look_for}.h"
        HINTS
            "${STM32CubeF0_ROOT}/${component_path}"
            "$ENV{STM32CubeF0_ROOT}/${component_path}"
        PATHS
            "$ENV{PROGRAMFILES}/STM32CubeF0/${component_path}"
            "${CMAKE_FIND_ROOT_PATH}/include"
            /usr/include
            /usr/local/include
            /opt/local/include
            /sw/include
        PATH_SUFFIXES
            "Inc"
            "include"
        DOC
            "The directory where header files of STM32CubeF0 ${component} library resides")
    mark_as_advanced(STM32CubeF0_${component_varname}_INCLUDE_DIR)

    # Look for the source files
    find_path(STM32CubeF0_${component_varname}_SOURCE_DIR
        NAMES
            "${component_look_for}.c"
        HINTS
            "${STM32CubeF0_ROOT}/${component_path}"
            "$ENV{STM32CubeF0_ROOT}/${component_path}"
        PATHS
            "$ENV{PROGRAMFILES}/STM32CubeF0/${component_path}"
        DOC
            "The directory where source files of STM32CubeF0 ${component} library resides"
        PATH_SUFFIXES
            "Src"
            "src"
        NO_CMAKE_FIND_ROOT_PATH)
    mark_as_advanced(STM32CubeF0_${component_varname}_SOURCE_DIR)

    if (STM32CubeF0_${component}_INCLUDE_DIR AND STM32CubeF0_${component}_SOURCE_DIR)
        set(STM32CubeF0_${component}_FOUND true)
    endif ()
endforeach ()

find_package_handle_standard_args(STM32CubeF0
    REQUIRED_VARS STM32CubeF0_HAL_INCLUDE_DIR STM32CubeF0_CMSIS_INCLUDE_DIR STM32CubeF0_CMSIS_DEVICE_INCLUDE_DIR 
        STM32CubeF0_HAL_SOURCE_DIR)

if (STM32CubeF0_FOUND)
    set(STM32CubeF0_INCLUDE_DIRS ${STM32CubeF0_HAL_INCLUDE_DIR}
        ${STM32CubeF0_CMSIS_INCLUDE_DIR}
        ${STM32CubeF0_CMSIS_DEVICE_INCLUDE_DIR}
        ${STM32CubeF0_USB_INCLUDE_DIR}
        ${STM32CubeF0_USB_CDC_INCLUDE_DIR}
        ${STM32CubeF0_USB_HID_INCLUDE_DIR})

    set(STM32CubeF0_HAL_SOURCES ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_adc.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_adc_ex.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_cortex.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_dma.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_exti.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_flash.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_flash_ex.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_gpio.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_i2c.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_i2c_ex.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_pcd.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_pcd_ex.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_pwr.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_pwr_ex.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_rcc.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_rcc_ex.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_tim.c
        ${STM32CubeF0_HAL_SOURCE_DIR}/stm32f0xx_hal_tim_ex.c)

    if (STM32CubeF0_USB_FOUND)
        set(STM32CubeF0_USB_SOURCES ${STM32CubeF0_USB_SOURCE_DIR}/usbd_core.c
            ${STM32CubeF0_USB_SOURCE_DIR}/usbd_ctlreq.c
            ${STM32CubeF0_USB_SOURCE_DIR}/usbd_ioreq.c)
    endif ()
    if (STM32CubeF0_USB_CDC_FOUND)
        set(STM32CubeF0_USB_CDC_SOURCES ${STM32CubeF0_USB_CDC_SOURCE_DIR}/usbd_cdc.c)
    endif ()
    if (STM32CubeF0_USB_HID_FOUND)
        set(STM32CubeF0_USB_HID_SOURCES ${STM32CubeF0_USB_HID_SOURCE_DIR}/usbd_hid.c)
    endif ()

    set(STM32CubeF0_SOURCES ${STM32CubeF0_HAL_SOURCES}
        ${STM32CubeF0_USB_SOURCES}
        ${STM32CubeF0_USB_CDC_SOURCES}
        ${STM32CubeF0_USB_HID_SOURCES})
endif ()

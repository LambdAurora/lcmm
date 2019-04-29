#
# Copyright © 2019 LambdAurora <aurora42lambda@gmail.com>
#
# This file is part of LambdaCMakeModules.
#
# Licensed under the MIT license. For more information,
# see the LICENSE file.
#

#.rst:
# FindDiscordRPC
# --------
#
# Find the DiscordRPC library.
#
# IMPORTED Targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the :prop_tgt:`IMPORTED` target ``DiscordRPC::DiscordRPC``,
# if DiscordRPC has been found.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ::
#
#   DISCORDRPC_INCLUDE_DIRS - Include directories for DiscordRPC.
#   DISCORDRPC_LIBRARIES - Libraries to link against DiscordRPC.
#   DiscordRPC_FOUND - True if DiscordRPC has been found and can be used.

include(FindPackageHandleStandardArgs)

# Look for the header file.
find_path(DISCORDRPC_INCLUDE_DIR
    NAMES
        discord_rpc.h
    HINTS
        "${DiscordRPC_LOCATION}/include"
        "$ENV{DiscordRPC_LOCATION}/include"
    PATHS
        "$ENV{PROGRAMFILES}/DiscordRPC/include"
        /usr/include/
        /usr/local/include/
        /opt/local/include/
        /sw/include/
    DOC
        "The directory where discord_rpc.h resides")
mark_as_advanced(DISCORDRPC_INCLUDE_DIR)

# Look for the library file.
find_library(DiscordRPC_LIBRARY
    NAMES
        libdiscord-rpc
        discord-rpc
    HINTS
        "${DiscordRPC_LOCATION}/lib"
        "$ENV{DiscordRPC_LOCATION}/lib"
    PATHS
        "$ENV{PROGRAMFILES}/DiscordRPC/lib"
        /usr/local/lib
        /usr/lib
        /lib
    DOC
        "The absolute path to DiscordRPC library.")
mark_as_advanced(DiscordRPC_LIBRARY)

find_package_handle_standard_args(DiscordRPC
    REQUIRED_VARS DiscordRPC_LIBRARY DISCORDRPC_INCLUDE_DIR)

if (DiscordRPC_FOUND)
  set(DISCORDRPC_INCLUDE_DIRS ${DISCORDRPC_INCLUDE_DIR})
  set(DISCORDRPC_LIBRARIES ${DiscordRPC_LIBRARY})

  if (NOT TARGET Discord::DiscordRPC)
    add_library(Discord::DiscordRPC UNKNOWN IMPORTED)
    set_target_properties(Discord::DiscordRPC PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${DISCORDRPC_INCLUDE_DIRS}")

    set_property(TARGET Discord::DiscordRPC APPEND PROPERTY IMPORTED_LOCATION "${DISCORDRPC_LIBRARIES}")
  endif ()
endif ()

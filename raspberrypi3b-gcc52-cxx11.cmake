# Copyright (c) 2015, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_RASPBERRYPI3B_GCC52_CXX11_CMAKE)
  return()
else()
  set(POLLY_RASPBERRYPI3B_GCC52_CXX11_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "RaspberryPi 3B Cross Compile / GCC 5.2 / C++11"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include(polly_clear_environment_variables)
include(polly_fatal_error)
include(polly_add_cache_flag)

set(_rpi_error_msg) #if empty, then no errors!
string(COMPARE EQUAL
    "$ENV{RASPBERRYPI_52_CROSS_COMPILE_TOOLCHAIN_PATH}"
    ""
    _is_empty
)
if(_is_empty)
  set(_rpi_error_msg
      "${_rpi_error_msg}\nRASPBERRYPI_52_CROSS_COMPILE_TOOLCHAIN_PATH environment variable not set. Set it to the absolute path of the \"bin\" directory for the toolchain"
  )
endif()

string(COMPARE EQUAL
    "$ENV{RASPBERRYPI_52_CROSS_COMPILE_TOOLCHAIN_PREFIX}"
    ""
    _is_empty
)
if(_is_empty)
  set(_rpi_error_msg
      "${_rpi_error_msg}\nRASPBERRYPI_52_CROSS_COMPILE_TOOLCHAIN_PREFIX environment variable not set. Set it to the triplet of the toolchain (ex: arm-linux-gnueabihf)"
  )
endif()

string(COMPARE EQUAL
    "$ENV{RASPBERRYPI_52_CROSS_COMPILE_SYSROOT}"
    ""
    _is_empty
)
if(_is_empty)
  set(_rpi_error_msg
    "${_rpi_error_msg}\nRASPBERRYPI_52_CROSS_COMPILE_SYSROOT environment variable not set. Set it to the sysroot to be used"
  )
endif()

string(COMPARE NOTEQUAL
    "${_rpi_error_msg}"
    ""
    _has_errors
)
if(_has_errors)
  polly_fatal_error(
      "RaspberyPi Toolchain configuration failed:"
      ${_rpi_error_msg}
  )
endif()

set(RAPSBERRYPI3B_COMPILE_FLAGS
    #"-mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
    #"-mcpu=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard"
    "-mcpu=cortex-a53 -mfloat-abi=hard -mfpu=neon-fp-armv8 -mneon-for-64bits -mtune=cortex-a53"
    # -funsafe-math-optimizations could be needed: https://github.com/RetroPie/RetroPie-Setup/issues/1385
    CACHE STRING "RaspberryPi 3 B Compile Flags"
)

# We shouldn't try to hardcore the path, since the cross compiler for the Mac
# needs to be in a "case-sensitive" file system
set(CROSS_COMPILE_TOOLCHAIN_PATH
    "$ENV{RASPBERRYPI_52_CROSS_COMPILE_TOOLCHAIN_PATH}"
    CACHE PATH "RaspberryPi Toolchain Path"
)

# The prefix is what is known as the cross compiler triplet or quadruplet.
# ex: arm-unknown-linux-gnueabihf (note: no dash at the end)
set(CROSS_COMPILE_TOOLCHAIN_PREFIX
    "$ENV{RASPBERRYPI_52_CROSS_COMPILE_TOOLCHAIN_PREFIX}"
    CACHE STRING "RaspberryPi Toolchain Prefix"
)

# The sysroot for the cross compile
set(CROSS_COMPILE_SYSROOT
    "$ENV{RASPBERRYPI_52_CROSS_COMPILE_SYSROOT}"
    CACHE PATH "RaspberryPi sysroot"
)

# only search for libraries and includes in the ndk toolchain
set(CMAKE_FIND_ROOT_PATH "${CROSS_COMPILE_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-cross-compile.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/fpic.cmake")

polly_add_cache_flag(CMAKE_C_FLAGS ${RAPSBERRYPI3B_COMPILE_FLAGS})
polly_add_cache_flag(CMAKE_CXX_FLAGS ${RAPSBERRYPI3B_COMPILE_FLAGS})
polly_add_cache_flag(CMAKE_SYSTEM_NAME "Linux")
polly_add_cache_flag(CMAKE_SYSTEM_PROCESSOR "armv8-a")

polly_add_cache_flag(CMAKE_CXX_FLAGS "-static-libgcc")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-static-libstdc++")
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "static-std")

add_definitions("-DRASPBERRY")
set(RASPBERRY "TRUE" CACHE STRING "Is platform Raspberry?")

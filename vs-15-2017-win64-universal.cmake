# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_14_2015_WIN64_UNIVERSAL_CMAKE_)
  return()
else()
	set(POLLY_VS_14_2015_WIN64_SDK_UNIVERSAL_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 15 2017 Win64 | Universal 10.0"
    "Visual Studio 15 2017 Win64"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")


set(CMAKE_SYSTEM_VERSION 10.0)
set(CMAKE_SYSTEM_NAME WindowsStore)

add_definitions("-DUWP")
add_definitions("-DWIN32_LEAN_AND_MEAN")
set(UWP "TRUE" CACHE STRING "Is platform universal windows?")

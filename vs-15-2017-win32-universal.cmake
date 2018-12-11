# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_15_2017_WIN32_UNIVERSAL_CMAKE_)
  return()
else()
	set(POLLY_VS_15_2017_WIN32_UNIVERSAL_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 15 2017 | Universal 10.0"
    "Visual Studio 15 2017"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_add_cache_flag)

set(CMAKE_SYSTEM_VERSION 10.0)
set(CMAKE_SYSTEM_NAME WindowsStore)

polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-DUWP")
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-DWIN32_LEAN_AND_MEAN")
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-DNOMINMAX")
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-D_CRT_SECURE_NO_WARNINGS") # fix tesnorflow
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-D_CRT_NONSTDC_NO_DEPRECATE") # fix tensorfow
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-D_SCL_SECURE_NO_WARNINGS") # fix tensorflow
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "/wd4701") #fix protobuf
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "/wd4703") # fix protobuf

polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "/wd4996")
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-D_DISABLE_EXTENDED_ALIGNED_STORAGE")

set(UWP "TRUE" CACHE STRING "Is platform universal windows?")

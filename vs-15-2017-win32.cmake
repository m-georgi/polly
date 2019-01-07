# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_15_2017_WIN32_CMAKE_)
  return()
else()
	set(POLLY_VS_15_2017_WIN32_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 15 2017"
    "Visual Studio 15 2017"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_add_cache_flag)
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-DNOMINMAX")

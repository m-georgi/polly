# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_GCC5_CMAKE)
  return()
else()
  set(POLLY_COMPILER_GCC5_CMAKE 1)
endif()

find_program(CMAKE_C_COMPILER gcc-5)
find_program(CMAKE_CXX_COMPILER g++-5)

if(NOT CMAKE_C_COMPILER)
  polly_fatal_error("gcc-5 not found")
endif()

if(NOT CMAKE_CXX_COMPILER)
  polly_fatal_error("g++-5 not found")
endif()

set(
    CMAKE_C_COMPILER
    "${CMAKE_C_COMPILER}"
    CACHE
    STRING
    "C compiler"
    FORCE
)

set(
    CMAKE_CXX_COMPILER
    "${CMAKE_CXX_COMPILER}"
    CACHE
    STRING
    "C++ compiler"
    FORCE
)

# Copyright (c) 2015, Ruslan Baratov
# Copyright (c) 2015, Ruslan Baratov
# Copyright (c) 2015, David Hirvonen
# Copyright (c) 2015, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_ANDROID_NDK_R13B_API_21_ARMEABI_V7A_VFP2_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_NDK_R13B_API_21_ARMEABI_V7A_VFP2_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_NDK_VERSION "r13b")
set(CMAKE_SYSTEM_VERSION "21")
set(CMAKE_ANDROID_ARCH_ABI "armeabi-v7a")
set(CMAKE_ANDROID_ARM_MODE TRUE) # 32-bit ARM
set(CMAKE_ANDROID_ARM_NEON TRUE)
set(CMAKE_ANDROID_STL_TYPE "c++_static")
set(CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION "clang")

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${CMAKE_SYSTEM_VERSION} / ${CMAKE_ANDROID_ARCH_ABI} / 32-bit ARM / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake") # before toolchain!

polly_add_cache_flag(CMAKE_CXX_FLAGS "-ftree-vectorize -mfloat-abi=hard -mfpu=neon -mhard-float -D_NDK_MATH_NO_SOFTFP=1")
polly_add_cache_flag(CMAKE_C_FLAGS "-ftree-vectorize -mfloat-abi=hard -mfpu=neon -mhard-float -D_NDK_MATH_NO_SOFTFP=1")
polly_add_cache_flag(CMAKE_LINK_LIBRARY_FLAG "-Wl,--no-warn-mismatch")

polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-Wl,--no-warn-mismatch -lm_hard")
polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-Wl,--no-warn-mismatch -lm_hard")

include("${CMAKE_CURRENT_LIST_DIR}/os/android.cmake")

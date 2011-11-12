# Copyright (c) 2011, Christian Rorvik
# Distributed under the Simplified BSD License (See accompanying file LICENSE.txt)

#
# Compiler flags
#
if(MSVC)
  add_definitions("-D_WIN32_WINNT=0x0501")
  add_definitions("-DNOMINMAX")
  add_definitions("-Dnoexcept=throw()")
  add_definitions("-D_SCL_SECURE_NO_WARNINGS")

  # Enable parallel compilation
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")

  # Set warning level to highest
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")

  # Disable buffer security checks
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /GS-")
  
  # Enable reasonable inlining in Release With Debug Info
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /Ob2")
  
  # Enable intrinsics
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Oi")
  
  # Enable floating point optimizations (for all configurations)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /fp:fast") 
  
  # Link time code gen
  # No way to set library linker flags at the moment. Disabling for now.
  # set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /GL")
  # set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /LTCG")
  
  # Disable some warnings
  # warning C4480: nonstandard extension used: specifying underlying type for enum 'Crunch::CpuidFunction'
  # warning C4481: nonstandard extension used: override specifier 'override'
  # warning C4482: nonstandard extension used: enum 'Crunch::CpuidFunction' used in qualified name
  # warning C4127: conditional expression is constant 
  # (boost utf) warning C4535: calling _set_se_translator() requires /EHa
  # (boost utf) warning C4702: unreachable code
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4480 /wd4481 /wd4482 /wd4127 /wd4535 /wd4702")

  # Enable static analysis warnings
  if (${CMAKE_SIZEOF_VOID_P} EQUAL 4)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /analyze")
    # (boost headers) warning C6326: Potential comparison of a constant with another constant
    # warning C6334: sizeof operator applied to an expression with an operator might yield unexpected results
    # warning C6255: _alloca indicates failure by raising a stack overflow exception. Consider using _malloca instead
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd6326 /wd6334 /wd6255")
  endif()
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  if (${CMAKE_SIZEOF_VOID_P} EQUAL 8)
    # Enable cmpxchg16
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mcx16")
  endif()
endif()

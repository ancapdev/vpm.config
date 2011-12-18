# Copyright (c) 2011, Christian Rorvik
# Distributed under the Simplified BSD License (See accompanying file LICENSE.txt)

#
# Compiler flags
#
if(MSVC)
  add_definitions("-D_WIN32_WINNT=0x0600")
  add_definitions("-DNOMINMAX")
  if(${MSVC_VERSION} EQUAL 1700)
    # Enable at least 10 parameters for variadic standard library types
    add_definitions("-D_VARIADIC_MAX=10")
  endif()
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
  # warning C4251: dll interface needed for 'foo'
  # warning C4275: non dll-interface 'foo' class used as base for dll-interface class 'bar'
  # (boost utf) warning C4535: calling _set_se_translator() requires /EHa
  # (boost utf) warning C4702: unreachable code
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4480 /wd4481 /wd4482 /wd4127 /wd4535 /wd4702 /wd4251 /wd4275")

  # Enable static analysis warnings
  if(${CMAKE_SIZEOF_VOID_P} EQUAL 4)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /analyze")
    # (boost headers) warning C6326: Potential comparison of a constant with another constant
    # warning C6334: sizeof operator applied to an expression with an operator might yield unexpected results
    # warning C6255: _alloca indicates failure by raising a stack overflow exception. Consider using _malloca instead
    # warning C6011: Dereferncing NULL pointer
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd6326 /wd6334 /wd6255 /wd6011")
  endif()
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  if (${CMAKE_SIZEOF_VOID_P} EQUAL 8)
    # Enable cmpxchg16
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mcx16")

    # Enable 32 bit cross compile
    if(DEFINED VPM_BITS)
      if(${VPM_BITS} EQUAL 32)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
      endif()
    endif()
  endif()
endif()

# Add compile time flag to detect a shared library build
if(${BUILD_SHARED_LIBS})
  add_definitions("-DVPM_SHARED_LIB_BUILD")
endif()



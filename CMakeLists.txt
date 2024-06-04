cmake_minimum_required(VERSION 3.14)
project(fsys VERSION 0.0.0)

cmake_policy(SET CMP0076 NEW)

enable_testing()
include(CTest)

include(CMakePrintHelpers)
enable_language(C)
enable_language(Fortran)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_program(FYPP fypp)
if(NOT FYPP)
  message(FATAL_ERROR "FYPP not found.")
endif()

set(fyppFlags)

list(
  APPEND fyppFlags
  "-I${PROJECT_SOURCE_DIR}/include"
  )

if(WIN32)
  list(
    APPEND fyppFlags
    "-DWIN32"
  )
endif()

add_subdirectory(src)
if(CMAKE_BUILD_TYPE MATCHES "Debug")
  add_subdirectory(test)
endif()

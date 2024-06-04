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

include(CheckFortranSourceCompiles)
include(CheckFortranSourceRuns)
check_fortran_source_runs(
  "if (selected_real_kind(3) == selected_real_kind(6)) STOP 1; end"
  HP_SUPPORT
  )
check_fortran_source_runs(
  "if (selected_real_kind(33) == -1) STOP 1; end"
  QP_SUPPORT
  )
check_fortran_source_runs(
  "if (ANY(selected_real_kind(18) == [-1, selected_real_kind(33)])) STOP 1; end"
  XDP_SUPPORT
  )

set(fyppFlags)

list(
  APPEND fyppFlags
  "-I${PROJECT_SOURCE_DIR}/include"
  )

list(
  APPEND fyppFlags
  "-DHP_SUPPORT=$<BOOL:${HP_SUPPORT}>"
  "-DXDP_SUPPORT=$<BOOL:${XDP_SUPPORT}>"
  "-DQP_SUPPORT=$<BOOL:${QP_SUPPORT}>"
  "-I${PROJECT_SOURCE_DIR}/include"
  )

if(WIN32)
  list(
    APPEND fyppFlags
    "-DWIN32=$<BOOL:${WIN32}>"
  )
endif()

add_subdirectory(src)
if(CMAKE_BUILD_TYPE MATCHES "Debug")
  add_subdirectory(test)
endif()

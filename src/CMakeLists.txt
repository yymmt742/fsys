set(LIB_MOD_DIR ${CMAKE_CURRENT_BINARY_DIR}/mod_files/)
if(NOT EXISTS "${LIB_MOD_DIR}")
  make_directory("${LIB_MOD_DIR}")
endif()

include(CheckCSourceCompiles)
include(CheckCSourceRuns)
check_c_source_runs("#include <unistd.h>\nint main(){if(STDIN_FILENO!=0){return 1;}}" stdinis0)
check_c_source_runs("#include <unistd.h>\nint main(){if(STDOUT_FILENO!=1){return 1;}}" stdoutis1)
check_c_source_runs("#include <unistd.h>\nint main(){if(STDERR_FILENO!=2){return 1;}}" stderris2)

list(APPEND f90src
  ${CMAKE_CURRENT_SOURCE_DIR}/fsys.f90
  ${CMAKE_CURRENT_SOURCE_DIR}/fsys_isatty.f90
  )

if(stdinis0 AND stdoutis1 AND stderris2)
list(APPEND f90src
  ${CMAKE_CURRENT_SOURCE_DIR}/mod_fsys_common.f90
  )
else()
  message(FATAL_ERROR "c macro error")
endif()

add_library(
  ${PROJECT_NAME} STATIC
  ${f90src}
  )

target_compile_options(
  ${PROJECT_NAME}
  PRIVATE
    $<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-O2>
    $<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-cpp>
    $<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-std=f2008>
    $<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-fimplicit-none>
    $<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-fall-intrinsics>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-Wuninitialized>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-fbounds-check>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-Wunused>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-fbacktrace>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-fcheck=array-temps,bounds,do,mem,pointer>>
    $<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-fast>
    $<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-Mnobackslash>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-C>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-g>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-traceback>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-Wall>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-Mbounds>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-Mchkptr>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-Mchkstk>>
    )
if(UNIX)
  target_compile_options(
  ${PROJECT_NAME}
  PRIVATE
    $<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:-free>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:-g>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:-traceback>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:-debug>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:-warn all>>
    $<$<COMPILE_LANG_AND_ID:Fortran,Intel>:-free>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,Intel>:-g>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,Intel>:-traceback>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,Intel>:-debug>>
    $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,Intel>:-warn all>>
    )
endif()

set_target_properties(
  ${PROJECT_NAME}
  PROPERTIES Fortran_MODULE_DIRECTORY
  ${LIB_MOD_DIR}
  )
install(
  TARGETS ${PROJECT_NAME}
  EXPORT ${PROJECT_NAME}-export
  ARCHIVE DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake/${PROJECT_NAME}/lib"
  LIBRARY DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake/${PROJECT_NAME}/lib")
install(
  EXPORT ${PROJECT_NAME}-export
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake/${PROJECT_NAME}")

install(DIRECTORY ${FORBAR_MOD_DIR}
        DESTINATION "${CMAKE_INSTALL_PREFIX}/cmake/${PROJECT_NAME}")

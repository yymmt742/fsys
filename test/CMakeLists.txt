#include(FetchContent)
#FetchContent_Declare(
#  unittest
#  GIT_REPOSITORY https://github.com/yymmt742/unittest
#  GIT_TAG origin/main
#  GIT_PROGRESS TRUE
#  )
#FetchContent_MakeAvailable(unittest)

macro(ADDTEST name)
  add_executable(test_${name} test_${name}.f90)
  target_link_libraries(test_${name} PRIVATE fsys)
#  target_link_libraries(test_${name} PRIVATE unittest)
  target_include_directories(test_${name} PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/../src/mod_files)
  target_compile_options(
    test_${name}
    PRIVATE
      $<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-O2>
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
      test_${name}
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
  elseif(WIN32)
    target_compile_options(
      test_${name}
      PRIVATE
        $<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:/free>
        $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:/traceback>>
        $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:/debug:full>>
        $<$<COMPILE_LANG_AND_ID:Fortran,Intel>:/free>
        $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,Intel>:/traceback>>
        $<$<CONFIG:Debug>:$<$<COMPILE_LANG_AND_ID:Fortran,Intel>:/debug:full>>
        )
  endif()
  add_test(NAME ${name} COMMAND $<TARGET_FILE:test_${name}>)
endmacro(ADDTEST)

ADDTEST(sleep)
ADDTEST(isatty)
ADDTEST(winsize)

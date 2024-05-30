program main
  use mod_unittest
  use fsys
  implicit none
  type(unittest) :: u
!
  call u%init('test_fsys')
  print *, isatty()
  call u%finish_and_terminate()
!
end program main


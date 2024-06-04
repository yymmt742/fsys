program main
  use, intrinsic :: ISO_FORTRAN_ENV, only: INT64, REAL64
  use fsys
  implicit none
  integer(INT64) :: count_s, count_e, count_rate
  real(REAL64)   :: time
!
  call SYSTEM_CLOCK(count=count_s, count_rate=count_rate)
  call sleep(0.1)
  call SYSTEM_CLOCK(count=count_e)
  time = real(count_e - count_s) / count_rate
  if (ABS(time - 0.1) > 0.05) error stop
!
end program main


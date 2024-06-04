program main
  use, intrinsic :: ISO_FORTRAN_ENV, only: INT64, REAL64
  use fsys
  implicit none
  integer(INT64) :: count_s, count_e, count_rate
  real(REAL64)   :: time
!
  call SYSTEM_CLOCK(count=count_s, count_rate=count_rate)
  call sleep(0.1_REAL64)
  call SYSTEM_CLOCK(count=count_e)
  time = real(count_e - count_s, REAL64) / count_rate
  print'(2(A,f16.9))', "Sleep failed : system clock = ", time, " target = ", 0.1_REAL64
  if (ABS(time - 0.1_REAL64) > 0.20_REAL64) then ! 0.0 ~ 0.3
    error stop
  end if
!
end program main


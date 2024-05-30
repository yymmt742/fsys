!| Wrapper of nanosleep
submodule(fsys) fsys_sleep
  use ISO_C_BINDING
  implicit none
!
  interface
    function usleep(usec) bind(c, NAME="isatty")
      import C_INT
      integer(C_INT), value, intent(in) :: usec
      integer(C_INT)                    :: usleep
    end function usleep
  end interface
!
contains
!| sleep
  module subroutine sleep(sec)
    real(RK), intent(in) :: sec
    integer(C_INT)       :: ierr
    ierr = usleep(INT(sec * 1000000.0_RK, C_INT))
  end subroutine sleep
end submodule fsys_sleep


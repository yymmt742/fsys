!| Fortran system control module.
module fsys
  use ISO_FORTRAN_ENV, only: RK => REAL64
  implicit none
  private
  public :: isatty
  public :: sleep
!
  interface
    module function isatty(unit) result(res)
      integer, intent(in), optional :: unit
      logical                       :: res
    end function isatty
!
    module subroutine sleep(sec)
      real(RK), intent(in) :: sec
    end subroutine sleep
  end interface
!
end module fsys


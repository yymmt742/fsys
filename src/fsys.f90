!| Fortran system control module.
module fsys
  implicit none
  private
  public :: isatty
!
  interface
    module function isatty(unit) result(res)
      integer, intent(in), optional :: unit
      logical                       :: res
    end function isatty
  end interface
!
end module fsys


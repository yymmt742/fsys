!| Wrapper of isatty
submodule(fsys) fsys_isatty
  use ISO_C_BINDING
  use ISO_FORTRAN_ENV, only: &
  &   FC_STDIN => INPUT_UNIT, &
  &   FC_STDOUT => OUTPUT_UNIT, &
  &   FC_STDERR => ERROR_UNIT
  use mod_fsys_common
  implicit none
  interface
    function isatty_(fd) bind(c, NAME="isatty")
      use ISO_C_BINDING
      integer(C_INT), value, intent(in) :: fd
      integer(C_INT)                    :: isatty_
    end function isatty_
  end interface
!
contains
!| Return true if unit is tty <br>
  module function isatty(unit) result(res)
    integer, intent(in), optional :: unit
    logical                       :: res
    integer(C_INT)                :: cres
    if (.not. PRESENT(unit)) then
      cres = isatty_(STDOUT_FILENO)
    else
      select case (unit)
      case (FC_STDIN)
        cres = isatty_(STDIN_FILENO)
      case (FC_STDOUT)
        cres = isatty_(STDOUT_FILENO)
      case (FC_STDERR)
        cres = isatty_(STDERR_FILENO)
      case default
        cres = 0
      end select
    end if
    res = .not. cres == 0
  end function isatty
end submodule fsys_isatty


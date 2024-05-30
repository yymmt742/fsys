!| Constatnts
module mod_fsys_common
  use ISO_C_BINDING
  implicit none
  private
  public :: STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO
  public :: TIOCGWINSZ
!&<
  integer(C_INT), parameter :: STDIN_FILENO  = 0
  integer(C_INT), parameter :: STDOUT_FILENO = 1
  integer(C_INT), parameter :: STDERR_FILENO = 2
  integer(C_INT), parameter :: TIOCGWINSZ    = INT(z'5413')
!&>
end module mod_fsys_common


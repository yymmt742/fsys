#include <unistd.h>
#include <sys/ioctl.h>

int winsize_(unsigned int *ws_col, unsigned int *ws_row)
{
  struct winsize ws;
  int ret = ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws);
  *ws_col = ws.ws_col;
  *ws_row = ws.ws_row;
  return ret;
}

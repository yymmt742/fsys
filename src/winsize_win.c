#include <windows.h>

int winsize_(int *ws_col, int *ws_row)
{
    CONSOLE_SCREEN_BUFFER_INFO csbi;
    bool r = GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi);
    *ws_col = csbi.srWindow.Right - csbi.srWindow.Left + 1;
    *ws_row = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
    if (r)
    {
      return 0;
    }
    else
    {
      return 1;
    }
}


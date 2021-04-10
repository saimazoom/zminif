#include <string.h>

void main()
{
  unsigned char nColor = 0;

  //set mode 0
  __asm
    ld  a, #0
    call  #0xBC0E
  __endasm;

  for(nColor = 0; nColor < 255; nColor++)
  {
    memset(0xC000, nColor, 0x3FFF);
  }

  __asm
    call #0xBB06
  __endasm;
}
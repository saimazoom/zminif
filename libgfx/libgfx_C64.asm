; https://groups.google.com/forum/#!topic/comp.sys.apple2/usZKHLQi-Ak
;
;    Sure thing, it's simple enough. The software stack is implemented with
; a zp pointer called sp. It starts at the top, and moves down as items
; are pushed on the stack. You can .importzp sp and access it directly,
; but it's easier to use the built in library calls for manipulating the
; stack. When your code is called, the arguments are pushed onto the
; stack left to right. If you declare your function __fastcall__ the
; last (rightmost) argument will be in A/X instead of on the stack,
; which saves a few cycles. Your code is responsible for pulling all the
; arguments off the stack, so if you have e.g. 4 bytes of arguments, sp
; should be increased with 4 before your code exits (2 if you use
; __fastcall__). The return value should be in A (lo) and X (hi). X must
; be set even if you just return a single byte, as cc65 doesn't clear X
; for you if the value is cast e.g. from a char to an int.
;
; Some of the available library routines are:
;  popa                pull one byte off stack, increase sp by one
;  popax         pull two bytes off stack, increase sp by two
;  pusha         dec sp byte one, push one byte onto the stack
;  pushax        dec sp by two, push two bytes onto stack
;  incsp1        increase sp by one
;  incsp2        increase sp by two (and so on)

.import popa, popax
.importzp ptr1, ptr2
.export _putPixel        ; prepend labels with _ so C can see them
.export _scrollArriba
.export _scrollArriba2
.export _drawRectangle
.export _clsScreen
.export _waitForAnyKey
.export _drawVline
.export _drawHline
.export _clearchar
.export _waitForNoKey
.export _setRAMPage
.export _setRAMBack
.export _drawSprite
.export _randomNumber
.export _getKey
.code

;---------------------------------------------------------------
; extern void putPixel (BYTE x, BYTE y, BYTE color);
;---------------------------------------------------------------
_putPixel:

    rts 

;---------------------------------------------------------------
; extern void scrollArriba (BYTE fila_inicial, BYTE columna_inicial);
;---------------------------------------------------------------
_scrollArriba:
    rts
;---------------------------------------------------------------
; extern void scrollArriba2 (BYTE linea_inicial, BYTE num, BYTE step);
;---------------------------------------------------------------
_scrollArriba2:
    rts
;---------------------------------------------------------------
; extern void drawRectangle (BYTE xorig, BYTE yorig, BYTE width, BYTE height);
;---------------------------------------------------------------
_drawRectangle:
    rts

;---------------------------------------------------------------
; extern void clsScreen (BYTE effect); // Distintos efectos para borrar la pantalla...
;---------------------------------------------------------------
_clsScreen:
    rts

;---------------------------------------------------------------
; extern void waitForAnyKey();
;---------------------------------------------------------------
_waitForAnyKey:
    rts

;---------------------------------------------------------------
; extern void drawVline (BYTE x0, BYTE y0, BYTE len);
;---------------------------------------------------------------
_drawVline:
    rts

;---------------------------------------------------------------
; extern void drawHline (BYTE x0, BYTE y0, BYTE len);
;---------------------------------------------------------------
_drawHline:
    rts

;---------------------------------------------------------------
; extern void clearchar (BYTE x, BYTE y, BYTE color);
;---------------------------------------------------------------
_clearchar:
    rts
;---------------------------------------------------------------
; extern void clear_screen (BYTE color);
;---------------------------------------------------------------
_clear_screen:
    rts

;---------------------------------------------------------------
; extern void waitForNoKey();
;---------------------------------------------------------------
_waitForNoKey:
    rts
;---------------------------------------------------------------
; extern void setRAMPage (BYTE banco);
;---------------------------------------------------------------
_setRAMPage:
    rts

;---------------------------------------------------------------
; extern void setRAMBack();
;---------------------------------------------------------------
_setRAMBack:
    rts

;---------------------------------------------------------------
; extern void drawSprite (BYTE *pointer, BYTE xorig, BYTE yorig, BYTE width, BYTE height);
;---------------------------------------------------------------
_drawSprite:
    rts

;---------------------------------------------------------------
; extern WORD randomNumber(); 
;---------------------------------------------------------------
_randomNumber:
    rts
;---------------------------------------------------------------
; extern unsigned char getKey();
;---------------------------------------------------------------
_getKey:
    rts

;///////////////////////////////////////////////////////////
;//                      DRAW TEXT                        //
;///////////////////////////////////////////////////////////
;// Functions in printlib.asm

;---------------------------------------------------------------
; extern int fzx_setat(unsigned char x, unsigned char y);
;---------------------------------------------------------------
_fzx_setat:
    rts

;---------------------------------------------------------------
; extern int fzx_putc(unsigned char c);
;---------------------------------------------------------------
_fzx_putc:
    rts
;---------------------------------------------------------------
; extern int fzx_puts(char *s);
;---------------------------------------------------------------
_fzx_puts:
    rts

;---------------------------------------------------------------
; extern int fzx_write(unsigned int *buf, unsigned int len);
;---------------------------------------------------------------
_fzx_write:
    rts
;---------------------------------------------------------------
; extern void print_string (BYTE x, BYTE y, unsigned char *texto);
;---------------------------------------------------------------
_print_string:
    rts
;---------------------------------------------------------------
; extern void print_char (BYTE x, BYTE y, unsigned char texto);
;---------------------------------------------------------------
_print_char:
    rts
;---------------------------------------------------------------
; extern void set_attr (BYTE x, BYTE Y, BYTE attr);
;---------------------------------------------------------------
_set_attr:
    rts











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
;.import popa, popax
;.importzp ptr1, ptr2
; jsr popa
.export _putPixel        ; prepend labels with _ so C can see them
.export _scrollArriba
.export _scrollArriba2
.export _drawRectangle
.export _clearScreen
.export _waitForAnyKey
.export _drawVline
.export _drawHline
.export _clearchar
.export _waitForNoKey
.export _drawSprite
.export _randomNumber
.export _getKey
.export _splitScreen
.export _print_string
.export _setRamLayout
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
; extern __FASTCALL__ void clearScreen (BYTE color);
; FASTCALL -> Argument in A(lo) and X(hi). Rightmost first.
;---------------------------------------------------------------
_clearScreen:
    ; Border color to Black
    LDA #$00
    STA $d020
    STA $d021
    ; Clear the video memory
   
    LDX #255
Loop_screen_ram: 
    ; 1) SCREEN RAM SCREEN MEMORY/VIDEO MATRIX/CHARMEM RAM -> 1000bytes -> 256x8
    ; $E000-E3FF: 1000 Bytes
   
    STA $E000,X   
    STA $E100,X 
    STA $E200,X
    STA $E300,X
   
    ; 3) VIDEO COLOR/COLORMEM RAM  -> 1000bytes. Fixed at 0xD800-0xDBE7
    STA $D800,X   
    STA $D900,X 
    STA $DA00,X
    STA $DB00,X
    
    ; 2) VIDEOBITMAP RAM  -> 160x200 -> 8000 bytes -> (40x8)x25
    ; $C000-$DFFF
    ; Contenido de la memoria de bitmap:
    ; %00: Se toma el color de fondo del registro $d021 (color de fondo 0).
    ; %01: Se toma el color de la RAM de pantalla (nibble alto). ScreenRAM
    ; %10: Se toma el color de la RAM de pantalla (nibble bajo). ScreenRAM.
    ; %11: Se toma el color de la RAM de color.
    STA $C000,X   
    STA $C100,X 
    STA $C200,X
    STA $C300,X
    STA $C400,X
    STA $C500,X
    STA $C600,X
    STA $C700,X
    STA $C800,X
    STA $C900,X
    STA $CA00,X
    STA $CB00,X
    STA $CC00,X
    STA $CD00,X
    STA $CE00,X
    STA $CF00,X
    STA $D000,X
    STA $D100,X
    STA $D200,X
    STA $D300,X
    STA $D400,X
    STA $D500,X
    STA $D600,X
    STA $D700,X
    STA $D800,X
    STA $D900,X
    STA $DA00,X
    STA $DB00,X
    STA $DC00,X
    STA $DD00,X
    STA $DE00,X
    STA $DF00,X
    
    DEX
    BNE Loop_screen_ram

    RTS

;---------------------------------------------------------------
; extern void waitForNoKey();
;---------------------------------------------------------------
_waitForNoKey:
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

;---------------------------------------------------------------
;   extern void __FASTCALL__ splitScreen (BYTE scanline);
;---------------------------------------------------------------
_splitScreen:
; Initialization
    LDA #%01111111
    STA $DC0D 	;"Switch off" interrupts signals from CIA-1
	AND $D011
    STA $D011 	; Clear most significant bit in VIC's raster register
	LDA #13*8
    STA $D012 ;	Set the raster line number where interrupt should occur
	
    LDA #<Irq
    STA $0314
    LDA #>Irq
    STA $0315 ;	Set the interrupt vector to point to interrupt service routine below
	LDA #%00000001
    STA $D01A ;	Enable raster interrupt signals from VIC
    RTS

Irq:
    LDA $D011
    AND #%10011111
    ORA #%10111111
    STA $D011 	; Select High Resolution, 320x200 for Text
	LDA $D016
    AND #%11011111
    STA $D016
    
    LDA #<Irq2 ; Load High Part of IRQ2 Address
    STA $0314
    LDA #>Irq2 ; Load Low Part of IRQ2 Address
    STA $0315 ;	Re-direct next interrupt to Irq2 service routine
	LDA #0
    STA $D012  ; Next interrupt to occur at raster line no. 0
	ASL $D019  ;	"Acknowledge" the interrupt by clearing the VIC's interrupt flag.
	JMP $EA31 ;	Jump to the beginning KERNAL's standard interrupt service routine. 

Irq2:
 	LDA $D011
    ; https://www.c64-wiki.com/wiki/Multicolor_Bitmap_Mode
    AND #%10011111
    ORA #%10111111
    STA $D011 	; Select multicolor screen mode
	LDA $D016
    ORA #%00010000
    STA $D016

    LDA #<Irq ; High Part of IRQ Address
    STA $0314  
    LDA #>Irq  ; Low Part of IRQ Address
    STA $0315 ;	Re-direct next interrupt back to Irq
	LDA #13*8
    STA $D012 	; Next interrupt to occur at raster line no. 104
	ASL $D019 ;	"Acknowledge" the interrupt by clearing the VIC's interrupt flag.
	JMP $EA81 ;	Jump to the final part of KERNAL's standard interrupt service routine

;---------------------------------------------------------------
;   extern void setRamLayout ();
;---------------------------------------------------------------
; 
;$02-$7f, $fa-$ff zeropage variables
;$0334(820d)-$bfff code and data -> 48KB RAM
;$BANK3: c000-$ffff video bank (graphics)  -> VIDEO MEMORY + ROM: 16384bytes

; VIC Can address up to 16Kbytes
; $DD00 = %xxxxxx11 -> bank0: $0000-$3fff
; $DD00 = %xxxxxx10 -> bank1: $4000-$7fff
; $DD00 = %xxxxxx01 -> bank2: $8000-$bfff
; $DD00 = %xxxxxx00 -> bank3: $c000-$ffff

_setRamLayout:
    LDA $DD00 
    AND #%11111100  ; Bank 3
    ; ORA #%000000xx ;<- your desired VIC bank value, see above
    STA $DD00
    ; https://sta.c64.org/cbm64mem.html
    ; https://codebase64.org/doku.php?id=base:vicii_memory_organizing
    ; $D018/53272/VIC+24:   Memory Control Register
    ;+----------+---------------------------------------------------+
    ;| Bits 7-4 |   Video Matrix Base Address (inside VIC)          |
    ;| Bit  3   |   Bitmap-Mode: Select Base Address (inside VIC)   |
    ;| Bits 3-1 |   Character Dot-Data Base Address (inside VIC)    |
    ;| Bit  0   |   Unused                                          |
    ;+----------+---------------------------------------------------+
    ; 1) SCREEN RAM / SCREEN MEMORY / VIDEO MATRIX -> 1000bytes -> 256x8
    ; 2) VIDEO BITMAP RAM/CHAR MEM in Text Mode  -> 160x200 -> 8000 bytes -> (40x8)x25
    ; 3) VIDEO COLOR/COLORMEM RAM  -> 1000bytes 
    ; i.e. 
    ; Bitmap data 0x2000 - 0x3F3E = 8000 bytes a copiar en RAM video-bitmap
    ; Charmem data 0x3F40 - 0x4327=1000 bytes a copiar en RAM de pantalla en 0x04000 (ScreenRAM)
    ; Colormem data 0x4328 - 0x470F = 1000bytes a copiar en RAM de color en 0xD800 (ColorRAM) fixed address
    ; Background data: 0x4710=1byte con el color de fondo
    ; Register$ D018
    ; In Bitmap Mode:
    ;   %0xx, 0: $0000-$1FFF, 0-8191.
    ;   %1xx, 4: $2000-$3FFF, 8192-16383.
   
    ; 2) VIDEO BITMAP RAM 
    ; The bits 0 to 3 used in TEXT mode to allocate the char mem.
    ;$D018 = %xxxx0xxx -> bitmap is at $0000 - $2000 (8192 rounded)
    ;$D018 = %xxxx1xxx -> bitmap is at $2000

    LDA 0
    ORA #%00000000 ; Video Bitmap from 0xC000 to 0xDFFF  (ABS RAM)

    ; 3) VIDEO COLOR/COLORMEM RAM -> FIXED VALUE
    ;    RAM de color 0xD800-0xDBE7 (1000 posiciones 40x25) -> Fija en memoria -> EL color de tinta de un caracter, esto no está en el Spectrum.
    ;   Indica el color de un caracter de 40x25

    ; 1) Bits #4-#7: Pointer to screen memory (bits #10-#13), relative to  VIC bank, memory address $DD00. Values:
    ; %0000, 0: $0000-$03FF, 0-1023.
    ; %0001, 1: $0400-$07FF, 1024-2047.
    ; %0010, 2: $0800-$0BFF, 2048-3071.
    ; %0011, 3: $0C00-$0FFF, 3072-4095.
    ; %0100, 4: $1000-$13FF, 4096-5119.
    ; %0101, 5: $1400-$17FF, 5120-6143.
    ; %0110, 6: $1800-$1BFF, 6144-7167.
    ; %0111, 7: $1C00-$1FFF, 7168-8191.
    ; %1000, 8: $2000-$23FF, 8192-9215. <--
    ; %1001, 9: $2400-$27FF, 9216-10239.
    ; %1010, 10: $2800-$2BFF, 10240-11263.
    ; %1011, 11: $2C00-$2FFF, 11264-12287.
    ; %1100, 12: $3000-$33FF, 12288-13311.
    ; %1101, 13: $3400-$37FF, 13312-14335.
    ; %1110, 14: $3800-$3BFF, 14336-15359.
    ; %1111, 15: $3C00-$3FFF, 15360-16383.
    ; Contenido de la memoria de bitmap:
    ;     %00: Se toma el color de fondo del registro $d021 (color de fondo 0).
    ; %01: Se toma el color de la RAM de pantalla (nibble alto). ScreenRAM
    ; %10: Se toma el color de la RAM de pantalla (nibble bajo). ScreenRAM.
    ; %11: Se toma el color de la RAM de color.

    ORA #%10000000 ; 1) SCREEN-RAM 0xE000 to 0xE3FF(ABS RAM), 0x2000 to 0x23FF in relative to VIC-ADDRESS 
    STA $D018
    RTS 
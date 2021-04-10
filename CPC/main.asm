;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:3: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:11: __endasm;
	ld	a, #0
	call	#0xBC0E
;main.c:13: for(nColor = 0; nColor < 255; nColor++)
	ld	c, #0x00
00102$:
;main.c:15: memset(0xC000, nColor, 0x3FFF);
	ld	b, c
	push	bc
	ld	hl, #0xc000
	ld	(hl), b
	ld	e, l
	ld	d, h
	inc	de
	ld	bc, #0x3ffe
	ldir
	pop	bc
;main.c:13: for(nColor = 0; nColor < 255; nColor++)
	inc	c
	ld	a, c
	sub	a, #0xff
	jr	C, 00102$
;main.c:20: __endasm;
	call	#0xBB06
;main.c:21: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)

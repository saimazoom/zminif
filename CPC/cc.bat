
del *.ihx 
del *.bin 
del *.asm

REM sdasz80 -o putchar_cpc.s

sdcc -mz80 --code-loc 0x0138 --data-loc 0 --no-std-crt0 crt0.rel ..\juego.c



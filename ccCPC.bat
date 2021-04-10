
del *.ihx 
del *.bin 
del *.asm
del *.rel 

REM sdasz80 -o putchar_cpc.s

sdasz80 -o .\libgfx\libgfx_cpc.asm

sdcc -mz80 --no-std-crt0 -DCPC -DENGLISH .\libgfx\libgfx.c 

sdcc -mz80 --no-std-crt0 -DCPC -DENGLISH juego.c 

sdcc -mz80 --no-std-crt0 -DCPC -DENGLISH parser.c 

sdcc -mz80 --code-loc 0x0138 --data-loc 0 --no-std-crt0 .\CPC\crt0.rel -DCPC -DENGLISH juego.rel parser.rel libgfx.rel .\libgfx\libgfx_cpc.rel




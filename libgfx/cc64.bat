del *.o
del *.sym
del *.map
del *.tap
del *.err


REM zcc --no-crt crt0_base.asm printlib.asm .\libgfx\libgfx.c parser.c juego_compressed.c -o parser.bin -vn -O3  -lzx7 -m -cleanup
REM copy parser.def parser_def.asm
REM appmake +zx -b parser.bin -o parser.tap --noloader --org 24200

cl65 -t c64 -D C64 -Or ./libgfx_c64.asm ./main.c -o libgfx.prg

dir *.prg



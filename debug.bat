
@echo Compile the tape and dsk files 
bas2tap loader.bas -a10
REM bin2tap ..\res\valle.scr -o screen.tap
REM copy /b loader.tap+screen.tap+parser.tap+p1.tap+p4.tap+p6.tap+p0.tap juego.tap
copy /b loader.tap+parser.tap juego.tap
REM ..\spectrum\Spectaculator.exe juego.tap
cd .\zesarux\ZEsarUX\
.\zesarux.exe ..\..\juego.tap --machine P3S --enable-remoteprotocol --enable-breakpoints
cd ..\..\
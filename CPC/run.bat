
hex2bin main.ihx

dir *.bin 

CPCDiskXP -File main.bin -AddAmsdosHeader 100 -AddToNewDsk main.dsk
 
D:\devel\Z80\WinAPE20B2\WinApe.exe D:\devel\z80\zminif\cpc\main.dsk /A:main.bin

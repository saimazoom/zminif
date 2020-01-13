// Demo for libgfx library for C64 
// V0.1

#include "libgfx.h"

#define BYTE unsigned char
#define WORD unsigned int


void main (void)
{
	setRamLayout (); // Funcion only for C64 	
	clearScreen (0); 
	splitScreen (13*8); // Install the split screen interrupt handler at the required scan-line
	clearScreen (0); 
	// Split screen: Top in multicolor (160x320) and bottom in highres color (320x200)
	// Carga una pantalla en memoria de vídeo
	print_string (0,13,"Pulsa una tecla.");
	//waitForAnyKey();
	//scrollArriba (0,0);
	//print_string (0,13,"Fin de la demo.");
	while(1);
}


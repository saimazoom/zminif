/*
 ZMiniIF para ordenadores de 8bit
 Basado en PAWS y NGPAWS-Beta 9 (Uto/Carlos Sanchez) http://www.ngpaws.com
 (c) 2016. Written by KMBR.
 v1.0

 License
-------
 Released under the the GPL v2 or later license.
*/

// Game flags available 64 to 255
// #define f.... xx
#define fTemp 64
#define fTemp2 65

// Game locations 1 to 250 are available
#define lPuente 1

// For containers and supporters the location ID number shall match the object ID number. 

//#define l_mesa 34	// La mesa no es un algo que lleve el jugador pero es un objeto de tipo contenedor.


// Definitions for objects, 1 to 255 available
//; Objetos
#define oCaja 1

// -------------------------------------------------------------------------------------------
// ----------------------------------- VOCABULARIO ------------------------------------------- 
// -------------------------------------------------------------------------------------------
// Definiciones de vocabulario
// Nombres de 1 a 20 reservados
#define nNorte  1
#define nSur 	2
#define nEste	3
#define nOeste  4
#define nNoreste 5
#define nNorOeste 6
#define nSurEste 7
#define nSurOeste 8
#define nArriba 9
#define nSubir 9
#define nAbajo 10
#define nBajar 10
#define nEntrar 11
#define nEntra 11
#define nAdentro 11
#define nDentro 11
#define nSalir 12
#define nSal 12 
#define nAfuera 12
#define nInventario 14
#define nPuntos 15
#define nTurnos 16
#define nTodo 20
 

// Nombres < 20 se pueden usar como verbos
// Nombres por debajo de 50 como nombre propio, no admite lo,las...

// ------------------------------------------------
// Nombres de 21 a 255 disponibles
// ------------------------------------------------

// Verbos que funcionan como nombres < 20

// Verbos
// Some notes about vocabulary:
//    Words with same number but different type are not considered synomyms.
//    Nouns under number 20 are considered "convertible", what means they can be converted to verbs if a verb is missing (so "north" does the same than "go north").
//    Verbs undernumber 14 are considered "direction verbs", so if you have not added a specific response for a player order like "north" then ngPAWS will try to go in that direction. That doesn't happen with verbs 14 and above.
//    You can leave gaps when adding vocabulary, that is, is not required that vocabulary numbers are consecutive.

// Names and verbs uses different tables. Verbs below 20 are reserved for directions
// Same definitions as for names below 20, just for convenience
// Declarations are in the table for names and are used as convertibles
#define vNorte  1
#define vSur 	2
#define vEste	3
#define vOeste  4
#define vNoreste 5
#define vNorOeste 6
#define vSurEste 7
#define vSurOeste 8
#define vSubir 0
#define vArriba 9
#define vAbajo 10
#define vBajar 10
#define vEntrar 11
#define vEntra 11
#define vAdentro 11
#define vDentro 11
#define vSalir 12
#define vSal 12 
#define vAfuera 12

// Verbs of normal use
#define vCoger 20
#define vDejar 21
#define vSacar 22
#define vQuitar 23
#define vMeter 74
#define vMirar 24
#define vFin 25
#define vMirar 24
#define vSave 26
#define vLoad  27
#define vRamsave 28
#define vRamload 29

#define vExaminar   30      
#define vDecir  31      
#define vMandar   31      
#define vPreguntar 31      
#define vHablar  31      
#define vPulsa   32      
#define vPulsar   32      
#define vEmpujar   32      
#define vApretar   32      
#define vPresionar   32      
#define vAbrir   33      
#define vAbre    33      
#define vCierr   34      
#define vCerrar  34      
#define vTirar   35      
#define vTeclear   36
#define vTeclea 36      
#define vEscribe   37
#define vEscribir 37      
#define vEnciede   38      
#define vEncender   38      
#define vApagar   39      
#define vIntroduce 40    
#define vIr      41      
#define vVe      41      
#define vVes     41      
#define vVolver  41      
#define vRegresa 41      
#define vCamina  41      
#define vOler    42      
#define vHuele   42      
#define vTocar   43      
#define vPalpar  43      
#define vToca    43      
#define vEscuchar 44     
#define vOir      44     
#define vOye      44     
#define vSentarse 45     
#define vSientate 45     
#define vSaltar   46     
#define vMea      47     
#define vCaga     47     
#define vMear     47     
#define vCagar    47     
#define vChupar   48     
#define vLamer    48     
#define vCantar   49     
#define vPaper    50     
#define vInk      51     
#define vTest     52     
#define vT        52
#define vLanzar   53
#define vGirar    54
#define vEsperar    55
#define vLeer 56
#define vAtacar 57
#define vPoner 58
#define vRomper 59 
#define vVestir 60
#define vDar 61
#define vPuntos 62
#define vTurnos 63
#define vUsar 64 

// Adverbios
#define adRapidamente 2
#define adLentamente 3
#define adSilenciosamente 4
#define adRuidosamente 5
#define adCuidadosamente 6
#define adTranquilamente 7

#define pA 2
#define pDe 3
#define pDentro 4
#define pDesde 5
#define pHacia 6
#define pTras 7
#define pBajo 8
#define pCon 9
#define pPara 10
#define pPor 11
#define pExcepto 12
#define pFuera 13
#define pDelante 14
#define pEntre 15
#define pEncima 16

// Adjetivos

#define aPequeno 2
#define aGrande  3
#define aViejo   4
#define aVieja   4
#define aNuevo   5
#define aNueva   5
#define aDuro   6
#define aDura    6
#define aBlando  7
#define aCorto   8
#define aCorta   8
#define aLargo   9
#define aLarga   9
#define aAzul    10    
#define aBlanco  11    
#define aRojo    12    
#define aVerde   13    
#define aNegro   14    
#define aTermico 15    
#define aFrio    16    
#define aCaliente 16   
#define aCalor   16    
#define aAmarillo 17   
 
// Funciones adicionales del juego


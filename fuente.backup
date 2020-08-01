
#include <string.h>
#include "parser_defs.h"
#include "parser.h"

// Flags del Juego
#include "juego_flags.h"

// Librería gráfica
#include "./libgfx/libgfx.h"

// Compiler options for ZX Spectrum
#ifndef C64
	/* Allocate space for the stack */
	#pragma output STACKPTR=24200
	#pragma -reqpag=0
	#pragma -no-expandz88
	#pragma output CRT_ENABLE_CLOSE = 0    // do not close open files on exit (at this time this has no effect)
	#pragma output CLIB_EXIT_STACK_SIZE = 0   // get rid of the exit stack (no functions can be registered with atexit() )
	#pragma output CLIB_MALLOC_HEAP_SIZE = 0  // malloc's heap will not exist
	#pragma output CLIB_STDIO_HEAP_SIZE = 0  // stdio's heap will not exist (you will not be able to open files)
	#pragma output CLIB_FOPEN_MAX = -1  // don't even create the open files list
	#pragma output CRT_ENABLE_RESTART = 1
#endif 

// Compiler options for C64
#ifdef C64
#endif 

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Código local
// Si necesitamos código en páginas de memoria hay que compilarlas como .bin y añadirlas aquí como extern
// Se llaman desde el código usando: setRAMpage (n) y llamando a la función, al terminar hay que volver siempre a la página 0

char respuestas();
char respuestas_post();
char proceso1();
char proceso1_post();
char proceso2();
char proceso2_post();

// Variables que necesitamos del parser...
// Se pueden declarar más tablas de flags para el juego pero el parser
// sólo trabaja con esta. 
extern unsigned char flags[255]; // Flags 60...250 Disponibles para el usuario
extern unsigned char playerInput[80];
extern unsigned char playerWord[25];
extern BYTE gWord_number; // Marker for current word, 1st word is 1
extern BYTE gChar_number; // Marker for current char, 1st char is 0

// Tabla de imágenes del juego
extern unsigned char L01_img[];

// Include binary files for the adventure
#ifndef C64
	#asm
	_L01_img:
 defb 0xf6,0x07,0x07,0x07,0xf8,0x50,0xf8,0x50,0x07,0x07,0x07,0xf6,0x08,0x2a,0x40,0x38,0xf7,0xa7,0xf6,0x47,0x36,0x4f,0x29,0xfa,0x1f,0x9b,0xf7,0xd5,0xd1,0xf6,0x25,0x91,0x2d,0x8e,0x44,0x81,0x4f,0x7b,0xf6,0x1f,0x9b,0x1f,0xa7,0xf7,0x21,0xf6,0x20,0xa9,0x1e,0xb1,0xf7,0x32,0x22,0xf6,0x22,0xb6,0x21,0xbe,0x22,0xc6,0xf7,0x23,0xf6,0x25,0xc8,0x2e,0xc8,0x43,0xbb,0xf7,0xb5,0xf6,0x48,0xb8,0x50,0xb5,0xfa,0x1d,0xb1,0xf7,0x2a
 defb 0xf6,0x1b,0xb3,0x1b,0xc4,0xf7,0x11,0x21,0x12,0x03,0xf6,0x09,0x2b,0x10,0xf0,0xf7,0x79,0xf6,0x11,0xef,0x2c,0xe6,0xf7,0x03,0x45,0x02,0xf6,0x36,0xea,0x30,0xc8,0xf6,0x41,0xf7,0x36,0xc4,0xf6,0x43,0xf8,0x49,0xde,0x42,0xbd,0xfa,0x49,0xe0,0xf7,0xb6,0xf6,0x2f,0xe5,0x2a,0xc8,0xfa,0x25,0x92,0xf7,0x61,0x43,0x16,0xf6,0x2f,0x9d,0x38,0x9c,0x49,0x94,0xf7,0xe6,0xc9,0xdc,0xcd,0xfa,0x2d,0x8e,0xf7,0x34,0x44,0x64,0x21
 defb 0x61,0x69,0xfa,0x34,0xbc,0xf7,0x30,0x49,0x3b,0xf6,0x2d,0xb8,0x2f,0xa9,0x39,0xac,0xf7,0x14,0x43,0x5a,0x5a,0x1b,0x0c,0xf6,0x35,0xbc,0x2d,0xb8,0xfa,0x30,0xa9,0xf7,0x99,0xf6,0x2f,0xa8,0x3a,0xa9,0xf7,0x04,0x42,0x30,0x79,0x3a,0xfa,0x44,0xb4,0xf7,0xf1,0xf6,0x45,0xad,0x4d,0xab,0xf7,0xa2,0xfa,0x44,0xb5,0xf7,0xa6,0xb5,0xfa,0x45,0xa7,0xf7,0xe0,0x94,0xb3,0xc3,0xfa,0x45,0xa8,0xf7,0xb6,0xb4,0xf6,0x45,0xa1,0x4e
 defb 0x9a,0xf6,0x0e,0x2c,0x11,0x85,0x1f,0x84,0x1f,0x61,0x15,0x85,0xf6,0x11,0x82,0x1e,0x57,0x1f,0x38,0xf7,0xf0,0x16,0xf6,0x25,0x32,0x21,0x83,0xf7,0x19,0xf6,0x0d,0x89,0x24,0x87,0xf6,0x0e,0xa2,0x1f,0x9b,0xf6,0x27,0x91,0x27,0x88,0xf6,0x2c,0x8d,0x24,0x85,0x28,0x33,0xf6,0x40,0x39,0x36,0x88,0xf6,0x3c,0x85,0x47,0x36,0xfa,0x4a,0x31,0xf7,0x35,0xf6,0x29,0x51,0x39,0x61,0xf6,0x28,0x71,0x35,0x7e,0xf6,0x2c,0x5a,0x38
 defb 0x66,0xfa,0x2e,0x5f,0xf7,0xc0,0x01,0x40,0xf6,0x2d,0x52,0x3a,0x40,0xf7,0xa1,0xa1,0xa0,0x99,0x3b,0x53,0xf6,0x3b,0x41,0x3b,0x4e,0xf7,0x09,0x20,0x19,0x20,0x19,0x10,0x2b,0x0a,0xaa,0x9a,0xda,0xf6,0x2d,0x4f,0x2d,0x42,0xf7,0x01,0xa0,0xa1,0xb1,0xa3,0x02,0x33,0xf6,0x30,0x3d,0x3b,0x47,0xf6,0x2e,0x43,0x39,0x4d,0xf6,0x2e,0x4a,0x37,0x54,0xfa,0x29,0x6a,0xf7,0xe1,0xf6,0x2a,0x64,0x37,0x6e,0x36,0x77,0xf7,0xbd,0xf6
 defb 0x31,0x74,0x33,0x67,0xf7,0xcc,0xf6,0x2f,0x63,0x2d,0x71,0xf7,0x33,0xf6,0x29,0x6b,0x36,0x73,0xfa,0x29,0x76,0x29,0x77,0x2a,0x78,0x2b,0x77,0x2c,0x78,0x2c,0x79,0xfa,0x29,0x7a,0xf7,0x23,0xfa,0x29,0x7d,0xf7,0x33,0xfa,0x29,0x81,0xf7,0x21,0x10,0x91,0xa0,0xfa,0x2f,0x7c,0xf7,0x20,0xfa,0x31,0x7d,0xf7,0x20,0xfa,0x33,0x7f,0xf7,0x30,0x01,0xa0,0xfa,0x31,0x81,0x34,0x84,0x33,0x86,0x2f,0x87,0x2e,0x84,0xfa,0x2f,0x83
 defb 0xf7,0x20,0xfa,0x2f,0x89,0xf7,0x10,0xfa,0x31,0x85,0xf7,0x20,0xFF
	#endasm
#endif 

// id, page, memory pointer
// Terminated with 0
img_t imagenes_t [] = {
    { 0,0,0}
    };

// Tabla de regiones
// Regiones del juego...
//unsigned char region_exterior [] = { 4,6,7,0 };
//unsigned char region_entrada [] = { 13,10,17,14,9,0 };
//unsigned char region_superior [] = { 3,8,23,26,27,0 };
//unsigned char region_inferior [] = { 12,15,19,2,5,11,21,16,19,18,27,28,25,24,30,1,31,20,0 };

// Tabla de localidades de la aventura
// 250 to 255 reservadas
// última localidad como ID 0 

loc_t localidades_t [] =
{
    {"","",0, FALSE, 0x00000000}
};

// Tabla de conexiones...
// Se usan los ID de localidad para idenfiticar las conexiones
cnx_t conexiones_t [] =
{
// LOC | AL_N | AL_S | AL_E | AL_O | AL_NE | AL_NO | AL_SE | AL_SO | ARRIB | ABAJO | ENTRAR | SALIR 
	{0,{	0,		0,		0,		0,		0,		0,		0,		0,		0,		0,0,0}}
	};

// Tabla de mensajes de la aventura
// 1 to 255
// Text, message_id (1 to 255)
// Messages can be printed directly in the code just calling the function writeText (unsigned char *string)
// More than one message table can be defined
token_t mensajes_t [] =
{
	{"",0},
};

// Messages used by the parser. 
token_t mensajesSistema_t [] =
{
	{"No puedo ver nada, está muy oscuro.^",0},
	{"También hay ",1},
	{"Escribe tus órdenes aquí",2},
	{"",3},
	{"",4},
	{"",5},
	{"¿Cómo? Por favor prueba con otras palabras.^",6},
	{"No puedo ir en esa dirección.^",7},
	{"¿Perdón?^",8},
	{"Llevo ",9},
	{"(puesto)",10},
	{"ningún objeto.",11},
	{"¿Seguro? ",12},
	{"¿Juegas de nuevo? ",13},
	{"Adiós...",14},
	{"OK^",15},
	{"[...]",16},
	{"Has realizado ",17},
	{" turno",18},
	{"s",19},
	{".^ ",20},
	{"La puntuación es de ",21},
	{" punto",22},
	{"No llevo puesto eso.^",23},
	{"No puedo, ya llevo eso puesto.^",24},
	{"Ya tengo ",25},
	{"No veo eso por aquí.^",26},
	{"No puedo llevar más cosas.^",27},
	{"No tengo eso.^",28},
	{"Pero si ya llevo puesto",29},
	{"S",30},
	{"N",31},
	{"Más...",32},
	{"> ",33},
	{"",34},
	{"El tiempo pasa...^",35},
	{"Ahora tengo ",36},
	{"Me pongo ",37},
	{"Me quito ",38},
	{"Dejo ",39},
	{"No puedo ponerme ",40},
	{"No puedo quitarme ",41},
	{"¡Tengo demasiadas cosas en las manos!",42},
	{"Desgraciadamente pesa demasiado.",43},
	{"Meto",44},
	{"Ahora no está en ",45},
	{",",46},
	{" y ",47},
	{".",48},
	{"No tengo ",49},
	{"No llevo puesto ",50},
	{"",51},
	{"Eso no está en ",52},
	{"ningún objeto",53},
	{"Fichero no encontrado.^",54},
	{"Fichero corrupto.^",55},
	{"Error de E/S. Fichero no grabado.^",56},
	{"Directorio lleno.^",57},
	{"Disco lleno.",58},
	{"Nombre de fichero no válido.^",59},
	{"Nombre del fichero: ",60},
	{"",61},
	{"¿Perdón? Por favor prueba con otras palabras.^",62},
	{"Aquí ",SYSMESS_NPCLISTSTART},
	{"está ",SYSMESS_NPCLISTCONTINUE},
	{"están",SYSMESS_NPCLISTCONTINUE_PLURAL},
    {"Dentro hay ",SYSMESS_INSIDE_YOUCANSEE},
    {"Encima hay ",SYSMESS_OVER_YOUCANSEE},
    {"",68},
	{"No es algo que pueda quitarme.^",69},
	{"Pongo ",SYSMESS_YOUPUTOBJECTON },
    {"No es algo que pueda cogerse.^",SYSMESS_YOUCANNOTTAKE},
	{"No parece que pueda moverse.^", SYSMESS_CANNOTMOVE},
	{"Llevo las manos vacías.^", SYSMESS_CARRYNOTHING},
	{"",0}	
};

// Tablas de vocabulario
// Nombre propios, sustantivos...
// último elemento debe ser 0
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


token_t nombres_t [] =
{
    {"norte",           nNorte},  //0
	{"n",               nNorte},
	{"sur",             nSur},    //2
	{"s",               nSur},
	{"este",            nEste},   //4
	{"e",               nEste},
	{"oeste",           nOeste},  //6
	{"o",               nOeste},
	{"noreste",         nNoreste}, //8
	{"w",               nOeste},
	{"noroeste",        nNorOeste}, //10
	{"ne",              nNoreste},
	{"sureste",         nSurEste},	 //12
	{"se",              nSurEste},
	{"suroeste",        nSurOeste},  // 14
    {"suroe",           nSurOeste},
    {"arriba",          nArriba},   // 16
	{"up",              nNorOeste},
	{"abajo",           nAbajo},   // 18
	{"no",              nNorOeste},
	{"entrar",			nEntrar}, // 20
	{"entra",			nEntrar},
	{"salir",			nSalir}, // 22
	{"sal",				nSalir},
	{"ascie",	nArriba},
	{"subet",	nArriba},
	{"sube",   	nArriba},
	{"bajar",  	nAbajo},
	{"baja",    nAbajo},
	{"desce",	nAbajo},
	{"desci",  	nAbajo},
	{"bajat",  	nAbajo},
	{"entra",	nEntrar},
	{"enter",	nEntrar},
	{"intro",	nEntrar},
	{"adent",   nEntrar},
	{"dentr",   nEntrar},
	{"inter",	nEntrar},
	{"salir",	nSalir},
	{"sal",		nSalir},
	{"exit",	nSalir},
	{"fuera",   nSalir},
	{"afuer",   nSalir},
    {"i",               nInventario},
    {"inven",           nInventario},
	{"inv",         nInventario },
	{"punto",       nPuntos},
	{"puntu",       nPuntos},
	{"conta",       nPuntos},
	{"turno",       nTurnos},    
	// Names < 20 can be used as verbs
	// Nombres para el Vocabulario del juego,
	{"",0}
};

// Verbos
// VOCABULARIO
// Verbos < 20 son iguales a nombres < 20
token_t verbos_t [] =
{
    {"coger",	vCoger},
    {"coge",	vCoger},
    {"tomar",	vCoger},
    {"toma",	vCoger},
    {"take",	vCoger},
    {"dejar",	vDejar},
    {"deja",	vDejar},
    {"solta",	vDejar},
    {"suelt",	vDejar},
    {"drop",	vDejar},
    {"quita",	vQuitar},
    {"sacat",	vQuitar},
    {"sacar",	vSacar},
    {"desvi",	vQuitar},
    {"desve",	vQuitar},
//    {"SENTA",	23},
//    {"SENTA",	23},
//    {"SENTA",	23},
//    {"SIENT",	23},
    {"l",		vMirar},
    {"look",	vMirar},
    {"m",		vMirar},
    {"mirar",	vMirar},
    {"mira",	24},
    {"quit",	vFin},
    {"fin",		vFin},
    {"save",	vSave},
    {"graba",	vSave},
    {"salva",	vSave},
	{"guard",	vSave},
	{"load",	vLoad},
	{"carga",	vLoad},
	{"ramsa",	vRamsave},
	{"graba",	vSave},
	{"ramlo",	vRamload},
	{"carga",	vLoad},
	{"x",       vExaminar},
	{"exami",	vExaminar},
	{"ex",		vExaminar},
	{"inspe",	vExaminar},
	{"obser",	vExaminar},
	{"decir", 	vDecir},
	{"di",		vDecir},
	{"habla", 	vDecir},
	{"respo",  	vDecir},
	{"manda",	vDecir},
	{"lanza",	vLanzar},
	{"tira", 	vLanzar},
	{"tirar",	vLanzar},
	{"arroj",	vLanzar},
	{"empuj",	vEmpujar},
	{"apret",	vEmpujar},
	{"pulsa",	vPulsar},
	/*
	{"AYUDA",	34},
	{"HELP",	34},
	*/
	{"girar",  	vGirar},
	{"gira",    vGirar},
	{"rota",	vGirar},
	{"rotar",	vGirar},
	/*
	{"VOLTE",	35},
	{"MOSTR",	36},
	{"MUEST",	36},
	{"ENSEÑ", 	36},
	*/
	{"escuc", 	vEscuchar},
	{"oir",		vEscuchar},
	{"oye",		vEscuchar},
	/*
	{"COMER",	38},
	{"COME",	38},
	{"COMET",	38},
	{"TRAGA",	38},
	{"INGIE",	38},
	{"INGER",	38},
	{"MASTI",	38},
	{"BEBER",	39},
	{"BEBE",	39},
	{"BEBET",	39},
	{"BEBER",	39},
	*/
	{"tocar",	vTocar},
	{"toca",	vTocar},
	{"acari",	vTocar},
	{"palpa",	vTocar},
	/*
	{"SALID",	41},
	{"EXITS",   41},
	{"X",		41},
	*/
	{"oler",	vOler},
	{"huele",	vOler},
	{"olfat",	vOler},
	{"husme", 	vOler},
	{"esper",	vEsperar},
	{"z",		vEsperar},
	{"canta",	vCantar},
	{"salta", 	vSaltar},
	{"brinc",	vSaltar},
	{"ataca",	vAtacar},
	{"agred",	vAtacar},
	{"matar",	vAtacar},
	{"mata",	vAtacar},
	{"asesi",	vAtacar},
	{"estra",	vAtacar},
	{"patea",	vAtacar},
	{"pisot",	vAtacar},
	{"tortu",	vAtacar},
	{"noque",	vAtacar},
	{"lucha",	vAtacar},
/*
	{"ORINA",	47},
	{"MEAR",	47},
	{"MEA",		47},
	{"MEATE",	47},
	{"MEARS",	47},
	{"MEART",	47},
	{"DEFEC",	47},
	{"CAGAR",	47},
	{"ERUCT",	47},
	{"VOMIT",	47},
	{"ESCUP",	48},
	{"agita",	49},
	{"menea",	49},
	{"sacud",	49},
	{"remov",	49},
	{"remue",	49},
	{"balan",	49},
	{"COLUM",	50},
	{"EXCAV",	51},
	{"CAVAR",	51},
	{"CAVA",	51},
	{"DESEN",	51},
	{"ENTER",	51},
	{"ENTIE",	51},
	{"CORTA",	52},
	{"RASGA",	52},
	{"LEVAN",	53},
	{"atar",	54},
	{"ata",		54},
	{"enlaz",	54},
	{"anuda",	54},
	{"LLENA",	55},
	{"RELLE",	55},
	{"NADAR",	56},
	{"NADA",	56},
	{"TREPA",	57},
	{"ESCAL",	57},
	{"RETOR",	58},
	{"RETUE",	58},
	{"TORCE",	58},
	{"TUERC",	58},
	{"REZAR",	59},
	{"REZA",	59},
	{"ORAR",	59},
	{"ORA",		59},
	{"PENSA",	60},
	{"PIENS",	60},
	{"DORMI",	61},
	{"DUERM",	61},
	{"DORMI",	61},
	{"DESCA",	61},
	{"RONCA",	61},
	{"ECHAT",	61},
	{"ECHAR",	61},
	{"BESAR",	62},
	{"BESA",	62},
	{"CHUPA",	63},
	{"LAMER",	63},
	{"LAME",	63},
	{"PROBA",	63},
	{"PRUEB",	63},
	{"PALAD",	63},
	{"SABOR",	63},
	*/
	{"abri",	vAbrir},
	{"abre",	vAbrir},
    {"abrir",   vAbrir},
	{"cerrar",	vCerrar},
	{"cierra",	vCerrar},
//	{"quema",	66},
	{"encen",	vEncender},
	{"encie",	vEncender},
	{"incen",	vEncender},
	{"prend",	vEncender},
	{"apaga",	vApagar},
	{"extin",	vApagar},
	{"sofoc",	vApagar},
//	{"trans",	68},
	{"rompe",	vRomper},
	{"parti",	vRomper},
	{"parte",	vRomper},
	{"quebr",	vRomper},
	{"quieb",	vRomper},
	{"destr",	vRomper},
//	{"versi",	70},
	{"poner",	vPoner},
	{"pon",		vPoner},
	{"ponte",	vPoner},
	{"ponse",	vPoner},
	{"pone",	vPoner},
	{"viste",	vVestir},
	{"vesti",	vVestir},
	{"golpe",	vAtacar},
	{"dar",		vDar},
	{"da",		vDar},
	{"dase",	vDar},
	{"darse",	vDar},
	{"darte",	vDar},
	{"dale",	vDar},
	{"darle",	vDar},
	{"ofrec",	vDar},
//	{"regal",	73},
	{"meter",	vMeter},
	{"mete", 	vMeter},
	{"intro",	vMeter},
	{"inser",	vMeter},
	{"echa",	vMeter},
	{"echar",	vMeter},
/*
	{"LLAMA",	76},
	{"GRITA",	77},
	{"CHILL",	77},
	{"REGIS",	78},
	{"REBUS",	78},
	{"ARRAN",	79},
	{"ESTIR",	79},
	{"USAR",	80},
	{"USA",		80},
	{"UTILI",	80},
	{"MATAT",	81},
	{"MATAR",	81},
	{"SUICI",	81},
	{"XYZZY",	82},
	{"ARRAS",	83},
	{"REGIS",	84},
	{"MIRAT",	85},
	{"MIRAR",	85},
	{"EXAMI",	85},
	{"VACIA",	86},
	{"VERTE",	86},
	{"VERTI",	86},  // Término erróneo, pero ampliamente extendido
	{"VIERT",	86},
	{"DESPI",	87},
	{"DESPE",	87},
	{"ESPAB",	87},
	{"LAVAT",	88},
	{"LAVAR",	88},
	{"LAVAR",	88},
	{"LIMPI",	88},
	{"INSUL",	89},
	{"INCRE",	89},
	*/
	{"ir",		vIr},
	{"ve",		vIr},
	{"vete",	vIr},
	{"irte",	vIr},
	{"irse",	vIr},
	{"camin",	vIr},
	{"anda",	vIr},
	{"andar",	vIr},
	{"corre",	vIr},
	{"huir",	vIr},
	{"huye",	vIr},
	{"dirig",	vIr},
	/*
	{"ESCON",	91},
	{"OCULT",	91},
	{"ESCON",	91},
	{"OCULTA",	91},
	{"ESCON",	92},
	{"OCULT",	92},
	{"LLORA",	93},
	{"LLORI",	93},
	{"SOLLO",	93},
	{"RECOR",	94},
	{"ACORD",	94},
	{"ACUER",	94},
	{"SOPLA",	95},
	{"DOBLA",	96},
	{"DESDO",	97},
	{"desat",	98},
	{"UNIR",	99},
	{"UNE",		99},
	{"JUNTA",	99},
	{"ACERC",	99},
	{"ARRIM",	99},
	{"APROX",	99},
	{"REUNE",	99},
	{"REUNI",	99},
	{"SEPAR",	100},
	{"LIMPI",	101},
	{"FROTA",	101},
	{"LAVAR",	101},
	{"LAVA",	101},
	{"PULE",	101},
	{"PULIR",	101},
	{"FREGA",	101},
	{"FRIEG",	101},
	{"RASCA",	102},
	{"RASPA",	102},
	{"CONEC",	103},
	{"ACTIV",	103},
	{"DESCO",	104},
	{"DESAC",	104},
	{"ABRAZ",	105},
	{"COMPRA",	106},	{"ADQUI",	106},
	{"CONSU",	107},
	{"PREGU",	108},
	*/
	{"lee",		vLeer},
	{"leer",	vLeer},
	{"leers",	vLeer},
	{"leert",	vLeer},
	{"leete",	vLeer},
	{"mover",	vEmpujar},
	{"mueve",	vEmpujar},
	{"despl",	vEmpujar},
/*
	{"APRET",	111},
	{"APRIE",	111},
	{"ESTRU",	111},
	{"BAILA",	112},
	{"DANZA",	112},
	{"SALUD",	113},
	{"LEVAN",	114},
	{"ESPAN",	115},
	{"SECA",	116},
	{"SECAR",	116},
	{"COLOC",	117},
	{"MACHA",	118},
	{"asust", 120},
	{"moja",121},
	{"mojar",121},
	{"empap",121},
	{"impre",121},
*/
	{"tecle", vTeclear},
	{"escri", vEscribir},
	{"punto", vPuntos},
	{"score", vPuntos},
	{"turno", vTurnos},
	{"usa", vUsar},
	{"usar", vUsar},
	{"activ", vUsar},
    {"",0}
};

// Tabla de adjetivos
token_t adjetivos_t [] =
{
	{"peque", aPequeno},
	{"grand", aGrande},
	{"viejo", aViejo},
	{"vieja", aVieja},
	{"nuevo", aNuevo},
	{"nueva", aNueva},
	{"duro", aDuro},
	{"dura", aDura},
	{"bland", aBlando},
	{"corto", aCorto},
	{"corta", aCorta},
	{"largo", aLargo},
	{"larga", aLarga},
	{"azul", aAzul},
	{"verde", aVerde},
	{"negro", aNegro},
	{"rojo", aRojo},
	{"verde", aVerde},
	{"amari", aAmarillo},
	{"termi", aTermico},
	{"frio", aFrio},
	{"calie", aCaliente},
	{"",0}
};


// Tabla de objetos
// No existe la limitación de PAWS donde el objeto 1 siemmpre es la fuente de luz 
// La luz en ngpaws se calcula en función del atributo de los objetos presentes en la localidad, puestos y llevados.
// Localidades de sistema: LOCATION_WORN,LOCATION_CARRIED, LOCATION_NONCREATED, LOCATION_HERE, CARRIED, HERE, NONCREATED, WORN

// Atributos con OR: aLight, aWear, aContainer, aNPC, aConcealed, aEdible, aDrinkable, aEnterable, aFemale, aLockable, aLocked, aMale, aNeuter, aOpenable, aOpen, aPluralName, aTransparent, aScenary, aSupporter, aSwitchable, aOn, aStatic, aExamined, aTaken, aDropped, aVisited, aTalked, aWore, aEaten, aPropio, aDeterminado

obj_t objetos_t[]=
{
    // ID, LOC, NOMBRE, NOMBREID, ADJID, PESO, ATRIBUTOS
    {0,0,"",                EMPTY_WORD,EMPTY_WORD,            0,0x0000}
}; // Tabla de objetos de la aventura


// ----------------------------------------------------------------
// Tabla de respuestas
// ----------------------------------------------------------------
char respuestas()
{
 NOTDONE;
// ================= LIBRERíA BASE FINAL=======================================
}

// ----------------------------------------------------------
// Tabla de respuestas-post
// Se llama después de ejecutar el proceso de respuestas
// ----------------------------------------------------------

char respuestas_post()
{
 //setRAMPage(0);
 // respuestas_post_pagina0();

// ------------------- LIBRERÍA BASE -----------------------------------
 // Comandos de dirección...
 // writeText ("Respuestas Post: %u %u^", flags[fverb], flags[fnoun1]);
 // Movimiento entre localidades...
    BYTE i;
    BYTE loc_temp;

	if (fverbo==vFin) { ACCend(); DONE; }

	if (fverbo==vQuitar) {  ACCautor(); DONE; }
	if (fverbo==vPoner) { ACCautow(); DONE; }
	
	// En este punto el examinar no ha sido cubierto por las respuestas
    if (fverbo==vExaminar)
    {
        if (findMatchingObject(get_loc_pos(loc_here()))!=EMPTY_OBJECT)
            writeText ("Deberías coger eso antes.^");
        else
			writeText ("No ves eso por aquí.^");
		DONE;
    }

    if(fverbo==nInventario)
    {
        ACCinven();
        ACCnewline();
        DONE;
    }

    if (fverbo==vCoger)  { ACCautog(); DONE; }

    if (fverbo==vDejar) { ACCautod(); DONE; }

    if (fverbo==vMeter) { DONE; }

    if (fverbo==vSacar) { DONE; }

    // Si es un nombre/verbo de conexión...
	
    if (flags[fverb]>0 && flags[fverb]<NUM_CONNECTION_VERBS)
        {
            i=0;
            loc_temp = get_loc_pos (flags[flocation]); // La posicion en el array no tiene porque coincidir con su id
			i = conexiones_t[loc_temp].con[flags[fverb]-1];
	        if (i>0)
            {
                ACCgoto(i);
                DONE;
            }
            else {
                ACCsysmess(SYSMESS_WRONGDIRECTION);
                NOTDONE;
            }

        }
	
    // Comandos típicos...
    if (fverbo==vMirar)
    {
        ACCgoto( flags[flocation]);
        DONE;
    }
	if (fverbo==vEmpujar || fverbo==vTirar)
	{
		ACCsysmess (SYSMESS_CANNOTMOVE);
		DONE;
	}

	if (fverbo==vSave || fverbo==vRamsave || fverbo==vLoad || fverbo==vRamload)
	{
		//ACCsave();
		ACCwriteln ("No necesitas cargar o salvar en este viaje -dice el ordenador");
		DONE;
	}

	if (fverbo==vPuntos) { ACCscore(); DONE; }
	if (fverbo==vTurnos) { ACCturns(); DONE; }
	if (fverbo==vEsperar) { writeSysMessage (35); DONE; }
	if (fverbo==vTocar || fverbo==vOler) { ACCmessage (56); DONE; }
	// Si ninguna acción es válida...
    ACCsysmess(SYSMESS_IDONTUNDERSTAND);
    newLine();
	NOTDONE;
}

char proceso1() // Antes de la descripción de la localidad...
{
	// Oculta el dibujado
	defineTextWindow (1,1,30,10); 
	clearTextWindow(INK_BLACK | PAPER_BLACK , FALSE);
	
	// Muestra la pantalla..
//	ACCpicture(flags[flocation]);
//	defineTextWindow (0,11,32,14); // Recupera la pantalla de texto 
	// Cálculo de luz
	flags[flight]=1; // No está oscuro
	NOTDONE;
}

char proceso1_post() // Después de la descripción
{
	NOTDONE;
}

char proceso2() // Después de cada turno, haya tenido o no éxito la entrada en la tabla de respuestas
{
	NOTDONE;
}

// ------------------------------------------------------------
// Bucle principal, menú del juego
// ------------------------------------------------------------

void main (void)
{
	// Inicializar variables
	clearScreen(INK_BLACK | PAPER_WHITE);
	initParser ();                // Inicializa el parser y la pantalla
	
	//defineTextWindow (1,1,30,10); 
	//clearTextWindow(INK_BLACK | PAPER_YELLOW , FALSE);
	
	//drawLine (1,1,2,191);
	paint_pic (L01_img);
	

// Añadir menú de juego
	defineTextWindow (0,11,32,14); // Pantalla reducida en 128Kb, Gráficos + Texto
	flags[LOCATION_MAX] = 8; // Número más alto de localidad
	ACCability(10,20); // 10 objetos, 20 piedras
	while(1)
	{

	}
	//ACCgoto(lPuente); // Localidad inicial, en el puente de mando
	//ParserLoop (); // Pone en marcha el bucle principal
	// Parser gets out of the parserloop when the player ENDS the game 	
	
	// -------------------------------------------------
	// The player wants to abandon the game
	writeSysMessage(SYSMESS_PLAYAGAIN);
	flags[fTemp] = getKey();
	// Restart
	if (flags[fTemp]=='y' || flags[fTemp]=='s' || flags[fTemp]=='S' || flags[fTemp]=='Y')
	{
		main();
	}
	
	// To the void...
#ifndef C64
	#asm 
		jp 0
	#endasm 
#endif
}

// ------------------------------------------------------------
// Funciones propias del juego
// ------------------------------------------------------------

unit UTIPOS;
//Resumen: en esta unidad se definen todos los tipos utilizados en el interprete
interface
type
//------------------------------------------------------------------------------Definicion de las variables y terminales utilizados en la gramatica------------------------------------------------------------------------------
//Este tipo incluye todos los terminales (Componentes lexicos) y no terminales (variables)
VariablesYTerminales=(
//Componentes lexicos o Terminales
ID,PARENTESISA,PARENTESISB,PUNTO,DOSPUNTOS,COMA,ASIGNACION1,SUMA,RESTA,MULT,DIB,RAIZ,POTEN,CONSTANTEREAL,CONSTANTECADENA,LEER,
MOSTRAR,SI,SINO,MIENTRAS,PARA,CASOS,MENOR,MAYOR,MAYORI,MENORI,DISTINTO,IGUAL,AN,O,FUNCION,FIN,HASTA,PESOS,EPSILON,FINDEARCHIVO,ERRORLEXICO,
//No Terminales o Variables
PROGRAMA,PROGRAMA1,FUCTION,FUNCIONE,PARAMETROS,PARAMETROS1,CUERPO,CUERPO1,SENTENCIA,ASIGNACION,OPASIG,EA,R,PARAMETROS2,PARAMETROS3,H,T,Y,Z,X,D,LECTURA,ESCRITURA,A,B,II,IF1,CASOS1,CASOS2,CASOS3,CASO,WHIL,FO,COND,COND1,EE,P,OPREL,OPLOG,BLOQUE);
CONST
//Devuelve el nombre en forma de una cadena de un de un terminal o variable el cual pasamos como parametro
NOMBREVARIABLEOTERMINAL:ARRAY[VARIABLESYTERMINALES] OF STRING=(
//Componentes lexicos o Terminales
              'ID','PARENTESISA','PARENTESISB','PUNTO','DOSPUNTOS','COMA','ASIGNACION1',
              'SUMA','RESTA','MULT','DIB','RAIZ','POTEN','CONSTANTEREAL','CONSTANTECADENA','LEER',
              'MOSTRAR','SI','SINO','MIENTRAS','PARA','CASOS','MENOR','MAYOR','MAYORI',
              'MENORI','DISTINTO','IGUAL','AN','O','FUNCION','FIN','HASTA','PESOS',
              'EPSILON','FINDEARCHIVO','ERRORLEXICO',
//No Terminales o Variables
              'PROGRAMA','PROGRAMA1','FUCTION','FUNCIONE','PARAMETROS','PARAMETROS1',
              'CUERPO','CUERPO1','SENTENCIA','ASIGNACION','OPASIG','EA','R',
              'PARAMETROS2','PARAMETROS3','H','T','Y','Z','X','D','LECTURA',
              'ESCRITURA','A','B','II','IF1','CASOS1','CASOS2','CASOS3',
              'CASO','WHIL','FO','COND','COND1','EE','P','OPREL','OPLOG',
               'BLOQUE');

//------------------------------------------------------------------------------Algunas constantes importante------------------------------------------------------------------------------
//Cantidad maxima elementos de la pila
MAX=30;
//Constante que representa la cantidad maxima de hijos que puede tener un arbol
MAXHIJOS=9;

TYPE
//------------------------------------------------------------------------------Tipos utilizados para el manejos de archivos------------------------------------------------------------------------------
//Archivo de texto que permite leer el archivo fuente
TFUENTE=file of char;
//------------------------------------------------------------------------------Tipos utilizados para el manejo de la TAS---------------------------------------------------------------------------------
//Tipo que contiene todos los terminales o componentes lexicos
TERMINALES=ID..ERRORLEXICO;
//Tipo que contiene todas las variables de la gramatica
VARIABLES=PROGRAMA..BLOQUE;
//Este tipo define la TAS que es una array que tiene como indice compuesto por una variable y por otro lado un componente lexico, y el elemento de la matriz o arreglo bidimensional es una caddena
TTAS=ARRAY[PROGRAMA..BLOQUE,ID..PESOS] OF STRING;
//------------------------------------------------------------------------------Tipos utilizados para el manejo de Tabla de simbolos------------------------------------------------------------------------------
//Este tipo es un registro que contiene una cadena que almacena el lexema, un campo valor que respresenta un numero real y un campo componente que almacena el tipo de componente lexico o terminal.
TTABLA=record
	lexema:string;
	valor:REAL;
	componente:Terminales;
end;
//Este tipo es un apuntador a un nodo del tipo Tnodo
TPUNTERO=^TNODO;
//Este tipo representa un nodo de la lista, es un registro que guarda informacion del tipo TIPOTABLA y tambien almacena el apuntador al siguiente nodo
//Nodo de una lista dinamica de componentes lexicos
TNODO=RECORD
	INFO:TTABLA;
	SIG:TPUNTERO;
END;
//Este tipo representa una lista en memoria dinamica donde el campo Cab es la cabecera y apunta al primer elemento de la lista y el campo Tam representa el tamaño o cantidad de elementos de la lista
//Lista en memoria dinamica de componentes lexicos
TLISTA=Record
	Cab:TPuntero;
	Tam:Word;
end;
//------------------------------------------------------------------------------Tipos utilizados para el manejo de arboles MAXP-arios------------------------------------------------------------------------------
//Este tipo es un apuntador a un arbol
TPUNTEROARBOL=^TARBOL;
//Este tipo representa un arbol, es un registro con un campo vot que representa una variable o terminal de la gramatica, un campo que almacena el lexema, cantidad de hijos del arbol que esta entre 0 y la constante MAXP Y  un array con todos los arboles hijos
TARBOL=record
	vot:VariablesYTerminales;
	lexema:string;
	cantidadhijos:0..MAXHIJOS;
	HIJOS:ARRAY[1..MAXHIJOS] OF TPUNTEROARBOL;
END;
//------------------------------------------------------------------------------Tipos utilizados para el manejo de pilas------------------------------------------------------------------------------
//Este tipo representa un elemento de la pila, tiene un campo que almacena un elemento del tipo variable o terminal y un campo que almacena un elemento del tipo arbol
TIPOP=RECORD
	VOT:VARIABLESYTERMINALES;
	APUNTA:TPUNTEROARBOL;
END;
//Este tipo representa una pila
TPILA=RECORD
	Elem:ARRAY[1..MAX] OF TIPOP;
	Tope:0..MAX;
END;
//------------------------------------------------------------------------------Tipos utilizados para el manejo de la lista de funciones------------------------------------------------------------------------------
TLF=RECORD
	LEXEMA:STRING;
	APUNTADOR:TPUNTEROARBOL;
END;

LFS=RECORD
	INFO:ARRAY[1..20] OF TLF;
	TAM:BYTE;
END;
//------------------------------------------------------------------------------Tipos utilizados para el manejo del vector de parametros------------------------------------------------------------------------------
//Array de parametros
VECTORPARAMETROS=ARRAY[1..10] OF REAL;

implementation

begin

end.

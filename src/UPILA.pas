unit UPILA;
//RESUMEN: esta unidad cuenta con todos los procedimientos necesarios para el manejo de pilas.
interface

uses UTIPOS;
//RESUMEN: Este procedimiento inicializa la pila.
PROCEDURE CREARPILA(VAR P:TPILA);
//RESUMEN: Este procedimiento añade un elemento a la pila.
PROCEDURE APILAR (VAR P:TPILA;ELEM:VariablesYTerminales;APUNTADOR:TPUNTEROARBOL);
//RESUMEN: Este procedimiento extrae el elemento en el tope de la pila.
PROCEDURE DESAPILAR (VAR P:TPILA;VAR ELEM:VariablesYTerminales;VAR APUNTADOR:TPUNTEROARBOL);
//Resumen: Este procedimiento indica si la pila pasada como parametro esta llena.
FUNCTION PILA_LLENA (VAR P:TPILA): BOOLEAN;
//Resumen: Este procedimiento indica si la pila pasada como parametro esta vacia.
FUNCTION PILA_VACIA (VAR P:TPILA): BOOLEAN;



implementation
//Este procedimiento inicializa la pila
PROCEDURE CREARPILA(VAR P:TPILA);
BEGIN
	         P.TOPE:=0;

END;


PROCEDURE APILAR (VAR P:TPILA;ELEM:VariablesYTerminales;APUNTADOR:TPUNTEROARBOL);
BEGIN
	P.TOPE:=P.TOPE+1;
    //Incrementa el tope de la pila
	P.ELEM[P.TOPE].VOT:=ELEM;
    //El elemento con el indice del tope de pila es igual al elemento (variable o terminal)
	P.ELEM[P.TOPE].APUNTA:=APUNTADOR;
END;

PROCEDURE DESAPILAR (VAR P:TPILA;VAR ELEM:VariablesYTerminales;VAR APUNTADOR:TPUNTEROARBOL);
BEGIN
	ELEM:=P.ELEM[P.TOPE].VOT;
    //se le asigna el contenido del tope de la pila al elemento
	APUNTADOR:=P.ELEM[P.TOPE].APUNTA;
    //al apuntador se le asigna la direccion a la que apunta el tope de la pila
	P.TOPE:=P.TOPE-1;
    // se decrementa el tope de la pila
END;


FUNCTION PILA_LLENA (VAR P:TPILA): BOOLEAN;
BEGIN
	PILA_LLENA:= P.TOPE=MAX;
    //la  pila esta llena si el tope es igual a max
END;


FUNCTION PILA_VACIA (VAR P:TPILA): BOOLEAN;
BEGIN
	PILA_VACIA:= P.TOPE=0;
    //la pila esta vacia si el tope es igual a cero
END;




begin
end.

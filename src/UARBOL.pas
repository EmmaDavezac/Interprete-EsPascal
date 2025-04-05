unit UARBOL;
//Resumen: en esta unidad se encuentran todos los procedimientos para el manejo de arboles maxp-arios (maxp es una constante que se encuentra en UTIPOS y determina la cantidad maxima de hijos que puede tener un arbol)
interface
uses UTIPOS;
//Resumen: Este procedimiento permite crear un nodo.
PROCEDURE CREARNODO(VAR ARBOL:TPUNTEROARBOL;VOT:VARIABLESYTERMINALES;LEXEMA:STRING);
//Resumen: Este procedimiento permite agrear un hijo a un arbol.
PROCEDURE AGREGARHIJO(VAR PADRE:TPUNTEROARBOL;HIJO:TPUNTEROARBOL);
//Resumen: Este procediento Devuelve el hijo numero N del arbol padre.
PROCEDURE NHIJO (VAR PADRE:TPUNTEROARBOL;N:BYTE;VAR HIJO:TPUNTEROARBOL);
//Resumen: Este procediento devuelve la cantidad de hijos de un arbol padre.
FUNCTION CANTIDADEHIJOS(VAR PADRE:TPUNTEROARBOL):BYTE;
//Resumen: Este procediento elimina el arbol que se pasa como parametro.
PROCEDURE BORRARARBOL(VAR ARBOL:TPUNTEROARBOL);
//Resumen: Este procedimiento hace un recorrido del arbol
PROCEDURE RECORRERARBOL(VAR ARBOL:TPUNTEROARBOL;D:INTEGER);
implementation
PROCEDURE CREARNODO(VAR ARBOL:TPUNTEROARBOL;VOT:VARIABLESYTERMINALES;LEXEMA:STRING);
BEGIN
//se crea un nodo
	NEW(ARBOL);
//Al nodo se le asigna el tipo de variable o terminal
	ARBOL^.VOT:=VOT;
//Al nodo se le asigna el lexema
	ARBOL^.LEXEMA:=LEXEMA;
//Se inicializa la cantidad de hijos del nodo
	ARBOL^.CANTIDADHIJOS:=0;
END;


PROCEDURE AGREGARHIJO(VAR PADRE:TPUNTEROARBOL;HIJO:TPUNTEROARBOL);
BEGIN
//Se incrementa la cantidad de hijos del arbol padre
	INC(PADRE^.CANTIDADHIJOS);
//Se añade el hijo al padre
	PADRE^.HIJOS[PADRE^.CANTIDADHIJOS]:=HIJO;
END;


PROCEDURE NHIJO (VAR PADRE:TPUNTEROARBOL;N:BYTE;VAR HIJO:TPUNTEROARBOL);
BEGIN
//Devuelve el hijo numero N del padre
	HIJO:=PADRE^.HIJOS[N]
END;


FUNCTION CANTIDADEHIJOS(VAR PADRE:TPUNTEROARBOL):BYTE;
BEGIN
//Devuelve la cantidad de hijos de un padre
	CANTIDADEHIJOS:=PADRE^.CANTIDADHIJOS;
END;


PROCEDURE BORRARARBOL(VAR ARBOL:TPUNTEROARBOL);
VAR 
	I:BYTE;
BEGIN
//Si el arbol no esta vacio se ejecuta lo siguiente
	IF ARBOL<>NIL THEN
 BEGIN
		FOR I:=1 TO ARBOL^.CANTIDADHIJOS DO
		BEGIN
//se eliminan todos los arboles hijos de manera recursiva
			BORRARARBOL(ARBOL^.HIJOS[I])
		END;
//se elimina el nodo
	DISPOSE(ARBOL);
 END;
END;


PROCEDURE RECORRERARBOL(VAR ARBOL:TPUNTEROARBOL;D:INTEGER);
//hace un recorrido del arbol
VAR 
	HIJO:TPUNTEROARBOL; I:BYTE;
BEGIN
	WRITELN('':D,NOMBREVARIABLEOTERMINAL[ARBOL^.VOT],'-',ARBOL^.LEXEMA);
	FOR I:=1 TO ARBOL^.CANTIDADHIJOS DO
	BEGIN
		NHIJO(ARBOL,I,HIJO);
        RECORRERARBOL(HIJO,D+2);
   END;
END;
begin

end.

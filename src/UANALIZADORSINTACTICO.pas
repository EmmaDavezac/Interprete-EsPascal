unit UANALIZADORSINTACTICO;
//RESUMEN:Esta unidad contiene los procedimientos relacionados con el analizador sintactico y el interprete.
interface
USES UTIPOS,UTAS,UAUTOMATAS,UTS,UEVALUADORSEMANTICO,CRT,UPILA,UARBOL;

//Resumen: Procedimiento principal del interprete.
PROCEDURE PROCESOINTERPRETE;

implementation
{RESUMEN:Esta funcion se basa en el algoritmo de reconocimiento visto en clase, es un interprete predictivo no recursivo.
Parametros: la ruta del archivo con el codigo fuente, la lista de funciones, lista de componenetes lexicos y la raiz del arbol de analisis sintactico.
RESULTADO: Error1, Error2 o EXITO si pasa el analisis sintactico. }
Function AnalizadorSintactico(ruta:string;VAR LF:LFs; VAR L:TLISTA; VAR RAIZ:TPUNTEROARBOL):String;
//RESUMEN: este procedimiento carga una funcion a la lista de funciones
PROCEDURE CARGARFUNCION(VAR LF:LFs;LEXEMA:STRING;APUNTADOR:TPUNTEROARBOL;VAR I:BYTE);
BEGIN
	INC(I);
	LF.INFO[I].LEXEMA:=LEXEMA;
	LF.INFO[I].APUNTADOR:=APUNTADOR;
END;
VAR
//Estado final del interprete. Estados posibles: EXITO, ERROR1, ERRROR.
	ESTADO:STRING[6];
	ATERMINAL:TERMINALES;
//PILA del analizador lexico
	PILA:TPILA;
	ELEMENTO:VARIABLESYTERMINALES;
//TAS, TABLA  de Analisis Sintactico
	TAS:TTAS;
//Cadenas utilizadas en la funcion
	AUX1,LEXEMA,PALABRA:STRING;
//Posicion en el archivo de texto
	Control:longint;
//Archivo fuente
	Fuente:tfuente;
//Variable entera utilizada en la funcion
	I:INTEGER;
//Arbol de Analisis Sintactico
	ARBOL:TPUNTEROARBOL;
//TpunteroArbol utilizado en la funcion para apuntar a un elemento
	PELEMENTO:TPUNTEROARBOL;
//ARRAY DE PRODUCCIONES
	PROD:ARRAY[1..MAX] OF VARIABLESYTERMINALES;
//Cantidad de producciones
	CPROD:BYTE;
    APUNTADOR:TPUNTEROARBOL;
BEGIN
//Asociamos el archivo con codigo fuente a la ruta especificada como parametro
	Assign(Fuente,RUTA);
//Abrimos el archivo fuente
	Reset(Fuente);
//Inicializamos la lista
	CrearLista(L);
//Inicializamos la pila del analizador sintactico
	CREARPILA(PILA);
//Creamos el nodo inicial ( con el simbolo inicial de la gramatica ) del arbol de derivacion o de analisis sintactico
	CREARNODO(ARBOL,PROGRAMA,'');
//Le asignamos a la raiz el nodo recien creado
	RAIZ:=ARBOL;
//Inicializamos la tabla de analisis sintactico o TAS
	INICIALIZARMATRIZ(TAS);
//Cargamos la TAS
	CARGARTAS(TAS);
//Cargamos en la pila el simbolo $ y el simbolo inicial de la gramatica
	APILAR(PILA,PESOS,NIL);
	APILAR(PILA,PROGRAMA,ARBOL);
//Este sera el resultado del analizador (ERROR1, ERROR2 O EXITO)
	ESTADO:='';
	palabra:='';
//Inicializamos la POSICION EN EL ARCHIVO
	CONTROL:=0;
//Inicializamos tamaño de la lista de funciones
	LF.TAM:=0;
//Leemos el primer componenente lexico desde el archivo
Writeln('LISTA DE COMPONENTES LEXICOS');
	Sigcomp_lex(Fuente,Control,ATERMINAL,Lexema,L);
//Repetir hasta exito o error
	while (estado<>'ERROR1')AND(estado<>'ERROR2') and (estado<>'EXITO') AND (ATERMINAL<>ERRORLEXICO) DO
	begin
//Desapilamos el elemenento en el tope de la pila
		DESAPILAR(PILA,ELEMENTO,PELEMENTO);
        IF ELEMENTO=FUCTION THEN APUNTADOR:=PELEMENTO;
           IF ELEMENTO IN [ID..HASTA] THEN
//Elemento es TERMINAL
BEGIN
			IF ELEMENTO=ATERMINAL THEN
        	BEGIN
				PELEMENTO^.LEXEMA:=LEXEMA;
				IF PELEMENTO^.VOT = ID THEN
                IF ARBOL^.VOT=FUNCION THEN
					BEGIN
//Se carga la funcion en la lista de funciones
						CARGARFUNCION(LF,LEXEMA,APUNTADOR,LF.TAM);
					END;
//Se vuelve a ejecutar SigComplex del analizador lexico
				Sigcomp_lex(Fuente,Control,ATERMINAL,Lexema,L);
				END
				ELSE
    BEGIN
				ESTADO:='ERROR1';
                writeln('Error sintactico: se esperaba, ',NOMBREVARIABLEOTERMINAL[PELEMENTO^.VOT],', se encontro ', NOMBREVARIABLEOTERMINAL[ATERMINAL])
                                                       end
			END


    else    IF ELEMENTO IN [PROGRAMA..BLOQUE] THEN
//Elemento es VARIABLE
			BEGIN
				IF TAS[ELEMENTO,ATERMINAL]='' then begin
//No esta definida la entrada [ELEMENTO,ATERMINAL] en la TAS
                                                       ESTADO:='ERROR2';
                                                       writeln('TASI[',NOMBREVARIABLEOTERMINAL[ELEMENTO],' , ', NOMBREVARIABLEOTERMINAL[ATERMINAL],' ] = empty');
                                                       writeln('Error sintactico: se esperaba ',NOMBREVARIABLEOTERMINAL[PELEMENTO^.VOT],', se encontro ',NOMBREVARIABLEOTERMINAL[ATERMINAL])
                                                       end
				ELSE
				BEGIN
					AUX1:=TAS[ELEMENTO,ATERMINAL];
					CPROD:=0;
					FOR I:=1 TO LENGTH(AUX1)+1 DO
					BEGIN
						IF (AUX1[I]<>#32) AND (I<=LENGTH(AUX1)) THEN
							PALABRA:=PALABRA+AUX1[I]
						ELSE
						BEGIN
							ELEMENTO:=CAMBIO(PALABRA);
							IF ELEMENTO<>EPSILON  THEN
							BEGIN
								INC(CPROD);
								PROD[CPROD]:=ELEMENTO;
							END;
							PALABRA:='';
						END;
					END;
//Agregamos los hijos al nodo PELEMENTO
					FOR I:=CPROD DOWNTO 1 DO
					BEGIN
						CREARNODO(ARBOL,PROD[I],'');
						AGREGARHIJO(PELEMENTO,ARBOL);
					END;
//Apilamos Ai,Ai-1..A1 (A1 queda en el tope)
					FOR I:=CPROD DOWNTO 1 DO
					BEGIN
                         NHIJO(PELEMENTO,I,ARBOL);
                         APILAR(PILA,ARBOL^.VOT,ARBOL);
					END;
			    END;
		    END
	        ELSE 
            BEGIN
            IF (ELEMENTO=ATERMINAL) AND (ATERMINAL=PESOS) THEN
//Se cumple la condicion para el reconocimiento por pila vacia del analizador sintactico predictivo
                    ESTADO:='EXITO';
            END;
        END;
//Se cierra el archivo funte
close(fuente);
//resultado final de la funcion
analizadorsintactico:= estado;

END;

//Proceso principal de interprete
PROCEDURE PROCESOINTERPRETE;
var ruta:string;
estado:string[6];
//Lista de Funciones
LF:LFs;
//lista de componenetes lexicos
L:TLISTA;
//Raiz del arbol de analisis sintactico
RAIZ:TPUNTEROARBOL;

Begin
 Writeln('BIENVENIDO A NUESTRO INTERPRETE');
 write('Ingrese la ruta del archivo fuente o arrastrelo hacia la consola: ');
 readln(ruta);
 estado:=AnalizadorSintactico(ruta,LF,L,RAIZ);
//Si el estado de la comprobacion sintactica es exito, se traduce el codigo para su ejecucion
if estado='EXITO' THEN
    BEGIN
    writeln('El analizador Sintactico concluyo que la sintaxis es correcta');
//Traduccion del codigo-Evaluacion de la semantica asociada desde el simbolo inicial
    EVALPROGRAMA(RAIZ,L,LF)
   END
ELSE
//En caso de error sintactico se muestra este en pantalla
Writeln('Error:',Estado);
Writeln('Presione una tecla para salir...');
readkey;
End;

begin
end.

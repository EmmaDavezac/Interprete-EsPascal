UNIT UTAS;
//RESUMEN: Esta unidad tiene todos los procedimientos necesarios para el manejo de la TAS-
interface
USES UTIPOS;
//RESUMEN: Esta funcion toma una cadena como parametro y devuelve una variable o terminal de la gramatica.
FUNCTION CAMBIO(PALABRA:STRING):VARIABLESYTERMINALES;
//RESUMEN:Este procedimiento inicializa la TAS.
Procedure INICIALIZARMATRIZ(var TAS:TTAS);
//RESUMEN: Este procedimiento se encarga de cargar la TAS.
PROCEDURE CARGARTAS(VAR TAS:TTAS);

implementation

FUNCTION CAMBIO(PALABRA:STRING):VARIABLESYTERMINALES;
BEGIN
IF PALABRA='ID' THEN CAMBIO:=ID
ELSE IF PALABRA='(' THEN CAMBIO:=PARENTESISA
ELSE IF PALABRA=')'THEN CAMBIO:=PARENTESISB
ELSE IF PALABRA='.' THEN CAMBIO:=PUNTO
ELSE IF PALABRA=':' THEN CAMBIO:=DOSPUNTOS
ELSE IF PALABRA=',' THEN CAMBIO:=COMA
ELSE IF PALABRA='ASIGNACION1'THEN  CAMBIO:=ASIGNACION1
ELSE IF PALABRA='+' THEN CAMBIO:=SUMA
ELSE IF PALABRA='~' THEN CAMBIO:=RESTA
ELSE IF PALABRA='*' THEN CAMBIO:=MULT
ELSE IF PALABRA='/' THEN CAMBIO:=DIB
ELSE IF PALABRA='RAIZ'THEN CAMBIO:=RAIZ
ELSE IF PALABRA='POTEN'THEN CAMBIO:=POTEN
ELSE IF PALABRA='CONSTANTEREAL'THEN CAMBIO:=CONSTANTEREAL
ELSE IF PALABRA='CONSTANTECADENA'THEN CAMBIO:=CONSTANTECADENA
ELSE IF PALABRA='LEER'THEN CAMBIO:=LEER
ELSE IF PALABRA='MOSTRAR'THEN CAMBIO:=MOSTRAR
ELSE IF PALABRA='SI'THEN CAMBIO:=SI
ELSE IF PALABRA='SINO'THEN CAMBIO:=SINO
ELSE IF PALABRA='MIENTRAS'THEN CAMBIO:=MIENTRAS
ELSE IF PALABRA='PARA'THEN CAMBIO:=PARA
ELSE IF PALABRA='CASOS'THEN CAMBIO:=CASOS
ELSE IF PALABRA='<'THEN CAMBIO:=MENOR
ELSE IF PALABRA='>'THEN CAMBIO:=MAYOR
ELSE IF PALABRA='>='THEN  CAMBIO:=MAYORI
ELSE IF PALABRA='<='THEN  CAMBIO:=MENORI
ELSE IF PALABRA='<>'THEN  CAMBIO:=DISTINTO
ELSE IF PALABRA='IGUAL'THEN  CAMBIO:=IGUAL
ELSE IF PALABRA='AN'THEN CAMBIO:=AN
ELSE IF PALABRA='O'THEN  CAMBIO:=O
ELSE IF PALABRA='FUNCION'THEN CAMBIO:=FUNCION
ELSE IF PALABRA='FIN' THEN CAMBIO:=FIN
ELSE IF PALABRA='HASTA' THEN CAMBIO:=HASTA
ELSE IF PALABRA='PESOS'THEN CAMBIO:=PESOS
ELSE IF PALABRA='PROGRAMA'THEN CAMBIO:=PROGRAMA
ELSE IF PALABRA='PROGRAMA1' THEN CAMBIO:=PROGRAMA1
ELSE IF PALABRA='FUCTION' THEN CAMBIO:=FUCTION
ELSE IF PALABRA='FUNCIONE'THEN CAMBIO:=FUNCIONE
ELSE IF PALABRA='PARAMETROS'THEN CAMBIO:=PARAMETROS
ELSE IF PALABRA='PARAMETROS1'THEN CAMBIO:=PARAMETROS1
ELSE IF PALABRA='CUERPO' THEN CAMBIO:=CUERPO
ELSE IF PALABRA='CUERPO1' THEN CAMBIO:=CUERPO1
ELSE IF PALABRA='SENTENCIA' THEN CAMBIO:=SENTENCIA
ELSE IF PALABRA='ASIGNACION'THEN CAMBIO:=ASIGNACION
ELSE IF PALABRA='OPASIG' THEN CAMBIO:=OPASIG
ELSE IF PALABRA='EA' THEN CAMBIO:=EA
ELSE IF PALABRA='H' THEN CAMBIO:=H
ELSE IF PALABRA='T' THEN CAMBIO:=T
ELSE IF PALABRA='Y' THEN CAMBIO:=Y
ELSE IF PALABRA='Z' THEN CAMBIO:=Z
ELSE IF PALABRA='X' THEN CAMBIO:=X
ELSE IF PALABRA='D' THEN CAMBIO:=D
ELSE IF PALABRA='LECTURA'THEN CAMBIO:=LECTURA
ELSE IF PALABRA='ESCRITURA' THEN CAMBIO:=ESCRITURA
ELSE IF PALABRA='A' THEN CAMBIO:=A
ELSE IF PALABRA='B' THEN CAMBIO:=B
ELSE IF PALABRA='II' THEN CAMBIO:=II
ELSE IF PALABRA='IF1' THEN CAMBIO:=IF1
ELSE IF PALABRA='CASOS1' THEN CAMBIO:=CASOS1
ELSE IF PALABRA='CASOS2' THEN CAMBIO:=CASOS2
ELSE IF PALABRA='CASOS3' THEN CAMBIO:=CASOS3
ELSE IF PALABRA='CASO' THEN CAMBIO:=CASO
ELSE IF PALABRA='WHIL' THEN CAMBIO:=WHIL
ELSE IF PALABRA='FO' THEN CAMBIO:=FO
ELSE IF PALABRA='COND' THEN CAMBIO:=COND
ELSE IF PALABRA='COND1' THEN CAMBIO:=COND1
ELSE IF PALABRA='EE' THEN CAMBIO:=EE
ELSE IF PALABRA='P' THEN CAMBIO:=P
ELSE IF PALABRA='OPREL' THEN CAMBIO:=OPREL
ELSE IF PALABRA='OPLOG' THEN CAMBIO:=OPLOG
ELSE IF PALABRA='BLOQUE' THEN CAMBIO:=BLOQUE
ELSE IF PALABRA='EPSILON' THEN CAMBIO:=EPSILON
ELSE IF PALABRA='R' THEN CAMBIO:=R
ELSE IF PALABRA='PARAMETROS2' THEN CAMBIO:=PARAMETROS2
ELSE IF PALABRA='PARAMETROS3' THEN CAMBIO:=PARAMETROS3;
END;

Procedure INICIALIZARMATRIZ (var TAS:TTAS);
Var
   I,J:VARIABLESYTERMINALES;
Begin
     For I:=PROGRAMA to BLOQUE do
     Begin
        For J:=ID to PESOS do
        Begin
          TAS[I,J]:='';
        end;
     end;
end;

PROCEDURE CARGARTAS(VAR TAS:TTAS);
BEGIN
//------------------------------------------------------------------------------COLUMNAS PARA PROGRAMA
TAS[PROGRAMA,FUNCION]:='PROGRAMA1 FUCTION';
//------------------------------------------------------------------------------COLUMNAS PARA PROGRAMA1
TAS[PROGRAMA1,FUNCION]:='PROGRAMA1 FUCTION';
TAS[PROGRAMA1,PESOS]:='EPSILON';
//------------------------------------------------------------------------------COLUMNAS PARA FUCTION
TAS[FUCTION,FUNCION]:='BLOQUE ) PARAMETROS ( FUNCIONE';
//------------------------------------------------------------------------------COLUMNAS PARA FUNCIONE
TAS[FUNCIONE,FUNCION]:='ID FUNCION';
//------------------------------------------------------------------------------COLUMNAS PARA PARAMETROS
TAS[PARAMETROS,ID]:='PARAMETROS1 ID';
//------------------------------------------------------------------------------COLUMNAS PARA PARAMETROS1
TAS[PARAMETROS1,PARENTESISB]:='EPSILON';
TAS[PARAMETROS1,COMA]:='PARAMETROS1 ID ,';
//------------------------------------------------------------------------------COLUMNAS PARA PARAMETROS2
TAS[PARAMETROS2,ID]:='PARAMETROS3 EA';
TAS[PARAMETROS2,PARENTESISB]:='PARAMETROS3 EA';
TAS[PARAMETROS2,RAIZ]:='PARAMETROS3 EA';
TAS[PARAMETROS2,CONSTANTEREAL]:='PARAMETROS3 EA';
//------------------------------------------------------------------------------COLUMNAS PARA PARAMETROS3
TAS[PARAMETROS3,COMA]:='PARAMETROS3 EA ,';
TAS[PARAMETROS3, PARENTESISB]:='EPSILON';
//------------------------------------------------------------------------------COLUMNAS PARA BLOQUE
TAS[BLOQUE,ID]:='. FIN CUERPO' ;
TAS[BLOQUE,LEER]:='. FIN CUERPO' ;
TAS[BLOQUE,MOSTRAR]:='. FIN CUERPO';
TAS[BLOQUE,SI]:='. FIN CUERPO'      ;
TAS[BLOQUE,MIENTRAS]:='. FIN CUERPO'  ;
TAS[BLOQUE,PARA]:='. FIN CUERPO'       ;
TAS[BLOQUE,CASOS]:='. FIN CUERPO'       ;
//------------------------------------------------------------------------------COLUMNAS PARA CUERPO
TAS[CUERPO,ID]:='CUERPO1 SENTENCIA';
TAS[CUERPO,LEER]:='CUERPO1 SENTENCIA';
TAS[CUERPO,MOSTRAR]:='CUERPO1 SENTENCIA';
TAS[CUERPO,SI]:='CUERPO1 SENTENCIA';
TAS[CUERPO,MIENTRAS]:='CUERPO1 SENTENCIA';
TAS[CUERPO,PARA]:='CUERPO1 SENTENCIA';
TAS[CUERPO,CASOS]:='CUERPO1 SENTENCIA';
//------------------------------------------------------------------------------COLUMNAS PARA CUERPO1
TAS[CUERPO1,ID]:='CUERPO1 SENTENCIA';
TAS[CUERPO1,LEER]:='CUERPO1 SENTENCIA';
TAS[CUERPO1,MOSTRAR]:='CUERPO1 SENTENCIA';
TAS[CUERPO1,SI]:='CUERPO1 SENTENCIA';
TAS[CUERPO1,MIENTRAS]:='CUERPO1 SENTENCIA';
TAS[CUERPO1,PARA]:='CUERPO1 SENTENCIA';
TAS[CUERPO1,CASOS]:='CUERPO1 SENTENCIA';
TAS[CUERPO1,FIN]:='EPSILON';
TAS[CUERPO1,SINO]:='EPSILON';
//------------------------------------------------------------------------------COLUMNAS PARA SENTENCIA
TAS[SENTENCIA,ID]:='ASIGNACION';
TAS[SENTENCIA,LEER]:='LECTURA';
TAS[SENTENCIA,MOSTRAR]:='ESCRITURA';
TAS[SENTENCIA,SI]:='II';
TAS[SENTENCIA,MIENTRAS]:='WHIL';
TAS[SENTENCIA,PARA]:='FO';
TAS[SENTENCIA,CASOS]:='CASOS1';
//------------------------------------------------------------------------------COLUMNAS PARA ASIGNACION
TAS[ASIGNACION,ID]:='. EA OPASIG ID';
//------------------------------------------------------------------------------COLUMNAS PARA OPASIG
TAS[OPASIG,ASIGNACION1]:='ASIGNACION1';
//------------------------------------------------------------------------------COLUMNAS PARA EA
TAS[EA,ID]:='H T';
TAS[EA,PARENTESISA]:='H T';
TAS[EA,RAIZ]:='H T';
TAS[EA,CONSTANTEREAL]:='H T';
//------------------------------------------------------------------------------COLUMNAS PARA H
TAS[H,PARENTESISB]:='EPSILON';
TAS[H,PUNTO]:='EPSILON';
TAS[H,DOSPUNTOS]:='EPSILON';
TAS[H,SUMA]:='H T +';
TAS[H,RESTA]:='H T ~';
TAS[H,MAYOR]:='EPSILON';
TAS[H,MENOR]:='EPSILON';
TAS[H,MAYORI]:='EPSILON';
TAS[H,MENORI]:='EPSILON';
TAS[H,DISTINTO]:='EPSILON';
TAS[H,IGUAL]:='EPSILON';
TAS[H,AN]:='EPSILON';
TAS[H,O]:='EPSILON';
TAS[H,HASTA]:='EPSILON';
TAS[H,COMA]:='EPSILON';
//------------------------------------------------------------------------------COLUMNAS PARA T
TAS[T,ID]:='Y Z';
TAS[T,PARENTESISA]:='Y Z';
TAS[T,RAIZ]:='Y Z';
TAS[T,CONSTANTEREAL]:='Y Z';
//------------------------------------------------------------------------------COLUMNAS PARA Y
TAS[Y,PARENTESISB]:='EPSILON';
TAS[Y,PUNTO]:='EPSILON';
TAS[Y,DOSPUNTOS]:='EPSILON';
TAS[Y,SUMA]:='EPSILON';
TAS[Y,RESTA]:='EPSILON';
TAS[Y,MULT]:='Y Z *';
TAS[Y,DIB]:='Y Z /';
TAS[Y,MAYOR]:='EPSILON';
TAS[Y,MENOR]:='EPSILON';
TAS[Y,MAYORI]:='EPSILON';
TAS[Y,MENORI]:='EPSILON';
TAS[Y,DISTINTO]:='EPSILON';
TAS[Y,IGUAL]:='EPSILON';
TAS[Y,AN]:='EPSILON';
TAS[Y,O]:='EPSILON';
TAS[Y,HASTA]:='EPSILON';
TAS[Y,COMA]:='EPSILON';
//------------------------------------------------------------------------------COLUMNAS PARA Z
TAS[Z,ID]:='X D';
TAS[Z,PARENTESISA]:='X D';
TAS[Z,RAIZ]:='X D RAIZ';
TAS[Z,CONSTANTEREAL]:='X D';
//------------------------------------------------------------------------------COLUMNAS PARA X
TAS[X,PARENTESISB]:='EPSILON';
TAS[X,PUNTO]:='EPSILON';
TAS[X,DOSPUNTOS]:='EPSILON';
TAS[X,SUMA]:='EPSILON';
TAS[X,RESTA]:='EPSILON';
TAS[X,MULT]:='EPSILON';
TAS[X,DIB]:='EPSILON';
TAS[X,POTEN]:='X D POTEN';
TAS[X,MAYOR]:='EPSILON';
TAS[X,MENOR]:='EPSILON';
TAS[X,MAYORI]:='EPSILON';
TAS[X,MENORI]:='EPSILON';
TAS[X,DISTINTO]:='EPSILON';
TAS[X,IGUAL]:='EPSILON';
TAS[X,AN]:='EPSILON';
TAS[X,O]:='EPSILON';
TAS[X,HASTA]:='EPSILON';
TAS[X,COMA]:='EPSILON';
TAS[D,ID]:='R ID';
TAS[D,PARENTESISA]:=') EA (';
TAS[D,CONSTANTEREAL]:='CONSTANTEREAL';
TAS[R,PARENTESISA]:=') PARAMETROS2 (';
TAS[R,PARENTESISB]:='EPSILON';
TAS[R,PUNTO]:='EPSILON';
TAS[R,DOSPUNTOS]:='EPSILON';
TAS[R,SUMA]:='EPSILON';
TAS[R,RESTA]:='EPSILON';
TAS[R,MULT]:='EPSILON';
TAS[R,DIB]:='EPSILON';
TAS[R,POTEN]:='EPSILON';
TAS[R,MAYOR]:='EPSILON';
TAS[R,MENOR]:='EPSILON';
TAS[R,MAYORI]:='EPSILON';
TAS[R,MENORI]:='EPSILON';
TAS[R,DISTINTO]:='EPSILON';
TAS[R,IGUAL]:='EPSILON';
TAS[R,AN]:='EPSILON';
TAS[R,O]:='EPSILON';
TAS[R,HASTA]:='EPSILON';
TAS[R,COMA]:='EPSILON';
//------------------------------------------------------------------------------COLUMNAS PARA LECTURA
TAS[LECTURA,LEER]:='. ) ID ( LEER';
//------------------------------------------------------------------------------COLUMNAS PARA ESCRITURA
TAS[ESCRITURA,MOSTRAR]:='. ) A ( MOSTRAR';
//------------------------------------------------------------------------------COLUMNAS PARA A
TAS[A,ID]:='ID';
TAS[A,CONSTANTECADENA]:='B CONSTANTECADENA';
//------------------------------------------------------------------------------COLUMNAS PARA B
TAS[B,PARENTESISB]:='EPSILON';
TAS[B,COMA]:='ID ,';
//------------------------------------------------------------------------------COLUMNAS PARA II
TAS[II,SI]:='IF1 CUERPO : COND SI';
//------------------------------------------------------------------------------COLUMNAS PARA IF1
TAS[IF1,SINO]:='BLOQUE SINO';
TAS[IF1,FIN]:='. FIN' ;
//------------------------------------------------------------------------------COLUMNAS PARA CASOS1
TAS[CASOS1,CASOS]:='. FIN CASOS2 : CASOS';
//------------------------------------------------------------------------------COLUMNAS PARA CASOS2
TAS[CASOS2,ID]:='CASOS3 CASO';
TAS[CASOS2,PARENTESISA]:='CASOS3 CASO';
TAS[CASOS2,RAIZ]:='CASOS3 CASO';
TAS[CASOS2,CONSTANTEREAL]:='CASOS3 CASO';
//------------------------------------------------------------------------------COLUMNAS PARA CASOS3
TAS[CASOS3,ID]:='CASOS3 CASO';
TAS[CASOS3,PARENTESISA]:='CASOS3 CASO';
TAS[CASOS3,RAIZ]:='CASOS3 CASO';
TAS[CASOS3,CONSTANTEREAL]:='CASOS3 CASO';
TAS[CASOS3,FIN]:='EPSILON';
 //------------------------------------------------------------------------------COLUMNAS PARA CASO
TAS[CASO,ID]:='BLOQUE : COND';
TAS[CASO,PARENTESISA]:='BLOQUE : COND';
TAS[CASO,RAIZ]:='BLOQUE : COND';
TAS[CASO,CONSTANTEREAL]:='BLOQUE : COND';
//------------------------------------------------------------------------------COLUMNAS PARA WHIL
TAS[WHIL,MIENTRAS]:='BLOQUE : COND MIENTRAS';
//------------------------------------------------------------------------------COLUMNAS PARA FO
TAS[FO,PARA]:='BLOQUE : EA HASTA EA IGUAL ID PARA';
//------------------------------------------------------------------------------COLUMNAS PARA COND
TAS[COND,ID]:='COND1 EE';
TAS[COND,PARENTESISA]:='COND1 EE';
TAS[COND,RAIZ]:='COND1 EE';
TAS[COND,CONSTANTEREAL]:='COND1 EE';
//------------------------------------------------------------------------------COLUMNAS PARA COND1
TAS[COND1,DOSPUNTOS]:='EPSILON';
TAS[COND1,AN]:='COND OPLOG';
TAS[COND1,O]:='COND OPLOG';
//------------------------------------------------------------------------------COLUMNAS PARA EE
TAS[EE,ID]:='P EA';
TAS[EE,PARENTESISA]:='P EA';
TAS[EE,CONSTANTEREAL]:='P EA';
TAS[EE,RAIZ]:='P EA';
//------------------------------------------------------------------------------COLUMNAS PARA P
TAS[P,MENOR]:='EA OPREL';
TAS[P,MAYOR]:='EA OPREL';
TAS[P,MENORI]:='EA OPREL';
TAS[P,MAYORI]:='EA OPREL';
TAS[P,DISTINTO]:='EA OPREL';
TAS[P,IGUAL]:='EA OPREL';
//------------------------------------------------------------------------------COLUMNAS PARA OPREL
TAS[OPREL,MENOR]:='<';
TAS[OPREL,MAYOR]:='>';
TAS[OPREL,MENORI]:='<=';
TAS[OPREL,MAYORI]:='>=';
TAS[OPREL,DISTINTO]:='<>';
TAS[OPREL,IGUAL]:='IGUAL';
//------------------------------------------------------------------------------COLUMNAS PARA OPLOG
TAS[OPLOG,AN]:='AN';
TAS[OPLOG,O]:='O';
END;

end.

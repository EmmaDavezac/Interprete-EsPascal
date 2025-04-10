unit UEVALUADORSEMANTICO;
//Resumen:esta unidad contiene todos los procedimientos relacionados a la semantica asociada.
interface
USES UTIPOS,UTS;
//Resumen: Este procedimiento evalua la semantica asociada del simbolo inicial de la gramatica.
procedure EVALPROGRAMA(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);

implementation
//RESUMEN: este procedimiento permite buscar una funcion de la lista de funciones.
PROCEDURE BUSCARLF(LF:LFS;VAR BUSCADO:TLF);
VAR I:BYTE; LEXEMA:STRING;
BEGIN
I:=0;
LEXEMA:='';
WHILE (I<=10) AND (BUSCADO.LEXEMA<>LEXEMA) DO
  BEGIN
   INC(I);
   LEXEMA:=LF.INFO[I].LEXEMA;
  END;
  IF LEXEMA=BUSCADO.LEXEMA THEN
   BUSCADO.APUNTADOR:=LF.INFO[I].APUNTADOR
   ELSE BUSCADO.LEXEMA:='';
END;
//RESUMEN: este procedimiento permite cargar un valor al vector de parametros.
PROCEDURE CARGARPARAMETROS(VAR VP:VECTORPARAMETROS;VALOR:REAL;VAR I:BYTE);
CONST MaxParametros=10;
BEGIN
IF I <= MaxParametros THEN
BEGIN
VP[I]:=VALOR;
I:=I+1;
END
ELSE
begin
WRITELN('Error al cargar valor ', VALOR:10:2);
end;
END;



PROCEDURE EVALEA(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR VALOR:REAL);FORWARD;
PROCEDURE EVALBLOQUE(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);FORWARD;

PROCEDURE EVALFOR(VAR ARBOL:TPUNTEROARBOL;ESTADO:TlISTA;LF:LFS);
VAR VALOR,VALOR1:REAL;DIR:TPUNTERO; I,W,K:INTEGER;
BEGIN
 EVALEA(ARBOL^.HIJOS[4],ESTADO,LF,VALOR);
 BUSCARLISTA(ESTADO,ARBOL^.HIJOS[2]^.LEXEMA,DIR);
 EVALEA(ARBOL^.HIJOS[6],ESTADO,LF,VALOR1);
 DIR^.INFO.VALOR:=VALOR;
 I := round(VALOR);
 W:=ROUND(VALOR1);
 FOR K:=I TO W DO 
 BEGIN
  DIR^.INFO.VALOR:=ROUND(K);
  EVALBLOQUE(ARBOL^.HIJOS[8],ESTADO,LF);
  
 END;
END;

PROCEDURE EVALPARAMETROS3(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR LP:VECTORPARAMETROS;VAR I:BYTE) ;
VAR VALOR:REAL;
BEGIN
 IF ARBOL^.HIJOS[1]<>NIL THEN
 BEGIN
  EVALEA(ARBOL^.HIJOS[2],ESTADO,LF,VALOR);
  CARGARPARAMETROS(LP,VALOR,I);
  EVALPARAMETROS3(ARBOL^.HIJOS[3],ESTADO,LF,LP,I);
 END;
END;

PROCEDURE EVALPARAMETROS2(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR LP:VECTORPARAMETROS;VAR I:BYTE) ;
VAR VALOR:REAL;
BEGIN
EVALEA(ARBOL^.HIJOS[1],ESTADO,LF,VALOR);
CARGARPARAMETROS(LP,VALOR,I);
EVALPARAMETROS3(ARBOL^.HIJOS[2],ESTADO,LF,LP,I);
END;

PROCEDURE EVALPARAMETROS1(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;LP:VECTORPARAMETROS;I:BYTE;VAR OP:BYTE);
VAR DIR:TPUNTERO;
BEGIN
IF ARBOL^.HIJOS[1]<> NIL THEN
BEGIN
BUSCARLISTA(ESTADO,ARBOL^.HIJOS[2]^.LEXEMA,DIR);
IF OP<=I THEN
DIR^.INFO.VALOR:=LP[OP];
INC(OP);
EVALPARAMETROS1(ARBOL^.HIJOS[3],ESTADO,LF,LP,I,OP);
END;
END;

PROCEDURE EVALPARAMETROS(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;LP:VECTORPARAMETROS;I:BYTE);
VAR OP:BYTE;  DIR:TPUNTERO;
BEGIN
  BUSCARLISTA(ESTADO,ARBOL^.HIJOS[1]^.LEXEMA,DIR);
  DIR^.INFO.VALOR:=LP[1];
  OP:=2;
  EVALPARAMETROS1(ARBOL^.HIJOS[2],ESTADO,LF,LP,I,OP);
END;

PROCEDURE EVALR(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR BUSCADO:TLF);
VAR LP:VECTORPARAMETROS; I:BYTE;
BEGIN
 IF ARBOL^.HIJOS[1]<>NIL THEN
 BEGIN
   I:=1;
   EVALPARAMETROS2(ARBOL^.HIJOS[2],ESTADO,LF,LP,I);
   EVALPARAMETROS(BUSCADO.APUNTADOR^.HIJOS[3],ESTADO,LF,LP,I);
   EVALBLOQUE(BUSCADO.APUNTADOR^.HIJOS[5],ESTADO,LF);
 END;

END;


PROCEDURE EVALD(VAR ARBOL:TPUNTEROARBOL;ESTADO:TlISTA;LF:LFS;VAR VALOR1:REAL);
VAR
	NUMERO:REAL;
	DIR:TPUNTERO;
    BUSCADO:TLF;
BEGIN
	IF ARBOL^.HIJOS[1]^.VOT=CONSTANTEREAL THEN
	BEGIN
		VAL(ARBOL^.HIJOS[1]^.LEXEMA,NUMERO);
		VALOR1:=NUMERO;
	END
	ELSE IF ARBOL^.HIJOS[1]^.VOT=ID THEN 
	BEGIN
            BUSCADO.LEXEMA:=ARBOL^.HIJOS[1]^.LEXEMA;
            BUSCARLF(LF,BUSCADO);
            IF BUSCADO.LEXEMA<>'' THEN
            BEGIN
		    EVALR(ARBOL^.HIJOS[2],ESTADO,LF,BUSCADO);
            END;
			BUSCARLISTA(ESTADO,ARBOL^.HIJOS[1]^.LEXEMA,DIR);
			VALOR1:=DIR^.INFO.VALOR;

	END
	ELSE IF ARBOL^.HIJOS[1]^.VOT=PARENTESISA THEN
	BEGIN
	 EVALEA(ARBOL^.HIJOS[2],ESTADO,LF,VALOR1);
	END;
END;

PROCEDURE EVALX (VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR VALOR:REAL;VALOR1:REAL);
VAR
	I:INTEGER;VALOR2:REAL;
    FUNCTION POTENCIA(VALOR1:REAL;VALOR2:INTEGER):REAL;
VAR 
	VALOR:REAl;I:INTEGER;
BEGIN
IF VALOR2 >0 then
begin
VALOR:=1;
	FOR I := 1 TO VALOR2 DO
	BEGIN
		VALOR:=VALOR*VALOR1;
	END;
	POTENCIA:=VALOR;
end
else if valor2<0 then 
begin
valor:=1;
valor2:=valor2*-1;
for i:=1 to valor2 do
valor:=valor*valor1;
potencia:=1/valor;
end
else potencia:=1;
END;
BEGIN
	IF ARBOL^.HIJOS[1]=NIL THEN
	BEGIN
	 VALOR:=VALOR1;
	END
	ELSE
	BEGIN
		EVALD(ARBOL^.HIJOS[2],ESTADO,LF,VALOR2);
		I:=ROUND(VALOR2);
		VALOR1:=POTENCIA(VALOR1,I);
		EVALX(ARBOL^.HIJOS[3],ESTADO,LF,VALOR,VALOR1);	
	END;
END;

PROCEDURE EVALZ(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR VALOR1:REAL);
VAR 
	VALOR:REAL;
BEGIN
	IF ARBOL^.HIJOS[1]^.VOT=D THEN
	BEGIN
		EVALD(ARBOL^.HIJOS[1],ESTADO,LF,VALOR);
		EVALX(ARBOL^.HIJOS[2],ESTADO,LF,VALOR1,VALOR);
	END
	ELSE IF ARBOL^.HIJOS[1]^.VOT=RAIZ THEN
	BEGIN
		EVALD(ARBOL^.HIJOS[2],ESTADO,LF,VALOR);
		VALOR:=SQRT(VALOR);
        EVALX(ARBOL^.HIJOS[3],ESTADO,LF,VALOR1,VALOR);
	END;
END;



PROCEDURE EVALY(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR VALOR1:REAL;VAR VALOR2:REAL );
VAR 
	VALOR3:REAl;
BEGIN 
	IF ARBOL^.HIJOS[1]=NIL THEN
	BEGIN
		VALOR1:=VALOR2;
	END
	ELSE
	BEGIN
		EVALZ(ARBOL^.HIJOS[2],ESTADO,LF,VALOR3);
		IF ARBOL^.HIJOS[1]^.VOT=MULT THEN
		BEGIN
			VALOR2:=VALOR2*VALOR3;
		END
		ELSE IF ARBOL^.HIJOS[1]^.VOT=DIB THEN
		BEGIN
			VALOR2:=VALOR2/VALOR3;
		END;  
		EVALY(ARBOL^.HIJOS[3],ESTADO,LF,VALOR1,VALOR2);
   
	END;   
END;



PROCEDURE EVALT(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR VALOR1:REAL);
VAR 
	VALOR2:REAL;
BEGIN
	EVALZ(ARBOL^.HIJOS[1],ESTADO,LF,VALOR2);
	EVALY(ARBOL^.HIJOS[2],ESTADO,LF,VALOR1,VALOR2);
END;


PROCEDURE EVALH(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR VALOR:REAL;VAR VALOR1:REAL);
VAR 
	VALOR2:REAL;
BEGIN
	IF ARBOL^.HIJOS[1]=NIL THEN 
	BEGIN
		VALOR:=VALOR1;
	END
	ELSE 
	BEGIN
        if arbol^.hijos[1]^.lexema='+' THEN
        BEGIN
		EVALT(ARBOL^.HIJOS[2],ESTADO,LF,VALOR2);
		VALOR1:=VALOR1+VALOR2;
        EVALH(ARBOL^.HIJOS[3],ESTADO,LF,VALOR,VALOR1);
        END
        ELSE
        BEGIN
        EVALT(ARBOL^.HIJOS[2],ESTADO,LF,VALOR2);
		VALOR1:=VALOR1-VALOR2;
        EVALH(ARBOL^.HIJOS[3],ESTADO,LF,VALOR,VALOR1);
        END;

	END;
END;



PROCEDURE EVALEA(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VAR VALOR:REAL);
VAR 
	VALOR1:REAL;
BEGIN
	EVALT(ARBOL^.HIJOS[1],ESTADO,LF,VALOR1);
	EVALH(ARBOL^.HIJOS[2],ESTADO,LF,VALOR,VALOR1);
END; 

PROCEDURE EVALASIGNACION(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
VAR 
	VALOR:REAL; 
	DIR:TPUNTERO;
BEGIN
	VALOR:=0;
 //EVALUAMOS LA OPERACION ARITMETICA DEL LADO DERECHO DE LA ASIGNACION (hijo 3 del arbol de la expresion) Y OBTENEMOS EL RESULTADO EN LA VARIABLE VALOR
	EVALEA(ARBOL^.HIJOS[3],ESTADO,LF,VALOR);
 //BUSCAMOS LA VARIABLE CORRESPONDIENTE A ESE IDENTIFICADOR (mas especificamente al lexema) Y OBTENEMOS LA DIRECCION DE MEMORIA(apuntador)
	BUSCARLISTA(ESTADO,ARBOL^.HIJOS[1]^.LEXEMA,DIR);
 //ASIGNAMOS EL VALOR A ESA DIRECCION DE MEMORIA
	DIR^.INFO.VALOR:=VALOR;
END;


FUNCTION EVALOPREL(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS):byte;
BEGIN
	if arbol^.hijos[1]^.lexema='<' then
		evaloprel:=1
	else if arbol^.hijos[1]^.lexema='<='then
		evaloprel:=2
	else if arbol^.hijos[1]^.lexema='<>' then
		evaloprel:=3
	else if arbol^.hijos[1]^.lexema='>' then
		evaloprel:=4
	else if arbol^.hijos[1]^.lexema='>=' then 
		evaloprel:=5
	else if arbol^.hijos[1]^.lexema='=' then
		evaloprel:=6; 
END;


FUNCTION EVALP(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS;VALOR:REAL):BOOLEAN;
VAR 
	VALOR1:REAL; 
	A:BYTE;
BEGIN
	EVALEA(ARBOL^.HIJOS[2],ESTADO,LF,VALOR1);
	A:=EVALOPREL(ARBOL^.HIJOS[1],ESTADO,LF);
	EVALP:=FALSE;
	CASE A OF 
		1:BEGIN 
			IF VALOR < VALOR1 THEN
				EVALP:=TRUE;
		END;
		2:BEGIN
			IF VALOR <= VALOR1 THEN 
				EVALP:=TRUE;
		END;
		3:BEGIN 
			IF VALOR <> VALOR1 THEN 
				EVALP:=TRUE;
		END;
		4: BEGIN
			IF VALOR > VALOR1 THEN 
				EVALP:=TRUE;
		END;
		5:BEGIN
			IF VALOR >= VALOR1 THEN
				EVALP:=TRUE;
		END;
		6:BEGIN
			IF VALOR = VALOR1 THEN
				EVALP:=TRUE;
		END
		ELSE EVALP:=FALSE;
	END;
END;


FUNCTION EVALEE(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS):BOOLEAN;
VAR 
	VALOR:REAL;
BEGIN
	EVALEA(ARBOL^.HIJOS[1],ESTADO,LF,VALOR);
	EVALEE:=EVALP(ARBOL^.HIJOS[2],ESTADO,LF,VALOR);
END;


FUNCTION EVALCOND(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS):BOOLEAN;FORWARD;

FUNCTION EVALCOND1(VAR ARBOL:TPUNTEROARBOL; ESTADO:TLISTA; LF:LFS; VALOR:BOOLEAN): BOOLEAN;
BEGIN
	IF ARBOL^.HIJOS[1]=NIL THEN 
	  BEGIN
		EVALCOND1:=VALOR;
	  END
	ELSE IF ARBOL^.HIJOS[1]<>NIL THEN
	BEGIN
		IF ARBOL^.HIJOS[1]^.HIJOS[1]^.VOT= AN THEN
		BEGIN
			IF (VALOR=TRUE) AND (EVALCOND(ARBOL^.HIJOS[2],ESTADO,LF)=TRUE)THEN
			 EVALCOND1:=TRUE
			 ELSE 
				EVALCOND1:=FALSE;
		END 
		ELSE IF ARBOL^.HIJOS[1]^.HIJOS[1]^.VOT = O THEN
		BEGIN
			IF (VALOR=TRUE) OR (EVALCOND(ARBOL^.HIJOS[2],ESTADO,LF)=TRUE)THEN
				EVALCOND1:=TRUE
			ELSE EVALCOND1:=FALSE;
		END;
	END;
END;



FUNCTION EVALCOND(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS):BOOLEAN;
VAR 
	VALOR:BOOLEAN;
BEGIN
	VALOR:=EVALEE(ARBOL^.HIJOS[1],ESTADO,LF);
	EVALCOND:=EVALCOND1(ARBOL^.HIJOS[2],ESTADO,LF,VALOR);
END;



PROCEDURE EVALWHILE(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS);
VAR 
	A:BOOLEAN;
BEGIN
	A:=EVALCOND(ARBOL^.HIJOS[2],ESTADO,LF);
	WHILE A=TRUE DO 
	BEGIN
		EVALBLOQUE(ARBOL^.HIJOS[4],ESTADO,LF);
		A:=EVALCOND(ARBOL^.HIJOS[2],ESTADO,LF);
	END;
END;



FUNCTION EVALB(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs;VAR VALOR:REAL):BOOLEAN;
VAR 
	DIR:TPUNTERO;
BEGIN
	IF ARBOL^.HIJOS[1]<>NIL THEN
	BEGIN
		BUSCARLISTA(ESTADO,ARBOL^.HIJOS[2]^.LEXEMA,DIR);
		VALOR:=DIR^.INFO.VALOR;
		EVALB:=TRUE;
	END
	ELSE EVALB:=FALSE;
END;



PROCEDURE EVALA(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
VAR
	VALOR:REAL;
	DIR:tpuntero;
BEGIN
	IF ARBOL^.HIJOS[1]^.VOT=ID THEN
	begin
		BuscarLista(ESTADO,arbol^.hijos[1]^.lexema,dir);
		writeln(dir^.info.valor:6:2);
	end
	ELSE IF ARBOL^.HIJOS[1]^.VOT=CONSTANTECADENA THEN
	BEGIN
		IF EVALB(ARBOL^.HIJOS[2],ESTADO,LF,VALOR)=TRUE THEN
		BEGIN
			WRITELN(ARBOL^.HIJOS[1]^.LEXEMA,valor:6:2);
		END
		ELSE WRITELN(ARBOL^.HIJOS[1]^.LEXEMA);
	END;
END;	



PROCEDURE EVALESCRITURA(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
BEGIN
	EVALA(ARBOL^.HIJOS[3],ESTADO,LF);
END;


PROCEDURE EVALECTURA(VAR ARBOL:TPUNTEROARBOL;VAR ESTADO:TLISTA;LF:LFs);
VAR 
	DIR:TPUNTERO;
	XA:REAL;
BEGIN
	BuscarLista(ESTADO,ARBOL^.HIJOS[3]^.LEXEMA,DIR);	
	READ(XA);
	DIR^.INFO.VALOR:= XA;
END;


PROCEDURE EVALCUERPO(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);FORWARD;
PROCEDURE EVALIF1(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS);
BEGIN
IF ARBOL^.HIJOS[1]<>NIL THEN
EVALBLOQUE(ARBOL^.HIJOS[2],ESTADO,LF); 
END;

PROCEDURE EVALIF(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS);
BEGIN
	IF  EVALCOND(ARBOL^.HIJOS[2],ESTADO,LF)= TRUE THEN
	BEGIN
		EVALCUERPO(ARBOL^.HIJOS[4],ESTADO,LF);
	END
	ELSE EVALIF1(ARBOL^.HIJOS[5],ESTADO,LF);
	
	END;



 PROCEDURE EVALCASO(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS);
BEGIN
	IF  EVALCOND(ARBOL^.HIJOS[1],ESTADO,LF)= TRUE THEN
	BEGIN
		EVALBLOQUE(ARBOL^.HIJOS[3],ESTADO,LF);
	END;
	
	END;

PROCEDURE EVALCASOS3(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS);
BEGIN
    IF ARBOL^.HIJOS[1]<>NIL THEN
	BEGIN
  	EVALCASO(ARBOL^.HIJOS[1],ESTADO,LF );
    EVALCASOS3(ARBOL^.HIJOS[2],ESTADO,LF );
	END;
	END;

PROCEDURE EVALCASOS2(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS);
BEGIN
	EVALCASO(ARBOL^.HIJOS[1],ESTADO,LF );
    EVALCASOS3(ARBOL^.HIJOS[2],ESTADO,LF );
	END;

PROCEDURE EVALCASOS1(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFS);
BEGIN
EVALCASOS2(ARBOL^.HIJOS[3],ESTADO,LF)  ;
END;




PROCEDURE EVALSENTENCIA(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
BEGIN
	IF ARBOL^.HIJOS[1]^.VOT=LECTURA THEN
	BEGIN
		EVALECTURA(ARBOL^.HIJOS[1],ESTADO,LF);
	END
	ELSE IF ARBOL^.HIJOS[1]^.VOT=ESCRITURA THEN
	BEGIN
		EVALESCRITURA(ARBOL^.HIJOS[1],ESTADO,LF);
	END
	ELSE IF ARBOL^.HIJOS[1]^.VOT=ASIGNACION THEN
	BEGIN 
		EVALASIGNACION(ARBOL^.HIJOS[1],ESTADO,LF);
	END
	ELSE IF ARBOL^.HIJOS[1]^.VOT=WHIL THEN
		EVALWHILE(ARBOL^.HIJOS[1],ESTADO,LF)
	ELSE IF ARBOL^.HIJOS[1]^.VOT=II THEN 
		EVALIF(ARBOL^.HIJOS[1],ESTADO,LF)
	ELSE IF ARBOL^.HIJOS[1]^.VOT=FO THEN
	    EVALFOR(ARBOL^.HIJOS[1],ESTADO,LF)
     ELSE IF ARBOL^.HIJOS[1]^.VOT=CASOS1 THEN
     EVALCASOS1(ARBOL^.HIJOS[1],ESTADO,LF);

END;




PROCEDURE EVALCUERPO1(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
BEGIN
	IF ARBOL^.HIJOS[1]<>NIL THEN
	BEGIN
		EVALSENTENCIA(ARBOL^.HIJOS[1],ESTADO,LF);
		EVALCUERPO1(ARBOL^.HIJOS[2],ESTADO,LF);
	END;
END;



PROCEDURE EVALCUERPO(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
BEGIN
	EVALSENTENCIA(ARBOL^.HIJOS[1],ESTADO,LF);
	EVALCUERPO1(ARBOL^.HIJOS[2],ESTADO,LF);
END;


PROCEDURE EVALBLOQUE(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
BEGIN
	EVALCUERPO(ARBOL^.HIJOS[1],ESTADO,LF);
END;


FUNCTION EVALFUNCIONE(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs):BOOLEAN;
VAR
	LEXEMA:STRING;
	I:BYTE;
BEGIN
	EVALFUNCIONE:=FALSE;
	I:=1;
	LEXEMA:=ARBOL^.HIJOS[2]^.LEXEMA;
 //Se recorre toda la lista de funciones y se comprueba que el lexema este registrado en la lista de funciones, recordemos que las funciones se cargan en el analisis sintactico
	WHILE (I<=LF.TAM) AND (EVALFUNCIONE=FALSE) DO
	BEGIN
		IF LF.INFO[I].LEXEMA=LEXEMA THEN 
			EVALFUNCIONE:=TRUE
		ELSE
		INC(I);
	END;
END;



PROCEDURE EVALFUCTION(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
BEGIN
	IF EVALFUNCIONE(ARBOL^.HIJOS[1],ESTADO,LF)=TRUE THEN
	EVALBLOQUE(ARBOL^.HIJOS[5],ESTADO,LF)
END;



PROCEDURE EVALPROGRAMA1(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
BEGIN
	IF ARBOL^.HIJOS[1]<>NIL THEN
	BEGIN
		EVALFUCTION(ARBOL^.HIJOS[1],ESTADO,LF);
		EVALPROGRAMA1(ARBOL^.HIJOS[2],ESTADO,LF);
	END;
END;


procedure EVALPROGRAMA(VAR ARBOL:TPUNTEROARBOL;ESTADO:TLISTA;LF:LFs);
BEGIN
	EVALFUCTION(ARBOL^.HIJOS[1],ESTADO,LF);
	EVALPROGRAMA1(ARBOL^.HIJOS[2],ESTADO,LF);
END;


end.

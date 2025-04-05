unit UAUTOMATAS;
//Resumen: Esta unit define todos los AFD y el procedimiento Sigcomp_lex.
interface
uses UTIPOS,UTS;

//Resumen:Este procedimiento se utiliza para reconocer una constante real.
//Dado un archivo fuente, la posicion del control sobre el archivo y un lexema. Reconoce si hay un numero real a partir la posicion del control y lo indica en su resultado, devuelve el lexema y la posicion actual del control
Function Es_constante_real(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING):BOOLEAN;
//Resumen:Este procedimiento se utiliza para reconocer una constante cadena.
//Dado un archivo fuente, la posicion del control sobre el archivo y un lexema. Reconoce si hay una cadena en nuestro lenguaje a partir la posicion del control y lo indica en su resultado, devuelve el lexema y la posicion actual del control
Function Es_constante_cadena(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING):BOOLEAN;
//Resumen:Este procedimiento se utiliza para reconocer un identificador.
Function Es_identificador(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING):BOOLEAN;
//Resumen:Este procedimiento se utiliza para reconocer un operador relacional.
Function Es_op_rel(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING;VAR comp_lex:TERMINALES):BOOLEAN;
//Resumen:Este procedimiento se utiliza para reconocer un operador asignacion
Function Es_op_asig(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING;VAR comp_lex:TERMINALES):BOOLEAN;
//Resumen:Este procedimiento se utiliza para reconocer un ioperador aritmetico.
Function Es_op_arit(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING;VAR comp_lex:TERMINALES):BOOLEAN;
//Resuman: Proceso principal para el analizador lexico.
//A partir del archivo fuente y el control, reconoce si hay un componente lexico, guarda la nueva posicion del control, el tipo de componente lexico, el lexema yen el caso de ser necesario lo agrega a la tabla de simbolos
Procedure Sigcomp_lex(VAR fuente:TFUENTE;VAR control:LONGINT;VAR comp_lex:TERMINALES;VAR Lexema:String;VAR L:TLISTA);

implementation

//------------------------------------------------------------------------------Algunas constantes importante------------------------------------------------------------------------------
CONST
//Estado inicial de los automatas
q0=0;

Function Es_constante_real(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING):BOOLEAN;
const
//Conjunto de estados finales
	estados_finales=[1,3];
Type
//Conjunto de estados
	ESTADOS = 0..4;
//Simbolos del alfabeto
	SIGMA=(DIGITO,PUNTO,MENOS,OTRO);
//Funcion de transicion de automata    
	TDELTA=Array[ESTADOS,SIGMA] of ESTADOS;
VAR
	caracter:CHAR;
	estado_actual:ESTADOS;
	delta:TDELTA;
	fin:BOOLEAN;
	saltar:set of CHAR;
//Esta funcion toma un caracter y lo transforma en un simbolo del alfabeto del automata
Function caracter_a_simbolo_automata(caracter:CHAR):SIGMA;
Begin
	Case caracter of
		'0'..'9':caracter_a_simbolo_automata:=DIGITO;
		',':caracter_a_simbolo_automata:=PUNTO;
		'-':caracter_a_simbolo_automata:=MENOS;
		else
			caracter_a_simbolo_automata:=OTRO;
	end;
End;

begin
//Conjunto de caracteres que se deben saltar o ignorar
	saltar:=['<','>','.','=',':','(',')','+','*','/','^'];
//Declaracion de las transiciones de la funcion de transicion
	delta[0,DIGITO]:=1;
	delta[0,MENOS]:=1;
	delta[0,PUNTO]:=4;
	delta[0,OTRO]:=4;
	delta[1,DIGITO]:=1;
	delta[1,MENOS]:=4;
	delta[1,OTRO]:=4;
	delta[1,PUNTO]:=2;
	delta[2,DIGITO]:=3;
    delta[2,MENOS]:=4;
	delta[2,OTRO]:=4;
	delta[2,PUNTO]:=4;
	delta[3,DIGITO]:=3;
    delta[3,MENOS]:=4;
    delta[3,OTRO]:=4;
	delta[3,PUNTO]:=4;
    delta[4,DIGITO]:=4;
    delta[4,MENOS]:=4;
    delta[4,OTRO]:=4;
	delta[4,PUNTO]:=4;
	fin:=FALSE;
	estado_actual:=q0;
	Seek(fuente,control);
	Read(fuente,caracter);
//Vamos leyendo el archivo fuente de a un caracter
	While (caracter > #32) and not (caracter in saltar) and (estado_actual <> 4) and not(fin) do
	begin
		estado_actual:=delta[estado_actual,caracter_a_simbolo_automata(caracter)];
		IF caracter=',' THEN
			lexema:=lexema+'.'
		ELSE
			lexema:=lexema+caracter;
		If not eof(fuente) then
			Read(fuente,caracter)
		else 
			fin:=TRUE;;
	end;
	If estado_actual in estados_finales then
	begin
		Es_constante_real:=TRUE;
		control:=FilePos(fuente)-1;
	end
	else
	begin
		lexema:= '';
		Es_constante_real:=FALSE;
	end;
end;

Function Es_constante_cadena(VAR fuente:TFUENTE; VAR control:LONGINT;VAR lexema:STRING):BOOLEAN;
Const
	estados_finales=[2];
Type
	ESTADOS=0..3;
	SIGMA=(COMILLA,CARACTER_VALIDO,CARACTER_INVALIDO);
	TDELTA=Array[ESTADOS,SIGMA] of ESTADOS;
VAR
	caracter:CHAR;
	delta:TDELTA;
	estado_actual:ESTADOS;
	fin:BOOLEAN;
Function caracter_a_simbolo_automata(caracter:CHAR):SIGMA;
begin
	Case caracter of
		#39: caracter_a_simbolo_automata:=COMILLA;
		#10,#13:caracter_a_simbolo_automata:=CARACTER_INVALIDO;
	else
		caracter_a_simbolo_automata:=CARACTER_VALIDO;
	end;
end;

begin
	delta[0,COMILLA]:=1;
	delta[0,CARACTER_INVALIDO]:=3;
	delta[0,CARACTER_VALIDO]:=3;
	delta[1,CARACTER_VALIDO]:=1;
	delta[1,CARACTER_INVALIDO]:=3;
	delta[1,COMILLA]:=2;
	estado_actual:=q0;
	Seek(fuente,control);
	Read(fuente,caracter);
	estado_actual:=delta[estado_actual,caracter_a_simbolo_automata(caracter)];
	fin:=FALSE;
	If (estado_actual = 1) then
	begin
		While (estado_actual = 1 ) do
		begin
			If NOT (estado_actual in estados_finales) or (estado_actual=3) and not(fin) then
				If not eof(fuente) then
					Read(fuente,caracter)
				else 
					fin:=TRUE;
			estado_actual:=delta[estado_actual,caracter_a_simbolo_automata(caracter)];
			IF NOT (estado_actual IN estados_finales) THEN
				lexema:=lexema+caracter;
		end;
		If estado_actual in estados_finales then
		begin
			Es_constante_cadena:=TRUE;
			control:=FilePos(fuente);
		end
		else
		begin
			lexema:= '';
			Es_constante_cadena:=FALSE;
		end;
	end
	Else
		Es_constante_cadena:=FALSE;
end;

Function Es_identificador(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING):BOOLEAN;
Const
	estados_finales=[1];
type
	ESTADOS=0..2;
	SIGMA=(LETRA,DIGITO,OTRO);
	TDELTA=Array[ESTADOS,SIGMA] of ESTADOS;
VAR
	caracter:CHAR;
	delta:TDELTA;
	estado_actual:ESTADOS;
	fin:BOOLEAN;
	saltar:set of CHAR;
Function caracter_a_simbolo_automata(caracter:CHAR):SIGMA;
begin
	Case caracter of
		'0'..'9':caracter_a_simbolo_automata:=DIGITO;
		'a'..'z','A'..'Z':caracter_a_simbolo_automata:=LETRA;
	else
		caracter_a_simbolo_automata:=OTRO;
	end;
end;

begin
	delta[0,DIGITO]:=2;
	delta[0,LETRA]:=1;
	delta[0,OTRO]:=2;
	delta[1,DIGITO]:=1;
	delta[1,LETRA]:=1;
	delta[1,OTRO]:=2;
	estado_actual:=q0;
	fin:=FALSE;
	saltar:=['<','>','.','=',':','(',')','+','-','*','/',','];
	Seek(fuente,control);
	Read(fuente,caracter);
	While (caracter >#32) and (estado_actual <> 2) and not (caracter in saltar) and not(fin) do
	begin
		estado_actual:=delta[estado_actual,caracter_a_simbolo_automata(caracter)];
		If estado_actual <> 2 then
		begin
			lexema:=lexema+caracter;
			if not eof(fuente) then
				Read(fuente,caracter)
			else
				fin:=TRUE;
		end;
	end;
	If estado_actual in estados_finales then
	begin
		Es_identificador:=TRUE;
		control:=Filepos(fuente)-1
	end
	else
	begin
		lexema:= '';
		Es_identificador:=FALSE;
	end;
 end;

Function Es_op_rel(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING;VAR comp_lex:TERMINALES):BOOLEAN;
const
	estados_finales=[1,2,3];
type
	ESTADOS=0..4;
	SIGMA=(SMAYOR,SMENOR,SIGUAL,OTRO);
	TDELTA=Array[ESTADOS,SIGMA] of ESTADOS;
VAR
	caracter:CHAR;
	estado_actual:ESTADOS;
	delta:TDELTA;
	A:SIGMA;
	fin:BOOLEAN;

function cambio(caracter:CHAR):SIGMA;
begin
	Case caracter of
		'>':cambio:=SMAYOR;
		'<':cambio:=SMENOR;
		'=':cambio:=SIGUAL;
	else
		cambio:=OTRO;
	end;
end;

Begin
	estado_actual:=q0;
	delta[0,SMENOR]:=2;
	delta[0,SMAYOR]:=3;
	delta[0,SIGUAL]:=1;
	delta[1,SMENOR]:=4;
	delta[1,SMAYOR]:=4;
	delta[1,SIGUAL]:=4;
	delta[2,SIGUAL]:=1;
	delta[2,SMAYOR]:=1;
	delta[2,SMENOR]:=4;
	delta[3,SIGUAL]:=1;
	delta[3,SMAYOR]:=4;
	delta[3,SMENOR]:=4;
	Seek(fuente,control);
	read(fuente,caracter);
	A:=cambio(caracter);
	fin:=FALSE;
	While (A <> OTRO) and (estado_actual<>4) and not(fin)  do
	begin
		estado_actual:=delta[estado_actual,A];
		if (estado_actual <> 4) then
		begin
			lexema:=lexema+caracter;
			If not eof(fuente) then
			begin
				read(fuente,caracter);
				A:=cambio(caracter);
			end
			else fin:=TRUE;
		end;
	end;
	if estado_actual in estados_finales then
	begin
		control:= filepos(fuente)-1;
		if lexema='<' then 
			comp_lex:=MENOR
		else if lexema='>'then 
			comp_lex:=MAYOR
		else if lexema='<='then
			comp_lex:=MENORI
		else if lexema='>='then 
			comp_lex:=MAYORI
		else if lexema='<>' then 
			comp_lex:=DISTINTO
		ELSE IF lexema='=' THEN 
			comp_lex:=IGUAL;
		Es_op_rel:= TRUE;
	end
	else
	begin
		lexema:= '';
		Es_op_rel:=FALSE;
	end;
end;

Function Es_op_asig(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING;VAR comp_lex:TERMINALES):BOOLEAN;
Const
	estados_finales=[1,2];
Type
	ESTADOS=0..3;
	SIGMA=(PUNTO,IGUAL,OTRO);
	TDELTA=array[ESTADOS,SIGMA] of ESTADOS;
VAR
	caracter:CHAR;
	A:SIGMA;
	estado_actual:ESTADOS;
	delta:TDELTA;
	fin:BOOLEAN;

Function caracter_a_simbolo_automata(caracter:CHAR):SIGMA ;
begin
	case caracter of
		':':caracter_a_simbolo_automata:=PUNTO;
		'=':caracter_a_simbolo_automata:=IGUAL;
	else
		caracter_a_simbolo_automata:=OTRO;
	end;
end;

Begin
	estado_actual:=q0;
	delta[0,PUNTO]:=1;
	delta[0,IGUAL]:=3;
	delta[1,PUNTO]:=3;
	delta[1,IGUAL]:=2;
	delta[2,IGUAL]:=3;
	delta[2,PUNTO]:=3;
	fin:=FALSE;
	Seek(fuente,control);
	Read(fuente,caracter);
	A:=caracter_a_simbolo_automata(caracter);
	While (A <> OTRO) and (estado_actual<>3) and not(fin) do
	begin
		estado_actual:=delta[estado_actual,A];
		If estado_actual<>3 then
		begin
			lexema:=lexema+caracter;
			if not eof(fuente) then
			begin
				Read(fuente,caracter);
				A:=caracter_a_simbolo_automata(caracter);
			end
			else
			begin 
				fin:=TRUE; 
				A:=OTRO;
			end;
		end;
	end;
	If (estado_actual in estados_finales) then
	begin
		case estado_actual of
			1:comp_lex:=DOSPUNTOS;
			2:comp_lex:=ASIGNACION1;
		END;
		control:=FilePos(fuente)-1;
		Es_op_asig:=TRUE;
	end
	else
	begin
		Es_op_asig:=FALSE;
		lexema:='';
	end;
end;

Function Es_op_arit(VAR fuente:TFUENTE;VAR control:LONGINT;VAR lexema:STRING; VAR comp_lex:TERMINALES):BOOLEAN;
VAR 
	caracter:CHAR;
Begin
	Seek(fuente,control);
	Read(fuente,caracter);
	case caracter of
		'+':begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter; comp_lex:=SUMA; control:=Filepos(fuente);
		end;
       '~':begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter; comp_lex:=RESTA; control:=Filepos(fuente);
		end;
		'*':begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter; comp_lex:=MULT; control:=Filepos(fuente);
		end;
		'/':begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter; comp_lex:=DIB; control:=Filepos(fuente);
		end;
		'(':begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter;comp_lex:=PARENTESISA; control:=Filepos(fuente);
		end;
		')':begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter; comp_lex:=PARENTESISB; control:=Filepos(fuente);
		end;
		'.':begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter; comp_lex:=PUNTO; control:=Filepos(fuente);
		end;
		',':begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter; comp_lex:=COMA; control:=Filepos(fuente);
		end;
		'^': begin
			Es_op_arit:=TRUE; lexema:=lexema+caracter; comp_lex:=POTEN; COntrol:=Filepos(fuente);
		end;  
	else
	Begin 
		Es_op_arit:=FALSE; 
		Lexema:=''; 
	end;
	end;
end;
//Proceso principal del analizador lexico, permite identificar los componentes lexicos del archivo fuente
Procedure Sigcomp_lex(VAR fuente:TFUENTE;VAR control:LONGINT;VAR comp_lex:TERMINALES;VAR Lexema:String;VAR L:TLISTA);
VAR	
	caracter:CHAR;
begin
	lexema:='';
	seek(fuente,control);
	 if not eof(fuente) then
	   Read(fuente,caracter);
	   
	IF EOF(fuente)=TRUE then
	begin
	Write(Fuente,' ');
	control:=control-1;
	end; 	 
	If (caracter > #32) and (not eof (fuente)) then
	Begin
	   
		control:=FilePos(fuente)-1;
		Seek(fuente,control);
		end;
		
		While (caracter < #33) and not eof(fuente) do
		begin
			Read(fuente,caracter);
			If (caracter > #32 )then
				Seek(fuente,FilePos(fuente)-1);
	end;
	control:=FilePos(fuente);
	seek(fuente,control);
	If eof(fuente) then
		comp_lex:=PESOS
	else If Es_identificador(fuente,control,Lexema) then
		Insertartabla (L,lexema,comp_lex)
	else If Es_constante_real(fuente,control,Lexema)then
	begin	
		comp_lex:=CONSTANTEREAL;
	end
	else If Es_constante_cadena(fuente,control,Lexema) then
	begin
		comp_lex:=CONSTANTECADENA;
	end
	else IF Es_op_rel(fuente,control,Lexema,comp_lex) then
		else If Es_op_asig(fuente,control,Lexema,comp_lex) then
			else If Es_op_arit(fuente,control,Lexema,comp_lex) then
				else  comp_lex:=ERRORLEXICO;
WRITELN('Componente lexico: ',NOMBREVARIABLEOTERMINAL[COMP_LEX]);
end;

end.


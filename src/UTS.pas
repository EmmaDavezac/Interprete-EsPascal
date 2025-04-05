unit UTS;
//Resumen: en esta unidad se encuentran todos los procedimientos para el manejo de la tabla de simbolos
//Tabla de palabras reservadas o simbolos
interface
USES UTIPOS;
//Inserta en la lista un elemento del tipo tabla
Procedure Insertar(Var L:Tlista;x:TTabla);
//Carga las palabras reservadas a la tabla de simbolos
Procedure CrearLista(Var L:TLista);
//Carga un componente lexico a la tabla de simbolos
Procedure Insertartabla (var L:Tlista;lexema:string;var complex:TERMINALES);
//Muestra en pantalla el contenido de la lista
PROCEDURE MOSTRARLISTA(VAR L:TLISTA);
//Devuelve la direccion de un elemento de la lista
Procedure BuscarLista(var L:Tlista;lexema:string;var dir:tpuntero);
implementation

Procedure Insertar(Var L:Tlista;x:TTabla);
var
	dir,ant,act:tpuntero;
begin
	New(dir);
	dir^.info:=x;
	If (l.cab=nil) or (l.cab^.info.componente< x.componente) then
	begin
		dir^.sig:=l.cab;
		l.cab:=dir;
	end
	else
	begin
		ant:=l.cab;
		act:=l.cab^.sig;
		while (act<>nil)and (act^.info.componente> x.componente) do
		begin
			ant:=act;
			act:=act^.sig;
		end;
		dir^.sig:=act;
		ant^.sig:=dir;
	end;
	inc(l.tam);
end;

Procedure CrearLista(Var L:TLista);
var x:ttabla;
begin
	L.tam:=0;
	L.Cab:=nil;
	x.componente:=FUNCION;	
	x.lexema:='FUNCION';
	x.valor:=0;
	insertar(L,x);
	x.componente:=LEER;
	x.lexema:='LEER';
	insertar(L,x);
	x.componente:=MOSTRAR;
	x.lexema:='MOSTRAR';
	insertar(L,x);
	x.componente:=SI;
	x.lexema:='SI';
	insertar(L,x);
	x.componente:=SINO;
	x.lexema:='SINO';
	insertar(L,x);
	x.componente:=MIENTRAS;
	x.lexema:='MIENTRAS';
	insertar(L,x);
	x.componente:=PARA;
	x.lexema:='PARA';
	insertar(L,x);
    x.componente:=CASOS;
	x.lexema:='CASOS';
	insertar(L,x);
	x.componente:=FIN;
	x.lexema:='FIN';
	insertar(L,x);
	x.componente:=HASTA;
	x.lexema:='HASTA';
	insertar(L,x);
	x.componente:=AN;
	x.lexema:='AND';
	insertar(L,x);
	x.componente:=O;
	x.lexema:='OR';
	insertar(L,x);
	x.componente:=RAIZ;
	x.lexema:='RAIZ';
	insertar(L,x);
end;

Procedure Insertartabla (var L:Tlista;lexema:string;var complex:TERMINALES);
Var x:Ttabla;
	I:integer;

Procedure BuscarL(var L:Tlista;var x:TTabla);
var 
	dir:tpuntero;
begin
	dir:=l.cab;
	WHILE (dir<>NIL) and (dir^.info.lexema<>x.lexema)  DO
	BEGIN
		dir:=dir^.sig;
	END;

	If (dir=nil) then
	begin
		x.componente:=ID;
		insertar(l,x);
	end
	else
		x.componente:=dir^.info.componente;
end;

begin
	for i:=1 to length(lexema)do
	lexema[I]:=Upcase(Lexema[I]);
	x.lexema:=lexema;
	buscarL(l,x);
	complex:=x.componente;
end;

PROCEDURE MOSTRARLISTA(VAR L:TLISTA);
VAR 
	DIR:TPUNTERO;
BEGIN
	DIR:=L.CAB;
	WHILE DIR<>NIL DO 
	BEGIN
		WRITELN(DIR^.INFO.LEXEMA);
		WRITELN('VALOR',DIR^.INFO.VALOR:4:2);
		DIR:=DIR^.SIG;
	END;
END;

Procedure BuscarLista(var L:Tlista;lexema:string;var dir:tpuntero);
var i:byte;
begin
	dir:=l.cab;
	for i:=1 to length(lexema)do
	lexema[I]:=Upcase(Lexema[I]);
	WHILE (dir<>NIL) and (dir^.info.lexema<>lexema)  DO
		BEGIN
			dir:=dir^.sig;
		END;
	if dir^.info.lexema<>lexema then
	dir:=nil;
end;

end.


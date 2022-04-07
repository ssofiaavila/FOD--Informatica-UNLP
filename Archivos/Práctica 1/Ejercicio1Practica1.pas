{
 1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.
   
}


program Ejercicio1.pas;
type
	archivo= file of integer;
	var arc_logico: archivo;
	nro:integer;
	arc_fisico: string [10];

procedure crearArchivo(var arc_logico: archivo);
var
	nombre:string;
begin
	writeln('Ingrese nombre de archivo: ');
	readln(nombre);
	assign (arc_logico, arc_fisico);
	rewrite(arc_logico);
end;

procedure leerNumeros(var arc_logico: archivo);
begin
	writeln('Ingrese numero ');
	readln(nro);
	while (nro <> 30000) do begin
		write(arc_logico,nro);
		writeln('ingrese numero: ');
		readln(nro);
	end;
	close(arc_logico);
end;


BEGIN 
	
	crearArchivo(arc_logico);
	leerNumeros(arc_logico);
	
	
	
END.

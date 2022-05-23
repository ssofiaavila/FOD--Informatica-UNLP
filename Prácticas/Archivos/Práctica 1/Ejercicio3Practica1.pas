{ 3. Realizar un programa que presente un menú con opciones para:
		a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
		b. Abrir el archivo anteriormente generado y
				i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
				ii. Listar en pantalla los empleados de a uno por línea.
				iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
única vez. }
program Ejercicio3TP1;
type
	cadena= string[15];
	empleado=record
		nro,edad,dni:integer;
		nombre,apellido:cadena;
	end;
	
	archivo= file of empleado;
	
var arch:archivo;


procedure leer(var e: empleado);
begin
	with e do begin
	writeln('Apellido: ');
	readln(apellido);
	if apellido <> 'fin' then begin
		writeln('Nro. empleado: ');
		readln(nro);
		writeln('Nombre: ');
		readln(nombre);
		writeln('Edad: ');
		readln(edad);
		writeln('DNI: ');
		readln(dni);
	end;
	end;
end;

procedure imprimir(e: empleado);
begin
	with e do 
		writeln('Numero: ', nro, ' Edad: ', edad, ' DNI: ', dni, ' Nombre: ', nombre, ' Apellido: ');
end;	

procedure listadoCriterio(var arch:archivo);
var
	reg: empleado;
	igual:cadena;
begin
	Writeln('Nombre u apellido por el cual listar: ');
	readln(igual);
	reset(arch);
	while (not eof(arch)) do begin
		read(arch,reg);
		if (reg.nombre = igual) or (reg.apellido = igual) then
			imprimir(reg);
	end;
	Close(arch);
end;
	



procedure listarTodos(var arch: archivo);
var
	e:empleado;
begin
	reset(arch);
	while (not eof(arch)) do begin
		read(arch,e);
		imprimir(e);
	end;
	Close(arch);
end;


procedure listarMayores(var arch:archivo);
var
	e:empleado;
begin
	reset(arch);
	while (not eof(arch)) do begin
		read(arch,e);
		imprimir(e);
	end;
	Close(arch);
end;

procedure abrir(var arch:archivo);
var
	nombre:cadena;
	opcion:integer;
begin
	Writeln('--- Nombre del archivo: ');
	readln(nombre);
	Assign(arch,nombre);		
	Writeln('--- Ingrese opcion ---');
	Writeln(' 1: Listar empleados por nombre/ apellido determinado ');	
	Writeln(' 2: Listar todos los empleados ');
	Writeln( '3: Listar mayores de 70 ');
	Writeln(' 0: Salir ');
	readln(opcion);
	repeat
		case opcion of 
			1: listadoCriterio(arch);
			2: listarTodos(arch);
			3: listarMayores(arch);
		
		end;
	until opcion=0;
end;
	
procedure crear(var arch:archivo);
var
	fisico:cadena;
	e:empleado;
begin
	Writeln('Nombre del archivo: ');
	readln(fisico);
	assign(arch,fisico);
	rewrite(arch);
	leer(e);
	while e.apellido <> 'fin' do begin
		Write(arch,e);
		leer(e)
	end;
	Close(arch);
	abrir(arch);
end;

	
	
	
	


var
	opcion:integer; 
begin
	Writeln('--- Ingrese opcion ---');
	Writeln('1: crear archivo ');
	Writeln('2: abrir archivo ');
	Writeln('0: salir del menu ');
	readln(opcion);
	case opcion of
			1: crear(arch);
			2: abrir(arch);
			end;
	Writeln('Exit ');
	


end.



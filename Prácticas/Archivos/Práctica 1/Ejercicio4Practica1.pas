{4. Agregar al menú del programa del ejercicio 3, opciones para:
		a. Añadir una o más empleados al final del archivo con sus datos ingresados por
teclado.
		b. Modificar edad a una o más empleados.
		c. Exportar el contenido del archivo a un archivo de texto llamado
“todos_empleados.txt”.
		d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.}
 
program ejercicio4TP1;
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

procedure agregarEmpleado(var arch:archivo);
var 
  reg: empleado;
begin
  reset(arch);
  leer(reg);
  seek(arch,FileSize(arch));
  while (reg.apellido <> 'fin') do
	begin
      write(arch,reg);
      leer(reg);
    end;
  Close(arch);
End;

procedure modificarEdad(var arch:archivo);
var
  reg:empleado;
  nro: integer;
  edad: integer;
  ok: boolean;
begin
	ok := false;
	reset(arch);
	write('Ingrese numero del empleado a modificar: ');
	write('Finaliza la modificacion al ingresar -1 ');
	readln(nro);
	while not(nro = -1) do begin
		while not (eof(arch)) do begin
			read(arch,reg);
			if(reg.nro = nro) then begin
				writeln('Empleado encontrado.');
				write('ingrese la edad para modificarlo: ');
				readln(edad);
				reg.edad := edad;
				seek(arch,filepos(arch)-1);
				write(arch,reg);
				ok:= true;
			end
		end;
		if not (ok) then
			writeln('El empleado no se econtro');
		write('Ingrese numero del empleado a modificar: ');
		readln(nro);
		seek(arch,0);
		ok:= false;
	end;
  close(arch);
end;

procedure exportarTexto(var arch:archivo);
var
	texto:Text;
	reg:empleado;
begin
	assign(texto,'todos_empleados.txt');
	rewrite(texto);
	reset(arch);
	while (not eof(arch)) do begin
		read(arch,reg);
		write(texto, 'Apellido: ', reg.apellido , ' Nombre: ', reg.nombre, ' Numero de empleado: ', reg.nro ,' Edad: ',reg.edad,' Dni: ', reg.dni,' ');	
	end;
	close(arch);
	close(texto);
	
end;

procedure exportarSinDNI(var arch: archivo);
var
	texto: Text;
	reg:empleado;
begin
	assign(texto, 'faltaDNIEmpleado.txt');
	reset(arch);
	rewrite(texto);	
	while (not eof(arch)) do begin
		read(arch,reg);
		if (reg.dni = 00) then
			write(texto, 'Apellido: ', reg.apellido , ' Nombre: ', reg.nombre, ' Numero de empleado: ', reg.nro ,' Edad: ',reg.edad,' Dni: ', reg.dni,' ');	
	end;
	close(arch);
	close(texto);
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
	Writeln('4: Agregar empleado '); 
	Writeln(' 5: Modificar edad ');
	Writeln(' 6: Exportar a archivo de texto ');
	Writeln(' 7: Exportar a archivo de texto los sin DNI ');
	
	Writeln(' 0: Salir ');
	readln(opcion);
	repeat
		case opcion of 
			1: listadoCriterio(arch);
			2: listarTodos(arch);
			3: listarMayores(arch);
			4: agregarEmpleado(arch);
			5: modificarEdad(arch);		
			6:exportarTexto(arch);
			7: exportarSinDNI(arch);
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
	readln(opcion);
	case opcion of
			1: crear(arch);
			2: abrir(arch);
			end;
	Writeln('Exit ');
	


end.





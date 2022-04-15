 {1. Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados),
agregándole una opción para realizar bajas copiando el último registro del archivo en
la posición del registro a borrar y luego truncando el archivo en la posición del último
registro de forma tal de evitar duplicados}
 
 program ejercicio1TP3;
 
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
	Writeln('Nombre o apellido por el cual listar: ');
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


procedure baja(var arch: archivo);
var
    regAux,regUltimo:empleado;
    nroEliminado,size:integer;
begin
    writeln('Numero del empleado a eliminar'); 
    readln(nroEliminado);
    reset(arch);
    seek(arch,filesize(arch));
    read(arch,regAux);
    seek(arch,0);
    read(arch,regAux);
    while (not eof (arch)) and (regAux.nro <> nroEliminado) do begin
        read(arch,regAux);
    end;
    regAux:=regUltimo;
    seek(arch,filepos(arch)-1);
    write(arch,regAux);
    seek(arch,filesize(arch));
    read(arch,regAux);
    regAux.nro:= 9999; //marca para eliminacion logica, CONSULTAR
    seek(arch,filepos(arch)-1);
    write(arch,regAux);
    close(arch);

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
    Writeln('8: Realizar baja ');
	
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
            8: baja(arch);
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


{
2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática.
Por cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
   a. Actualizar el archivo maestro de la siguiente manera:
		i.Si aprobó el final se incrementa en uno la cantidad de materias con final
		aprobado.
		ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
	b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.
}


program ejercicio2TP2;
type
	cadena=string[20];
	alumno=record
		cod:integer;
		apellido:cadena;
		nombre:cadena;
		aprobadas_cursada:integer;
		aprobadas_final:integer;
	end;
	materia=record	
		cod:integer;
		aprobo_cursada:boolean;
		aprobo_final:boolean;
	end;
	
	master= file of alumno;
	detail= file of materia;
	
	

procedure actualizar_maestro(var maestro:master;var detalle:detail);
var
	regM:alumno;
	regD:materia;
	cod_actual:integer;
	cant_final,cant_cursada:integer;
begin
	reset(maestro); //abro archivos
	reset(detalle);	
	while not eof(detalle) do begin //mientras que no haya leido todos los detalles
		read(maestro,regM); //traigo un registro de cada uno, los dos estan ordenados
		read(detalle,regD); //por codigo
		while (regM.cod <> regD.cod) do //busco del maestro indicado
			read(maestro,regM);
		cod_actual:=regD.cod; //guardo valores
		cant_final:=0; //inicializo los aprobados
		cant_cursada:=0;
		while (regD.cod = cod_actual) do begin //mientras los detalles tengan igual codigo
			if (regD.aprobo_cursada) then 
				cant_final:=cant_final+1; 
			if (regD.aprobo_final) then
				cant_cursada:=cant_cursada+1;
		end;
		regM.aprobadas_cursada:=regM.aprobadas_cursada+cant_cursada;
		regM.aprobadas_final:=regM.aprobadas_final+cant_final; //actualizo maestro
		seek(maestro,filepos(maestro)-1); //porque despues de un write o read avanza puntero
		write(maestro,regM); //guardo el registro del maestro actualizado
	end;		
	close(maestro);
	close(detalle);			
		
end;
	
		
procedure listar(var maestro:master; var detalle:detail);
var
	txt:Text;
	regM:alumno;
	regD:materia;
	cod_actual,cant_cursada:integer;
	
begin
	assign(txt,'alumnos_cursada.txt');
	rewrite(txt);
	reset(maestro);
	reset(detalle);
	while not eof(detalle) do begin
		read(maestro,regM);
		read(detalle,regD);
		while (regM.cod <> regD.cod) do
			read(maestro,regM);
		cod_actual:=regD.cod;
		cant_cursada:=0;
		while (regD.cod= cod_actual) do begin
			if (regD.aprobo_cursada) and not (regD.aprobo_final) then
				cant_cursada:=cant_cursada+1;
		end;
		if cant_cursada > 4 then
			write(txt, 'Codigo: ',regM.cod, 'Apellido: ',regM.apellido, 'Nombre: ', regM.nombre, 'Cantidad cursadas aprobadas: ', cant_cursada);
	
	end;
end;

	
procedure menu(var maestro:master; var detalle:detail);
var
	opcion:integer;
begin
	writeln('Seleccione opcion ');
	writeln('1: actualizar detalle');
	writeln('2: listar en archivo de texto ');
	writeln('0: salir del menu ');
	readln(opcion);
	case opcion of
		1: actualizar_maestro(maestro,detalle);
		2: listar(maestro,detalle);
		0:halt;
	else
		writeln('Opcion incorrecta');
	
	end;
end;

	
	
var
	maestro:master;
	detalle:detail;
begin
	assign(maestro,'arch_maestro');
	assign(detalle, 'arch_detalle');
	menu(maestro,detalle);


end.



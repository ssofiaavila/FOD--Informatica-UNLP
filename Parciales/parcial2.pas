program parcial2;
type
	cadena=string[20[;
	municipio=record
		nombre:cadena;
		descripcion:cadena;
		cant_habitantes:integer;
		mts2:integer;
		anio:integer;
	end;
	archivo=file of municipio;
	
function ExisteMunicipio(var arch:archivo; nombre:cadena): boolean;
var
	reg:municipio;
	encontre:boolean;
begin
	reset(arch);
	encontre:=false;
	read(arch,reg);
	while (not eof(arch) and (reg.nombre<> nombre) do begin
		if reg.nombnre=nombre then
			encontre:=true
		else
			read(arch,reg);
	end;
	close(arch);
	existeMunicipio:=encontre;
end;

procedure insertar(var arch:archivo; nuevoi:municipio);
var

	aux:municipio;
begin
	reset(arch)
	read(arch,aux);
	if (aux.cant_habitantes < 0) then begin
		seek(arch, (aux.cant_habitantes)*-1);
		read(arch,aux);
		seek(arch,filepos(arch)-1);
		write(arch,nuevo);
		seek(arch,0);
		write(arch,aux);
	end
	else
		begin
			seek(arch,filesize(arch));
			write(arch,nuevo);
		end;
	close(arch);
end;


procedure AltaMunicipio(var arch:archivo);
var
	nuevo:municipio;
begin
	writeln('Nombre de municipio a insertar ');
	read(nuevo.nombre);
	if not ExisteMunicipio(arch,reg.nombre) then begin
		with nuevo do begin
			writeln('Descripcion: ');
			read(descripcion);
			writlen('Cantidad de habitantes: ');
			read(cant_habitantes);
			writeln('Metros cuadrados: ');
			read(mts2);
			writeln('Año de creacion: ');
			read(anio);
		end;
		insertar(arch,nuevo);
	end
	else
		writeln('Ya existe el municipio en el archivo ');
end;



procedure eliminar(var arch:archivo; nombre: cadena);
vaR
	head:integer;
	reg:municipio;
begin
	reset(arch);
	read(arch,reg);
	head:=reg.cant_habitantes;
	while (reg.nombre <> nombre) do
		read(arch,reg);
	reg.cant_habitantes:=head;
	head:=(-1*filepos(arch)-1);
	seek(arch,filepos(arch)-1);
	write(arch,reg);
	seek(arch,0);
	reg.cant_habitantes:=head;
	write(arch,reg);
	close(arch);
end;
		
		
procedure BajaMunicipio(var arch:archivo);
var
	nombre:cadena;
begin
	writeln('Ingrese nombre de municipio a eliminar ');
	read(nombre);
	if ExisteMunicipio(arch,nombre) then
		eliminar(arch,nombre)
	else
		writeln('Municipio no existente');
end;



{programa principal}
var
	arch:archivo;
begin
	assign(arch,'municipios.arch');
end.
{no hay llamada al resto de los modulos porque solo era necesario iomplementarlos pero no usarlos} 

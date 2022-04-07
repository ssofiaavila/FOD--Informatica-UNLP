{ 7. Realizar un programa que permita:
		a. Crear un archivo binario a partir de la información almacenada en un archivo
	 de texto.
El nombre del archivo de texto es: “novelas.txt”
	b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
	 agregar
una novela y modificar una existente. Las búsquedas se realizan por código de novela.
NOTA: La información en el archivo de texto consiste en: código de novela,
nombre,género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.}

program ejercicio7TP1;
type 
	cadena=string[20];
	novela=record
		cod:integer;
		precio:real;
		genero:cadena;
		nombre:cadena;
	end;
	
	archivo=file of novela;

//inciso a
procedure crear_binario(var arch:archivo);
var
	txt: Text;
	n:novela;
begin
	assign(txt,'novelas.txt');
	reset(txt);
	assign(arch,'novelas');
	rewrite(arch);
	while (not eof(txt)) do begin
		readln(txt,n.cod,n.precio,n.genero);
		readln(txt,n.nombre);
	end;
	close(txt);
	close(arch);
end;
	
	
		
procedure leer(var n:novela);
begin
	with n do begin
		writeln('Codigo de novela: ');
		readln(cod);
		writeln('Precio: ');
		readln(precio);
		writeln('Genero: ');
		readln(genero);
		writeln('Nombre: ');
		readln(nombre);
	end;
end;

//inciso b i
procedure agregar_novela(var arch:archivo);
var
	n:novela;
begin
	reset(arch);
	leer(n);
	seek(arch,filepos(arch));
	write(arch,n);
	close(arch);
end;

//inciso b ii
procedure modificar_novela(var arch:archivo);
var 
	n:novela;
	nombre:cadena;
	encontro:boolean;
begin
	encontro:=false;
	writeln('Nombre de novela a modificar: ');
	readln(nombre);
	reset(arch);
	while (not eof(arch)) and (not encontro) do begin
		read(arch,n);
		if n.nombre = nombre then begin
			leer(n);
			seek(arch,filepos(arch)-1);
			write(arch,n);
			encontro:=true;
		end;
	end;
	if encontro then
		writeln('Se modifico el producto')
	else
		writeln('No se encontro producto con ese nombre ');
end;


procedure menu(var arch:archivo);
var
	opcion:integer;
begin
	writeln('Ingrese operacion que desee hacer ');
	writeln('1: agregar novela' );
	writeln('2: modificar novela ');
	writeln('0: salir' );
	readln(opcion);
	repeat
		case opcion of
			1: agregar_novela(arch);
			2:modificar_novela(arch);
			0: halt;
		else
			writeln('Opcion incorrecta');
		end;
	
	until opcion=0;
end;	


var
	arch:archivo;
begin
	crear_binario(arch);
	menu(arch);
	
	
end.

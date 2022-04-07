{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
	a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripcion, marca, precio, stock mínimo y el stock disponible.
	b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
	c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
	d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo.

NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.
* 
* NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.
* 
* }

program Ejercicio5TP1;
type
	cadena=string[15];
	celular=record
		cod:integer;
		precio:real;
		marca:cadena;
		stockDispo:integer;
		stockMinimo:integer;
		descripcion:cadena;
		nombre:cadena;
	end;
	
	archivo= file of celular;


//inciso a
procedure crear_archivo(var arch:archivo);
var
	txt: Text;
	c:celular;
begin
	assign(txt,'celulares.txt');
	reset(txt);
	rewrite(arch);
	while (not eof(arch)) do begin
		readln(txt,c.cod,c.precio,c.marca);
		readln(txt,c.stockDispo,c.stockMinimo,c.descripcion);
		readln(txt,c.nombre);
		write(arch,c);
	end;
	close(arch);
	close(txt);
end;
	
	
procedure imprimirCelu(c:celular);
begin
	with c do begin	
		writeln('Codigo: ',c.cod);
		writeln('Precio: ', c.precio);
		writeln('Marca: ', c.marca);
		writeln('Stock disponible: ', c.stockDispo);
		writeln('Stock minimo: ', c.stockMinimo);
		writeln('Descripcion: ', c.descripcion);
		writeln('Nombre: ',c.nombre);
		
	end;
end;
	
//inciso b
procedure listar_minimo_stock(var arch:archivo);
var
	c:celular;
begin
	reset(arch);
	writeln('Productos con stock menor al minimo ');
	while (not eof(arch)) do begin
		read(arch,c);
		if (c.stockDispo < c.stockMinimo) then 
			imprimirCelu(c);

	end;
	close(arch);
end;


//inciso c
procedure listar_con_descripcion(var arch:archivo);
var
	c:celular;
	desc:cadena;
	encontro:boolean;
begin
	encontro:=false;
	reset(arch);
	writeln('Ingrese descripcion: ');
	readln(desc);
	writeln('Productos que coinciden con la descripcion ingresada: ');
	while (not eof(arch)) do begin
		read(arch,c);
		if (c.descripcion = desc) then begin
			imprimirCelu(c);
			encontro:= true;
		end;
	end;
	if (not encontro) then
		writeln('No se hallo ningun resultado');
	close(arch);
end;	
	
	
//inciso c		
procedure exportar_archivo(var arch: archivo);
var
	txt:Text;
	c:celular;
begin
	assign(txt,'celulares.txt');
	reset(arch);
	rewrite(txt);
	while (not eof(arch)) do begin
		read(arch,c);
		write(txt,'Codigo: ', c.cod, 'Precio: ', c.precio, 'Marca: ',c.marca, 'Stock disponible: ',c.stockDispo, 'Stock minimo', c.stockMinimo, 'Descripcion: ', c.descripcion, 'Nombre: ', c.nombre);
	end;
	close(arch);
	close(txt);
end;



	

procedure mostrarMenu(var arch:archivo);
var
	opcion: integer;
begin
	writeln('Seleccione opcion ');
	writeln('1: crear archivo binario ');
	writeln('2: listar celulares con stock menor al minimo ');
	writeln('3: listar celulares con determinada descripcion ');
	writeln('4: exportar archivo binario a texto ');
	writeln('0: salir del menu ');	
	readln(opcion);
	case opcion of 
        1: crear_archivo(arch);
        2: listar_minimo_stock(arch);
        3: listar_con_descripcion(arch);
        4: exportar_archivo(arch);
        5: halt;
        else begin
            writeln('Ingreso una opcion invalida. Vuelva a intentar.');
            mostrarMenu(arch);
        end;
 end;
	
	
	
end;

var
	arch:archivo;
	nombre_arch:cadena;	

begin
	mostrarMenu(arch);
	Writeln('Nombre de archivo binario: ');	
	readln(nombre_arch);
	assign(arch,nombre_arch);
	mostrarMenu(arch);
	
	


end.

{
   6. Agregar al menú del programa del ejercicio 5, opciones para:
		d. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
	e. Modificar el stock de un celular dado.
	f. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.   
   
}


program ejercicio6TP1;

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

procedure leer(var c:celular);
begin
	with c do begin
		writeln('Codigo ');
		readln(cod);
		if cod <> -1 then begin
			writeln('Precio: ');
			readln(precio);
			writeln('Marca: ');
			readln(marca);
			writeln('Stock disponible: ');
			readln(stockDispo);
			writeln('Stock minimo: ');
			readln(stockMinimo);
			writeln('Descripcion: ');
			readln(descripcion);
			writeln('Nombre: ');
			readln(nombre);
		end;
	end;
end;

//inciso d
procedure agregar_producto(var arch:archivo);
var
	c:celular;
begin
	reset(arch);
	leer(c);
	seek(arch,filesize(arch));
	while (c.cod <> -1) do begin
		write(arch,c);
		leer(c);
	end;
	close(arch);
end;


//inciso e
procedure modificar_stock(var arch:archivo);
var
	c:celular;
	nombre:cadena;
	encontro:boolean;
	nuevo:integer;
begin
	encontro:=false;
	reset(arch);	
	writeln('Nombre de celular para modificar: ');
	readln(nombre);
	while (not eof(arch)) and (not encontro) do begin
		read(arch,c);
		if c.nombre = nombre then begin
			writeln('Ingrese nuevo stock');
			readln(nuevo);
			c.stockDispo:= nuevo;
			seek(arch,filepos(arch)-1);
			write(arch,c);
			encontro:=true;
		end;
	end;
	if encontro then 
		writeln('Se modifico el stock ')
	else
		writeln('No se encontro el celular ');
	close(arch);
end;

//inciso f
procedure exportar_sin_stock(var arch:archivo);
var
	txt:Text;
	c:celular;
begin
	reset(arch);
	assign(txt,'SinStock.txt');
	rewrite(txt);
	while (not eof(arch)) do begin
		read(arch,c);
		if c.stockDispo =0 then begin
			writeln(txt, c.cod,' ',c.precio, c.marca);
            writeln(txt, c.stockDispo,' ',c.stockMinimo, c.descripcion);
            writeln(txt, c.nombre);
        end;
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
	writeln('5: agregar producto ');
	writeln('6: modificar stock ');
	writeln('7: exportar los que no tienen stock');
	writeln('0: salir del menu ');	
	readln(opcion);
	case opcion of 
        1: crear_archivo(arch);
        2: listar_minimo_stock(arch);
        3: listar_con_descripcion(arch);
        4: exportar_archivo(arch);
        5: agregar_producto(arch);
        6: modificar_stock(arch);
        7: exportar_sin_stock(arch);
        0: halt;
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


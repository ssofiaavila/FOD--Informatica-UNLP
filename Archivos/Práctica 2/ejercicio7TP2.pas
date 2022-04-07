{7- El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos
los productos que comercializa. De cada producto se maneja la siguiente información:
código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.
Se pide realizar un programa con opciones para:
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.}
program ejercicio7TP2;
const
	corte=9999;
type
	cadena=string[20];
	producto=record
		cod_pdto:integer;
		nombre_comercial:cadena;
		precio:real;
		stock_actual:integer;
		stock_minimo:integer;
	end;
	
	venta=record
		cod_pdto:integer;
		cant_vendida:integer;
	end;
	
	maestro=file of producto;
	detalle=file of venta;
	
	
	
// MODULO PARA ACTUALIZAR DETALLE
procedure leer(var arch:detalle; var reg:venta);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.cod_pdto:=corte;
end;

procedure actualizarMaestro(var mae:maestro; var det:detalle);
var
	regD:venta;
	regM:producto;
begin
	reset(mae);
	reset(det);
	leer(det,regD);
	while regD.cod_pdto <> corte do begin
		read(mae,regM);
		while (regm.cod_pdto <> regd.cod_pdto) do
			read(mae,regM);
		while (regm.cod_pdto = regd.cod_pdto) do begin
			regm.stock_actual:=regm.stock_actual - regd.cant_vendida;
			leer(det,regD);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regM);
	end;
	close(det);
	close(mae);
end;
	
	
// modulo generar arch de txt
procedure generarArch(var mae:maestro);
var
	txt:Text;
	reg:producto;
begin
	assign(txt, 'arch_pdtos.txt');
	rewrite(txt);
	reset(txt);
	while not eof(mae) do begin
		read(mae,reg);
		if (reg.stock_actual < reg.stock_minimo) then begin
			with reg do begin
				write(txt, 'Cod producto: ', cod_pdto, 'Nombre: ', nombre_comercial, 'Precio: ',precio, 'Stock actual: ', stock_actual, 'Stock minimo: ', stock_minimo);
			end;
		end;
	end;
end;
		

var
	mae:maestro;
	det:detalle;
begin
	assign(mae,'arch maestro');
	assign(det,'arch detalle');
	actualizarMaestro(mae,det);
	generarArch(mae);
end.
	
	
		


{8. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el
total mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el 
año por el cliente.
Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por 
la empresa. El formato del archivo maestro está dado por: cliente (cod cliente,
 nombre y apellido), año, mes, día y monto de la venta.
El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras.}
program ejercicio8TP2;
const
	corte=9999;
type
	cadena=string[20];
	venta=record
		cod_cliente:integer;
		nombre:cadena;
		apellido:cadena;
		anio:integer;
		mes:integer;
		dia:integer;
		monto:real;
	end;
	
	archivo=file of venta;
	
	
// MODULOS PARA INFORMAR CLIENTES

procedure leer(var arch:archivo; var reg:venta);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.cod_cliente:=corte;
end;

procedure informarClientes(var arch:archivo);
var
	reg:venta;
	anio_act:integer;
	mes_act:integer;
	cod_actual:integer;
	total_act_anio,total_act_mes,total_empresa:real;	
begin
	total_empresa:=0;
	reset(arch);
	leer(arch,reg);
	while reg.cod_cliente<> corte do begin		
		anio_act:=reg.anio;
		total_act_anio:=0;
		cod_actual:=reg.cod_cliente;
		Writeln('Compras de: ',reg.nombre);
		while reg.anio = anio_act do begin			
			total_act_mes:=0;
			mes_act:=reg.mes;
			while (reg.anio = anio_act) and (reg.mes = mes_act) and (reg.cod_cliente = cod_actual) do begin
				total_act_mes:=total_act_mes + reg.monto;
				total_act_anio:= total_act_anio + reg.monto;
				leer(arch,reg);
			end;
			writeln('Compras para el mes numero: ', mes_act, ' ', total_act_mes);
		end;
		writeln('Compras para el anio:', anio_act, ' ', total_act_anio);
		total_empresa:=total_empresa + total_act_anio;
	end;
	close(arch);
end;
			
			
				
		
	
	
var
	arch:archivo;
begin
	assign(arch,'clientes');
	informarClientes(arch);

end.

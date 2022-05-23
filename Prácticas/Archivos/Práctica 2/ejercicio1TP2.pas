{
1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.
   
}


program ejercicio1TP2;
const
	valor_alto=9999;
type
	cadena=string[20];
	empleado=record
		cod:integer;
		nombre:cadena;
		comision:real;
	end;
	
	archivo=file of empleado;
	

procedure leer(var arch:archivo;var e:empleado);
begin
	if (not eof(archivo)) then 	
		read(archivo,e)
	else
		e.cod:=valor_alto;
end;
	
var
	original,resumen:archivo;
	e:empleado;	

begin
	assign(original,'original');
	assign(resumen,'resumen');
	reset(original);
	rewrite(resumen);
	leer(arch,e);
	while (e.cod <> valor_alto) do begin
		total.comision:=0;
		total.nombre:=e.nombre;
		total.cod:=e.cod;
		while (total.cod = e.cod) do begin			
			total.comision:=total.comision + e.comision;
			leer(arch,e);
		end;
		write(resumen,total);
	end;
	writeln('Fin de compactacion del archivo');
	close(original);
	close(resumen);	
	
end.

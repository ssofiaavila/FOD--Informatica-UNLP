{10. Se tiene información en un archivo de las horas extras realizadas por los empleados
de una empresa en un mes. Para cada empleado se tiene la siguiente información:
departamento, división, número de empleado, categoría y cantidad de horas extras
realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por
departamento, luego por división, y por último, por número de empleados. Presentar en
pantalla un listado con el siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____ 
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.
}
program ejercicio10TP2;
const
	corte=9999;
	dimF=15;
type
	rango=1..dimF;
	empleado=record
		depto:integer;
		division:integer;
		nro_empleado:integer;
		categoria:rango;
		horas_extras:integer;
	end;
	
	categorias=record
		cat:rango;
		precio:real;
	end;
	vector= array [1..dimF] of real;
	
	archivo= file of empleado;


//MODULOS PARA LEER LOS VALORES

procedure cargarVector(var vc:vector);
var
	txt:Text;
	reg:categorias;
	i:integer;
begin
	assign(txt, 'valores_horas_extra.txt');
	reset(txt);
	for i:=1 to dimF do begin
		readln(txt,reg.precio);
		vc[i]:= reg.precio;
	end;
end;



///modulos para informar

procedure leer(var arch:archivo; var reg:empleado);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.depto:=corte;
end;


procedure informar(var arch:archivo; vc:vector);
var
	reg:empleado;
	depto_actual,div_actual, horas_depto,horas_div:integer;
	monto_division, monto_depto,monto:real;
begin
	reset(arch);
	leer(arch,reg);
	while reg.depto <> corte do begin
		depto_actual:= reg.depto;
		writeln('Departamento: ', depto_actual);
		horas_depto:=0;
		monto_depto:=0;
		while (depto_actual = reg.depto) do begin
			div_actual:= reg.division;
			writeln('Division: ', div_actual);
			monto_division:=0;
			horas_div:=0;
			while (depto_actual = reg.depto) and (div_actual = reg.division) do begin
				monto:=reg.horas_extras* vc[reg.categoria];
				writeln('Numero de empleado: ',reg.nro_empleado, ' Cant horas: ',reg.horas_extras, ' Monto a cobrar: ', monto:0:2);
				horas_div:=horas_div+ reg.horas_extras;
				monto_division:=monto_division + monto;
				leer(arch,reg);
				writeln();
			end;
			monto_depto:=monto_depto+monto_division;
			horas_depto:=horas_depto+horas_div;
			writeln('Horas de division: ', div_actual, ': ', horas_div);
			writeln('Monto de division: ', div_actual, ': ', monto_division);
			writeln();
		end;
		writeln('Depto: ', depto_actual, ' Total horas: ', horas_depto, ' Monto total: ', monto_depto);
		writeln();
	end;
	close(arch);
	
end;				

var
	arch:archivo;
	vc:vector;
begin
	assign(arch, 'empleados');
	cargarVector(vc);
	informar(arch,vc);
	
	
	
end.

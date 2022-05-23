{11. A partir de información sobre la alfabetización en la Argentina, se necesita 
actualizar un archivo que contiene los siguientes datos: nombre de provincia, cantidad 
de personas alfabetizadas y total de encuestados. Se reciben dos archivos detalle 
provenientes de dos agencias de censo diferentes, dichos archivos contienen: nombre 
de la provincia, código de localidad, cantidad de alfabetizados y cantidad de encuestados. 
Se pide realizar los módulos necesarios para actualizar el archivo maestro a partir
de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia.}
program ejercicio11TP2;
const 
	corte='ZZZZ';
type
	cadena=string[20];
	reg_maestro=record
		nombre_prov:cadena;
		cant_alfabeto:integer;
		cant_encuestados:integer;
	end;
	
	reg_detalle=record
		nombre_prov:cadena;
		cod_localidad:integer;
		cant_alfabeto:integer;
		cant_encuestados:integer;
	end;
	
	maestro= file of reg_maestro;
	detalle= file of reg_detalle;



//MODULOS PARA ACTUALIZAR MAESTRO

procedure leer(var arch: detalle; var reg:reg_detalle);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.nombre_prov:=corte;
end;


procedure minimo(var r1,r2,min:reg_detalle);
begin
	if (r1.nombre_prov < r2.nombre_prov) then
		min:=r1
	else
		min:=r2;
end;

procedure actualizar(var mae:maestro; var det1:detalle; var det2:detalle);
var
	regM:reg_maestro;
	reg1,reg2,min:reg_detalle;	
begin
	reset(mae);
	reset(det1);
	reset(det2);
	leer(det1,reg1);
	leer(det2,reg2);
	minimo(reg1,reg2,min);
	while min.nombre_prov <> corte do begin
		read(mae,regM);
		while regM.nombre_prov <> regM.nombre_prov do
			read(mae,regM);
		while (regM.nombre_prov = min.nombre_prov) do begin
			regM.cant_alfabeto:= min.cant_alfabeto;
			regM.cant_encuestados:= min.cant_encuestados;
			minimo(reg1,reg2,min);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regM);
	end;
		
end;



var
	mae:maestro;
	det1,det2:detalle;
begin
	assign(mae,'maestro');
	assign(det1, 'detalle1');
	assign(det2, 'detalle2');
	actualizar(mae,det1,det2);
	
end.

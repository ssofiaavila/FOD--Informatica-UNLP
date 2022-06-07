program ejercicio13;
const
	dimF=30;
	corte=9999;
type
	cadena=string[50];
	reg_detalle=record
		cod_farmaco:integer;
		nombre:cadena;
		cant_vendida:integer;
		forma_pago:string;
	end;
	arch_detalle=file of reg_detalle;
	vc_detalles=array[1..dimF] of arch_detalle;
	vc_registros= array[1..dimF] of reg_detalle;
	
procedure leer(var arch:arch_detalle; var reg:reg_detalle);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.cod_farmado:=corte;
end;
	
	
procedure assignVc(var detalles:vc_detalles; var registros:vc_registros);
var
	i:integer;
	num:cadena;
begin
	for i:=1 to dimF do begin
		Str(num,i);
		assign(detalles[i],'detalle',num);
		reset(detalles[i]);
		leer(detalles[i],registros[i]);
	end;
end;


procedure minimo(var detalles:vc_detalles; var registros:vc_registros; var reg:reg_detalle);
var
	i,indiceMin:integer;
begin
	reg.cod_farmaco:=corte;
	indiceMin:=-1;
	for i:=1 to dimF do begin
		if registros[i].cod_farmaco < reg.cod_farmaco then begin
			indiceMin:=i;
			reg.cod_farmaco:=registros[i].cod_farmaco;
		end;
	end;
	if indiceMin <> -1 then begin
		reg:=registros[indiceMin];
		leer(detalles[indiceMin],registros[indiceMin]);
	end;
end;
	

procedure seekVc(var detalles:vc_detalles; var registros:vc_registros);
var
	i:integer;
begin
	for i:=1 to dimF do begin
		seek(detalles[i],0);
		read(detalles[i],registros[i]);
	end;
end;

	
	
procedure informarMayorVendido(var detalles:vc_detalles; var registros:vc_registros);
var
	min:reg_detalle;
	cod_actual:integer;
	total_actual:integer;
	max_total:integer
	max_cod:integer;
begin
	max_total:=-1;
	minimo(detalles,registros,min);
	while min.cod_farmaco <> corte do begin
		cod_actual:=min.cod_farmaco;
		total_actual:=0
		while (cod_actual = min.cod_farmaco) do begin
			total_actual:=total_actual+ min.cant_vendida;
			minimo(detalles,registros,min);
		end;
		if total_actual > max_total then begin
			max_total:=total_actual;
			max_cod:=cod_actual;
		end;
	end;
end;
	
procedure generarTexto(var txt
	
	
	
var
	txt:Text;
	detalles:vc_detalles;
	registros:vc_registros;
begin
	assingVc(detalles,registros);
	assign(txt,'resumen_farmacos.txt');
	informarMayorVendido(detalles,registros);
	seekVc(detalles,registros);
	generarTexto(txt,detalles,registros);
	
	
	

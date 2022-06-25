program ejercicio9;
const
	dimF=3;
type
	cadena=string[20];
	reg_detalle=record
		cod_bebida,cant_total_vendida:integer;
		nombre:cadena;
	end;
	detalle=file of reg_detalle;
	
	reg_maestro=record
		cod_bebida,cant_total_vendida:integer;
		nombre:cadena;
	end;
	
	maestro=file of reg_maestro;
	
	vc_detalles=array[1..dimF]of detalle;
	vc_registros=array[1..dimF] of reg_detalle;

procedure leer(var arch:detalle; var reg:reg_detalle);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.cod_bebida:=corte;
end;

	
procedure assignVc(var detalles: vc_detalles; var registros:vc_registros);
var
	i:integer;
	num:cadena;
begin
	for i:=1 to dimF do begin
		Str(num,i);
		assign(detalles[i],'detalle:'num);
		reset(detalles[i]);
		leer(detalles[i],registros[i]);
	end;
end;
	
	
procedure minimo(var detalles:vc_detalles, var registros:vc_registros; var reg:reg_detalle);
var
	i,indiceMin:integer;
begin
	indiceMin:=-1;
	reg.cod_bebida:=corte;
	for i:=1 to dimF do begin
		if reg.cod_bebida < registros[i].cod_bebida then begin
			indiceMin:=i;
			reg.cod_bebida:=registros[i].cod_bebida;
		end;
	end;
	if indiceMin <> -1 then begin
		reg:=registros[indiceMin];
		leer(detalles[indiceMin],registros[indiceMin]);
	end;
end;

procedure closeVc(var detalles:vc_detalles);
var
	i:integer;
begin
	for i:=1 to dimF do
		close(detalles[i]);
end;
	
procedure generarMaestro(var mae:maestro; var detalles:vc_detalles; var registros:vc_registros);
var
	aux:reg_detalle;
	mae1:reg_maestro;
begin
	assign(mae,'archivo_maestro');
	rewrite(mae);
	minimo(detalles,registros,aux);
	while aux.cod_bebida <> corte do begin
		mae1.cod_bebida:=aux.cod_bebida;
		mae1.cant_total_vendida:= 0;
		mae1.nombre:=aux.nombre
		while aux.cod_bebida = mae1.cod_bebida do begin
			mae1.cod_total_vendida:=mae1.cant_total_vendida + aux.cant_total_vendida;
			minimo(detalles,registros,aux);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,mae1);
	end;
	close(mae);
	closeVc(detalles);
end;
	
	
var
	mae:maestro;
	detalles:vc_detalles;
	registros:vc_registros;
begin
	assignVc(detalles,registros);
	generarMaestro(mae,detalles,regisros);
		
	

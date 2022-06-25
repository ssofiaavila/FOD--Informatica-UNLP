program ejercicio8;
const
	corte=9999;
	dimF=3;
type
	cadeba=string[20];
	proceso=record
		cod_proceso:integer;
		nombre,fechaYHora_acceso:cadena;
	end;
	
	resumen=record
		cod_proceso,cant_total_accesos:integer;
		nombre:cadena;
	end;
	
	maestro=file of resumen;
	detalle=file of proceso;
	vc_detalle= array[1..dimF] of detalle;
	vc_procesos=array[1..dimF] of proceso;

procedure leer(var arch:detalle; var reg:proceso);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.cod_proceso:=corte;
end;


procedure assignVc(var vc:vc_detalle; var registros:vc_procesos);
var
	i:integer;
	num:cadena;
begin
	for i:=1 to dimF do begin
		Str(num,i);
		assign(vc[i],'detalle:'num);
		reset(vc[i]);
		leer(vc[i],registros[i]);
	end;
end;


procedure closeVc(var vc:vc_detalles);
var
	i:integer;
begin
	for i:=1 to dimF do
		close(vc[i]);
end;
	
	
procedure minimo(var vc:vc_detalles; var registros:vc_procesos; var reg:proceso);	
var
	i,indiceMin:integer;
begin	
	indiceMin:=-1;
	reg.cod_proceso:=corte;
	for i:=1 to dimF do begin
		if registros[i].cod_proceso < reg.cod_procesos do begin
			reg.cod_prccesos:=registros[i];
			indiceMin:=1;
		end;
	end;
	if indiceMin<>-1 then begin
		reg:=registros[indiceMin];
		leer(vc[indiceMin],registros[indiceMin]);
	end;
end;
			
	

procedure generarMaestro(var mae:maestro; var vc:vc_detalles; var registros:vc_procesos);
var
	aux:proceso;
	mae1:resumen;
	cod_actual:integer;
	nombre_actual:cadena;
	total_actual:integer;
begin
	assign(mae,'accesos_datos_dat');
	minimo(vc,registros,aux);
	while aux.cod_proceso <> corte do begin
		mae1.cod_proceso:= aux.cod_proceso;
		mae1.cant_total_accesos:=0;
		mae1.nombre:=aux.nombre;
		while aux.cod_proceso = mae1.cod_proceso do begin
			mae1.cant_total_accesos:=mae1.cant_total_accesos + 1;
			minimo(vc,registros,aux);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,mae1);
	end;
	close(mae);
	closeVc(vc);
end;


	
var
	mae:maestro;
	vc:vc_detalle;
	registros:vc_procesos;
begin
	assignVc(vc,registros);
	generarMaestro(mae,vc,registros);

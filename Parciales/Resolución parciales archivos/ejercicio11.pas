program ejercicio11;
const
	corte=9999;
	dimF=25;
type
	cadena=string[20];
	reg_detalle=record
		nro_ticket,cod_pdto,cant_vendida:integer;
	end;
	
	reg_maestro=record
		cod_pdto,stock_actual,stock_minimo:integer;
		descripcion:cadena;
		precio:real;
	end;
	
	archivo_detalle=file of reg_detalle;
	archivo_maestro=file of reg_maestro;
	
	vc_detalles=array[1..dimF] of archivo_detalle;
	vc_registros=array[1..dimF] of reg_detalle;


procedure leer(var arch:archivo_detalle; var reg:reg_detalle);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.cod_pdto:=corte;
end;




procedure assignVc(var detalles:vc_detalle; var registros:vc_registros);
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
	
	
procedure minimo(var deta:vc_detalles; var registros:vc_registros; var reg:reg_detalle);
var
	i,indiceMin:integer;
begin
	indiceMin:=-1;
	reg.cod_pdto:=corte;
	for i:=1 to dimF do begin
		if registros[i].cod_pdto < reg.cod_pdto then begin
			reg.cod_pdto:=registros[i].cod_pdto;
			indiceMin:=-1;
		end;
	end;
	if indiceMin <> -1 then begin
		reg:=registros[indiceMin];
		leer(deta[indiceMin],registros[indiceMin]);
	end;
end;
	
	
procedure closeVc(var deta:vc_detalles);
var
	i:integer;
begin
	for i:=1 to dimF do
		close(deta[1);
end;
	
	
procedure actualizarMaestro(var mae:archivo_maestro; var deta:vc_detalles; var registros:vc_detalles);
var
	mae1:reg_maestro;
	aux:reg_detalle;
	total_actual:integer;
begin
	reset(mae);
	minimo(deta,registros,aux);
	while aux.cod_pdto <> corte do begin
		read(mae,mae1);
		while mae1.cod_pdto <> aux.cod_pdto do
			read(mae,mae1);
		total_actual:=0;
		while aux.cod_pdto = mae1.cod_pdto do begin
			total_actual:=total_actual + aux.cant_vendida;
			minimo(deta,registros,aux);
		end;
		if mae1.stock_actual > total_actual then
			mae1.stock_actual:= mae1.stock_actual - total_actual;
		if (mae1.stock_actual < mae1.stock_minimo) then
			writeln('Producto: ', mae1.cod_pdto, ' quedo por debajo del stock minimo');
		writeln('Producto: ', mae1.cod_pdto,'cantidad vendida: ', total_actual, ' total vendido: ', total_actual * mae1.precio);
		seek(mae,filepos(mae)-1);
		write(mae,mae1);
	end;
	close(mae);
	closeVc(deta);
end;
			
	
	
	
var
	maestro=archivo_maestro;
	detalles:vc_detalles;
	registros:vc_detalles;
begin
	assign(maestro,'maestro.arch');
	assignVc(detalles,registros);
	actualizarMaestro(maestro,detalles,registros);
	

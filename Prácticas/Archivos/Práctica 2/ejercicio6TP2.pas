
{6- Se desea modelar la información necesaria para un sistema de recuentos de casos de
covid para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casos
activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
nuevos, cantidad recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}

program ejercicio6TP2;
const
	corte=9999;
type
	cadena=string[20];
	municipio= record
		cod_localidad:integer;
		cod_cepa:integer;
		casos_activos:integer;
		casos_nuevos:integer;
		casos_recuperados:integer;
		casos_fallecidos:integer;
	end;
	
	maestro=record
		cod_localidad:integer;
		nombre_localidad:cadena;
		cod_cepa:integer;
		nombre_cepa:cadena;
		casos_activos:integer;
		casos_nuevos:integer;
		casos_recuperados:integer;
		casos_fallecidos:integer;
	end;
	
	detalles=file of municipio;
	master=file of maestro;
	
	det=array [1..10] of detalles;	
	
//abro los detalles
procedure crearDetalles(var vc:det);
var
	i:integer;
	num:cadena;
begin
	for i:= 1 to 10 do begin
		Str(i,num);
		assign(vc[i],'Localidad numero: '+num);
		reset(vc[i]);
	end;
end;


// MODULOS PARA ACTUALIZAR MAESTRO

procedure leer_detalle(var arch:detalles; var reg:municipio);
begin
	if not eof(arch) then 
		read(arch,reg)
	else
		reg.cod_localidad:=corte;
end;

procedure actualizarMaestro(var mae:master; var vc_detalles:det);
var
	regMae:maestro;
	i:integer;
	regDet:municipio;
begin
	assign(mae,'arch_maestro');
	reset(mae);
	for i:=1 to 30 do begin
		reset(vc_detalles[i]);
		leer_detalle(vc_detalles[i],regDet);
		while (regDet.cod_localidad <> corte) do begin
			read(mae,regMae);
			with regMae do begin
				cod_localidad:=regDet.cod_localidad;
				casos_activos:=regDet.casos_activos;
				casos_nuevos:=regDet.casos_nuevos;
				casos_recuperados:=casos_recuperados+regDet.casos_recuperados;
				casos_fallecidos:=casos_fallecidos+regDet.casos_fallecidos;
			end;
			seek(mae,filepos(mae)-1);
			write(mae,regMae);
			close(vc_detalles[1]);
		end;
	end;
	close(mae);
end;
	
	

//modulo para informar localidades con mas de 50 activos 
procedure informar_mas50(var mae:master);
var
	regM:maestro;
begin
	reset(mae);
	while not eof(mae) do begin
		read(mae,regM);
		if regM.casos_activos >= 50 then
			writeln(regM.nombre_localidad)
	end;
	close(mae);
end;
	
	
var
	vc_detalles:det;
	mae:master;
begin
	assign(mae, 'arch_maestro');
	crearDetalles(vc_detalles);
	actualizarMaestro(mae,vc_detalles);
	informar_mas50(mae);
	

end.

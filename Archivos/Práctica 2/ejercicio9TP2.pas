{9. Se necesita contabilizar los votos de las diferentes mesas electorales registradas
por provincia y localidad. Para ello, se posee un archivo con la siguiente información:
código de provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información se encuentra ordenada por código de provincia y código de
localidad.}
program ejercicio8TP2;
const
	corte=9999;
type
	registro=record
		cod_prov:integer;
		cod_localidad:integer;
		nro_mesa:integer;
		cant_votos:integer;
	end;
	
	archivo=file of registro;
 //no seria un vector porque no indica cant de provincias o algo asi
 
 
// modulos para informar votaciones	


procedure leer(var arch:archivo; var reg:registro);
begin
	if not eof(arch) then 
		read(arch,reg)
	else
		reg.cod_prov:= corte;
end;

procedure informar(var arch:archivo);
var
	reg:registro;
	total_prov,total_loc,prov_actual,loc_actual:integer;
begin
	reset(arch);
	leer(arch,reg);
	while (reg.cod_prov <> corte) do begin
		prov_actual:=reg.cod_prov;
		total_prov:=0;
		while (prov_actual = reg.cod_prov) do begin
			loc_actual:= reg.cod_localidad;
			total_loc:=0;
			while (prov_actual =  reg.cod_prov) and (loc_actual= reg.cod_localidad) do begin
				total_prov:=total_prov + reg.cant_votos;
				total_loc:=total_loc+ reg.cant_votos;
			end;
			writeln(' Codigo de provincia: ', prov_actual);
			writeln(' Localidad: ', loc_actual, ' Cant votos: ', total_loc);
		end;
		writeln(' Total votos en provincia: ', total_prov);
	end;
	close(arch);
end;
			
	
	
var
	arch:archivo;
begin
	assign(arch,'votaciones');
	informar(arch);

end.



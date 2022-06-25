program ejercicio7;
const
	dimF=50;
	corte=9999;
type
	cadena=string[30];
	
	nacimiento=record
		nro_partida:integer;
		nombre:cadena;
		apellido:cadena;
		calle:cadena;
		nro:integer;
		depto:integer;
		piso:integer;
		ciudad:cadena;
		matricula_medico:cadena;
		nombre_apellido_madre:cadena;
		dni_madre:integer;
		nombre_apellido_padre:cadena;
		dni_padre:integer;
	end;
	
	fallecimiento=record
		nro_partida:integer;
		dni:integer;
		nombre:cadena;
		apellido:integer;
		matricula_medico:cadena;
		dia:integer;
		mes:integer;
		anio:integer;
		hora:integer;
		minutos:integer;
		lugar:cadena;
	end;
	
	master=record
		nro_partida:integer;
		nombre:cadena;
		apellido:cadena;
		calle:cadena;
		nro:integer;
		piso:integer;
		depto:integer;
		ciudad:cadena;
		matricula_medico:cadena;		
		nombre_apellido_madre:cadena;
		dni_madre:integer;
		nombre_apellido_padre:cadena;
		dni_padre:integer;
		fallecido:boolean;
		matricula_deceso:cadena;
		dia:integer;
		mes:integer;
		anio:integer;
		lugar:cadena;
	end;
	
	
	//archivos
	born=file of nacimiento;
	dead=file of fallecimiento;
	maestro=file of master;
	
	
	//vc de archivos
	vc_nac= array [1..dimF] of born; 
	vc_fall=array [1..dimF] of dead;
	
	//vc registros
	regNac= array[1..dimF] of nacimiento;
	regFall= array [1..dimF] of fallecimiento;
	
	
procedure leerNac(var arch:born; var reg: nacimiento);
begin
		if not eof(arch) then 
			read(arch,reg)
		else
			reg.nro_partida:=corte;
end;

procedure leerFall(var arch:dead; var reg:fallecimiento);
begin
	if not eof(arch) then 
			read(arch,reg)
		else
			reg.nro_partida:=corte;
end;	
	
	
// MINIMOS 
procedure minNacimiento(var detalles_nac: vc_nac; var reg_nac: regNac; var registro:nacimiento);
var
	i,posMin:integer;
begin
	posMin:= -1;
	registro.nro_partida:=corte;
	for i:=1 to dimF do begin
		if(reg_nac[i].nro_partida<registro.nro_partida) then
			posMin:=i;
			
	end;
	if (posMin <> -1) then begin
		registro:=reg_nac[posMin];
		leerNac(detalles_nac[posMin], reg_nac[posMin]);
	end;
end;
	
procedure minFallecimiento(var detalles_fall:vc_fall; var reg_fall:regFall; var registro: fallecimiento);
var
	i,posMin:integer;
begin
	posMin:=-1;
	registro.nro_partida:=corte;
	for i:=1 to dimF do begin
		if (reg_fall[i].nro_partida < registro.nro_partida) then 
			posMin:=i;
	end;
	if posMin <> -1 then begin
		registro:=reg_fall[posMin];
		leerFall(detalles_fall[posMin],reg_fall[posMin]);
	end;
end;
			
	
	





//--------------- GENERO MAESTRO ----------------

procedure crearMaestro(var mae:maestro; var detallesFallecimientos: vc_fall; var detallesNacimientos: vc_nac; var reg_nac: regNac; var reg_fall:regFall);
var
	minNac:nacimiento;
	minFall:fallecimiento;
	regMae:master;
	i:integer;
begin
	assign(mae, 'Actas.doc'); //genero arch maestro
	rewrite(mae);
		
	minNacimiento(detallesNacimientos, reg_nac, minNac); //busco minimo de cada uno
	minFallecimiento(detallesFallecimientos, reg_fall,minFall);
	
	while minNac.nro_partida <> corte do begin
		with regMae do begin
			fallecido:=false;
			nro_partida:=minNac.nro_partida;
			nombre:=minNac.nombre;
			apellido:=minNac.apellido;
			calle:=minNac.calle;
			nro:= minNac.nro;
			piso:=minNac.piso;
			depto:=minNac.depto;
			ciudad:=minNac.ciudad;
			matricula_medico:=minNac.matricula_medico;	
			nombre_apellido_madre:=minNac.nombre_apellido_madre;
			dni_madre:=minNac.dni_madre;
			nombre_apellido_padre:=minNac.nombre_apellido_padre;
			dni_padre:=minNac.dni_padre;
			if minNac.nro_partida = minFall.nro_partida then begin
				fallecido:=true;
				matricula_deceso:=minFall.matricula_medico;
				dia:=minFall.dia;
				mes:=minFall.mes;
				anio:=minFall.anio;
				lugar:=minFall.lugar;
			end;
		end;
		write(mae,regMae);
		minNacimiento(detallesNacimientos, reg_nac, minNac); 
		minFallecimiento(detallesFallecimientos, reg_fall,minFall);
	end;
	close(mae);
	for i:=1 to dimF do begin 
		close(detallesNacimientos[i]);
		close(detallesFallecimientos[i]);
	end;
end;
		
		
var
	mae:maestro;
	detallesFallecimientos:vc_fall;
	detallesNacimientos:vc_nac;
	
	registros_nacimientos:regNac;
	registros_fallecimientos:regFall;
	
	i:integer;
	indice:cadena;
	
		
	
begin
	for i:=1 to dimF do begin
		Str(i,indice);
		assign(detallesNacimientos[i], 'Archivo de nacimientos. Delegacion: '+indice);
		reset(detallesNacimientos[i]);
		assign(detallesFallecimientos[i], 'Archivo de defunciones. Delegacion: '+indice);
		reset(detallesFallecimientos[i]);
		leerNac(detallesNacimientos[i],registros_nacimientos[i]); //traigo de cada archivo un elemento
		leerFall(detallesFallecimientos[i],registros_fallecimientos[i]);
	end;
	crearMaestro(mae,detallesFallecimientos,detallesNacimientos, registros_nacimientos, registros_fallecimientos);
	
	
	

end.
program parcial1;
const	corte='ZZZ';
type
	cadena=string[20];
	venta=record
		razon:cadena;
		genero:cadena;
		nombre:cadena;
		precio:integer;
		cant:integer;
	end;
	
	archivo=file of venta;
	
	
procedure leer(var arch:archivo; var reg:venta);
begin
		if not eof(arch) then
			read(arch,reg)
		else
			reg.razon:=corte;
end;
	
	
procedure informarVentas(var arch:archivo);
var
	razon_act,genero_act,nombre_act:cadena;
	total,total_genero,total_libro,cant_libro:integer;
	reg:venta;
	
begin
	reset(arch);
	leer(arch,reg);
	total:=0;
	while reg.razon <> corte do begin
		razon_act:=reg.razon;
		writeln('Libreria: ',reg.razon);
		total_genero:=0;	
		while (reg.genero= genero_act) do begin
			writeln('Genero: ', reg.genero);
			genero_act:=reg.genero;
			total_libro:=0;
			while (reg.razon=razon_act) and (reg.genero = genero_act) do begin
				writeln('Nombre de libro: ',reg.nombre);
				nombre_act:=reg.nombre;
				total_libro:=reg.precio;
				cant_libro:=0;
				while (reg.razon=razon_act) and (reg.genero=genero_act) and (reg.nombre=nombre_act) do begin
					cant_libro:=cant_libro + reg.cant;
					leer(arch,reg);
				end;
				total_libro:=total_libro*cant_libro;
				writeln('Total vendido libro: ',nombre_act, ' : ', total_libro_);
				total_genero:=total_genero+ total_libro;
			end;
			writeln('Monto vendido genero ', genero_act, ': ',total_genero);
			total_razon:=total_razon+ total_genero;
		end;
		writeln('Monto vendido libreria ', razon_act, ': ', total_razon);
		total:=total+ total_razon;
	end;
	writeln('Monto total librerias: ', total);
	close(arch);
end;
					
						
	
var
	arch:archivo;
begin
	assign(arch,'ventas.arch');
	informarVentas(arch);
end.

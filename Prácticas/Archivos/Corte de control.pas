{se almacena en un archivo la información de venta de una cadena de elctrodomésticos. Es necesario informar el total vendido en cada sucursal, ciudad, provincia como el total final.
El archivo está ordenado por provincia, ciudad y sucursal}

program ejemplo;
const
	valor_alto='ZZZ';
type
	nombre=string[20];
	reg_venta=record
		vendedor:integer;
		monto:real;
		sucursal:nombre;
		ciudad:nombre;
		provincia:nombre;
	end;
	ventas=file of reg_ventas;

procedure leer(var arch: archivo; var dato:reg_venta);
begin
	if not eof(arch) then
		read(arch,dato)
	else
		dato.provincia:=valor_alto;
end;

procedure corteControl(var arch::archivo);
var
	reg:reg_venta;
	total,totalProv,totalCiudad,totSuc:integer;
	prov,ciudad,sucursal:nombre;
begin
	reset(arch);
	total:=0;
	while reg.provincia <> valor_alto do begin
		write('Prov: ', reg.provincia);
		prov:=reg.provincia;
		totProv:=0;
		while (prov= reg.provincia) do begin
			writeln('Ciudad: ', reg.ciudad);
			totCiudad:=0;
			while (prov=reg.provincia) and (ciudad=reg.ciudad) do begin
				writeln('Sucursal: ', reg.sucursal);
				sucursal:=reg.sucursal;
				totSuc:=0;
				while (prov=reg.provincia) and (ciudad=reg.provincia) and (sucursal=reg.sucursal) do begin	
					write('Vendedor: ', reg.vendedor);
					write(reg.monto);
					totSuc:=totSuc+ reg.monto;
					leer(arch,reg);
				end;
				writeln('Total sucursal:', totSuc);
				totalCiudad:=totalCiudad+totSuc;
			end;
			writeln('Total ciudad: ', totCiudad);
			totProv:= totProv+ totCiudad;
		end;
		writeln('Total provincia: ', totProv);
		total:=total+ totProv;
	end;
	wirteln('Total empresa: ',total);
	close(arch);
end;

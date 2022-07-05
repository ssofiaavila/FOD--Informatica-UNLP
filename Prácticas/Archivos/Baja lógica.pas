begin
	reset(arch);
	while not eof(arch) do begin
		read(arch,reg);
		if reg.nro < condicion theb begin
			aux:="*",reg.nombre; //* es la marcacion de eliminacion logica
			reg.nombre:=aux;
		end;
		seek(arch,filepos(arch)-1);
		write(arch,reg);
	end;
	close(arch);
end;
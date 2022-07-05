var
	cod,head:integer;
	reg:novela;
begin
	reset(arch);
	read(arch,reg);
	head:=reg.cod; //en oa primera posicion del archivo tengo indices
	while (not eof(arch) and (reg.cod <> cod) do // busco el que quiero eliminar
		read(arch,reg);
	if not eof(arch) then begin //significa que salió del while porque encontré el elemento
		reg.cod:=head;
		head:= (-1* (filepos(arch)-1)); //guardo posición del elemento que borré y lo paso a negativo indicando que es un espacio libre para llevarlo a head
		seek(arch,filepos(arch)-1);
		write(arch,reg);
		seek(srch,0);
		reg.cod:=head;
		write(arch,reg);
	end;
	close(arch);
end;
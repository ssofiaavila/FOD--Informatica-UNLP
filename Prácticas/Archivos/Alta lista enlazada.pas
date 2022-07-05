var
	flor,aux:registro;
begin
	flor.cod:=cod;
	reset(arch);
	read(arch,aux);
	if aux.cod < 0 then begin //significa que hay algun registro que borré y puedo reutilizarlo
		seek(arch, Abs(aux.cod)); //función para el absoluto, si no hago (aux.cod * -1)
		read(arch,aux); //leo lo que tiene esa posicion para despues llevarlo a head
		seek(arch,filepos(arch)-1);
		write(arch,flor); //inserto el nuevo elemento;
		seek(arch,0); //vuelvo a head
		write(arch,aux); //escribo dato que había en la posición donde inserté
	end
	else //en caso de que aux.cod > 0 significa que no hay un espacio libre por lo tanto tengo que insertar al final del archivo
	begin
		seek(arch,filesize(arch);
		write(arch,flor);
	end;
end;


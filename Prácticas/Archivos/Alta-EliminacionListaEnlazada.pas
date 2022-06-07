procedure eliminarNovela(var arch: archivo);
var
    cod:integer;
    head:integer;
    reg:novela;
    str:cadena;
begin
    writeln('Ingrese nombre de archivo');
    readln(str);
    assign(arch,str);
    writeln('Codigo de novela para eliminar: ');
    readln(cod);
    reset(arch);
    read(arch,reg);
    head:=reg.cod; //leo primera posicion donde tengo el indice
    while ((not eof(arch)) and (reg.cod <> cod) do
        read(arch,reg);
    if (not eof(arch)) then begin
        reg.cod:=head; 
        head:=(-1* filepos(arch));  //guardo la posicion del registro que elimine y lo paso a negativo
        seek(arch,filepos(arch)-1)); //lo ubico en la posicion que lo eliminé
        write(arch,reg); 
        seek(arch,0); //me ubico en el indice otra vez
        reg.cod:= head; 
        write(arch,reg);
    end
    else
        write('No fue eliminado ');
    close(arch); 
end;

procedure agregarFlor(var arch:archivo, nombre: string; cod:integer);
var
    flor,aux:reg_flor;
begin
    flor.cod:=cod;
    flor.nombre:=nombre;
    reset(arch);
    read(arch,aux);
    if aux.codigo < 0 then begin
        seek(arch,Abs(aux.codigo);
        read(arch,aux);
        seek(arch, filepos(arch)-1);
        write(arch,flor);
        seek(arch,0);
        write(arch,aux);
    end
    else begin
        seek(arch,filepos(arch));
        write(arch,flor);
    end;
    close(arch);
end;

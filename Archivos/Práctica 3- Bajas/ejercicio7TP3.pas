{7. Se cuenta con un archivo que almacena información sobre especies de aves en
vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las especies a
eliminar. Deberá realizar todas las declaraciones necesarias, implementar todos los
procedimientos que requiera y una alternativa para borrar los registros. Para ello deberá
implementar dos procedimientos, uno que marque los registros a borrar y posteriormente
otro procedimiento que compacte el archivo, quitando los registros marcados. Para
quitar los registros se deberá copiar el último registro del archivo en la posición del registro
a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros
duplicados.
Nota: Las bajas deben finalizar al recibir el código 500000}
program ejercicio7TP3;
const
    fin=500000;
type
    cadena=string[50];
    ave=record
        cod:integer;
        nombre_especie:cadena;
        familia:cadena;
        descripcion:cadena;
        zona:cadena;
    end;

    archivo= file of ave;


//modulos para las bajas
procedure baja_logica(var arch:archivo);
var
    reg:ave;
    cod:integer;
begin
    reset(arch);
    write('Codigo de ave: ');
    read(cod);
    while not eof(arch) and cod <> fin do begin
        read(arch,reg);
        while (not eof(arch) and (reg.cod <> cod) do
            read(arch,reg);
        if not eof(arch) then begin
            str:= '#'+ reg.nombre_especie;
            reg.nombre_especie:= str;
            seek(arch,filepos(arch)-1);
            write(arch,reg);
        end;
    end;
    close(arch);
end;


procedure compactar(var arch:archivo; pos:integer; var cont:integer);
var
    reg:ave;
    aux:integer;
begin
    aux:=filesize(arch)-1;
    seek(arch,(aux-cont);
    read(arch,reg);
    seek(arch,pos);
    write(arch,reg);
    cont:=cont+1;
end;


procedure truncar(var arch: archivo);


procedure compactacion(var arch:archivo);
var
    reg:ave;
    cont:integer;
begin
    reset(arch);
    cont:=0;
    while (filepos(arch) <> (filepos(arch) - cont) do begin
        read(arch,reg);
        if pos('#',reg.nombre_especie) then begin
            compactar(arch,(filepos(arch)-1,cont);
            seek(a,filepos(arch)-1);
        end;
    end;
    seek(arch,(filesize(arch)-cont);
    truncate(arch);
    close(arch);
end;




var
    arch:archivo;
    nombre:cadena;
begin
    write('Nombre de archivo: ');
    read(nombre);
    assign(arch,nombre);
    baja_logica(arch);
    compactacion(arch);
end.

{4. Dada la siguiente estructura:
type
reg_flor = record
nombre: String[45];
codigo:integer;
tArchFlores = file of reg_flor;
Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
a. Implemente el siguiente módulo:
{Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descripta anteriormente 
procedure agregarFlor (var a: tArchFlores ; nombre: string;
codigo:integer);
b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado. }

program ejercicio4TP3;
const
    corte= 9999;
type
    reg_flor=record
        nombre:String[45];
        codigo:integer;

    arch_flores= file of reg_flor;


//modulos para crear el archivo
procedure leer(var reg:reg_flor);
begin
    with reg do begin
        write('Codigo: ');
        read(codigo);
        if codigo <> corte then begin
            write('Nombre: ');
            read(nombre);
        end;
    end;
end;

procedure crearArch(var arch: arch_flores); //implemento lista enlazada
var
    reg:reg_flor;
begin
    rewrite(arch);
    reg.cod:=0;
    write(arch,reg);
    leer(reg);
    while (reg.cod <> corte) do begin
        write(arch,reg);
        leer(reg);
    end;
    close(arch);
end;


//modulos para agregar flores
procedure agregarFlor(var arch:archivo, nombre: string; cod:integer);
var
    flor,aux:reg_flor;
begin
    flor.cod:=cod;
    flor.nombre:=nombre;
    reset(arch);
    read(arch,aux);
    if aux.codigo > 0 then begin
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


//modulos para listar contenido de arch 
procedure listar_contenido(var arch: archivo);
var
    reg:reg_flor;
begin
    while not eof(arch) do begin
        read(arch,reg);
        if reg.codigo > 0 then 
            Writeln('Nombre: ', reg.nombre, ' Codigo: ', reg.codigo);
    end;
    
end;

var
    arch:arch_flores;
begin 
    assign(arch,'flores');
    crearArch(arch);
    agregarFlor(arch,'Lavanda',1);
    agregarFlor(arch, 'Rosa', 4);
    agregarFlor(arch, 'Bonsai', 10);
    listar_contenido(arch);
end.

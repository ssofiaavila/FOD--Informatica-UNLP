{8. Se cuenta con un archivo con información de las diferentes distribuciones de linux
existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de
versión del kernel, cantidad de desarrolladores y descripción. El nombre de las
distribuciones no puede repetirse.
Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de
reutilización de espacio libre llamada lista invertida.
Escriba la definición de las estructuras de datos necesarias y los siguientes
procedimientos:
ExisteDistribucion: módulo que recibe por parámetro un nombre y devuelve verdadero si
la distribución existe en el archivo o falso en caso contrario.
AltaDistribución: módulo que lee por teclado los datos de una nueva distribución y la
agrega al archivo reutilizando espacio disponible en caso de que exista. (El control de
unicidad lo debe realizar utilizando el módulo anterior). En caso de que la distribución que
se quiere agregar ya exista se debe informar “ya existe la distribución”.
BajaDistribución: módulo que da de baja lógicamente una distribución cuyo nombre se
lee por teclado. Para marcar una distribución como borrada se debe utilizar el campo
cantidad de desarrolladores para mantener actualizada la lista invertida. Para verificar
que la distribución a borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no
existir se debe informar “Distribución no existente”.}

program ejercicio8TP3;
type
    cadena= string[20];
    distribucion=record
        nombre:cadena; //no se repite
        anio:integer;
        version:integer;
        cant_desarrolladores:integer;
        descripcion:integer;
    end;

    archivo=file of distribucion;


//modulo buscar nombre de distribucion
function existe_distribucion(var arch: archivo; str:cadena):boolean;
var
    existe:boolean;
    reg:distribucion;
begin
    existe:=false;
    reset(arch);
    seek(arch,1); // porque en posicion 0 tengo el indice de los borrados
    while (not eof(arch)) and (not existe) do begin
        read(arch,reg);
        if reg.nombre = str then
            existe:=true;
    end;
    close(arch);
    existe_distribucion:=existe;
end;

//modulo alta distribucion

procedure leer(var reg:distribucion);
begin
    with reg do begin
        write('Nombre: ');
        read(nombre);
        write('Anio: ');
        read(anio);
        write('Version: ');
        read(version);
        write('Cantidad de desarrolladores: ');
        read(cant_desarrolladores);
        write('Descripcion: ');
        read(descripcion);
    end;
end;


procedure agregar(var arch:archivo; reg:distribucion);
begin
    reset(arch); //consultar si hace falta abrirlo otra vez
    seek(arch,filesize(arch);
    write(arch,reg);
end;


procedure alta_distribucion(var arch:archivo; reg: distribucion);
var
    existe:boolean;
    aux:distribucion;
begin
    reset(arch);
    if not existe_distribucion(arch,reg.nombre) then
        agregar(arch,reg)
    else
        writeln('Ya existe la distribucion ');
    close(arch);
end;


//modulo baja distribucion

procedure eliminar(var arch:archivo; reg:distribucion);
var
    aux:distribucion;
    heap:integer;
begin
    reset(arch);
    read(arch,aux);
    heap:=aux.cant_desarrolladores;
    while (not eof(arch)) and (aux.cod <> reg.cod) do
        read(arch,aux);
    if not eof(arch) then begin
        aux.cant_desarrolladores:=heap;
        head:= -1 * filepos(arch);
        seek(arch,filepos(arch)-1);
        write(arch,aux);
        seek(arch,0);
        aux.cant_desarrolladores:=heap;
        write(arch,aux);
    end;
end;



procedure baja_distribucion(var arch:archivo; reg:distribucion);
var
    heap:integer;
begin
    reset(arch);
    if existe_distribucion(arch,reg.nombre) then 
        eliminar(arch,reg);
    else   
        write('Distribucion no existe ');
end;
    // -------------- CONTINUAR

var
    arch:archivo;
    str:cadena;
    reg:distribucion;
begin
    write('Nombre del archivo: ');
    read(str);
    assign(arch,str);
    writeln('Nombre de distribución a buscar: ');
    read(str);
    if existe_distribucion(arch,str) then
        writeln('Fue hallada la distribucion ');
    else
        writeln('No fue hallada la distribucion ');
    leer(reg);
    alta_distribucion(arch,reg);
    baja_distribucion(arch,reg);

end.
{6. Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado
con la información correspondiente a las prendas que se encuentran a la venta. De
cada prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y
precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las prendas
a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las prendas que
quedarán obsoletas. Deberá implementar un procedimiento que reciba ambos archivos
y realice la baja lógica de las prendas, para ello deberá modificar el stock de la prenda
correspondiente a valor negativo.
Por último, una vez finalizadas las bajas lógicas, deberá efectivizar las mismas
compactando el archivo. Para ello se deberá utilizar una estructura auxiliar, renombrando
el archivo original al finalizar el proceso.. Solo deben quedar en el archivo las prendas
que no fueron borradas, una vez realizadas todas las bajas físicas.} 
program ejercicio6TP3;
type
    cadena=string[50];
    prenda=record
        cod_prenda:integer;
        descripcion:cadena;
        colores:cadena;
        tipo_prenda:cadena;
        stock:integer;
        precio_unitario:integer;
    end;

    maestro= file of prenda;
    detalle= file of integer; 

//modulos para actualizar archivo maestro

procedure actualizar archivo_maestro(var mae:maestro; var det:detalle);
var
    reg:prenda;
    nombre:cadena;
    cod:integer;
begin
    write('Nombre de archivo maestro: ');
    read(nombre);
    assign(mae,nombre);
    write('Nombre de archivo detalle: ');
    read(nombre);
    assign(det,nombre);
    reset(mae);
    reset(det);
    while not eof(det) do begin
        read(mae,reg);
        while (not eof(mae)) and (reg.cod <> cod) do
            read(mae,reg);
        if not eof(mae) do begin
            reg.stock:= -1;
            seek(mae,filepos(mae)-1);
            write(mae,reg);
        end;
        seek(mae,0);
    end;
    close(mae);
    close(det);
end; 

//modulos de compactacion
procedure compactacion_maestro(var mae:maestro; var nuevo:maestro);
var
    reg:prenda;
    nombre:cadena;
begin
    write('Nombre para el nuevo archivo maestro: ');
    read(nombre);
    assign(nuevo,nombre);
    rewrite(nuevo);
    reset(mae);
    while not eof(mae) do begin
        read(mae,reg);
        if reg.stock >= 0 then
            write(nuevo,reg);
    end;
end;


var
    mae:maestro;
    nuevo:maestro;
    det:detalle;
begin
    actualizar_maestro(mae,det);
    compactacion_maestro(mae,nuevo);
end.


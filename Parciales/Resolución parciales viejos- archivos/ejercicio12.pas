program ejercicio12;
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

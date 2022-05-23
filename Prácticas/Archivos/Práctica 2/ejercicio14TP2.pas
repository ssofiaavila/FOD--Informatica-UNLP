{14. Una compañía aérea dispone de un archivo maestro donde guarda información sobre
sus próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida
y la cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles
para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida
y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino
más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada
uno del maestro. Se pide realizar los módulos necesarios para:
c. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje
sin asiento disponible.
d. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que
tengan menos de una cantidad específica de asientos disponibles. La misma debe
ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.
}


program ejercicio14TP2;
const 
    corte='ZZZ';
type
    cadena=string[20];

    reg_maestro=record
        destino:cadena;
        fecha:integer;
        hora:integer;
        asientos_disponibles:integer;
    end;
    
    reg_detalle=record  
        fecha:integer;
        hora:integer;
        asientos_comprados:integer; 
    end;

    maestro=file of reg_maestro;
    detalle=file of reg_detalle; 


//MODULOS PARA ACTUALIZAR EL MAESTRO

procedure leer(var arch:maestro; var reg:reg_detalle);
begin 
    if not oef(arch) then 
        read(arch,reg)
    else
        reg.destino:=corte;
end;

procedure minimo(var r1,r2,min:reg_detalle);
begin 
    if (r1.fecha < r2.fecha) and (r1.destino < r2.destino) and (r1.hora < r2.hora) then begin
        min:=r1;
        leer(det1,r1);
    else begin 
        min:=r2;
        leer(det2,r2); 
    end;
end;


procedure actualizarMaestro (var mae:maestro; var det1:detalle; var det2:detalle);
var
    min,regD1,regD2:reg_detalle;
    asientos_total:integer;
    hora_actual:horario;
    fecha_actual:date;
    regM:reg_maestro;
begin 
    reset(mae);
    reset(det1);
    reset(det2);
    leer(det1,regD1);
    leer(det2,regD2);
    minimo(regD1,regD2,minimo);
    while (min.destino <> corte) do begin 
        read(mae,regM);
        while (regM.destino <> min.destino) and (regM.fecha <> min.fecha) and (regM.hora<> min.hora) do 
            read(mae,regM);
            asientos_total:=0;
            while (regM.destino = min.destino) and (regM.fecha = min.fecha) and (regM.hora= min.hora) do begin 
                asientos_total:=asientos_total + min.asientos_comprados;
                minimo(regD1,regD2,min);
            end;
        end;
        regM.asientos_disponibles:=regM.asientos_disponibles - asientos_total;
        seek(mae,filepos(mae)-1);
        write(mae,regM);
    end;
    close(mae);
    close(det1);
    close(det2);
end;  


// MODULOS PARA IMPRIMIR LISTA

procedure listar(var mae:maestro);
var 
    cant_esperada:integer;
    regM:reg_maestro;
begin
    reset(mae);
    writeln('Ingrese cantidad minima de asientos disponibles');
    read(cant_esperada);
    while not eof(mae) do begin
        read(mae,regM);
        if regM.asientos_disponibles < cant_esperada then
            writeln('Destino: ',regM.destino, ' Fecha: ', regM.fecha, ' Hora: ', regM.hora);
    end;
end; 

var
    mae:maestro;
    det1,det2:detalle;
begin
    assign(mae,'arch_maestro');
    assign(det1,'arch_detalle1');
    assign(det2,'arch_detalle2');
    actualizarMaestro(mae,det1,det2);
    listar(mae);
end.
{17. Una concesionaria de motos de la Ciudad de Chascomús, posee un archivo con
información de las motos que posee a la venta. De cada moto se registra: código, nombre,
descripción, modelo, marca y stock actual. Mensualmente se reciben 10 archivos detalles
con información de las ventas de cada uno de los 10 empleados que trabajan. De cada
archivo detalle se dispone de la siguiente información: código de moto, precio y fecha de la
venta. Se debe realizar un proceso que actualice el stock del archivo maestro desde los
archivos detalles. Además se debe informar cuál fue la moto más vendida.
NOTA: Todos los archivos están ordenados por código de la moto y el archivo maestro debe
ser recorrido sólo una vez y en forma simultánea con los detalles.} 
program ejercicio17TP2;
const
    corte=9999;
type    
    cadena=string[20];
    moto=record
        cod:integer;
        nombre:cadena;
        descripcion:cadena;
        modelo:cadena;
        stock_actual:integer;
    end;

    maestro=file of moto;
    venta=record
        cod:integer;
        precio:real;
        fecha:integer;
    end;
    detalle=file of venta; 

    vector=array[1..10] of detalle;
    registros=array[1..10] of venta; 

procedure leer(var arch:detalle; var reg:venta);
begin 
    if not eof(arch) then 
        read(arch,reg)
    else 
        reg.cod:=corte;
end; 


procedure abrirDetalles(var vc:vector; var regs:registros);
var 
    i:integer;
    num:cadena;
begin
    for i:=1 to 10 do begin
        Str(i,num);
        assign(vc[i],'detalle:'+num);
        reset(vc[i]);
        leer(vc[i],regs[i]);
    end;
end;

procedure minimo(var vc:vector);
var
    i:integer;
begin 
    for i:=1 to 10 do 
        close(vc[i]);
end;


procedure actualizarMaestro(var mae:maestro; var vc:vector; var regs:registros);
var 
    min:venta;
    regM: moto;
    cant_min:integer;
    modelo:cadena;
begin
    cant_min:=corte;
    reset(mae);
    minimo(vc,regs,min);
    while min.cod <> corte do begin
        read(mae,regM);
        while regM.cod <> min.cod do 
            read(mae,regM);
        while (regM.cod = min.cod ) do begin
            regM.stock_actual:= regM.stock_actual - 1;
            minimo(vc,regs,min);
        end;
        seek(mae,filepos(mae)-1);
        if regM.stock < cant_max then begin
            cant_max:=regM.stock;
            modelo:=regM.modelo;
        end;
        write(mae,regM);
    end;
    close(mae);
    cerrarVc(vc);
    writeln('El modelo mas vendido fue: ' modelo);
end;


var
    mae:maestro;
    vc:vector;
    vc_reg:registros;
begin;
    assign(mae, 'arch_maestro');
    abrirDetalles(vc,vc_reg);
    actualizarMaestro(mae,vc,vc_reg);
end.
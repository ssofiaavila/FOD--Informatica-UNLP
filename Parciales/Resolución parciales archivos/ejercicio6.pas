program ejercicio6;
const
    dimF=3;
    corte=9999;
type
    cadena=string[20];
    operacion=record
        cod_repuesto:integer;
        nombre_repuesto:cadena;
        cant_vendida:integer;
        fechaYHora_venta:cadena;
    end;

    repuesto=record
        cod_repuesto:integer;
        nombre_repuesto:cadena;
        cant_total:integer;
    end;


    venta=file of operacion;
    vc_ventas=array[1..dimF] of venta;
    maestro=file of repuesto;
    vc_reg=array[1..dimF] of operacion;

procedure leer(var arch:venta; var reg:operacion);
begin
    if not eof(arch) then
        read(arch,reg)
    else
        reg.cod_repuesto:=corte;
end; 




procedure assignVc(var vc:vc_ventas; var regs:vc_reg);
var
    i:integer;
    num:cadena;
begin
    for i:=1 to dimF do begin
        Str(num,i);
        assign(vc[i],'detalle:'num);
        reset(vc[i]);
        leer(vc[i],regs[i]);
    end;
end;


procedure closeVc(var vc:vc_ventas);
var
    i:integer;
begin
    for i:=1 to dimF do
        close(vc[i]);
end;

procedure generarMaestro(var mae:maestro; var vc:vc_ventas; var regs:vc_reg);
var
    aux:operacion;
    mae1:repuesto;
    cod_actual,total_aux:integer
begin
    rewrite(mae);
    minimo(vc,regs,aux);
    while aux.cod_repuesto<> corte do begin
        mae1.cod_repuesto:=aux.cod_repuesto;
        mae1.cant_total:=0;
        mae1.nombre_repuesto= aux.nombre_repuesto;
        while aux.nombre_repuesto = mae1.nombre_repuesto do BEGIN 
            mae1.cant_total:=mae1.cant_total+aux.cant_vendida;
            minimo(vc,regs,aux);
        end;
        seek(mae1,filepos(mae1 -1));
        write(mae,mae1);
    end;
    close(mae);
    closeVc(vc);
end;

var
    mae:maestro;
    vc:vc_ventas;
    regs:vc_reg;
begin
    assign(mae,'total_repuestos_vendidos.dat');
    assignVc(vc,regs);
    generarMaestro(mae,vc,regs);
end.
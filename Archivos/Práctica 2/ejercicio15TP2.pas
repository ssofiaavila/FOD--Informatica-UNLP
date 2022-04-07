{15. Se desea modelar la información de una ONG dedicada a la asistencia de personas con
carencias habitacionales. La ONG cuenta con un archivo maestro conteniendo información
como se indica a continuación: Código pcia, nombre provincia, código de localidad, nombre
de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin
agua,# viviendas sin sanitarios.
Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras
de ayuda en la edificación y equipamientos de viviendas en cada provincia. La información
de los detalles es la siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas
construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
provincia y código de localidad.
Para la actualización se debe proceder de la siguiente manera:
1. Al valor de vivienda con luz se le resta el valor recibido en el detalle.
2. Idem para viviendas con agua, gas y entrega de sanitarios.
3. A las viviendas de chapa se le resta el valor recibido de viviendas construidas
La misma combinación de provincia y localidad aparecen a lo sumo una única vez.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades sin viviendas de
chapa (las localidades pueden o no haber sido actualizadas).} 

program ejercicio15TP2;
const
    corte=9999;
type
    cadena= string[20];
    reg_maestro=record
        cod_prov: integer;
        nombre_prov:cadena;
        cod_localidad:integer;
        nombre_localidad:cadena;
        sin_luz:integer;
        sin_gas:integer;
        con_chapa:integer;
        sin_agua:integer;
        sin_sanitario:integer;
    end;
 
    reg_detalle=record
        cod_prov:integer;
        cod_localidad:integer;
        con_luz:integer;
        cant_construidas:integer;
        con_agua:integer;
        con_gas:integer;
        cant_sanitario:integer;
    end;

    maestro=file of reg_maestro;
    detalle=file of detalle;

    vector=array [1..10] of detalle;
    vector_reg=array [1..10] of reg_detalle;

procedure leer(var arch:detalle; var reg:reg_detalle);
begin
    if not eof(arch) then
        read(arch,reg)
    else
        reg.cod_prov :=corte;
end; 


//MODULOS ASSIGN DE DETALLES



procedure assignDetalles(var vc:vector; var registros:vc_reg);
var
    i:integer;
    nro:cadena;
begin
    for i:=1 to 10 do begin
        Str(i,nro);
        assign(vc[i],'Detalle nro:'+nro);
        reset(vc[i]);
        leer(vc[i],registros[i]);
    end;
end; 


//MODULOS ACTUALIZAR MAESTRO 

procedure cerrarVc(var vc:vector);
var
    i:integer;
begin 
    for i:=1 to 10 do
        close(vc[i]);
end;

procedure actualizarMaestro(var mae:maestro; var vc:vector; var registros:vc_reg);
var
    regM:reg_maestro;
    minimo:reg_detalle;
begin
    reset(mae);
    minimo(vc,registros,min);
    while min.cod_prov <> corte do begin
        while (regM.cod_prov <> min.cod_prov) and (regM.cod_localidad <> min.cod_localidad) do
          read(mae,regM);
        while (regM.cod_prov = min.cod_prov) and (regM.cod_localidad = min.cod_localidad) do begin
            regM.sin_luz:= regM.sin_luz - min.con_luz; 
            regM.sin_gas:= regM.sin_gas - min.con_gas;
            regM.con_chapa:= regM.con_chapa - min.cant_construidas;
            regM.sin_agua:= regM.sin_agua - min.con_agua;
            regM.sin_sanitario:= regM.sin_sanitario - min.cant_sanitario;
            minimo(vc,registros,min);
        end;
    end;
    close(mae);
    cerrarVc(vc);
end;
    


//modulos informar localidades sin viviendas sin chapa 
procedure informar(var mae:maestro);
var
    regM:reg_maestro;
begin
    writeln('Localidades sin viviendas de chapa: ');
    while not eof(mae) do begin 
        read(mae,regM);
        if regM.con_chapa = 0 then
            writeln(regM.nombre_localidad);
    end;
end;





var
    mae:maestro;
    vc:vector;
    vc_reg:vector_reg;
begin
    assign(mae,'arch_mae');
    assignDetalles(vc,vc_reg);
    actualizarMaestro(mae,vc,vc_reg);
    informar(mae);


end. 

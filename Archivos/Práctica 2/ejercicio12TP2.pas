program ejercicio12;
const 
    corte=9999;
type
    usuario=record
        anio,mes,dia,id,tiempo:integer;
    end;

    archivo= file of usuario;

// MODULOS PARA INFORMAR 

procedure leer(var arch:archivo;var reg:usuario);
begin
    if not eof(arch) then 
        read(arch, reg);
    else
        reg.anio:=corte;
end;



procedure informar(var arch:archivo);
var  
    reg:usuario;
    anio,mes_actual,dia_actual:integer;
begin
    reset(arch);
    writeln('Ingrese anio del cual desea un informe ');
    read(anio);
    writeln('Anio: ',anio);
    leer(arch,reg);
    while (reg.anio <> corte) and (reg.anio=anio) do begin
        mes_actual:=reg.mes;
        writeln('Mes: ', mes_actual);
        while (reg.anio <> corte) and (reg.anio=anio) and (mes_actual=reg.mes) do begin
            dia_actual:=reg.dia_actual;
            while (reg.anio <> corte) and (reg.anio=anio) and (mes_actual=reg.mes) and(dia_actual=dia_actual) do begin
                writeln('Dia: ', dia_actual);
                writeln('ID de usuario: ', reg.id_de_usuario, ' Tiempo total de acceso en el dia ', dia_actual, ' mes : ', mes_actual, ': ', reg.tiempo);
                leer(arch, reg);
        end;
    end;
end;


var
    arch:archivo;
begin
    assign(arch,'archivo_accesos');   
    informar(arch);


end.
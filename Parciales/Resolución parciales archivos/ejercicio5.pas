program ejercicio5;
const
    dimF=N;
    corte=9999;
type
    cadena=string[20];
    alumno=record
        dni_alumno,codigo_carrera:integer;
        monto_total_pagado:real;
    end;
    
    pago=record
        dni_alumno,codigo_carrera:integer;
        monto_cuota:real;
    end;

    arch_alumnos= file of alumno;
    arch_pagos= file of pagos;
    vc_pagos= array[1..dimF] of arch_pagos;
    registros=array[1..dimF] of pago;


procedure leer(var arch:arch_pagos; var reg:pago);
begin
    if not eof(arch) then
        read(arch,reg)
    else
        reg.dni_alumno=corte;
end;


procedure assignVc(var vc:vc_pagos; var regs: registros);
var
    i:integer;
    num:cadena;
begin
    for i:=1 to dimF do BEGIN
        Str(num,i);
        assign(vc[i],'archivo_detalle_:'num);
        reset(vc[i]);
        leer(vc[i],regs[i]);
    end;
end;


procedure minimo(var vc:vc_pagos; var regs:registros,var aux:pagos);
var
    i,indiceMin:integer;
begin
    aux.dni_alumno:=corte;
    indiceMin:=-1;
    for i:=1 to N do begin
        if vc[i].dni_alumno < aux.dni_alumno then
            indiceMin:=i;
    end;
    if indiceMin<> -1 then 
        aux:=regs[indiceMin];
        leer(vc[indiceMin],regs[indiceMin);
end;

procedure closeVc(var vc:vc_pagos);
var
    i:integer;
begin
    for i:=1 to N do
        close(vc[i]);
end;


procedure actualizarPagos(var maestro:arch_alumnos; var vc:vc_pagos; var regs:registros);
var
    aux:pagos;
    mae:alumno;
    dni_actual:integer;
    cod_actual:integer;
    total_actual:real;
begin
    reset(maestro);
    minimo(vc,regs,aux);
    while aux.dni_alumno <> corte do begin
        read(maestro,mae);
        while mae.dni_alumno <> aux.dni_alumno do
            read(maestro,mae);
        dni_actual:=aux.dni_alumno;
        while dni_actual = aux.dni_alumno do begin
            cod_actual:= aux.codigo_carrera;
            total_actual:=0;
            while cod_actual = aux.codigo_carrera do begin
                total_actual:=aux.monto_cuota;
                minimo(vc,regs,aux);
        end;
        mae.monto_total_pagado:=total_actual;
    end;
    close(maestro);
    closeVc(vc);

end;



procedure exportarMorosos(var maestro:arch_alumnos);
var
    txt:Text;
    aux:alumno;
    dni_actual:integer;
    pago:boolean;
begin
    assign(txt,'alumnos_morosos');
    rewrite(txt);
    reset(maestro);
    while not eof(maestro) do BEGIN
        read(maestro,aux);
        dni_actual:=aux.dni_alumno;
        pago:=true;
        while aux.dni_alumno = dni_actual do begin
            if not aux.pago then pago:=false
            read(maestro,aux);
        end;
        if not pago then 
            write(txt,'DNI: ', dni_actual, ' Alumno moroso');
    end;
    close(maestro);
    close(txt);    
end;


var
    maestro:arch_alumnos;
    vc:vc_pagos;
    regs:registros;
begin
    assign(maestro,'arch_maestro');
    assignVc(vc,regs);
    actualizarPagos(maestro,vc,regs);
    exportarMorosos(maestro);
end.
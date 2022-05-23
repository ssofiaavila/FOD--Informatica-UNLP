{16. La editorial X, autora de diversos semanarios, posee un archivo maestro con la
información correspondiente a las diferentes emisiones de los mismos. De cada emisión se
registra: fecha, código de semanario, nombre del semanario, descripción, precio, total de
ejemplares y total de ejemplares vendido.
Mensualmente se reciben 100 archivos detalles con las ventas de los semanarios en todo el
país. La información que poseen los detalles es la siguiente: fecha, código de semanario y
cantidad de ejemplares vendidos. Realice las declaraciones necesarias, la llamada al
procedimiento y el procedimiento que recibe el archivo maestro y los 100 detalles y realice la
actualización del archivo maestro en función de las ventas registradas. Además deberá
informar fecha y semanario que tuvo más ventas y la misma información del semanario con
menos ventas.
Nota: Todos los archivos están ordenados por fecha y código de semanario. No se realizan
ventas de semanarios si no hay ejemplares para hacerlo} 
program ejercicio16TP2;
const 
    corte=9999;
type
    cadena:string[20];
    reg_maestro=record
        fecha:integer;
        cod:integer;
        nombre:cadena;
        descripcion:cadena;
        precio:real;
        cant_total:integer;
        cant_vendida:integer;
    end;

    reg_detalle=record
        fecha:integer;
        cod:integer; 
        cant_vendidos:integer;  
    end;

    detalle=file of reg_detalle;
    maestro=file of reg_maestro;

    vector=array[1..100] of detalle;
    vector_reg=array[1..100] of reg_detalle;

procedure leer(var arch:detalle; var reg:reg_detalle);
begin 
    if not eof(arch) then 
        read(arch,reg)
    else
        reg.cod:=corte;
end;


procedure assignVc(var vc:vector; var registros:vector_reg);
var
    i:integer;
    num:cadena;
begin 
    for i:=1 to 100 do begin 
        Str(i,num);
        assign(vc[i],'archivo_detalle:'+num);
        reset(vc[i]);
        leer(vc[i],registros[i]);
    end; 
end; 

procedure minimo(var vc:vector; var registros:vector_reg; var min:reg_detalle);
var
    i,indiceMin:integer;
begin 
    indiceMin:=-1;
    min.fecha:=corte;
    min.cod:=corte;
    for i:=1 to 100 do begin 
        if (registros[i].fecha < min.fecha) and (registros[i].cod < min.cod) then
            indiceMin:=1;
    end;
    if indiceMin <> -1 then begin 
        min:=registros[indiceMin];
        leer(vc[indiceMin],registros[indiceMin]);
    end;
end;

procedure cerrarVc(var vc:vector);
var 
    i:integer;
begin
    for i:=1 to 100 do 
        close(vc[i]);
end;


procedure actualizarMaestro(var mae:maestro; var vc:vector; var registros:vector_reg);
var 
    regM:reg_maestro; 
    min:reg_detalle;

begin
    reset(mae);
    minimo(vc,registros,min);
    while min.cod <> corte do begin 
        read(mae,regM);
        while (regM.fecha <> min.fecha) and (regM.cod <> min.cod) do
            read(mae,regM);
        while (regM.fecha = min.fecha) and (regM.cod = min.cod) do
            regM.cant_vendida:= regM.cant_vendida + min.cant_vendidos;
            minimo(vc,registros,min);
        end;
        seek(mae,filepos(mae)-1);
        write(mae,regM);
    end;
    close(mae);
    cerrarVc(vc);
end;

procedure informarMinYMax(var mae:maestro);
var
    fechaMin,fechaMax,min,max:integer; 
    nombreMin,nombreMax:integer;
    regM:reg_maestro; 
begin
    min:=corte;
    max:=-1;
    while not eof(mae) do begin
        read(mae,regM);
        if regM.cant_vendida < min then begin
            nombreMin:=regM.nombre;
            fechaMin:=regM.fecha;
            min:=regM.cant_vendida;
        end
        else begin 
            if regM.cant_vendida > max then begin  
                nombreMax:=regM.nombre;
                fechaMax:=regM.fecha;
                max:=regM.cant_vendida;
            end;
        end;
    end;
    writeln('Menos vendido, nombre: ', nombreMin, ' fecha:', fechaMin, ' cantidad: ',min);
    writeln('Más vendido, nombre: ', nombreMax, ' fecha:', fechaMax, ' cantidad: ',max);
    close(mae);
end;


var
    vc:vector;
    vc_reg:vector_reg;
    mae:maestro;
begin
    assign(mae,'arch_maestro');
    assignVc(vc,vc_reg);
    actualizarMaestro(mae,vc,vc_reg);
    informarMinYMax(mae);


end.

program ejercicio2;
const
    corte=9999;
type
    cadena=string[20];
    producto=record
        cod_pdto,cod_barras:integer;
        nombre,descripcion,categoria:cadena;
        stock_actual,stock_minimo:integer;
    end;

   

    pedido=record
        cod_pdto,cant:integer;
        descripcion:cadena;
    end;

    maestro= file of producto;
    detalle= file of pedido;
    vc_detalles= file of detalle;
    vc_reg= array [1..3] of pedido;

procedure assignVc(var vc:vc_detalles; var registros:vc_reg);
var
    i:integer;
    num:cadena;
begin
    for i:=1 to 3 do BEGIN
        Str(i,num);
        assign(vc[i],'archivo_detalle:'num);
        reset(detalles[i]);
        leer(vc[i],registros[i]);
    end;
end;

procedure leer(var arch:detalle, var reg: pedido);
begin
    if not eof(arch) then
        read(arch,reg)
    else 
        reg.cod_pdto:=corte;
end;


procedure minimo(var vc:vc_detalles; var registros:vc_reg; var min:pedido);
var
    i,indiceMin:integer;
begin
    min.cod_pdto=corte;
    indiceMin:=-1;
    for i:=1 to 3 to begin
        if registros[i].cod_pdto < min.cod_pdto then
            indiceMin:=i;
    end;
    if indiceMin <> -1 then begin
        min:=registros[indiceMin];
        leer(vc[indiceMin],registros[indiceMin]);
    end;


procedure recibirPedidos(var mae:maestro,var vc:vc_detalles; var registros:vc_reg);
var
    mae1:producto;
    min:pedido;
begin
    reset(mae);
    minimo(vc,registros,min);
    while min.cod_pdto <> corte do begin
        read(mae,mae1);
        while mae1.cod_pdto <> min.cod_pdto do
            read(mae,mae1);
        while (min.cod_pdto = mae1.cod_pdto do begin
            if (mae1.stock_actual > min.cant) then 
                mae1.stock_actual:=mae1.stock_actual - min.cant
            else begin
                mae1.stock_actual:=0;
                writeln('No se pudo enviar el total de lo pedido');
            end;
            minimo(vc,registros,min);
        end;
        seek(mae,filepos(mae)-1);
        write(mae,mae1);
    end;
    close(mae);
    cerrarVc(vc);
end;



var
    mae:maestro;
    vc:vc_detalles;
    registros:vc_reg;
begin
    assign(mae,'maestro');
    assignVc(vc,registros);
    recibirPedidos(mae,vc,registros);
end.
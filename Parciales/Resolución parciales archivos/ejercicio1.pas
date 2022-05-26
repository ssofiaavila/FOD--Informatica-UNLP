program ejercicio1;
const
    corte=99999;
type
    cadena= string[20];
    carrera=record
        dni:integer;
        apellido,nombre:cadena;
        km,ganada:integer;
    end;

    participante=record
        dni:integer;
        apellido,nombre:cadena;
        km_total,cant_ganadas:integer;
    end;

    
    archivo_carreras= file of carrera;
    archivo_maestro= file of participante;
    vector_detalles= array[1..5] of archivo_carreras;
    vector_carrera= array[1..5] of carrera;



procedure leer(var arch:archivo_carreras; var reg:carrera);
begin
    if not eof(arch) then
        read(arch,reg);
    else
        reg.DNI:= corte;
end;


procedure assignVc(var detalles: vector_detalles; var vc_reg:vector_carrera);
var
    i:integer;
    num:cadena;
begin
    for i:=1 to 5 do begin
        Str(i,num);
        assign(detalles[i],'archivo_detalle:'num);
        reset(detalles[i]);
        leer(detalles[i],vc_reg[i]);
    end;
end;

procedure cerrarVc(var detalles: vector_detalles);
var
    i:integer;
begin
    for i:=1 to 5 do
        close(detalles[i]);
end;

procedure minimo(var detalles:vector_detalles; var vc_reg:vector_carrera; var min:carrera);
var
    i,indiceMin:integer;
begin
    indiceMin:=-1;
    min.dni:=corte;
    for i:=1 to 5 do begin
        if (vc_reg[i].dni < min.dni) then
            indiceMin:=i;  
    end;
    if indiceMin <> -1 then BEGIN
        min:=vc_reg[indiceMin];
        leer(detalles[indiceMin],vc_reg[indiceMin]);
    end;

end;


//modulo para cargar los datos en el maestro 
procedure crearMaestro(var maestro:archivo_maestro; var detalles:vector_detalles, var vc_reg:vector_carrera);
var
    min:carrera;
    maeAux:participante;
    total_km,total_ganadas:integer;

begin
    reset(mae);
    minimo(detalles,vc_reg,min);
    while (min.dni <> corte) do begin
        read(mae,maeAux);
        while min.dni <> maeAux.dni do
          read(mae,maeAux);
        total_km:=0;
        total_ganadas:=0;  
        while (min.dni = maeAux.dni) do begin
            total_km:=total_km+ min.km;
            if (min.ganada) then
                total_ganadas:=total_ganadas+1;
            minimo(detalles,vc_reg,mih);
        end;
        maeAux.km_total:=total_km;
        maeAux.cant_ganadas:=total_ganadas;
        seek(mae,filepos(mae)-1);
        write(mae,maeAux);  
    end;
    close(mae);
    cerrarVc(detalles);

end;


var
    maestro:archivo_maestro;
    detalles:vector_detalles;
    vc_reg:vector_carrera;
begin
    assign(maestro,'resumen_carreras'); //creo maestro
    assignVc(detalles,vc_reg);
    crearMaestro(maestro,detalles,vc_reg);
end.


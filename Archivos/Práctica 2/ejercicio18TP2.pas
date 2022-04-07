{18 . Se cuenta con un archivo con información de los casos de COVID-19 registrados en los
diferentes hospitales de la Provincia de Buenos Aires cada día. Dicho archivo contiene:
cod_localidad, nombre_localidad, cod_municipio, nombre_minucipio, cod_hospital,
nombre_hospital, fecha y cantidad de casos positivos detectados.
El archivo está ordenado por localidad, luego por municipio y luego por hospital.
a. Escriba la definición de las estructuras de datos necesarias y un procedimiento que haga
un listado con el siguiente formato:
Nombre: Localidad 1
Nombre: Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
NombreHospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad 1
-----------------------------------------------------------------------------------------
Nombre Localidad N
Nombre Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad N
Cantidad de casos Totales en la Provincia
b. Exportar a un archivo de texto la siguiente información nombre_localidad,
nombre_municipio y cantidad de casos de municipio, para aquellos municipios cuya
cantidad de casos supere los 1500. El formato del archivo de texto deberá ser el
adecuado para recuperar la información con la menor cantidad de lecturas posibles.
NOTA: El archivo debe recorrerse solo una vez.}

program ejercicio18TP2;
const
    corte=9999;
type
    cadena=string[20];
    registro=record
        cod_localidad:integer;
        nombre_localidad:cadena;
        cod_municipio:integer;
        nombre_municipio:cadena;
        cod_hospital:integer;
        nombre_hospital:cadena;
        fecha:integer;
        casos:integer;
    end;

    archivo=file of registro;

procedure informar(var arch:archivo);
var 
    reg:registro;
    localidad_total,localidad_actual,municipio_actual,municipio_total:integer;

begin
    reset(arch);
    leer(arch,reg);
    while reg.cod_localidad <> corte do begin
        localidad_actual:=reg.cod_localidad;
        localidad_total:=0;
        writeln('Localidad: ', localidad_actual);
        while (reg.cod_localidad = localidad_actual) do begin
            municipio_actual:=reg.cod_municipio;
            municipio_total:=reg.cod_municipio;
            writeln('Municipio: ', municipio_actual);
            while (reg.cod_localidad = localidad_actual) and (reg.cod_municipio =municipio_actual) do begin
                writeln('Cantidad casos hospital ', reg.nombre_hospital, ' : ', reg.casos);
                municipio_total = municipio_total + reg.casos;
                leer(arch,reg);
            end;
            localidad_total:= localidad_total + municipio_total; 
        end;
    end;
    close(arch);
end;



var
    arch:archivo;
begin
    assign(arch,'archivo_covid');
    informar(arch);

end.
{13. Suponga que usted es administrador de un servidor de correo electrónico. En los logs
del mismo (información guardada acerca de los movimientos que ocurren en el server) que
se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información:
nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el
servidor de correo genera un archivo con la siguiente información: nro_usuario,
cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los
usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se
sabe que un usuario puede enviar cero, uno o más mails por día.
a- Realice el procedimiento necesario para actualizar la información del log en
un día particular. Defina las estructuras de datos que utilice su procedimiento.
b- Genere un archivo de texto que contenga el siguiente informe dado un archivo
detalle de un día determinado:
nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que
existen en el sistema.}
program ejercicio13TP2;
const
    corte=9999;
type
    cadena=string[20];
    maestro=record 
        nro_usuario:integer;
        nombreUsuario:cadena;
        nombre:cadena;
        apellido:cadena;
        mails_enviados:cadena;
    end;

    detalle=record
        nro_usuario:integer;
        cuenta_destino:cadena;
        cuerpo_mensaje:cadena;
    end;

    master=file of maestro;
    detail=file of detalle;

//MODULOS ACTUALIZAR MAESTRO

procedure actualizar(var mae:master;var det:detail);
var
    regM:maestro;
    regD:detalle;
    nro_actual:integer;
begin
    reset(mae);
    reset(det);
    leer(det,regD);
    read(det,regM);
    while (regD.nro_usuario <> regM.nro_usuario) do 
        read(mae,regM);
    while regD.nro_usuario <> corte do begin
        nro_actual = regD.nro_usuario;
        cant_mensajes:=0;
        while nro_actual = regD.nro_usuario do begin
            cant_mensajes:=cant_mensajes+1;
            leer(det,regD);
        end;
        regM.cant_mensajes:=cant_mensajes;
        seek(mae,filepos(mae)-1);
        write(mae,regM);
    end;
    close(mae);
    close(det);
end;




var
    mae:master;
    det:detalle;
begin
    assign(mae,'/var/log/logmail.dat');
    actualizar(mae,det);
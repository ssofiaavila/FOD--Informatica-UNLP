program ejercicio4;
type
    cadena=string[20];
    usuario=record
        nro_usuario:integer;
        nombre_usuario,nombre,apellido:cadena;
        cant_enviados:integer;
    end;

    mail=record
        nombre_usuario,cuenta_destino,cuerpo:cadena;
    end;

    log_arch= file of usuario;
    movimientos=file of mail;


procedure actualizarLog(var logs:log_arch; var operaciones: movimientos);
var
    mae:usuario;
    aux:mail;
    actual:cadena;
    total:integer;
begin
    reset(logs);
    reset(operaciones);
   
    while not eof(operaciones) do begin
         read(logs,mae);
         read(operaciones,aux);
        while mae.nombre_usuario <> aux.nombre_usuario do
            read(logs,mae);
        actual:=aux.nombre_usuario;
        total:=0;
        while aux.nombre_usuario = actual do begin
            total:=total+1;
            read(operaciones,aux);
        end;
        mae.cant_enviados:=total;
        seek(logs,filepos(logs)-1);
        write(logs,mae);
    end;
    close(logs);
    close(operaciones);
end;
        
procedure generarTxt(var logs:log_arch);
var
    txt:Text;
    aux:mail;
begin
    assign(txt,'listado.txt');
    reset(logs);
    rewrite(txt);
    while not eof(logs) do begin
        read(logs,aux);
        write(txt,'nroUsuario: ',aux.nro_usuario, ' nombre de usuario: ', aux.nombre_usuario, ' cantidad enviados: ', aux.cant_enviados); 
    end;
    close(logs);
    close(txt);
end;


var
    logs:log_arch;
    operaciones:movimientos;
begin
    assign(logs,'/var/log/logsmail.dat');
    assign(operaciones,'6junio2017.dat');
    actualizarLog(logs,operaciones);
    generarTxt(logs);

end.
{2. Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.}

program ejercicio2TP3;
const
    corte=9999;
    condicion= 1000;
type 
    cadena= string[25];
    asistente=record
        nro:integer;
        apellido:cadena;
        nombre:cadena;
        email:cadena;
        tel:integer;
        dni:integer;
    end;

    archivo = file of asistente; 

//modulos para generar archivo

procedure leer(var reg:asistente);
begin
    writeln('Nro. de empleado: ') ;
    readln(reg.nro);
    if reg.nro <> corte then begin
        with reg do begin
            writeln('Apellido: ');
            readln(apellido);
            writeln('Nombre: ');
            readln(nombre);
            writeln('Email: ');
            readln(email);
            writeln('Telefono: ');
            readln(tel);
            writeln('DNI: ');
            readln(dni);
        end;
    end;
end;

procedure generarArchivo(var arch: archivo);
var
    reg:asistente;
    nombre_fisico:cadena;
begin
    writeln('Ingrese nombre para el archivo');
    readln(nombre_fisico);
    assign(arch,nombre_fisico);
    rewrite(arch);
    leer(reg);
    while reg.nro <> corte do begin
        write(arch,reg);
        leer(reg);
    end;
    close(arch);
end;

//modulos para eliminar los asistentes con nro menor a 1000

procedure eliminarAsistentes(var arch:archivo);
var
    reg:asistente;
    aux:cadena;
begin
    reset(arch);
    while not eof(arch) do begin
        read(arch,reg);
        if reg.nro < condicion then begin
            aux:= '*'+ reg.nombre; //la marcacion de eliminacion logica entonces va a estar en el nombre del asistente
            reg.nombre:=aux; 
        end;
        seek(arch,filepos(arch)-1);
        write(arch,reg);
    end;
    close(arch);
end;


var
    arch:archivo;
begin
    generarArchivo(arch);
    eliminarAsistentes(arch);
end.
{3. Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:

a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.
b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:
i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.
ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.
iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.
c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.}

program ejercicio3TP3;
const
    corte=9999;
type
    cadena= string[20];
    novela=record
        cod:integer;
        genero:cadena;
        nombre:cadena;
        duracion: integer;
        director:cadena;
        precio:real;
    end;

    archivo= file of novela;


//modulos para crear archivo y cargar datos 

procedure leer(var reg:novela);
begin
    with reg do begin
        writeln('Codigo: ');
        readln(cod);
        if cod <> corte then begin
            writeln('Genero: ');
            readln(genero);
            writeln('Nombre: ');
            readln(nombre);
            writeln('Duracion: ');
            readln(duracion);
            writeln('Director: ');
            readln(director);
            writeln('Precio: ');
            readln(precio);
        end;
    end;
end;

procedure crearArchivo(var arch:archivo);
var
    reg:novela;
    nombre:cadena;
begin
    writeln('Nombre para el archivo: ');
    radln(nombre);
    asssign(arch,nombre);
    rewrite(arch);
    reg.cod:=0; //para la lista invertida
    write(arch,reg);
    leer(reg);
    while reg.cod <> corte do begin
        write(arch,reg);
        leer(reg);
    end;
    close(arch);
end;

//modulos para modificar novela

procedure modificarNovela(var arch:archivo);
    procedure menu_modificacion(var reg:novela);
        procedure modificar_nombre( var nombre:cadena);
        begin
            writeln('Nuevo nombre: ');
            readln(nombre);
        end;
        procedure modificar_genero(var genero:cadena);
        begin
            writeln('Nuevo genero: ');
            readln(genero);
        end;
        procedure modificar_precio(var precio:real);
        begin
            writeln('Nuevo precio: ');
            readln(precio);
        end;
        procedure modificar_duracion(var duracion: integer);
        begin
            writeln('Nueva duracion: ');
            readln(duracion);
        end;
        procedure modificar_director(var director:cadena);
        begin
            writeln('Nuevo director: ');
            readln(director);  
        end;
        var
            opcion:integer;
        begin
            writeln('Codigo: ', reg.codigo);
            with reg do 
                writeln('Nombre: ', nombre, ' Genero: ', genero, ' Duracion: ', duracion, 'Director: ', director, ' Precio: ', precio);
            writeln('1: modificar nombre');
            writeln('2: modificar genero');
            writeln('3: precio ');
            writeln('4: duracion');
            writeln('5: director');
            writeln('Seleccione cual desea modificar');
            readln(opcion);
            case opcion of
                1: moficiar_nombre(reg.nombre);
                2:modificar_genero(reg.genero);
                3:modificar_precio(reg.precio);
                4: modificar_duracion(reg.duracion);
                5: modificar_director(reg.director);
                0: exit;
            else begin
                writeln('Ingrese opcion correcta');
                menu_modificacion(reg);
            end;
        end;
        menu_modificacion(reg);
    end;
var
    cod:integer;
    reg:novela;
    str:cadena;
begin
    writeln('Ingrese nombre de archivo');
    readln(str);
    assign(arch,str);
    writeln('Codigo de novela para modificar: ');
    readln(cod);
    while (not eof(arch)) and (reg.cod <> cod) do
        read(arch,reg);
    if reg.cod = cod then begin
        menu_modificacion(reg);
        seek(arch,filepos(arch)-1));
        writeln('Novela modificada ');
    end
    else
        writeln('No se encontro ');
    close(arch);
end;


//modulos para eliminar novela

procedure eliminarNovela(var arch: archivo);
var
    cod:integer;
    head:integer;
    reg:novela;
    str:cadena;
begin
    writeln('Ingrese nombre de archivo');
    readln(str);
    assign(arch,str);
    writeln('Codigo de novela para eliminar: ');
    readln(cod);
    reset(arch);
    read(arch,reg);
    head:=reg.cod; //leo primera posicion donde tengo el indice
    while ((not eof(arch)) and (reg.cod <> cod) do
        read(arch,reg);
    if (not eof(arch)) then begin
        reg.cod:=head;
        head:=(-1* filepos(arch));  //guardo la posicion del registro que elimine y lo paso a negativo
        seek(arch,filepos(arch)-1)); //lo ubico en la posicion que lo eliminé
        write(arch,reg); 
        seek(arch,0); //me ubico en el indice otra vez
        reg.cod:= head;
        write(arch,reg);
    end
    else
        write('No fue eliminado ');
    close(arch); 
end;


procedure menu(var arch:archivo);
var
    opcion:integer;
begin
    writeln('1: Crear archivo y cargar datos ');
    writeln('2: Modificar novela ');
    writeln('3: Eliminar novela ');
    writeln('0: salir del menu ');
    
    readln(opcion);
    case opcion of
        1: crearArchivo(arch);
        2: modificarNovela(arch);
        3: eliminarNovela(arch);
        0: halt;
    end;
    else menu(arch);

end;

var
    arch:archivo;
begin 
    menu(arch);

end.

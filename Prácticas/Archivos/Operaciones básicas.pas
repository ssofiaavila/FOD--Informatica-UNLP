------- MODIFICAR ARCHIVO -----------

var
  E:registro;
begin
  Reset(X);
  while not eof (X) do begin
    Read(X,x);
    X.salario := X.salario * 1.1;
    Seek (X, filepos(X-1);
    Write(x,x);
  end;
  Close(X);
end.

------ AGREGAR DATOS -------------
  procedure agregarElemento (var x:empleados);
  var X:registro;
  begin
    reset (X);
    Seek (X, filesize (X));
    leer(x);
    while X.nombre <> ' ' do begin
      write(X, x);
      leer(x);
    end;
    close(X);
  end;
  

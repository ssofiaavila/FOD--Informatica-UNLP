program funcionHashing;
var
    operando,dividendo,resultado:integer;
begin
    writeln('Dividendo: ');
    readln(dividendo);
    writeln('Operando: ');
    readln(operando);
    while operando <> 0 do begin
        resultado:=operando mod dividendo;
        writeln(resultado);
        writeln('Operando nuevo: ');
    readln(operando);
    end;
end.
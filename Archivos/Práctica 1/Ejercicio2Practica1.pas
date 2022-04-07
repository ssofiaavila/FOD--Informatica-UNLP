{
 2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
}


program practica1Ejercicio2;
type
	archivo= file of integer;
var
	arc:archivo;
	nombre_arc:string[12];
	nro,cant,suma:integer;
	
begin	
	writeln('Ingrese nombre ');
	readln(nombre_arc);
	assign(arc,nombre_arc); //o una ruta 
	suma:=0;
	cant:=0;
	while (not eof(arc))do begin
		read(arc,nro);
		suma:=suma+nro;
		if (nro <1500) then
			cant:=cant+1;
	end;
	close(arc);
	writeln('Hay ', cant , ' de numeros menos a 1500');
	writeln('El promedio de los numeros es: ', (suma /filesize(arc)):2:2);
end.
		

// va a dar error porque no abri ningun archivo pero el ejercicio está bien

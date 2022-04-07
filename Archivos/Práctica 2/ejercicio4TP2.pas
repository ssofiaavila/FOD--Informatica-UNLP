{
4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
   
}


program ejercicio4TP2;

type
	sesion=record
		cod:integer;
		fecha:cadena;
		tiempo:integer;
	end;
	central=record
		cod:integer;
		fecha:cadena;
		tiempo:integer;
	end;
	
	master=file of central;
	detail= file of sesion;	
	details=array [1.5] of detail;
	vector_compu= array [1..5] of sesion;
	
procedure crear_detalles(var detalles:details);
var
	i:integer;
begin
	for i:=0 to 30 do begin
		assign(detalles[i], 'archivo_detalle' +  IntToStr(i));         
        reset(detalles[i]);
        rewrite(detalles[i]);
    end;
	
	
var
	maestro:master;
	detalles:details;
begin
	assign(maestro,'/var/log');
	reset(maestro);
	crear_detalles(detalles);
	
	

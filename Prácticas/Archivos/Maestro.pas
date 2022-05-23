  ----------- ACTUALIZAR MAESTRO CON UN DETALLE -----
  
program actualizar;
type 
  emp= record
    nombre:string[30];
    direccion: string [30];
    cht:integer; //cantidad horas trabajadas
  end;
  e_diario=record
    nombre:string[30];
    chr:integer;
  end;
  detalle= file of e_diario;
  maestro= file of emp;
const 
  valoralto='9999';
var
  regm:emp;
  regd:e_diario;
  mae1:maestro;
  det1:detalle; 
  
procedure leer(var archivo: detalle; var dato: e_diario);
begin
  if (not eof(archivo) then
    read(archivo,dato);
  else
    dato.cod:=valoralto;
end;
  
begin
  assign(mae1, 'maestro');
  assign(det1, 'detalle');
  reset(mae1);
  reset(det1);
  leer(det1,regd);
  while (regd.cod <> caloralto) do begin
    regm.cant:+regm.cant+ regd.cht;
    leer(det1,regd);
  end;
  seek(mae1,filepos(mae1-1));
  write(mae1,regm);
 end.
 
 ------- UN MAESTRO N DETALLE ---------
 var 
  regm:prod;
  min,regd1,regd2,regd3:v_prod;
  det1,det2det3:detalle;
 
 
 
 begin
  assign(mae1,'maestro);
  assign(det1,'detalle1');
  assign(det2,'detalle2');
  assign(det3, 'detalle');
  reset(mae1);
  reset(det1);
  reset(det2);
  reset(det3);
  leer(mae1);
  leer(det1,regd1);
  leer(det2,regd2);
  leer(det3,regd3);
  minimo(regd1,regd2,regd3,min);
  while (min.cod <> valoralto) do begin
    read(mae1,regm);
    while (regm.cod <>min.cod) do 
      read(mae1,regm);
    while (regm.cod =  min.cod) do begin
      regm.cant:+regm.cant + min.cantvendida;
      minimo(regd1,regd2,regd3.min);
    end;
    seek(mae1,filepos(mae1 -1));
    write(mae1,regm);
  end;
 end.
 
 -------- 
  
 
    
    

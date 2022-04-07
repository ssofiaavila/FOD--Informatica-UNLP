program corteDeControl;
const
  valoralto= 'ZZZ';
type
  str10=string[10];
  prov = record
    provincia,partido,ciudad:str10;
    cant_varones,cant_mujeres,cant_desocupados:integer;
  end;
  instituto=file of prov;
  
var
  regm:prov;
  inst:instituto;
  t_varones,t_mujeres,t_desocupados,t_prov_var,t_prov_muj,t_prov_des:integer;
  ant_prov,ant_partido:str10;
  
  
begin
  assign(inst,'censo');
  reset(inst); //creo archivo
  writeln('Provincia: ', regm.provincia);
  writeln('Partido: ', regm.partido);
  writeln('Ciudad: ', regm,ciudad);
  t_varones:=0;
  t_mujeres:=0; //inicializo totales auxiliares
  t_desocupados:=0;
  
  
  t_prov_var:=0;
  t_prov_muj:=0;  //inicializo totales provincia
  t_prov_des:=0;
  
  while (regm.provincia <> valoralto) do begin
    ant_prov:= regm.provincia;
    ant_partido:=regm.partido;
    while (ant_prov = regm.provincia) and (ant_partido = regm.partido) do begin
      t_varones:= t_varones + regm.cant_varones;
      t_mujeres:= t_mujeres + regm.cant_mujeres;
      t_desocupados:+ t_desocupados + regm.cant_desocupados;
      leer(inst,regm);
    end;
    writeln('Total partido: ', t_varones, t_mujeres, t_desocupados);
    t_prov_var:= t_prov_var +t_varones;
    t_prov_muj:= t_prov_muj + t_mujeres;
    t_prov_des:= t_prov_des + t_des;
    ant_partido:= regm.partido;
    if (ant_prov <> regm.provincia) then begin
      writeln('Total provincia: ', t_prov_var, t_prov_muj, t_prov,des);
      t_prov_var:= 0;
      t_prov_muj:= 0;
      t_prov_des:= 0;
      writeln('Provincia: ', regm.provincia);
    end;
    writeln('Partido: ', regm.partido);
  end;
end.

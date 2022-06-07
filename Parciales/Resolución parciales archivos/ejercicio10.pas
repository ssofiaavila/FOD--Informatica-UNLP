program ejercicio10;
const
	corte=9999;
type
	cadena=string[10];
	reg_detalle=record
		cod_categoria,cod_marca,cod_modelo,cant_vendida:integer;
	end;
	
	detalle= file of reg_detalle;
	
	
procedure crearTxt(var det1:detalle; var det2:detalle; var txt:	Text);
var
	categoria_actual,marca_actual,modelo_actual,total_categoria,total_marca,total_modelo:integer;
	aux:reg_detalle;
begin
	minimo(det1,det2,aux);
	while aux.cod_categoria <> corte do begin
		categoria_actual:=aux.cod_categoria;
		total_categoria:=0;
		while categoria_actual = aux.cod_categoria do begin
			marca_actual:=aux.cod_marca;
			total_marca:=0;
			while (categoria_actual= aux.cod_categoria) and (marca_actual = aux.cod_marca) do begin
				modelo_actual:=aux.cod_marca;
				cant_vendida:=0;
				total_modelo:=0;
				while (categoria_actual=aux.cod_categoria) and (marca_actual= aux.cod_marca) and (modelo_actual = aux.cod_modelo) do begin
					cant_vendida:=cant_vendida + aux.cant_vendida;
					minimo(det1,det2,aux_;
					total_modelo:=total_modelo + aux.cant_vendida;
				end;
				total_marca:=total_marca+ total_modelo;
			end;
			total_categoria:=total_categoria +  total_marca;
		end;
		write(txt,'Total por categoria: 'total_categoria);
		write(txt, 'Total por cateogira y marca: ',total_marca);
		write(txt, 'Total por cateogoria, marca y modelo: ', total_modelo);		
	end;
	close(txt);
	close(det1);
	close(det2);
end;	
	

var
	det1,det2:detalle;
	txt:Text;
begin
	assign(det1,'detalle1');
	assign(det2,'detalle2');
	reset(det1);
	reset(det2);
	assign(txt,'resumen.txt');
	rewrite(txt);
	crearTxt(det1,det2,txt);
end.

program ejercicio2;
type
    cadena=string[20];
    producto=record
        cod_pdto,cod_barras:integer;
        nombre,descripcion,categoria:cadena;
        stock_actual,stock_minimo:integer;
    end;

   

    pedido=record
        cod_pdto,cant:integer;
        descripcion:cadena;
    end;

    maestro= file of producto;
    detalle= file of pedido;
    vc_detalles= file of detalle;

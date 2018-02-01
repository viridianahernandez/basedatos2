create table  almacen(
numero_almacen integer ,
ubicacion_almacen varchar2(40),
constraint pk_na primary key(numero_almacen)
);

create or replace procedure guardar_almacen(my_numero_almacen in integer, my_ubicacion_almacen in varchar2)

as
begin
insert into almacen values(my_numero_almacen, my_ubicacion_almacen);
end;
/

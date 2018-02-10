
--GENERACIÓN DE LA TABLA ALMACEN .......................................................................................................................
CREATE TABLE ALMACEN
(
NUMERO_ALMACEN INTEGER, 
UBICACION_ALMACEN VARCHAR2(50),
CONSTRAINT PK_NUM_ALM PRIMARY KEY (NUMERO_ALMACEN)
);


-- Declaración de procedimiento GUARDAR_ALMACEN
CREATE OR REPLACE PROCEDURE guardar_almacen(my_num_alm IN integer, my_ub_alm IN varchar2)
AS
-- Variables locales si se requieren
BEGIN
--Cuerpo o lógica del procedimiento
INSERT INTO ALMACEN VALUES(my_num_alm,my_ub_alm);
END;
/


--Usaremos un bloque PL-SQL para probar que esta bien nuestro procedimiento
BEGIN 
guardar_almacen (321,'ECATEPEC');
END;
/
SELECT * FROM ALMACEN
-- Probar el procedimiento con Netbeans



--GENERACIÓN DE LA TABLA CLIENTE ...........................................................................................................................

CREATE TABLE CLIENTE
(
NUMERO_CLIENTE INTEGER,
NUMERO_ALMACEN INTEGER,
NOMBRE_CLIENTE VARCHAR2(80),
CONSTRAINT PK_N_C PRIMARY KEY(NUMERO_CLIENTE),
CONSTRAINT FK1_N_A FOREIGN KEY(NUMERO_ALMACEN) REFERENCES ALMACEN(NUMERO_ALMACEN)
);


-- Declaración de procedimiento GUARDAR_CLIENTE
CREATE OR REPLACE PROCEDURE guardar_cliente(my_num_clt IN integer, my_num_alm IN integer, my_nom_clt IN varchar2)
AS
-- Variables locales si se requieren
BEGIN
--Cuerpo o lógica del procedimiento
INSERT INTO CLIENTE VALUES(my_num_clt,my_num_alm,my_nom_clt);
END;
/



--GENERACIÓN DE LA TABLA VENDEDOR ..............................................................................................................................

CREATE TABLE VENDEDOR
(
NUMERO_VENDEDOR INTEGER,
NOMBRE_VENDEDOR VARCHAR2(80),
AREA_VENTAS VARCHAR2(80),
CONSTRAINT PK_N_V PRIMARY KEY(NUMERO_VENDEDOR)
);


-- Declaración de procedimiento GUARDAR_CLIENTE
CREATE OR REPLACE PROCEDURE guardar_vendedor(my_num_vnd IN integer, my_nom_vnd IN varchar2,my_area_ventas IN varchar2)
AS
-- Variables locales si se requieren
BEGIN
--Cuerpo o lógica del procedimiento
INSERT INTO CLIENTE VALUES(my_num_vnd,my_nom_vnd,my_area_ventas);
END;
/



--GENERACIÓN DE LA TABLA VENTAS ........................................................................................................................................

CREATE TABLE VENTAS
(
ID_VENTAS INTEGER,
NUMERO_CLIENTE INTEGER,
NUMERO_VENDEDOR INTEGER,
MONTO_VENTA FLOAT,
CONSTRAINT PK_ID_V PRIMARY KEY(ID_VENTAS),
CONSTRAINT FK1_N_CL FOREIGN KEY(NUMERO_CLIENTE) REFERENCES CLIENTE(NUMERO_CLIENTE),
CONSTRAINT FK1_N_VEN FOREIGN KEY(NUMERO_VENDEDOR) REFERENCES VENDEDOR(NUMERO_VENDEDOR)
);







--EJEMPLO DE UNA TABLA Y SU PROCEDIMIETO ALMACENADO PARA GUARDAR CON PK IMPUESTO O ARTIFICIAL .................................................................................

CREATE TABLE CALIFICACIONES
(
ID_CALIFICACION INTEGER,
MATERIA VARCHAR2(80),
VALOR FLOAT,
CONSTRAINT PK_ID_CAL PRIMARY KEY (ID_CALIFICACION)
);

--GENEAMOS UNA SECUENCIA ... SOLAMENTE PARA PK IMPUESTA

CREATE SEQUENCE SEC_CALIFICACIONES
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

-- AQUI -> EL PROCEDIMIENTO

CREATE OR REPLACE PROCEDURE GUARDAR_CALIFICACIONES(my_id_calificacion OUT INTEGER, my_materia IN VARCHAR2, my_valor IN FLOAT)
AS
BEGIN
SELECT SEC_CALIFICACIONES.NEXTVAL INTO my_id_calificacion FROM DUAL;
INSERT INTO CALIFICACIONES VALUES(my_id_calificacion, my_materia, my_valor);
END;
/


-- PROBAR PROCEDIMIENTO
DECLARE
VALOR INTEGER;
BEGIN
GUARDAR_CALIFICACIONES(VALOR,'BD 2',8);
END;
/

--verificamos 
SELECT * FROM CALIFICACIONES;  -- relacionado a un cursor explicito
delete from calificaciones where id_calificaciones=2;
select count(*) from calificaciones;  --- relacionado a un cursor implicito



--ejemplo de cursos explicito con la tabla calificaciones
declare
cursor cur_calif is select*from calificaciones;
begin
    for rec in cur_calif loop    --rec=fila
    dbms_output.put_line('calificacion  '||rec.valor|| 'materia  '||rec.materia);
    end loop;
end;
  /
  
     set serveroutput on;                                                              
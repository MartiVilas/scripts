create database shop;

CREATE USER shop WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'shop';

ALTER DATABASE shop OWNER TO shop;

GRANT ALL PRIVILEGES ON DATABASE shop TO shop;

psql -U shop -W -d shop;

CREATE TABLE IF NOT EXISTS ORDERF(
    order_id numeric(12) UNIQUE,
    order_date date,
    shipped_date date,
    ship_address varchar(50) NOT NULL,
    ship_city varchar(20),
    ship_region varchar(20),
    constraint PK_orderf PRIMARY KEY (order_id),
    constraint CH_shipped_date CHECK (shipped_date > order_date),
    constraint CH_ship_region CHECK (ship_region in ('USA','EUROPA','ASIA','AMERICA','RUSIA'))
);

comment on column ORDERF.order_id is 'Identificador de comanda';
comment on column ORDERF.order_date is 'Data de comanda';
comment on column ORDERF.shipped_date is 'Data de enviament';
comment on column ORDERF.ship_address is 'Adreça enviament';
comment on column ORDERF.ship_city is 'Citutat enviament';
comment on column ORDERF.ship_region is 'Regió enviament';


CREATE TABLE IF NOT EXISTS PRODUCT(
    product_id numeric(12) UNIQUE,
    product_name VARCHAR(50) NOT NULL,
    unitprice DOUBLE PRECISION NOT NULL,
    unitstock NUMERIC(3) NOT NULL,
    unitonorder NUMERIC(3) NOT NULL DEFAULT 1,
    constraint PK_product PRIMARY KEY (product_id)
);

comment on column PRODUCT.product_id is 'Identificador del producte';
comment on column PRODUCT.product_name is 'Nom del producte';
comment on column PRODUCT.unitprice is 'Preu unitat';
comment on column PRODUCT.unitstock is 'Número de unitats en stock';
comment on column PRODUCT.unitonorder is 'Número unitat en comanda';

CREATE TABLE IF NOT EXISTS ORDER_DETAILS(
    order_id numeric(12) UNIQUE,
    product_id numeric(12) UNIQUE,
    quantity numeric(3) NOT NULL,
    discount NUMERIC(3),
    constraint PK_order_details PRIMARY KEY (order_id,product_id),
    constraint FK_order FOREIGN KEY (order_id) REFERENCES ORDERF(order_id),
    constraint FK_product FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

comment on column ORDER_DETAILS.product_id && ORDER_DETAILS.order_id is 'Identificadors de detall de comanda';
comment on column ORDER_DETAILS.quantity is 'Quantitat de producte';
comment on column ORDER_DETAILS.discount is 'Descompte';

ALTER TABLE ORDERF alter column ship_city set data type varchar(40);
ALTER TABLE ORDERF alter column ship_region set data type varchar(40);


CREATE SEQUENCE PRODUCTID_SEQ increment 1 start with 1 maxvalue 99999;

/*INSERTS TAULA PRODUCT*/

INSERT INTO PRODUCT (product_id,product_name,unitprice,unitstock,unitonorder) VALUES (NEXTVAL('PRODUCTID_SEQ'),'nikkon ds90',67.09,75,1);
INSERT INTO PRODUCT (product_id,product_name,unitprice,unitstock,unitonorder) VALUES (NEXTVAL('PRODUCTID_SEQ'),'canon t90',682.82,92,1);
INSERT INTO PRODUCT (product_id,product_name,unitprice,unitstock,unitonorder) VALUES (NEXTVAL('PRODUCTID_SEQ'),'dell inpirion',182.78,56,2);
INSERT INTO PRODUCT (product_id,product_name,unitprice,unitstock,unitonorder) VALUES (NEXTVAL('PRODUCTID_SEQ'),'ipad air',482.83,56,2);
INSERT INTO PRODUCT (product_id,product_name,unitprice,unitstock,unitonorder) VALUES (NEXTVAL('PRODUCTID_SEQ'),'microsoft surface',693.84,92,2);
INSERT INTO PRODUCT (product_id,product_name,unitprice,unitstock) VALUES (NEXTVAL('PRODUCTID_SEQ'),'nexus 6',133.88,16);
INSERT INTO PRODUCT (product_id,product_name,unitprice,unitstock) VALUES (NEXTVAL('PRODUCTID_SEQ'),'thinkpad t365',341.02,22);


/*INSERTS TAULA ORDERF*/

/*Funciona*/
INSERT INTO ORDERF (order_id,order_date,shipped_date,ship_address,ship_city,ship_region) VALUES (4001,'2016-04-04','2016-11-06','93 Spohn Place','Manggekompo','ASIA');
/*La fecha del pedido es mayor que la fecha de entrega del pedido, el insert da error por eso*/
INSERT INTO ORDERF (order_id,order_date,shipped_date,ship_address,ship_city,ship_region) VALUES (4002,'2017-01-29','2016-05-28','46 Eliot Trail','Virginia','USA');
/*Funciona*/
INSERT INTO ORDERF (order_id,order_date,shipped_date,ship_address,ship_city,ship_region) VALUES (4003,'2016-08-19','2016-12-08','23 Sundown Junction','Obodivka','RUSIA');
/*Viola la restricció que diu que ha de haber una adreça d'entrega i dona error*/
INSERT INTO ORDERF (order_id,order_date,shipped_date,ship_city,ship_region) VALUES (4004,'2016-09-25','2016-12-24','Nova Venécia','AMERICA');
/*funciona*/
INSERT INTO ORDERF (order_id,order_date,shipped_date,ship_address,ship_city,ship_region) VALUES (4005,'2017-03-14','2017-03-19','7 Ludington Court','Sukamaju','ASIA');
/*funciona*/
INSERT INTO ORDERF (order_id,order_date,shipped_date,ship_address,ship_region) VALUES (4006,'2016-08-14','2016-12-05','859 Dahle Plaza','ASIA');
/*funciona*/
INSERT INTO ORDERF (order_id,order_date,shipped_date,ship_address,ship_city,ship_region) VALUES (4007,'2017-01-02','01-02-2017','5 Fuller Center Log pri','Brezovici','EUROPA');


/*INSERTS TAULA ORDER_DETAILS*/
/*funciona*/
INSERT INTO ORDER_DETAILS (order_id,product_id,quantity,discount) VALUES (4001,1,5,8.73);
/*funciona*/
INSERT INTO ORDER_DETAILS (order_id,product_id,quantity,discount) VALUES (4003,2,8,4.01);
/*funciona*/
INSERT INTO ORDER_DETAILS (order_id,product_id,quantity,discount) VALUES (4005,601,2,3.05);
/*Dona un error perque el camp de product id esta repetit y es 2*/
INSERT INTO ORDER_DETAILS (order_id,product_id,quantity,discount) VALUES (4006,2,4,5.78);


ALTER TABLE ORDER_DETAILS ALTER COLUMN discount set data type double precision;  

CREATE INDEX ship_addres_index ON ORDERF(ship_address);

CREATE UNIQUE INDEX product_name_index ON PRODUCT(product_name);

alter table ORDERF add column cost_ship double precision DEFAULT 1500;
alter table ORDERF add column logistic_cia varchar(100);
alter table ORDERF add column others varchar(250);

alter table ORDERF add check (logistic_cia in ('UPS','MRW','Post_Office','FEDEX','TNT','DHL','Moldtrans','SEUR'));
alter table ORDERF drop others;

BEGIN;

update ORDER_DETAILS set discount = 7.5 where discount>2;

ROLLBACK;

delete from product where unitstock>30;

commit;

/*funciona*/
delete from ORDERF where order_id=4006;
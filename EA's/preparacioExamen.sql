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


CREATE SEQUENCE PREODUCTID_SEQ increment 1 start with 1 maxvalue 99999;


insert into 

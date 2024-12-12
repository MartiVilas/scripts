CREATE DATABASE proveidors; 

CREATE USER proveidors WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'proveidors';

ALTER DATABASE proveidors OWNER TO proveidors;

GRANT ALL PRIVILEGES ON DATABASE proveidors TO proveidors;

CREATE TABLE IF NOT EXISTS fabricant(
    cod_fabricant numeric(3),
    nom varchar(15) ,
    pais varchar(15),
    CONSTRAINT PK_fabricant PRIMARY KEY (cod_fabricant),
    CONSTRAINT CK_nom CHECK (nom = UPPER(nom)),
    CONSTRAINT CK_pais CHECK (pais = UPPER(pais))
);

CREATE TABLE IF NOT EXISTS article(
    cod_articles varchar(20),
    cod_fabricant numeric(3),
    pes numeric(3),
    categoria varchar(10),
    preu_venda decimal(6,2),
    preu_cost decimal(6,2),
    stock numeric(5),
    CONSTRAINT PK_article PRIMARY KEY (cod_articles,cod_fabricant,pes,categoria),
    CONSTRAINT CK_preu_venda CHECK(preu_venda>0),
    CONSTRAINT CK_preu_cost CHECK(preu_cost>0),
    CONSTRAINT CK_pes CHECK(pes>0),
    CONSTRAINT CK_categoria CHECK(categoria in ('Primera','Segona','Tercera'))
);



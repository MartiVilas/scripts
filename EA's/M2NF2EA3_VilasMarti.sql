CREATE DATABASE cadastre;

create user cadastre with superuser createrole ENCRYPTED PASSWORD 'cadastre';

alter database cadastre owner to cadastre;

grant all privileges on database cadastre to cadastre;

/***************** HABITAPIS *****************/
CREATE TABLE IF NOT EXISTS habitapis(
    DNI varchar(12),
    carrer varchar(80),
    nombre numeric(4) NOT NULL,
    escala varchar(1),
    planta numeric(2),
    porta numeric(2),
    CONSTRAINT PK_dni PRIMARY KEY (DNI),
    CONSTRAINT FK_carrer FOREIGN KEY (porta,planta,escala,carrer,nombre) REFERENCES pis (porta,planta,escala,carrer,nombre),
    CONSTRAINT FK_dni FOREIGN KEY (dni) REFERENCES persona (dni)
);

/***************** PIS *****************/
CREATE TABLE IF NOT EXISTS pis(
    mestres_p numeric(4),
    dni_p varchar(12),
    carrer varchar(80),
    nombre numeric(4),
    escala varchar(1),
    planta numeric(2),
    porta numeric(2), 
    CONSTRAINT PKt_pis PRIMARY KEY (porta,planta,escala,carrer,nombre),
    CONSTRAINT FK_carrer FOREIGN KEY (carrer,nombre) REFERENCES vivienda (carrer,nombre),
    CONSTRAINT FK_dni_p FOREIGN KEY (dni_p) REFERENCES persona (dni),
    CONSTRAINT CK_metres_p CHECK (mestres_p > 0)

);

/***************** CASAPARTICULAR *****************/
CREATE TABLE IF NOT EXISTS casaparticular(
    mestres_c numeric(4),
    dni_cp varchar(12),
    carrer varchar(80),
    nombre numeric(4),
    CONSTRAINT PK_casaparticular PRIMARY KEY (carrer,nombre),
    CONSTRAINT FK_carrer FOREIGN KEY (carrer,nombre) REFERENCES vivienda (carrer,nombre),
    CONSTRAINT FK_dni_cp FOREIGN KEY (dni_cp) REFERENCES persona (dni)
);

/***************** BLOCCASES *****************/

CREATE TABLE IF NOT EXISTS bloccases(
    metres_b numeric(4),
    carrer varchar(80),
    nombre numeric(4),
    CONSTRAINT PK_bloccases PRIMARY KEY (carrer,nombre),
    CONSTRAINT FK_carrer FOREIGN KEY (carrer,nombre) REFERENCES vivienda (carrer,nombre),
    CONSTRAINT CK_metres_b CHECK (metres_b > 0)
);

/***************** PERSONA *****************/
CREATE TABLE IF NOT EXISTS persona(
    nom_persona varchar(20),
    cognoms_persona varchar(40),
    dni_c varchar(20),
    carrer varchar(80),
    nombre numeric(4) NOT NULL,
    dni varchar(12),
    CONSTRAINT PK_persona PRIMARY KEY (dni),
    CONSTRAINT FK_dni FOREIGN KEY (dni_c) REFERENCES persona (dni),
    CONSTRAINT FK_carrer FOREIGN KEY (carrer,nombre) REFERENCES vivienda (carrer,nombre)
);

/***************** VIVENDA *****************/
CREATE TABLE IF NOT EXISTS vivienda(
    tipus_vivienda varchar(1),
    codi_postal numeric(5) DEFAULT 00001,
    metres numeric(5),
    nom_zona varchar(60),
    carrer varchar(80),
    nombre numeric(4),
    CONSTRAINT PK_vivienda PRIMARY KEY (carrer,nombre),
    CONSTRAINT FK_nomurbana FOREIGN KEY (nom_zona) REFERENCES zonaurbana (nom_zona),
    CONSTRAINT CK_carrer CHECK(carrer = INITCAP(UPPER(carrer))),
    CONSTRAINT CK_nombre CHECK (nombre > 0),
    CONSTRAINT CK_tipus_vivienda CHECK (tipus_vivienda in ('C','B'))
);

/***************** ZONAURBANA *****************/
CREATE TABLE IF NOT EXISTS zonaurbana(
    nom_zona varchar(60),
    CONSTRAINT PK_nom_zona PRIMARY KEY (nom_zona),
    CONSTRAINT CK_nom_zona CHECK (nom_zona = UPPER(nom_zona))
);

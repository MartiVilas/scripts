CREATE DATABASE agenda;

CREATE USER agenda WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'agenda';

ALTER DATABASE agenda OWNER TO agenda;

GRANT ALL PRIVILEGES ON DATABASE agenda to agenda;

/*a) Crear la següent taula FITXA d’una base de dades d’una AGENDA. L’estructura és la següent:*/

CREATE TABLE IF NOT EXISTS fitxa(
    DNI numeric(10),
    NOM varchar(30) NOT NULL,
    COGNOMS varchar(70) NOT NULL,
    ADREÇA varchar(60),
    TELEFON varchar(11) NOT NULL,
    PROVINCIA varchar(30),
    DATA_NAIX DATE DEFAULT CURRENT_DATE,
    CONSTRAINT PK_fitxa PRIMARY KEY (DNI)
);

/*
b) Afegir un nou camp a la taula Fitxa, anomenat cp que serà el codi postal. Serà
de tipus varchar(5).*/
alter table fitxa add cp varchar(5); 

/*c) Comprovar que s’ha creat correctament el camp a la taula.*/
/*PER COMPROBAR QUE HA FUNCIONAT LA MODIFICACIÓ*/
\d fitxa;

/*d) Canviar el nom del nou camp cp. S’ha de dir Codi_Postal.*/
alter table fitxa rename column cp to Codi_Postal;

/*e) Canviar el nom de la restricció anomendada PK_Fitxa. S’ha de dir PrimKey_Fitxa*/
ALTER TABLE fitxa DROP CONSTRAINT PK_dni;

ALTER TABLE fitxa ADD CONSTRAINT PrimaryKey_Fitxa PRIMARY KEY (dni);


/*f) Modificar la longitud del tipus de dada del camp Codi_Postal. La nova longitud és VARCHAR(10).*/
alter table fitxa alter column Codi_Postal type varchar(10); 
alter table fitxa alter column Codi_Postal set data type varchar(5);

/*g) Modificar el tipus de dades del camp Codi_Postal. a El nou tipus de dades per aquest camp és
NUMERIC(5). Si et salta l’error busca per internet com es podria fer.*/
ALTER TABLE fitxa ALTER COLUMN Codi_Postal TYPE numeric(5);
ALTER TABLE fitxaALTER COLUMN codi_postal TYPE NUMERIC USING codi_postal::NUMERIC;

/*h) Afegeix una restricció amb el nom CK_Upper_Prov a la taula FITXA per verificar que els valors de
camp Provincia estiguin en majúscules.*/
alter table fitxa add constraint CK_Upper_Prov CHECK (provincia=UPPER(provincia));

/*i) Elimina la restricció CK_Upper_Prov de la taula FITXA i comprova el canvi.*/
alter table fitxa drop constraint CK_Upper_Prov;

/*Canvia el nom de la taula FITXA. S’ha de dir ENTRADA i comprova el canvi.*/
alter table fitxa rename to entrada; + \d

/*k) Elimina la taula ENTRADA i Comprovar que la taula està eliminada.*/
drop table entrada; + \d

/*COMENTARIS */
comment on column fitxa.nom is 'Nom de la persona';

comment on column fitxa.cognoms is 'Cognoms de la persona';

comment on column fitxa.adreça is 'Adreça de la persona';

COMMENT ON COLUMN fitxa.telefon is 'Telèfon de la persona';

comment on column fitxa.provincia is 'Provincia on resideix la persona';

comment on column fitxa.data_naix is 'Data de neixament de la persona';









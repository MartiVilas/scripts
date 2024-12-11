--Exercici 1
CREATE DATABASE bicirent;

create user bicirent with superuser createrole ENCRYPTED PASSWORD 'bicirent';

alter database bicirent owner to bicirent;

grant all privileges on database bicirent to bicirent;

psql -U bicirent -W -d bicirent;

/*--Exercici1: 2.2*/
create table if not exists client(
    idclient serial,
    nom varchar(30) not null ,
    cognom1 varchar(40) not null,
    cognom2 varchar(40) not null,
    dni varchar(10) unique,
    telefon numeric(10) unique,
    email varchar(35) unique,
    CONSTRAINT PK_client primary key (idclient)
);

comment on table client is 'Taula amb informació del client';
comment on column client.idclient is 'Identificador del client';
comment on column client.nom is 'Nom del client';
comment on column client.cognom1 is 'Primer cognom del client';
comment on column client.cognom2 is 'Segon cognom del client';
comment on column client.dni is 'Dni del client';
comment on column client.telefon is 'Telefon del client';
comment on column client.email is 'Email del client';


create table if not exists bicicleta(
    idbici numeric(15),
    marca varchar(30) not null,
    model varchar(30),
    preu double precision not null default 250,
    constraint PK_bicicleta primary key (idbici),
    constraint CK_preu CHECK (preu > 0)
);

create table if not exists lloguer(
    idlloguer numeric(35),
    bici numeric(35) not null,
    datalloguer date DEFAULT CURRENT_DATE,
    dataretorn date,
    client integer not null,
    retorn char(3) not null,
    penalitzacio numeric(20),
    preu numeric(15),
    constraint PK_lloguer primary key (idlloguer),
    constraint FK_lloguer_bicicleta FOREIGN KEY (bici) REFERENCES  bicicleta(idbici),
    constraint FK_lloguer_client FOREIGN key (client) references client(idclient),
    constraint CK_retorn CHECK (retorn in ('PEN', 'RET')),
    constraint CK_preu CHECK (preu > 0)
);


--Exercici 2: 0.25
\d per mirar les taules creades
\d+ client per  mirar la taula client amb el comentaris y els tipus de dades.
\d lloguer
\d bicicleta


--Exercici 3: 0.25
alter table lloguer drop constraint CK_retorn;
alter table lloguer add constraint CK_ret CHECK (retorn in ('PEN', 'RET'));

\d+ lloguer per comprobar que ha canviat i en efecte ha canviat


--Exercici 4: 0.25

alter table lloguer drop preu;
\d lloguer i veiem com ara ja no està preu.

--Exercici 5: 0.5 
alter table lloguer add preu double precision not null;
\d lloguer i veiem que ara torna a ser la columna preu i te el tipus double precision.


--Exercici 6: 0.25
alter table lloguer add constraint CK_preu CHECK(preu > 0);
\d lloguer i veiem com ara la taula te una restriccio que diu que el preu ha de ser major a 0.


--Exercici 7: 0.25
alter table lloguer add constraint CK_data CHECK (dataretorn > datalloguer);
\d lloguer i veiem com ara la lloguer hi ha una nova restricció.

--Exercici 8: 0.25
alter table lloguer alter column client set data type numeric(35);
/*
ERROR:  foreign key constraint "fk_lloguer_client" cannot be implemented
DETAIL:  Key columns "client" and "idclient" are of incompatible types: numeric and integer.

viola la restriccio de la clau foranea de la taula lloguer
*/


--Exercici 9: 0.5
INSERT INTO client (nom,cognom1,cognom2,dni,telefon,email) VALUES ('Marti','Vilas','Ruano','48196854Y',692233320,'marti@gmail.com');
INSERT INTO client (nom,cognom1,cognom2,dni,telefon,email) VALUES ('Victor','Vilas','Ruano','48196851Y',692233321,'victor@gmail.com');
INSERT INTO client (nom,cognom1,cognom2,dni,telefon,email) VALUES ('Argar','Fernandez','Gonzale','11111111Y',692233322,'argar@gmail.com');
INSERT INTO client (nom,cognom1,cognom2,dni,telefon,email) VALUES ('Ashmed','Barreiro','Fernandez','2222222Y',692233323,'ashmed@gmail.com');
INSERT INTO client (nom,cognom1,cognom2,dni,telefon,email) VALUES ('Scarlett','Toala','Gimenez','33333333Y',692233324,'scarlett@gmail.com');

/*
select * from client;
per poder veure tots els inserts
*/

--Exercici 10: 0.5 podriem posar defaulta a l'ultim camp perquèno fallés.

INSERT INTO bicicleta (idbici,marca,model,preu) VALUES (333456,'Acepac','XTS23',1500);
/*funciona*/
INSERT INTO bicicleta (idbici,marca,model,preu) VALUES (4233456,'Aevor','Alpine',2000);
/*funciona*/
INSERT INTO bicicleta (idbici,marca,model,preu) VALUES (5633456,'BTH',3000);
/*no funciona perque falta un camp que es not null*/
INSERT INTO bicicleta (idbici,marca,model,preu) VALUES (333774,'Capsuled','Lumen',0);
/*no funciona perque el preu ha de ser major a 0*/
INSERT INTO bicicleta (idbici,marca,model,preu) VALUES (2433456,'Lazer',2500);
/*no funciona perque falta un camp que si que se li ha dit que se li donaria*/
INSERT INTO bicicleta (idbici,marca,model,preu) VALUES (333456,'FAZUA','Remix',1700);
/*no funciona perque el idbici es igual que el primer i no es pot repetir*/
INSERT INTO bicicleta (idbici,marca,model,preu) VALUES (33334568,'Octane One','Collage');
/*no funciona perque li falten camps que se li ha dit que li donariem*/

--Exercici 11: 0.25
create SEQUENCE idlloguer_seq increment 1 start with 100 maxvalue 99999999;

--Exercici 12: 0.5
INSERT INTO lloguer (idlloguer,bici,datalloguer,dataretorn,client,retorn,penalitzacio,preu) VALUES (NEXTVAL('idlloguer_seq'),423456,'2017-01-29','2017-05-28',3,'RET',0,200);
/*no funciona perque el camp bici ha de ser present a la taula bicicleta i en aquest cas no hi es*/

INSERT INTO lloguer (idlloguer,bici,datalloguer,dataretorn,client,retorn,penalitzacio,preu) VALUES (NEXTVAL('idlloguer_seq'),333456,'2019-07-14','2019-08-20',10,'RET',0,400);
/*no funciona per el camp client ha de ser present a la taula client i en aquest cas no hi es*/

INSERT INTO lloguer (idlloguer,bici,datalloguer,dataretorn,client,retorn,penalitzacio,preu) VALUES (NEXTVAL('idlloguer_seq'),4233456,'2020-06-21','2020-09-12',2,'RET',50,300);
/*funciona*/

INSERT INTO lloguer (idlloguer,bici,datalloguer,dataretorn,client,retorn,penalitzacio,preu) VALUES (NEXTVAL('idlloguer_seq'),33334568,'2021-04-20','2021-02-02',2,'RET',0,260);
/*no funciona perque la data de lloguer es mes tard que la data de retorn*/

INSERT INTO lloguer (idlloguer,bici,datalloguer,dataretorn,client,retorn,penalitzacio,preu) VALUES (NEXTVAL('idlloguer_seq'),333456,'2022-06-20','2022-07-01',1,'PEN',0);
/*no funciona perque espera un preu i no se li dona*/

INSERT INTO lloguer (idlloguer,bici,datalloguer,dataretorn,client,retorn,penalitzacio,preu) VALUES (NEXTVAL('idlloguer_seq'),333456,'2023-09-13','2023-10-11',2,'SET',100,370);
/*no funciona perque el retorn es set i nomes pot ser o ret o pen*/

INSERT INTO lloguer (idlloguer,bici,datalloguer,dataretorn,client,retorn,penalitzacio,preu) VALUES (NEXTVAL('idlloguer_seq'),5633456,'2020-09-13','2020-10-11',2,'PEN',100,500);
/*no funciona perque el camp bici ha de ser present a la taula bicicleta i en aquest cas no hi es*/

--Exercici 13: 0.4
update lloguer set retorn = 'PEN' where preu > 150;

--Exercici 14: 0.5
delete from bicicleta where idbici = 2126219;

--Exercici 15: 0.25
drop table client;
/*
ERROR:  cannot drop table client because other objects depend on it
DETAIL:  constraint fk_lloguer_client on table lloguer depends on table client
no podem eliminar la taula client perque la foreign key de lloguer depen de aquesta taula, hauriem de fer servir drop table client on cascade;
*/
--Exercici 16: 0.25
delete from bicicleta;
/*
ERROR:  update or delete on table "bicicleta" violates foreign key constraint "fk_lloguer_bicicleta" on table "lloguer"
DETAIL:  Key (idbici)=(4233456) is still referenced from table "lloguer".
no podem eliminar els valor de la taula bicicleta perque la clau foranea de la taula lloguer depen de aquesta taula.
*/
--Exercici 17: 0.4
create view telfclient as (select nom,cognom1, telefon from client);
/*funciona*/

--Exercici 18: 0.4
create unique index cognom_idx on client (cognom1);
/*
Quan he fet els inserte he posat el nom del meu germà i el meu, els dos tenims els mateixos congnoms 
i a l'hora de crear un index únic sobre el congom1 de la taula client dona error perquè els cognoms estan repetits
Per això crec que no es la millor idea crear un index unique a la columna cognom1 perquè moltes vegades els cognoms es repeteixen i pot donar molts errors
*/

--Exercici 19: 0.25
update bicicleta set idbici = 2233456 where idbici = 4233456;
/*
ERROR:  update or delete on table "bicicleta" violates foreign key constraint "fk_lloguer_bicicleta" on table "lloguer"
DETAIL:  Key (idbici)=(4233456) is still referenced from table "lloguer".
no funciona perque el camp idbici esta present a la taula lloguer ara faré els canvis necesaris per tal de que canvii el id
*/
alter table lloguer drop constraint FK_lloguer_bicicleta;
/*
Ara si que funciona.
*/

--Exercici 20: 0.5
BEGIN;

INSERT INTO bicicleta VALUES (45567, 'BH', 'Simple', 600);
/* Ara la taula està amb la bicicleta de id 45567 fins, però fins que fagi commit no es quedara de forma permanent*/
DELETE FROM bicicleta WHERE idbici = 45567;
ROLLBACK;
/*
Ara la taula bicicleta no te la bici que hem afegir, perquè hm fet un rollback 
i es com si la creació i el delete que hem fet no haguessin existit
*/
INSERT INTO bicicleta VALUES (533422, 'BH', 'Ramses', 970);
COMMIT;
/*
Ara tenim a la taula de forma permanent la bicicleta amb id 533422 ja que hem fet un commit i hem fet permament els canvis.
*/

/*Punts totals examen: 9.15*/
/*Exercici 1*/

/*Afegir un nou camp a la taula Fitxa, anomenat Equip de tipus INTEGER.*/
alter table fitxa add column equip integer;

/*Inserir els següents registres a la taula, i una vegada afegits comprovar que existeixen.*/
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, DATA_NAIX)  VALUES (3421232, 'LUIS MIGUEL', 'ACEDO GÓMEZ', 'GUZMÁN EL BUENO, 90', '969231256', '1970-05-05');
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, PROVINCIA, DATA_NAIX) VALUES (4864868, 'BEATRIZ', 'SANCHO MANRIQUE', 'ZURRIAGA, 25', '932321212', 'BCN', '1978-07-06');

/*Elimina la fila amb DNI = 3421223 i comprova el canvi a la taula.*/
delete from fitxa where dni = 3421223;

/*Inserta la primera fila però per la data de naixement s’ha de posar el valor per defecte.*/
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, DATA_NAIX)  VALUES (3421232, 'LUIS MIGUEL', 'ACEDO GÓMEZ', 'GUZMÁN EL BUENO, 90', '969231256', DEFAULT);

/*Buida tota la taula amb una sola sentència.*/
delete from fitxa;

/*Inserta les dues files però indicant els camps on aniran els valors a les sentències*/
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, DATA_NAIX)  VALUES (3421232, 'LUIS MIGUEL', 'ACEDO GÓMEZ', 'GUZMÁN EL BUENO, 90', '969231256', '1970-05-05');
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, PROVINCIA, DATA_NAIX) VALUES (4864868, 'BEATRIZ', 'SANCHO MANRIQUE', 'ZURRIAGA, 25', '932321212', 'BCN', '1978-07-06');

/* Exercici 2 */
BEGIN;

/*Inserir els següents registres a la taula fes un ROLLBACK i comprovar si encara existeixen.*/
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, equip, PROVINCIA, DATA_NAIX)  VALUES (7868544, 'JONÁS', 'ALMENDROS RODRIGUEZ', 'FEDERICO PUERTAS, 3', '915478947', 3, 'MADRID', '1987-01-01');
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, equip, PROVINCIA, DATA_NAIX)  VALUES (8324216, 'PEDRO', 'MARTIN HUIGERO', 'VIRGEN DEL CERRO, 154', '961522344', 5, 'SORIA', '1978-04-29');

ROLLBACK;

/*Inserir els següents registres a la taula programant les transaccions indicades.*/
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, equip, PROVINCIA, DATA_NAIX)  VALUES (14948992,'SANDRA','MARTÍN GONZALEZ','PABLO NERUDA, 15', '916581515',6,'MADRID','1970-05-05');

/*Desar el canvis permanentment.*/
COMMIT;

/*introduir el registre*/
INSERT INTO fitxa (DNI, NOM, COGNOMS, ADREÇA, TELEFON, equip, PROVINCIA, DATA_NAIX)  VALUES (15756214,'MIGUEL','CAMARGO ROMAN','ARMADORES, 1', '949488588', 7, NULL,'1985-12-12');

/*Posar una marca anomenada intA.*/

/*Desar els canvis permanentment*/

/*Introduir els registres*/

/*Posar una marca anomenada intB. Comprova que estan els registres que hem donat d’alta de moment.*/

/*Introduir el registre*/

/*Posar una marca anomenada intC. Comprova que estan els registres que hem donat d’alta de moment.*/

/*Introduir els registres.*/

/*Posar una marca anomenada intD. Comprova que estan els registres que hem donat d’alta de moment.*/

/*Eliminar el registre amb DNI = 45824852.*/

/*Posar una marca anomenada intE. Comprova que estan els registres que hem donat d’alta de moment i que s’ha eliminat un.*/

/*Modificar l’equip de l’amic que té per DNI = 48488588. L’equip ha de ser a partir d’ara l’11 i posar una marca anomenada intF.*/

/*Desfer les operacions fins a la marca intE. Què ha passat?. Comprova els registres.*/

/*Desfer les operacions fins a la marca intD. Què ha passat?. Comprova els registres.*/

/*Modificar l’equip que té per DNI =38624852. L’equip ha de ser a partir d’ara l’11.*/

/*Comprovar si tots els canvis s’han realitzat correctament a la taula i desa els canvis permanentment.*/

/*Inserir el registre:*/

/*Comprovar si tots els canvis s’han realitzat correctament a la taula i tancar la sessió de treball i
tornar a entrar. Comprovar si està el registre que s’ha donat d’alta a l’apartat anterior.*/

/*Està el registre?
En cas negatiu. Perquè no es troba?.
Torna a inserir-lo i desa el registre permanentment.*/

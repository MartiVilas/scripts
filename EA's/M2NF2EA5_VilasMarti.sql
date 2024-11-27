/*CREAR LA DATABASE 'escola'*/
CREATE DATABASE escola;


/*CREAR L'USUARI 'escola'*/
CREATE USER escola WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'escola';


/*CANVIAR EL OWNER DE LA TAULA DE L'USUARI MEU A L'USUARI 'escola'*/
ALTER DATABASE escola OWNER TO escola;


/*DONAR PRIVILEGIS DE LA DATABASE 'escola' AL USUARI 'escola'*/
GRANT ALL PRIVILEGES ON DATABASE escola TO escola;


/*TAULA DE LES AULES*/
CREATE TABLE IF NOT EXISTS Aules (
    NumeroAula INT,
    MetresQuadrats varchar(10) NOT NULL,
    constraint PK_Aules primary key (NumeroAula)
);


/*TAULA DELS MODULS*/
CREATE TABLE IF NOT EXISTS Moduls (
    CodiModul INT,
    NomModul VARCHAR(100) NOT NULL,
    NumeroAula INT,
    constraint PK_Moduls primary key (codiModul),
    constraint FK_Aules FOREIGN KEY (NumeroAula) REFERENCES Aules(NumeroAula)
);


/*TAULA DE LES ASSIGNATURES*/
CREATE TABLE IF NOT EXISTS Assignatures (
    CodiAssignatura INT,
    NomAssignatura VARCHAR(100) NOT NULL,
    constraint PK_Assignatres primary key(CodiAssignatura)
);


/*TAULA PERSONA*/
CREATE TABLE IF NOT EXISTS Persona(
    DNI CHAR(9),
    Nom VARCHAR(50) NOT NULL,
    Cognom1 VARCHAR(50) NOT NULL,
    Cognom2 VARCHAR(50),
    Adreca VARCHAR(100),
    Telefon VARCHAR(15),
    constraint PK_Persona PRIMARY KEY (DNI),
    constraint CK_nom check (nom = INITCAP(UPPER(nom)))
);

/*TAULA DELS PROFESSORS*/
CREATE TABLE IF NOT EXISTS Professor (
    DNI CHAR(9),
    Especialitat VARCHAR(50),
    Assignatures varchar(30),
    constraint PK_Professors primary key (DNI),
    constraint FK_Professors FOREIGN key (DNI) REFERENCES Persona(DNI)
);


/*TAULA DELS ALUMNES*/
CREATE TABLE IF NOT EXISTS Alumne (
    DNI varchar(9),
    DNIAlume varchar(9),
    DataNaixement DATE,
    AssignaturesMatriculades varchar(30),
    constraint PK_Alumnes PRIMARY KEY (DNI),
    constraint FK_Alumnes FOREIGN KEY (DNI) REFERENCES Persona(DNI),
    constraint FK_Delegat FOREIGN KEY (DNIAlume) REFERENCES Alumne(DNI)
);


/*Taula de la relació de modul i assignatura*/
CREATE TABLE IF NOT EXISTS Modul_Assignatura (
    CodiModul INT,
    CodiAssignatura INT,
    PRIMARY KEY (CodiModul, CodiAssignatura),
    FOREIGN KEY (CodiModul) REFERENCES Moduls(CodiModul),
    FOREIGN KEY (CodiAssignatura) REFERENCES Assignatures(CodiAssignatura)
);


/*Taula de la relació de la taula de modul amb aula*/
CREATE TABLE IF NOT EXISTS Modul_Aula (
    CodiModul INT UNIQUE,
    NumeroAula INT,
    PRIMARY KEY (CodiModul, NumeroAula),
    FOREIGN KEY (CodiModul) REFERENCES Moduls(CodiModul),
    FOREIGN KEY (NumeroAula) REFERENCES Aules(NumeroAula)
);


/*Taula de la relació de la taula professor amb asignatura*/
CREATE TABLE IF NOT EXISTS Professor_Assignatura (
    DNIProfessor CHAR(9),
    CodiAssignatura INT,
    PRIMARY KEY (DNIProfessor, CodiAssignatura),
    FOREIGN KEY (DNIProfessor) REFERENCES Professor(DNI),
    FOREIGN KEY (CodiAssignatura) REFERENCES Assignatures(CodiAssignatura)
);


/*Taula de la relació entre almne i assignatura*/
CREATE TABLE IF NOT EXISTS Alumne_Assignatura (
    DNIAlumne CHAR(9),
    CodiAssignatura INT,
    PRIMARY KEY (DNIAlumne, CodiAssignatura),
    FOREIGN KEY (DNIAlumne) REFERENCES Alumne(DNI),
    FOREIGN KEY (CodiAssignatura) REFERENCES Assignatures(CodiAssignatura)
);

-- Tabla Aules
INSERT INTO Aules (NumeroAula, MetresQuadrats) VALUES (106, '55m2');
INSERT INTO Aules (NumeroAula, MetresQuadrats) VALUES (107, '65m2');
INSERT INTO Aules (NumeroAula, MetresQuadrats) VALUES (108, '75m2');
INSERT INTO Aules (NumeroAula, MetresQuadrats) VALUES (109, '85m2');
INSERT INTO Aules (NumeroAula, MetresQuadrats) VALUES (110, '90m2');

-- Tabla Moduls
INSERT INTO Moduls (CodiModul, NomModul, NumeroAula) VALUES (6, 'Història', 106);
INSERT INTO Moduls (CodiModul, NomModul, NumeroAula) VALUES (7, 'Geografia', 107);
INSERT INTO Moduls (CodiModul, NomModul, NumeroAula) VALUES (8, 'Anglès', 108);
INSERT INTO Moduls (CodiModul, NomModul, NumeroAula) VALUES (9, 'Música', 109);
INSERT INTO Moduls (CodiModul, NomModul, NumeroAula) VALUES (10, 'Arts Plàstiques', 110);

-- Tabla Assignatures
INSERT INTO Assignatures (CodiAssignatura, NomAssignatura) VALUES (106, 'Història Contemporània');
INSERT INTO Assignatures (CodiAssignatura, NomAssignatura) VALUES (107, 'Geopolítica');
INSERT INTO Assignatures (CodiAssignatura, NomAssignatura) VALUES (108, 'Anglès Avançat');
INSERT INTO Assignatures (CodiAssignatura, NomAssignatura) VALUES (109, 'Composició Musical');
INSERT INTO Assignatures (CodiAssignatura, NomAssignatura) VALUES (110, 'Dibuix Tècnic');

-- Tabla Persona
INSERT INTO Persona (DNI, Nom, Cognom1, Cognom2, Adreca, Telefon) VALUES ('34567890C', 'Anna', 'Torres', 'Sánchez', 'Carrer Vell 3', '600345678');
INSERT INTO Persona (DNI, Nom, Cognom1, Cognom2, Adreca, Telefon) VALUES ('45678901D', 'Pere', 'Ramírez', 'Lopez', 'Carrer Estret 4', '600456789');
INSERT INTO Persona (DNI, Nom, Cognom1, Cognom2, Adreca, Telefon) VALUES ('56789012E', 'Clara', 'Soler', 'Martí', 'Carrer Llarg 5', '600567890');
INSERT INTO Persona (DNI, Nom, Cognom1, Cognom2, Adreca, Telefon) VALUES ('67890123F', 'Jordi', 'Ferrer', 'Pérez', 'Carrer Ample 6', '600678901');
INSERT INTO Persona (DNI, Nom, Cognom1, Cognom2, Adreca, Telefon) VALUES ('78901234G', 'Carme', 'Vila', 'Rodríguez', 'Carrer Curt 7', '600789012');

-- Tabla Professor
INSERT INTO Professor (DNI, Especialitat, Assignatures) VALUES ('12345678A', 'Matemàtiques', 'Àlgebra Lineal');
INSERT INTO Professor (DNI, Especialitat, Assignatures) VALUES ('23456789B', 'Física', 'Electromagnetisme');
INSERT INTO Professor (DNI, Especialitat, Assignatures) VALUES ('34567890C', 'Química', 'Reaccions Químiques');
INSERT INTO Professor (DNI, Especialitat, Assignatures) VALUES ('45678901D', 'Biologia', 'Genètica Molecular');
INSERT INTO Professor (DNI, Especialitat, Assignatures) VALUES ('56789012E', 'Informàtica', 'Programació Avançada');

-- Tabla Alumne
INSERT INTO Alumne (DNI, DNIAlume, DataNaixement, AssignaturesMatriculades) VALUES ('78901234G', NULL, '2005-03-15', 'Àlgebra Lineal');
INSERT INTO Alumne (DNI, DNIAlume, DataNaixement, AssignaturesMatriculades) VALUES ('67890123F', NULL, '2004-05-20', 'Electromagnetisme');
INSERT INTO Alumne (DNI, DNIAlume, DataNaixement, AssignaturesMatriculades) VALUES ('56789012E', NULL, '2003-07-10', 'Reaccions Químiques');
INSERT INTO Alumne (DNI, DNIAlume, DataNaixement, AssignaturesMatriculades) VALUES ('45678901D', '78901234G', '2002-09-25', 'Genètica Molecular');
INSERT INTO Alumne (DNI, DNIAlume, DataNaixement, AssignaturesMatriculades) VALUES ('34567890C', NULL, '2001-12-30', 'Programació Avançada');

-- Tabla Modul_Assignatura
INSERT INTO Modul_Assignatura (CodiModul, CodiAssignatura) VALUES (1, 101);
INSERT INTO Modul_Assignatura (CodiModul, CodiAssignatura) VALUES (2, 102);
INSERT INTO Modul_Assignatura (CodiModul, CodiAssignatura) VALUES (3, 103);
INSERT INTO Modul_Assignatura (CodiModul, CodiAssignatura) VALUES (4, 104);
INSERT INTO Modul_Assignatura (CodiModul, CodiAssignatura) VALUES (5, 105);

-- Tabla Modul_Aula
INSERT INTO Modul_Aula (CodiModul, NumeroAula) VALUES (1, 101);
INSERT INTO Modul_Aula (CodiModul, NumeroAula) VALUES (2, 102);
INSERT INTO Modul_Aula (CodiModul, NumeroAula) VALUES (3, 103);
INSERT INTO Modul_Aula (CodiModul, NumeroAula) VALUES (4, 104);
INSERT INTO Modul_Aula (CodiModul, NumeroAula) VALUES (5, 105);

-- Tabla Professor_Assignatura
INSERT INTO Professor_Assignatura (DNIProfessor, CodiAssignatura) VALUES ('12345678A', 101);
INSERT INTO Professor_Assignatura (DNIProfessor, CodiAssignatura) VALUES ('23456789B', 102);
INSERT INTO Professor_Assignatura (DNIProfessor, CodiAssignatura) VALUES ('34567890C', 103);
INSERT INTO Professor_Assignatura (DNIProfessor, CodiAssignatura) VALUES ('45678901D', 104);
INSERT INTO Professor_Assignatura (DNIProfessor, CodiAssignatura) VALUES ('56789012E', 105);

-- Tabla Alumne_Assignatura
INSERT INTO Alumne_Assignatura (DNIAlumne, CodiAssignatura) VALUES ('78901234G', 101);
INSERT INTO Alumne_Assignatura (DNIAlumne, CodiAssignatura) VALUES ('67890123F', 102);
INSERT INTO Alumne_Assignatura (DNIAlumne, CodiAssignatura) VALUES ('56789012E', 103);
INSERT INTO Alumne_Assignatura (DNIAlumne, CodiAssignatura) VALUES ('45678901D', 104);
INSERT INTO Alumne_Assignatura (DNIAlumne, CodiAssignatura) VALUES ('34567890C', 105);


/* ALTER TABLES */
ALTER TABLE Persona ADD Email VARCHAR(100);

ALTER TABLE Persona MODIFY Telefon VARCHAR(20);

ALTER TABLE Persona ADD CONSTRAINT UK_Persona_Telefon UNIQUE (Telefon);

ALTER TABLE Persona DROP COLUMN Cognom2;

/* UPDATES */
UPDATE Persona SET Nom = 'María' WHERE DNI = '12345678A';

UPDATE Aules SET MetresQuadrats = '60m2' WHERE CAST(SUBSTR(MetresQuadrats, 1, LENGTH(MetresQuadrats) - 2) AS INT) < 60;

UPDATE Moduls SET NumeroAula = (SELECT NumeroAula FROM Aules WHERE NumeroAula = 110) WHERE CodiModul = 5;

UPDATE Persona SET Adreca = 'Carrer Nou 10', Telefon = '611223344' WHERE DNI = '23456789B';

/* DELETES */
DELETE FROM Alumne WHERE DNI = '78901234G';

DELETE FROM Moduls WHERE CodiModul = 5;

DELETE FROM Assignatures;

DELETE FROM Alumne WHERE YEAR(DataNaixement) < 2004;
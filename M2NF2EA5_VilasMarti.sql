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
    constraint PK_Moduls primary key (codiModul),
    constraint FK_Aules FOREIGN KEY (NumeroAula) REFERENCES TO Aules(NumeroAula)
);

/*TAULA DE LES ASSIGNATURES*/
CREATE TABLE IF NOT EXISTS Assignatures (
    CodiAssignatura INT,
    NomAssignatura VARCHAR(100) NOT NULL,
    constraint PK_Assignatres primary key (CodiAssignatura)
);

/*TAULA PERSONA*/

CREATE TABLE IF NOT EXISTS Persona(
    DNI CHAR(9),
    Nom VARCHAR(50) NOT NULL,
    Cognom1 VARCHAR(50) NOT NULL,
    Cognom2 VARCHAR(50),
    Adreca VARCHAR(100),
    Telefon VARCHAR(15),
    constraint PK_Persona primary key (DNI)
);

/*TAULA DELS PROFESSORS*/
CREATE TABLE IF NOT EXISTS Professors (
    Especialitat VARCHAR(50),
    Assignatures varchar(30),
    constraint PK_Professors primary key Persona (DNI),
    constraint FK_Professors FOREIGN key (DNI) REFERENCES Persona(DNI),
    constraint CK_nom check (nom = INITCAP(UPPER(nom)))
);

/*TAULA DELS ALUMNES*/
CREATE TABLE IF NOT EXISTS Alumnes (
    DataNaixement DATE,
    AssignaturesMatriculades varchar(30),
    constraint PK_Alumnes PRIMARY KEY Persona (DNI),
    constraint FK_Alumnes FOREIGN key (DNI) REFERENCES Persona(DNI),
    constraint FK_Alunes_Reflexiva (DNI) REFERENCES Alumnes(PK_Alumnes)
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
    FOREIGN KEY (DNIProfessor) REFERENCES Professors(DNI),
    FOREIGN KEY (CodiAssignatura) REFERENCES Assignatures(CodiAssignatura)
);

/*Taula de la relació entre almne i assignatura*/
CREATE TABLE IF NOT EXISTS Alumne_Assignatura (
    DNIAlumne CHAR(9),
    CodiAssignatura INT,
    PRIMARY KEY (DNIAlumne, CodiAssignatura),
    FOREIGN KEY (DNIAlumne) REFERENCES Alumnes(DNI),
    FOREIGN KEY (CodiAssignatura) REFERENCES Assignatures(CodiAssignatura)
);

/*Taula de la relació entre alumne y delegats*/
CREATE TABLE IF NOT EXISTS Alumne_Delegats (
    DNIAlumne CHAR(9),
    CodiGrup INT,
    PRIMARY KEY (DNIAlumne, CodiGrup),
    FOREIGN KEY (DNIAlumne) REFERENCES Alumnes(DNI),
    FOREIGN KEY (CodiGrup) REFERENCES Delegats(CodiGrup)
);



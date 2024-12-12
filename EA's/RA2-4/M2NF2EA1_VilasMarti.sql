CREATE DATABASE empleats;

CREATE USER empleats WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'empleats';

ALTER DATABASE empleats OWNER TO empleats;

GRANT ALL PRIVILEGES ON DATABASE empleats TO empleats;

CREATE TABLE IF NOT EXISTS Región (
    CodRegión varchar(7) UNIQUE,
    Nombre varchar(7),
    CONSTRAINT PK_CodRegión PRIMARY KEY (CodRegión) 
);

CREATE TABLE IF NOT EXISTS Provincia (
    CodProvincia varchar(7),
    Nombre varchar(7),
    CodRegión varchar(7),
    CONSTRAINT PK_CodProvincia PRIMARY KEY (CodProvincia),
    CONSTRAINT FK_CodRegión FOREIGN KEY (CodRegión) REFERENCES Región(CodRegión)
);

CREATE TABLE IF NOT EXISTS Localidad (
    CodLocalidad varchar(5),
    Nombre varchar(7),
    CodProvincia varchar(5),
    CONSTRAINT PK_CodLocalidad PRIMARY KEY (CodLocalidad),
    CONSTRAINT FK_CodProvincia FOREIGN KEY (CodProvincia) REFERENCES Provincia(CodProvincia)
);

CREATE TABLE IF NOT EXISTS Empleado (
    DNI varchar(9),
    Nombre varchar(7),
    FechaNac DATE,
    Telefono smallint,
    Salario smallint,
    CodLocalidad varchar(5),
    CONSTRAINT FK_CodLocalidad FOREIGN KEY (CodLocalidad) REFERENCES Localidad(CodLocalidad)
);

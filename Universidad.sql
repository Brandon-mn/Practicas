--SQL
USE master;
GO
IF DB_ID (N'Universidad') IS NOT NULL
DROP DATABASE Universidad
GO
CREATE DATABASE Universidad
ON
( NAME = Universidad_dat,
    FILENAME = 'C:\BD\Universidad.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Universidad_log,
    FILENAME = 'C:\BD\Universidad.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE Universidad
GO
CREATE TABLE AreaConocimiento
(
	idAreaConocimiento IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Catedra
(
	idCatedra INT not null,
	nombre VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Departamento
(
	idDepartamento  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	idCatedra INT not null,
	idProfesor INT not null,
	idAreaConocimiento INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Facultad
(
	idFacultad INT IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Profesor
(
	idProfesor INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	telefono INT not null,
	idDepartamento INT not null,
	idFacultad INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE DepartamentoFacultad
(
	idDepartamentoFacultad  IDENTITY (1,1),
	idDepartamento INT not null,
	idFacultad INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE CatedraProfesor
(
	idCatedraProfesor  IDENTITY (1,1),
	idCatedra INT not null,
	idProfesor INT not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias
ALTER TABLE AreaConocimiento ADD CONSTRAINT PK_AreaConocimiento PRIMARY KEY (idAreaConocimiento)
ALTER TABLE Catedra ADD CONSTRAINT PK_Catedra PRIMARY KEY (idCatedra)
ALTER TABLE Facultad  ADD CONSTRAINT PK_Facultad PRIMARY KEY (idFacultad)
ALTER TABLE Departamento ADD CONSTRAINT PK_Departamento PRIMARY KEY (idDepartamento)
ALTER TABLE Profesor ADD CONSTRAINT PK_Profesor PRIMARY KEY (idProfesor)
ALTER TABLE DepartamentoFacultad ADD CONSTRAINT PK_DepartamentoFacultad PRIMARY KEY (idDepartamentoFacultad)
ALTER TABLE CatedraProfesor ADD CONSTRAINT PK_CatedraProfesor PRIMARY KEY (idCatedraProfesor)
--Llaves Foraneas
--Departamento
ALTER TABLE Departamento ADD CONSTRAINT FK_DepartamentoCatedra FOREIGN KEY (idCatedra) REFERENCES Catedra (idCatedra)
ALTER TABLE Departamento ADD CONSTRAINT FK_DepartamentoProfesor FOREIGN KEY (idProfesor) REFERENCES Profesor (idProfesor)
ALTER TABLE Departamento ADD CONSTRAINT FK_DepartamentoAreaConocimiento FOREIGN KEY (idAreaConocimiento) REFERENCES AreaConocimiento (idAreaConocimiento)
--PROFESOR 
ALTER TABLE Profesor ADD CONSTRAINT FK_ProfesorDepartamento FOREIGN KEY (idDepartamento) REFERENCES Departamento (idDepartamento)
ALTER TABLE Profesor ADD CONSTRAINT FK_ProfesorFacultad FOREIGN KEY (idFacultad) REFERENCES Facultad (idFacultad)
--CATEDRAPROFESOR
ALTER TABLE CatedraProfesor ADD CONSTRAINT FK_CatedraProfesorCatreda FOREIGN KEY (idCatedra) REFERENCES Catedra (idCatedra)
ALTER TABLE CatedraProfesor ADD CONSTRAINT FK_CatedraProfesorProfesor FOREIGN KEY (idProfesor) REFERENCES Profesor (idProfesor)
--DEPARTAMENTOFACULTAD
ALTER TABLE DepartamentoFacultad ADD CONSTRAINT FK_DepartamentoFacultadDepartamento FOREIGN KEY (idDepartamento) REFERENCES Departamento (idDepartamento)
ALTER TABLE DepartamentoFacultad ADD CONSTRAINT FK_DepartamentoFacultadFacultad FOREIGN KEY (idFacultad) REFERENCES Facultad (idFacultad)
--INDICES
CREATE INDEX IX_AreaConocimiento ON AreaConocimiento (idAreaConocimiento)
CREATE INDEX IX_Catedra ON Catedra (idCatedra)
CREATE INDEX IX_Facultad ON Facultad (idFacultad)
CREATE INDEX IX_Departamento ON Departamento (idDepartamento)
CREATE INDEX IX_Profesor ON Profesor (idProfesor)
CREATE INDEX IX_DepartamentoFacultad ON DepartamentoFacultad (idDepartamentoFacultad)
CREATE INDEX IX_CatedraProfesor ON CatedraProfesor (idCatedraProfesor)
--SQL
USE master;
GO
IF DB_ID (N'Viviendas') IS NOT NULL
	DROP DATABASE Viviendas;

GO
CREATE DATABASE Viviendas
ON 
( NAME = Viviendas_dat,
	FILENAME = 'C:\BD\Viviendas.mdf',
	SIZE = 10,
	MAXSIZE = 50,
	FILEGROWTH = 5)
LOG ON 
(NAME = Viviendas_log,
	FILENAME = 'C:\BD\Viviendas.ldf',
	SIZE = 5MB,
	MAXSIZE = 25MB,
	FILEGROWTH = 5MB);
GO
USE Viviendas;
GO
--Tablas
CREATE TABLE Persona
(
  idPersona INT IDENTITY(1,1),
  nombre varchar(50) NOT NULL,
  apellidoPaterno INT NOT NULL,
  apellidoMaterno varchar(50) NOT NULL, 
  idVivienda INT NOT NULL,
  estatus bit default 1 not null,
);
CREATE TABLE Vivienda
(
  idVivienda INT  IDENTITY (1,1),
  calle varchar(50) NOT NULL,
  numero INT NOT NULL,
  ciudad varchar(50) NOT NULL, 
  idPersona INT NOT NULL,
  estatus bit default 1 not null,
);
CREATE TABLE Municipio
(
  idMunicipio INT  IDENTITY (1,1),
  nombre varchar(50) NOT NULL,
  idVivienda INT NOT NULL, 
  estatus bit default 1 not null,
);
--Llaves primarias
ALTER TABLE Persona ADD CONSTRAINT PK_Persona PRIMARY KEY (idPersona)
ALTER TABLE Vivienda ADD CONSTRAINT PK_Vivienda PRIMARY KEY (idVivienda)
ALTER TABLE Municipio ADD CONSTRAINT PK_Municipio PRIMARY KEY (idMunicipio)


--Llaves Secundarias
ALTER TABLE Persona ADD CONSTRAINT FK_PersonaVivienda 
FOREIGN  KEY(idVivienda) REFERENCES Vivienda(idVivienda)
GO

ALTER TABLE Vivienda ADD CONSTRAINT FK_ViviendaPersona 
FOREIGN  KEY(idPersona) REFERENCES Persona(idPersona)
GO

ALTER TABLE Municipio ADD CONSTRAINT FK_MunicipioVivienda 
FOREIGN  KEY(idVivienda) REFERENCES Vivienda(idVivienda)
GO
--INDEX
CREATE INDEX IX_Persona ON Persona(idPersona);
GO
CREATE INDEX IX_Vivienda ON Vivienda(idVivienda);
GO
CREATE INDEX IX_Municipio ON Municipio(idMunicipio);
GO
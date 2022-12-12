USE master;
GO
IF DB_ID (N'Carretera') IS NOT NULL
DROP DATABASE Carretera
GO
CREATE DATABASE Carretera
ON
( NAME = Carretera_dat,
    FILENAME = 'C:\BD\Carretera.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Carretera_log,
    FILENAME = 'C:\BD\Carretera.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB 
);
GO
USE Carretera;
GO
CREATE TABLE Carretera
(
	idCarretera INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Tramo 
(
	idTramo INT  IDENTITY (1,1),
	idCarretera INT not null,
	numeroTramo INT not null,
	descripcion VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Municipio
(
	idMunicipio INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE MunicipioTramo
(
	idMunicipioTramo INT  IDENTITY (1,1),
	idMunicipio INT not null,
	idTramo INT not null,
	kmEntrada INT not null,
	kmSalida INT not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias 
ALTER TABLE Carretera ADD CONSTRAINT PK_Carretera PRIMARY KEY (idCarretera)
ALTER TABLE Tramo ADD CONSTRAINT PK_Tramo PRIMARY KEY (idTramo)
ALTER TABLE Municipio ADD CONSTRAINT PK_Municipio PRIMARY KEY (idMunicipio) 
ALTER TABLE MunicipioTramo ADD CONSTRAINT PK_MunicipioTramo PRIMARY KEY (idMunicipioTramo)
--Llaves Foraneas
ALTER TABLE Tramo ADD CONSTRAINT FK_TramoCarretera FOREIGN KEY (idCarretera) REFERENCES Carretera (idCarretera)
--MunicipioTramo
ALTER TABLE MunicipioTramo ADD CONSTRAINT FK_MunicipioTramoMunicipio FOREIGN KEY (idMunicipio) REFERENCES Municipio (idMunicipio)
ALTER TABLE MunicipioTramo ADD CONSTRAINT FK_MunicipioTramoTramo FOREIGN KEY (idTramo) REFERENCES Tramo (idTramo)
--INDICES
CREATE INDEX IX_Carretera ON Carretera (idCarretera)
CREATE INDEX IX_Tramo ON Tramo (idTramo)
CREATE INDEX IX_Municipio ON Municipio (idMunicipio)
CREATE INDEX IX_MunicipioTramo ON MunicipioTramo (idMunicipioTramo)

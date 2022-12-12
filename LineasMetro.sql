--SQL
USE master;
GO
IF DB_ID (N'LineasMetro') IS NOT NULL
	DROP DATABASE LineasMetro;

GO
CREATE DATABASE LineasMetro
ON 
( NAME = LineasMetro_dat,
	FILENAME = 'C:\BD\LineasMetro.mdf',
	SIZE = 10,
	MAXSIZE = 50,
	FILEGROWTH = 5)
LOG ON 
(NAME = LineasMetro_log,
	FILENAME = 'C:\BD\LineasMetro.ldf',
	SIZE = 5MB,
	MAXSIZE = 25MB,
	FILEGROWTH = 5MB);
GO
USE LineasMetro;
GO
--Tablas
CREATE TABLE Acceso
(
  idAcceso INT NOT NULL,
  nombre varchar(50) NOT NULL,
  numero INT NOT NULL,
  calle varchar(50) NOT NULL, 
  ciudad varchar(50) NOT NULL, 
  idEstacion INT NOT NULL,
  estatus bit default 1 not null,
);
CREATE TABLE Cochera
(
  idCochera INT NOT NULL,
  nombre varchar(50) NOT NULL,
  numero INT NOT NULL,
  calle varchar(50) NOT NULL, 
  ciudad varchar(50) NOT NULL, 
  estatus bit default 1 not null,
);
CREATE TABLE Estacion
(
  idEstacion INT NOT NULL,
  nombre varchar(50) NOT NULL,
  numero INT NOT NULL,
  calle varchar(50) NOT NULL, 
  ciudad varchar(50) NOT NULL, 
  estatus bit default 1 not null,
);
CREATE TABLE Linea
(
  idLinea INT NOT NULL,
  nombre varchar(50) NOT NULL,
  ruta INT NOT NULL,
  estatus bit default 1 not null,
);
CREATE TABLE Tren
(
  idTren INT NOT NULL,
  numero INT NOT NULL,
  idLinea INT NOT NULL,
  idCochera INT NOT NULL,
  estatus bit default 1 not null,
);
CREATE TABLE LineaEstacion
(
  idLineaEstacion INT NOT NULL,
  idLinea INT NOT NULL,
  idEstacion INT NOT NULL,
  estatus bit default 1 not null,
);
--Llaves primarias
ALTER TABLE Acceso ADD CONSTRAINT PK_Acceso PRIMARY KEY (idAcceso)
ALTER TABLE Cochera ADD CONSTRAINT PK_Cochera PRIMARY KEY (idCochera)
ALTER TABLE Estacion ADD CONSTRAINT PK_Estacion PRIMARY KEY (idEstacion)
ALTER TABLE Linea ADD CONSTRAINT PK_Linea PRIMARY KEY (idLinea)
ALTER TABLE Tren ADD CONSTRAINT PK_Tren PRIMARY KEY (idTren)
ALTER TABLE LineaEstacion ADD CONSTRAINT PK_LineaEstacion PRIMARY KEY (idLineaEstacion)

--Llaves foraneas
ALTER TABLE Acceso ADD CONSTRAINT FK_AccesoEstacion
FOREIGN  KEY(idEstacion) REFERENCES Estacion(idEstacion)
GO
ALTER TABLE Tren ADD CONSTRAINT FK_TrenLinea
FOREIGN  KEY(idLinea) REFERENCES Linea(idLinea)
GO
ALTER TABLE Tren ADD CONSTRAINT FK_TrenCochera
FOREIGN  KEY(idCochera) REFERENCES Cochera(idCochera)
GO
ALTER TABLE LineaEstacion ADD CONSTRAINT FK_LineaEstacionLinea
FOREIGN  KEY(idLinea) REFERENCES Linea(idLinea)
GO
ALTER TABLE LineaEstacion ADD CONSTRAINT FK_LineaEstacionEstacion
FOREIGN  KEY(idEstacion) REFERENCES Estacion(idEstacion)
GO
--INDEX
CREATE INDEX IX_Acceso ON Acceso(idAcceso);
GO
CREATE INDEX IX_Cochera ON Cochera(idCochera);
GO
CREATE INDEX IX_Estacion ON Estacion(idEstacion);
GO
CREATE INDEX IX_Linea ON Linea(idLinea);
GO
CREATE INDEX IX_Tren ON Tren(idTren);
GO
CREATE INDEX IX_LineaEstacion ON LineaEstacion(idLineaEstacion);
GO
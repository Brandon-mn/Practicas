--SQL
USE master;
GO
IF DB_ID (N'FutbolSoccer') IS NOT NULL
DROP DATABASE FutbolSoccer
GO
CREATE DATABASE FutbolSoccer
ON
( NAME = FutbolSoccer_dat,
    FILENAME = 'C:\BD\FutbolSoccer.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = FutbolSoccer_log,
    FILENAME = 'C:\BD\FutbolSoccer.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE FutbolSoccer
GO
CREATE TABLE Colegiado 
( 
	idColegiado INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	tipo VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Equipo
(
	idEquipo INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Jugador
(
	idJugador INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	numero INT not null,
	colonia VARCHAR (50) not null,
	cuidad VARCHAR (50) not null,
	CURP VARCHAR (25) not null,
	idEquipo INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Partido
(
	idPartido INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	tipo VARCHAR (50) not null,
	idEquipo INT not null,
	estatus BIT DEFAULT  1 not null,
);
GO
CREATE TABLE Puesto
(
	idPuesto INT IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	descripcion VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE JugadorPuesto
(
	idJugadorPuesto INT not null,
	idJugador INT not null,
	idPuesto INT not null,
	fecha DATETIME not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE ColegiadoPartido
(
	idColegiadoPartido INT  IDENTITY (1,1),
	idColegiado INT not null,
	idPartido INT not null,
	estatus BIT DEFAULT 1 not null,
);

--Llaves Primarias 
ALTER TABLE Colegiado ADD CONSTRAINT PK_Colegiado PRIMARY KEY (idColegiado)
ALTER TABLE Equipo ADD CONSTRAINT PK_Equipo PRIMARY KEY (idEquipo)
ALTER TABLE Jugador ADD CONSTRAINT PK_Jugador PRIMARY KEY (idJugador)
ALTER TABLE Partido ADD CONSTRAINT PK_Partido PRIMARY KEY (idPartido)
ALTER TABLE Puesto ADD CONSTRAINT PK_Puesto PRIMARY KEY (idPuesto)
ALTER TABLE JugadorPuesto ADD CONSTRAINT PK_JugadorPuesto PRIMARY KEY (idJugadorPuesto)
ALTER TABLE ColegiadoPartido ADD CONSTRAINT PK_ColegiadoPartido PRIMARY KEY (idColegiadoPartido)
--Llaves Foraneas
--JUGADOR 
ALTER TABLE  Jugador ADD CONSTRAINT FK_JugadorEquipo FOREIGN KEY (idEquipo) REFERENCES Equipo (idEquipo)
--PARTIDO
ALTER TABLE Partido ADD CONSTRAINT FK_PartidoEquipo FOREIGN KEY (idEquipo) REFERENCES Equipo (idEquipo)
--JUGADORPUESTO
ALTER TABLE JugadorPuesto ADD CONSTRAINT FK_JugadorPuestoJugador FOREIGN KEY (idJugador) REFERENCES Jugador (idJugador)
ALTER TABLE JugadorPuesto ADD CONSTRAINT FK_JugadorPuestoPuesto FOREIGN KEY (idPuesto) REFERENCES Puesto (idPuesto)
--COLEGIADOPARTIDO
ALTER TABLE ColegiadoPartido ADD CONSTRAINT FK_ColegiadoPartidoColegiado FOREIGN KEY (idColegiado) REFERENCES Colegiado (idColegiado)
ALTER TABLE ColegiadoPartido ADD CONSTRAINT FK_ColegiadoPartdidoPartido FOREIGN KEY (idPartido) REFERENCES Partido (idPartido)
--INDICES
CREATE INDEX IX_Colegiado ON Colegiado (idColegiado)
CREATE INDEX IX_Equipo ON Equipo (idEquipo)
CREATE INDEX IX_Jugador ON Jugador (idJugador)
CREATE INDEX IX_Partido ON Partido (idPartido)
CREATE INDEX IX_Puesto ON Puesto (idPuesto)
CREATE INDEX IX_JugadorPuesto ON JugadorPuesto (idJugadorPuesto)
CREATE INDEX IX_ColegiadoPartido ON ColegiadoPartido (idColegiadoPartido)

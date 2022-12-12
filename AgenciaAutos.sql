USE master;
GO
IF DB_ID (N'AgenciaAutos') IS NOT NULL
DROP DATABASE AgenciaAutos
GO
CREATE DATABASE AgenciaAutos
ON
( NAME = AgenciaAutos_dat,
    FILENAME = 'C:\BD\AgenciaAutos.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = AgenciaAutos_log,
    FILENAME = 'C:\BD\AgenciaAutos.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE AgenciaAutos
GO
CREATE TABLE Cliente
(
	idCliente INT IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	apellidoPaterno VARCHAR (50) not null,
	apellidoMaterno VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	numero VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	codigoPostal INT not null,
	telefono INT not null,
	claveAlfanumerico INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Reserva
(
	idReserva INT  IDENTITY (1,1),
	fechaInicial DATETIME not null,
	fechaFinal DATETIME not null,
	estatus BIT DEFAULT 1 not null,
	claveAlfanumerica INT not null,
	idCliente INT not null,
	idAgencia INT not null,

);
GO
CREATE TABLE Coche
(
	idCoche INT  IDENTITY (1,1),
	estatus BIT DEFAULT 1 not null,
	costo INT not null,
	placa VARCHAR (50) not null,
	claveAlfanumerica INT not null,
	idGaraje INT not null,
);
GO
CREATE TABLE Garaje 
(
	idGaraje INT  IDENTITY (1,1),
	calle VARCHAR (50) not null,
	numero INT not null,
	colonia VARCHAR (50) not null,
	codigoPostal INT not null,
	claveAlfanumerica INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Agencia
(
	idAgencia INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	telefono INT not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	codigoPostal INT not null,
	claveAlfanumerica INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE CocheReserva
(
	idCocheReserva INT IDENTITY (1,1),
	idCoche INT not null,
	idReserva INT not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Reserva ADD CONSTRAINT PK_Reserva PRIMARY KEY (idReserva)
ALTER TABLE Coche ADD CONSTRAINT PK_Coche PRIMARY KEY (idCoche)
ALTER TABLE Garaje ADD CONSTRAINT PK_Garaje PRIMARY KEY (idGaraje)
ALTER TABLE Agencia ADD CONSTRAINT PK_Agencia PRIMARY KEY (idAgencia)
ALTER TABLE CocheReserva ADD CONSTRAINT PK_CocheReserva PRIMARY KEY (idCocheReserva)
--Llaves Foraneas
--Reserva
ALTER TABLE Reserva ADD CONSTRAINT FK_ReservaCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
ALTER TABLE Reserva ADD CONSTRAINT FK_ReservaAgencia FOREIGN KEY (idAgencia) REFERENCES Agencia (idAgencia)
--Coche
ALTER TABLE Coche ADD CONSTRAINT FK_CocheGaraje FOREIGN KEY (idGaraje) REFERENCES Garaje (idGaraje)
--CocheReserva
ALTER TABLE CocheReserva ADD CONSTRAINT FK_CocheReservaCoche FOREIGN KEY (idCoche) REFERENCES Coche (idCoche)
ALTER TABLE CocheReserva ADD CONSTRAINT FK_CocheReservaReserva FOREIGN KEY (idReserva) REFERENCES Reserva (idReserva)
--INDICES
CREATE INDEX IX_Cliente ON Cliente (idCliente)
CREATE INDEX IX_Reserva ON Reserva (idReserva)
CREATE INDEX IX_Coche ON Coche (idCoche)
CREATE INDEX IX_Garaje ON Garaje (idGaraje)
CREATE INDEX IX_Agencia ON Agencia (idAgencia)
CREATE INDEX IX_CocheReserva ON CocheReserva (idCocheReserva)
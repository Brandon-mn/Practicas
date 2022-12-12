--SQL
USE master;
GO
IF DB_ID (N'AgenciaViajesII') IS NOT NULL
DROP DATABASE AgenciaViajesII
GO
CREATE DATABASE AgenciaViajesII
ON
( NAME = AgenciaViajesII_dat,
    FILENAME = 'C:\BD\AgenciaViajes2.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = AgenciaViajesII_log,
    FILENAME = 'C:\BD\AgenciaViajes2.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE AgenciaViajesII;
GO
CREATE TABLE Cliente
(
	 idCliente INT  IDENTITY (1,1),
	 nombre VARCHAR (50) not null,
	 apellidoPaterno VARCHAR (50) not null,
	 apellidoMaterno VARCHAR (50) not null,
	 telefono INT not null,
	 estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Hotel
(
	idHotel INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	plazasDisponibles VARCHAR (50) not null,
	codigoPostal INT not null,
	numeroExterior INT not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE PuntoRuta
(
	idPuntoRuta INT  IDENTITY (1,1),
	descripcion VARCHAR (50) not null,
	tipo VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Tour
(
	idTour INT  IDENTITY (1,1),
	fecha DATETIME not null,
	finalidad VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE ClienteTour
(
	idClienteTour INT  IDENTITY (1,1),
	idCliente INT not null,
	idTour INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE HotelPuntoRuta
(
	idHotelPuntoRuta INT  IDENTITY (1,1),
	idHotel INT not null,
	idPuntoRuta INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE PuntoRutaTour
(
	idPuntoRutaTour INT  IDENTITY (1,1),
	idPuntoRuta INT not null,
	idTour INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE ClienteHotel
(
	idClienteHotel INT IDENTITY (1,1),
	idCliente INT not null,
	idHotel INT not null,
	fecha DATETIME not null,
	estatus BIT DEFAULT 1 not null,
);
--Llaves Primarias
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Hotel ADD CONSTRAINT PK_Hotel PRIMARY KEY (idHotel)
ALTER TABLE PuntoRuta ADD CONSTRAINT PK_PuntoRuta PRIMARY KEY (idPuntoRuta)
ALTER TABLE Tour ADD CONSTRAINT PK_Tour PRIMARY KEY (idTour)
ALTER TABLE ClienteTour ADD CONSTRAINT PK_ClienteTour PRIMARY KEY (idClienteTour)
ALTER TABLE HotelPuntoRuta ADD CONSTRAINT PK_HotelPuntoRuta PRIMARY KEY (idHotelPuntoRuta)
ALTER TABLE PuntoRutaTour ADD CONSTRAINT PK_PuntoRutaTour PRIMARY KEY (idPuntoRutaTour)
ALTER TABLE ClienteHotel ADD CONSTRAINT PK_ClienteHotel PRIMARY KEY (idClienteHotel)
--Llaves Foraneas
--CLIENTETOUR
ALTER TABLE ClienteTour ADD CONSTRAINT FK_ClienteTourCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
ALTER TABLE ClienteTour ADD CONSTRAINT FK_ClienteTourTour FOREIGN KEY (idTour) REFERENCES Tour (idTour)
--HOTELPUNTORUTA
ALTER TABLE HotelPuntoRuta ADD CONSTRAINT FK_HotelPuntoRutaHotel FOREIGN KEY (idHotel) REFERENCES Hotel (idHotel)
ALTER TABLE HotelPuntoRuta ADD CONSTRAINT FK_HotelPuntoRutaPuntoRuta FOREIGN KEY (idPuntoRuta) REFERENCES PuntoRuta (idPuntoRuta)
--CLIENTEHOTEL
ALTER TABLE ClienteHotel ADD CONSTRAINT FK_ClienteHotelCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
ALTER TABLE ClienteHotel ADD CONSTRAINT FK_ClienteHotelHotel FOREIGN KEY (idHotel) REFERENCES Hotel (idHotel)
--PUNTORUTATOUR
ALTER TABLE PuntoRutaTour ADD CONSTRAINT FK_PuntoRutaPuntoRuta FOREIGN KEY (idPuntoRuta) REFERENCES PuntoRuta (idPuntoRuta)
ALTER TABLE PuntoRutaTour ADD CONSTRAINT FK_PuntoRutaTour FOREIGN KEY (idTour) REFERENCES Tour (idTour)
--INDICES
CREATE INDEX IX_Cliente ON Cliente (idCliente)
CREATE INDEX IX_Hotel ON Hotel (idHotel)
CREATE INDEX IX_PuntoRuta ON PuntoRuta (idPuntoRuta)
CREATE INDEX IX_Tour ON Tour (idTour)
CREATE INDEX IX_ClienteTour ON ClienteTour (idClienteTour)
CREATE INDEX IX_HotelPuntoRuta ON HotelPuntoRuta (idHotelPuntoRuta)
CREATE INDEX IX_PuntoRutaTour ON PuntoRutaTour (idPuntoRutaTour)
CREATE INDEX IX_ClienteHotel ON ClienteHotel (idClienteHotel)
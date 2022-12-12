--SQL
USE master;
GO
IF DB_ID (N'ConcecionarioAutomoviles') IS NOT NULL
   DROP DATABASE ConcecionarioAutomoviles;
GO
CREATE DATABASE ConcecionarioAutomoviles
ON
( NAME = ConcecionarioAutomoviles_dat,
    FILENAME = 'C:\BD\ConcecionarioAutomoviles.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ConcecionarioAutomoviles_log,
    FILENAME = 'C:\BD\ConcecionarioAutomoviles.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE ConcecionarioAutomoviles;
GO

CREATE TABLE Cliente
(
idCliente INT  IDENTITY (1,1),
nombre varchar (50) not null,
apellidoPaterno varchar (50) not null,
apellidoMaterno varchar (50) not null,
direccion varchar (50) not null,
numeroDireccion  int not null,
calle varchar (50) not null,
estatus bit default 1 not null,
);

CREATE TABLE Opicon
(
idOpcion INT  IDENTITY (1,1),
nombre varchar (50) not null,
descripcion varchar (50) not null,
estatus bit default 1 not null,
);
CREATE TABLE Usado
(
idUsado INT  IDENTITY (1,1),
marca varchar (50) not null,
matricula varchar (50) not null,
idCliente varchar (50) not null,
estatus bit default 1 not null,
);
CREATE TABLE Vendedor
(
idVendedor	INT  IDENTITY (1,1),
nombre varchar (50) not null,	
apellidoPaterno varchar (50) not null,	
apellidoMaterno varchar (50) not null,	
rfc varchar (10) not null,	
direccion varchar(50) NOT NULL,
calle varchar(50) NOT NULL,
numero INT NOT NULL,
estatus bit default 1 not null,
);
CREATE TABLE Viaje
(
idViaje	int IDENTITY(1,1),
numero int NOT NULL,
idSucursal int NOT NULL,
idTurista int NOT NULL,
estatus bit default 1 not null,
);
CREATE TABLE ViajeVuelo
(
idViajeVuelo int IDENTITY(1,1),
clase varchar(50) NOT NULL,
idVuelo int NOT NULL,
idViaje int NOT NULL,
estatus bit default 1 not null,
);
CREATE TABLE ViajeHotel
(
idViajeHotel int IDENTITY(1,1),
regimen varchar(50) NOT NULL,
horSalida int NOT NULL,
horaLlegada int NOT NULL,
idVuelo int NOT NULL,
idHotel int NOT NULL,
estatus bit default 1 not null,
);
ALTER TABLE Hotel ADD CONSTRAINT PK_Hotel PRIMARY KEY(idHotel)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY(idSucursal)
ALTER TABLE Turista ADD CONSTRAINT PK_Turista PRIMARY KEY(idTurista)
ALTER TABLE Vuelo ADD CONSTRAINT PK_Vuelo PRIMARY KEY(idVuelo)
ALTER TABLE Viaje ADD CONSTRAINT PK_Viaje PRIMARY KEY(idViaje)
ALTER TABLE ViajeVuelo ADD CONSTRAINT PK_ViajeVuelo PRIMARY KEY(idViajeVuelo)
ALTER TABLE ViajeHotel ADD CONSTRAINT PK_ViajeHotel PRIMARY KEY(idViajeHotel)

--Tabla Viaje
ALTER TABLE Viaje ADD CONSTRAINT FK_ViajeSucursal FOREIGN KEY(idSucursal) REFERENCES 
Sucursal(idSucursal)
ALTER TABLE Viaje ADD CONSTRAINT FK_ViajeTurista FOREIGN KEY(idTurista) REFERENCES 
Turista(idTurista)
--Tabla ViajeVuelo
ALTER TABLE ViajeVuelo ADD CONSTRAINT FK_ViajeVueloVuelo FOREIGN KEY(idVuelo) REFERENCES 
Vuelo(idVuelo)
ALTER TABLE ViajeVuelo ADD CONSTRAINT FK_ViajeVueloViaje FOREIGN KEY(idViaje) REFERENCES 
Viaje(idViaje)
--Tabla ViajeHotel
ALTER TABLE ViajeHotel ADD CONSTRAINT FK_ViajeHotelVuelo FOREIGN KEY(idVuelo) REFERENCES 
Viaje(idViaje)
ALTER TABLE ViajeHotel ADD CONSTRAINT FK_ViajeHotelHotel FOREIGN KEY(idHotel) REFERENCES 
Hotel(idHotel)
--Indices 
CREATE INDEX IX_Hotel ON Hotel(idHotel)
CREATE INDEX IX_Sucursal ON Sucursal(idSucursal)
CREATE INDEX IX_Turista ON Turista(idTurista)
CREATE INDEX IX_Vuelo ON Vuelo(idVuelo)
CREATE INDEX IX_Viaje ON Viaje(idViaje)
CREATE INDEX IX_ViajeVuelo ON ViajeVuelo(idViajeVuelo)
CREATE INDEX IX_ViajeHotel ON ViajeHotel(idViajeHotel)
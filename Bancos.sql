--SQL
USE master;
GO
IF DB_ID (N'Bancos') IS NOT NULL
DROP DATABASE Bancos
GO
CREATE DATABASE Bancos
ON
( NAME = Bancos_dat,
    FILENAME = 'C:\BD\Bancos.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = Bancos_log,
    FILENAME = 'C:\BD\Bancos.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE Bancos;
GO
CREATE TABLE Cliente
(
	idCliente INT IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	apellidoP VARCHAR (50) not null,
	apellidoM VARCHAR (50) not null,
	curp VARCHAR (50) not null,
	calle VARCHAR (50) not null,
	colonia VARCHAR (50) not null,
	telefono INT not null,
	numero INT not null,
	estado VARCHAR (50) not null,
	ciudad VARCHAR (50) not null,
	codigoPostal INT not null,
	estatus BIT DEFAULT 1 not null,
	idCuenta INT not null,
);
GO
CREATE TABLE Domicializacion
(
	idDomicializacion INT  IDENTITY (1,1),
	concepto VARCHAR (50) not null,
	fecha DATETIME not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Cuenta
(
	idCuenta INT  IDENTITY (1,1),
	estatus BIT DEFAULT 1 not null,
	idSucursal INT not null,
);
GO
CREATE TABLE Prestamo
(
	idPrestamo INT  IDENTITY (1,1),
	nFolio INT not null,
	monto INT not null,
	fecha DATETIME not null,
	estatus BIT DEFAULT 1 not null,
	idCliente int not null,
);
GO
CREATE TABLE Sucursal
(
	idSucursal INT  IDENTITY (1,1),
	nombre VARCHAR (50) not null,
	telefono INT not null,
	calle VARCHAR (50) not null,
	estado VARCHAR (50) not null,
	numero INT not null,
	colonia VARCHAR (50) not null,
	ciudad VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO

CREATE TABLE CuentaCliente
(
	idCuentaCliente INT  IDENTITY (1,1),
	idCuenta INT not null,
	idCliente INT not null,
	estatus BIT DEFAULT 1 not null,

);
GO
CREATE TABLE CuentaDomicializacion 
(
	idCuentaDomicializacion INT  IDENTITY (1,1),
	idCuenta INT not null,
	idDomicializacion INT not null,
	estatus BIT DEFAULT 1 not null,

);
--LLaves Primarias 
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Cuenta ADD CONSTRAINT PK_Cuenta PRIMARY KEY (idCuenta)
ALTER TABLE Domicializacion ADD CONSTRAINT PK_Domicializacion PRIMARY KEY (idDomicializacion)
ALTER TABLE Prestamo ADD CONSTRAINT PK_Prestamo PRIMARY KEY (idPrestamo)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (idSucursal)
ALTER TABLE CuentaCliente ADD CONSTRAINT PK_CuentaCliente PRIMARY KEY (idCuentaCliente)
ALTER TABLE CuentaDomicializacion ADD CONSTRAINT PK_CuentaDomicializacion PRIMARY KEY (idCuentaDomicializacion)
--LLaves Foraneas 
--Cuenta
ALTER TABLE Cuenta ADD CONSTRAINT FK_CuentaSucursal FOREIGN KEY (idSucursal) REFERENCES Sucursal (idSucursal)
--CuentaDomicializacion 
ALTER TABLE CuentaDomicializacion ADD CONSTRAINT FK_CuentaDomicializacionCuenta FOREIGN KEY (idCuenta) REFERENCES Cuenta (idCuenta)
ALTER TABLE CuentaDomicializacion ADD CONSTRAINT FK_CuentaDomicializacionDomicializacion FOREIGN KEY (idDomicializacion) REFERENCES Domicializacion (idDomicializacion)
--CuentaCliente
ALTER TABLE CuentaCliente ADD CONSTRAINT FK_CuentaClienteCuenta FOREIGN KEY (idCuenta) REFERENCES Cuenta (idCuenta)
ALTER TABLE CuentaCliente ADD CONSTRAINT FK_CuentaClienteCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
--Prestamo
ALTER TABLE Prestamo ADD CONSTRAINT FK_PrestamoCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente)
--Cliente
ALTER TABLE Cliente ADD CONSTRAINT FK_ClienteCuenta FOREIGN KEY (IdCuenta) References Cuenta (idCuenta)
--INDICES
CREATE INDEX IX_Cliente ON Cliente (idCliente)
CREATE INDEX IX_Cuenta ON Cuenta (idCuenta)
CREATE INDEX IX_Domcializacion ON Domicializacion (idDomicializacion)
CREATE INDEX IX_Prestamo ON Prestamo (idPrestamo)
CREATE INDEX IX_Sucursal ON Sucursal (idSucursal)
CREATE INDEX IX_CuentaCliente ON CuentaCliente (idCuentaCliente)
CREATE INDEX IX_CuentaDomicializacion ON CuentaDomicializacion (idCuentaDomicializacion)


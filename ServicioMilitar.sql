--SQL
USE master;
GO
IF DB_ID (N'ServicioMilitar') IS NOT NULL
   DROP DATABASE ServicioMilitar;
GO
CREATE DATABASE ServicioMilitar
ON
( NAME = ServicioMilitar_dat,
    FILENAME = 'C:\BD\ServicioMilitar.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = ServicioMilitar_log,
    FILENAME = 'C:\BD\ServicioMilitar.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE ServicioMilitar;
GO
CREATE TABLE Compania
(	
   idCompania INT  IDENTITY (1,1),
   actividad VARCHAR(50) NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL
);
CREATE TABLE Cuartel
(	
   idCuartel INT IDENTITY (1,1),
   direccion VARCHAR(50) NOT NULL,
   numero INT NOT NULL, 
   codigoPostal INT NOT NULL,
   calle VARCHAR(50) NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL

);
CREATE TABLE Cuerpo
(	
   idCuerpo INT  IDENTITY (1,1),
   denominacion VARCHAR(50) NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL

);
CREATE TABLE Servicio
(	
   idServicio INT  IDENTITY (1,1),
   descripcion VARCHAR(50) NOT NULL,
   codigo INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL

);
CREATE TABLE Soldado
(	
   idSoldado INT  IDENTITY (1,1),
   nombre VARCHAR(50) NOT NULL,
   apellidoPaterno VARCHAR(50) NOT NULL,
   apellidoMaterno VARCHAR(50) NOT NULL,
   graduacion VARCHAR(50) NOT NULL,
   idCompania INT NOT NULL,
   idCuartel INT NOT NULL,
   idCuerpo INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL

);
CREATE TABLE ServicioSoldado
(	
   idServicioSoldado INT  IDENTITY (1,1),
   fechaRealizacion DATETIME NOT NULL,
   idSoldado INT NOT NULL,
   idServicio INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL

);
CREATE TABLE CompaniaCuartel
(	
   idCompaniaCuartel INT  IDENTITY (1,1),
   idCompania INT NOT NULL,
   idCuartel INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL

);


--Llaves primarias
ALTER TABLE Compania ADD CONSTRAINT PK_Compania PRIMARY KEY(idCompania)
ALTER TABLE Cuartel ADD CONSTRAINT PK_Cuartel PRIMARY KEY(idCuartel)
ALTER TABLE Cuerpo ADD CONSTRAINT PK_Cuerpo PRIMARY KEY(idCuerpo)
ALTER TABLE Servicio ADD CONSTRAINT PK_Servicio PRIMARY KEY(idServicio)
ALTER TABLE Soldado ADD CONSTRAINT PK_Soldado PRIMARY KEY(idSoldado)
ALTER TABLE ServicioSoldado ADD CONSTRAINT PK_ServicioSoldado PRIMARY KEY(idServicioSoldado)
ALTER TABLE CompaniaCuartel ADD CONSTRAINT PK_ComapaniaCuartel PRIMARY KEY(idCompaniaCuartel)


--Llaves Foraneas
--Tabla Soldado
ALTER TABLE Soldado ADD CONSTRAINT FK_SoldadoCompania FOREIGN KEY(idCompania) REFERENCES 
Compania(idCompania)
ALTER TABLE Soldado ADD CONSTRAINT FK_SoldaoCuartel FOREIGN KEY(idCuartel) REFERENCES 
Cuartel(idCuartel)
ALTER TABLE Soldado ADD CONSTRAINT FK_SoldadoCuerpo FOREIGN KEY(idCuerpo) REFERENCES 
Cuerpo(idCuerpo)

--Tabla ServicoSoldado
ALTER TABLE ServicioSoldado ADD CONSTRAINT FK_ServicioSoldadoSoldado FOREIGN KEY(idSoldado) REFERENCES 
Soldado(idSoldado)
ALTER TABLE ServicioSoldado ADD CONSTRAINT FK_ServicioSoldadoServicio FOREIGN KEY(idServicio) REFERENCES 
Servicio(idServicio)

--Tabla CompaniaCuartel
ALTER TABLE CompaniaCuartel ADD CONSTRAINT FK_CompaniaCuartelCompania FOREIGN KEY(idCompania) REFERENCES 
Compania(idCompania)
ALTER TABLE CompaniaCuartel ADD CONSTRAINT FK_CompaniaCuartelCuartel FOREIGN KEY(idCuartel) REFERENCES 
Cuartel(idCuartel)



--Indices 
CREATE INDEX IX_Compania ON Compania(idCompania)
CREATE INDEX IX_Cuartel ON Cuartel(idCuartel)
CREATE INDEX IX_Cuerpo ON Cuerpo(idCuerpo)
CREATE INDEX IX_Servicio ON Servicio(idServicio)
CREATE INDEX IX_Soldado ON Soldado(idSoldado)
CREATE INDEX IX_ServicioSoldado ON ServicioSoldado(idServicioSoldado)
CREATE INDEX IX_CompaniaCuartel ON CompaniaCuartel(idCompaniaCuartel)

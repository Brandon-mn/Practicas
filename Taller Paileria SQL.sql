--SQL
USE master;
GO
IF DB_ID (N'TallerPaileria') IS NOT NULL
DROP DATABASE TallerPaileria
GO
CREATE DATABASE TallerPaileria
ON
( NAME = TallerPaileria_dat,
    FILENAME = 'C:\BD\Taller Paileria.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = TallerPaileria_log,
    FILENAME = 'C:\BD\Taller Paileria.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE TallerPaileria;
GO
CREATE TABLE Cliente
(
	idCliente INT not null,
	nombre VARCHAR(50) NOT NULL,
	apellidoPaterno VARCHAR(50) NOT NULL,	
	apellidoMaterno VARCHAR(50) NOT NULL,	
	colonia VARCHAR(50) NOT NULL,	
	numero INT not null,
	calle VARCHAR(50) NOT NULL,	
	estatus BIT DEFAULT 1 not null,
	
);
GO 
CREATE TABLE Material
(
	idMaterial INT not null,
	disponibilidad INT not null,
	nombre VARCHAR(50) NOT NULL,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE Puesto
(
	idPuesto INT not null,
	nombre VARCHAR (50) not null,
	descripcion VARCHAR (50) not null,
	salario int not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE Proveedor
(
	idProveedor INT not null,
	nombre VARCHAR (50) not null,
	telefono int not null,
	colonia VARCHAR (50) not null,
	numero int not null,
	calle VARCHAR (50) not null,
	estatus BIT DEFAULT 1 not null,
);
GO
CREATE TABLE Compra
(
	idCompra INT not null,
	nombre VARCHAR (50) not null,
	idEmpleado INT not null,
	idProveedor INT not null,
	estatus BIT DEFAULT 1 not null,
);
GO 
CREATE TABLE Empleado
(
	idEmpleado INT not null,
	nombre VARCHAR(50) not null,
	apellidoPaterno VARCHAR(50) not null,
	apellidoMaterno VARCHAR(50) not null,
	estatus BIT DEFAULT 1 not null,
	idPuesto INT not null,
);
GO
CREATE TABLE Factura
(
	idFactura INT not null,
	numero INT not null,
	fechaVencimiento DATETIME not null,
	fechaEmision DATETIME not null,
	descripcion VARCHAR(50) not null,
	idVenta INT not null,
	estatus BIT DEFAULT 1 not null,
)
CREATE TABLE Sucursal
(
	idSucursal INT not null,
	nombre VARCHAR(50) not null,
	colonia VARCHAR(50) not null,
	calle VARCHAR(50) not null,
	numero int not null,
	telefono int not null,
	estatus BIT DEFAULT 1 not null,
)
CREATE TABLE Venta
(
	idVenta INT not null,
	fechaVenta DATETIME not null,
	idEmpleado INT not null,
	idCliente INT not null,
	idSucursal INT not null,
	estatus BIT DEFAULT 1 not null,
)
CREATE TABLE Producto
(
	idProducto INT not null,
	nombre VARCHAR(50) not null,
	disponibilidad VARCHAR(50) not null,
	medida VARCHAR(50) not null,
	estatus BIT DEFAULT 1 not null,
)
CREATE TABLE VentaProducto
(
	idVentaProducto INT not null,
	idVenta INT not null,
	idProducto INT not null,
	estatus BIT DEFAULT 1 not null,
)
CREATE TABLE ProductoMaterial
(
	idProductoMaterial INT not null,
	idMaterial INT not null,
	idProducto INT not null,
	estatus BIT DEFAULT 1 not null,
)
CREATE TABLE CompraMaterial
(
	idCompraMaterial INT not null,
	idCompra INT not null,
	idMaterial INT not null,
	fechaCompra DATETIME not null,
	estatus BIT DEFAULT 1 not null,
)
--Llaves primarias
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Material ADD CONSTRAINT PK_Material PRIMARY KEY (idMaterial)
ALTER TABLE Puesto ADD CONSTRAINT PK_Puesto PRIMARY KEY (idPuesto)
ALTER TABLE Proveedor ADD CONSTRAINT PK_Proveedor PRIMARY KEY (idProveedor)
ALTER TABLE Compra ADD CONSTRAINT PK_Compra PRIMARY KEY (idCompra)
ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado)
ALTER TABLE Factura ADD CONSTRAINT PK_Factura PRIMARY KEY (idFactura)
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (idSucursal)
ALTER TABLE Venta ADD CONSTRAINT PK_Venta PRIMARY KEY (idVenta)
ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (idProducto)
ALTER TABLE VentaProducto ADD CONSTRAINT PK_VentaProducto PRIMARY KEY (idVentaProducto)
ALTER TABLE ProductoMaterial ADD CONSTRAINT PK_ProductoMaterial PRIMARY KEY (idProductoMaterial)
ALTER TABLE CompraMaterial ADD CONSTRAINT PK_CompraMaterial PRIMARY KEY (idCompraMaterial)

--Llaves foraneas
--Compra
ALTER TABLE Compra ADD CONSTRAINT FK_CompraEmpleado FOREIGN KEY (idEmpleado)
REFERENCES Empleado (idEmpleado)
ALTER TABLE Compra ADD CONSTRAINT FK_CompraProveedor FOREIGN KEY (idProveedor)
REFERENCES Proveedor (idProveedor)
--Empleado
ALTER TABLE Empleado ADD CONSTRAINT FK_EmpleadoPuesto FOREIGN KEY (idPuesto)
REFERENCES Puesto (idPuesto)
--Factura
ALTER TABLE Factura ADD CONSTRAINT FK_FacturaVenta FOREIGN KEY (idVenta)
REFERENCES Venta (idVenta)
--Venta
ALTER TABLE Venta ADD CONSTRAINT FK_VentaEmpleado FOREIGN KEY (idEmpleado) 
REFERENCES Empleado (idEmpleado)
ALTER TABLE Venta ADD CONSTRAINT FK_VentaCliente FOREIGN KEY (idCliente)
REFERENCES Cliente (idCliente)
ALTER TABLE Venta ADD CONSTRAINT FK_VentaSucursal FOREIGN KEY (idSucursal)
REFERENCES Sucursal (idSucursal)
--VentaProducto
ALTER TABLE VentaProducto ADD CONSTRAINT FK_VentaProductoVenta FOREIGN KEY (idVenta) 
REFERENCES Venta (idVenta)
ALTER TABLE VentaProducto ADD CONSTRAINT FK_VentaProductoProducto FOREIGN KEY (idProducto)
REFERENCES Producto (idProducto)
--ProductoMaterial
ALTER TABLE ProductoMaterial ADD CONSTRAINT FK_ProductoMaterialMaterial FOREIGN KEY (idMaterial) 
REFERENCES Material (idMaterial)
ALTER TABLE ProductoMaterial ADD CONSTRAINT FK_ProductoMaterialProducto FOREIGN KEY (idProducto)
REFERENCES Producto (idProducto)
--CompraMaterial
ALTER TABLE CompraMaterial ADD CONSTRAINT FK_CompraMaterialCompra FOREIGN KEY (idCompra) 
REFERENCES Compra (idCompra)
ALTER TABLE CompraMaterial ADD CONSTRAINT FK_CompraMaterialMaterial FOREIGN KEY (idMaterial)
REFERENCES Material (idMaterial)

--INDICES
CREATE INDEX IX_Cliente ON Cliente (idCliente)
CREATE INDEX IX_Material ON Material (idMaterial)
CREATE INDEX IX_Puesto ON Puesto (idPuesto)
CREATE INDEX IX_Proveedor ON Proveedor (idProveedor)
CREATE INDEX IX_Compra ON Compra (idCompra)
CREATE INDEX IX_Empleado ON Empleado (idEmpleado)
CREATE INDEX IX_Factura ON Factura (idFactura)
CREATE INDEX IX_Sucursal ON Sucursal (idSucursal)
CREATE INDEX IX_Venta ON Venta (idVenta)
CREATE INDEX IX_Producto ON Producto (idProducto)
CREATE INDEX IX_VentaProducto ON VentaProducto (idVentaProducto)
CREATE INDEX IX_ProductoMaterial ON ProductoMaterial (idProductoMaterial)
CREATE INDEX IX_CompraMaterial ON CompraMaterial (idCompraMaterial)
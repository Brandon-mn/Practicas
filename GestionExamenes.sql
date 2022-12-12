--SQL
USE master;
GO
IF DB_ID (N'GestionExamenes') IS NOT NULL
	DROP DATABASE GestionExamenes;

GO
CREATE DATABASE GestionExamenes
ON 
( NAME = GestionExamenes_dat,
	FILENAME = 'C:\BD\GestionExamenes.mdf',
	SIZE = 10,
	MAXSIZE = 50,
	FILEGROWTH = 5)
LOG ON 
(NAME = GestionExamenes_log,
	FILENAME = 'C:\BD\GestionExamenes.ldf',
	SIZE = 5MB,
	MAXSIZE = 25MB,
	FILEGROWTH = 5MB);
GO
USE GestionExamenes;
GO
--TABLAS
CREATE TABLE Alumno
(
idAlumno int IDENTITY (1,1),
nombre varchar (50) not null,
apellidoPaterno varchar (50) not null,
apellidoMaterno varchar (50) not null,
seccionGrupo char (5) not null,
estatus bit default 1 not null,
);
CREATE TABLE Examen
(
idExamen int IDENTITY (1,1),
numeroExamen char (10) not null,
numeroPreguntas char (10) not null,
fechaRealizacion varchar (15) not null,
estatus bit default 1 not null,
);
CREATE TABLE Profesor
(
idProfesor int IDENTITY (1,1),
nombre varchar (50) not null,
apellidoPaterno varchar (50) not null,
apellidoMaterno varchar (50) not null,
matricula char (15) not null,
codigoPostal char (6) not null,
numCasa char (10) not null,
calle varchar (20) not null,
estatus bit default 1 not null,
);
CREATE TABLE Practica
(
idPractica int IDENTITY (1,1),
codigo char (15) not null,
dificultad varchar (15) not null,
titulo varchar (50) not null,
nota char (4) not null,
fechaExaminacion datetime NOT NULL, 
estatus bit default 1 not null,
);
CREATE TABLE AlumnoExamen
(
idAlumnoExamen int IDENTITY (1,1),
idAlumno int null,
idExamen int null,
nota char (4) not null,
estatus bit default 1 not null,
);
CREATE TABLE AlumnoPractica
(
idAlumnoPractica int IDENTITY (1,1),
idAlumno int null,
idPractica int null,
nota char (4) not null,
FechaRealizacion datetime not null,
estatus bit default 1 not null,
);
CREATE TABLE ProfesorAlumno
(
idProfesorAlumno int IDENTITY (1,1),
idProfesor int null,
idAlumno int null,
fechaDiseño datetime not null,
estatus bit default 1 not null,
);
GO
--------------------------------LLAVES PRIMARIAS-------------------
ALTER TABLE Alumno ADD CONSTRAINT PK_Alumno PRIMARY KEY (idAlumno)
ALTER TABLE Examen ADD CONSTRAINT PK_Examen PRIMARY KEY (idExamen)
ALTER TABLE Profesor ADD CONSTRAINT PK_Profesor PRIMARY KEY (idProfesor)
ALTER TABLE Practica ADD CONSTRAINT PK_Practica PRIMARY KEY (idPractica)
ALTER TABLE AlumnoPractica ADD CONSTRAINT PK_AlumnoPractica PRIMARY KEY (idAlumnoPractica)
ALTER TABLE AlumnoExamen ADD CONSTRAINT PK_AlumnoExamen PRIMARY KEY (idAlumnoExamen)
ALTER TABLE ProfesorAlumno ADD CONSTRAINT PK_ProfesorAlumno PRIMARY KEY (idProfesorAlumno)


-------------------------------LLAVES FORANEAS----------------------
ALTER TABLE AlumnoExamen  ADD CONSTRAINT FK_AlumnoExamenAlumno 
FOREIGN  KEY (idAlumno) REFERENCES Alumno(idAlumno)
GO
ALTER TABLE AlumnoExamen  ADD CONSTRAINT FK_AlumnoExamenExamen 
FOREIGN KEY (idExamen) REFERENCES Examen(idExamen)
GO
ALTER TABLE AlumnoPractica ADD CONSTRAINT FK_AlumnoPracticaAlumno 
FOREIGN KEY (idAlumno) REFERENCES Alumno(idAlumno)
GO
ALTER TABLE AlumnoPractica ADD CONSTRAINT FK_AlumnoPracticaPractica
FOREIGN KEY (idPractica) REFERENCES Practica(idPractica)
GO
ALTER TABLE ProfesorAlumno ADD CONSTRAINT FK_ProfesorAlumnoProfesor 
FOREIGN KEY (idProfesor) REFERENCES Profesor(idProfesor)
GO
ALTER TABLE ProfesorAlumno ADD CONSTRAINT FK_ProfesorAlumnoAlumno
FOREIGN KEY (idAlumno) REFERENCES Alumno(idAlumno)
GO
--------------------------------INDEX------------------------------
CREATE INDEX IX_Alumno ON Alumno(idAlumno);
GO
CREATE INDEX IX_Examen ON Examen(idExamen);
GO
CREATE INDEX IX_Profesor ON Profesor(idProfesor);
GO
CREATE INDEX IX_Practica ON Practica(idPractica);
GO
CREATE INDEX IX_AlumnoExamen ON AlumnoExamen(idAlumnoExamen);
GO
CREATE INDEX IX_AlumnoPractica ON AlumnoPractica(idAlumnoPractica);
GO
CREATE INDEX IX_ProfesorAlumno ON ProfesorAlumno(idProfesorAlumno);
GO

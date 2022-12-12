--SQL
USE master;
GO
IF DB_ID (N'ServicioMilitar') IS NOT NULL
   DROP DATABASE GestiónTrabajoFinCarrera;
GO
CREATE DATABASE GestiónTrabajoFinCarrera
ON
( NAME = GestiónTrabajoFinCarrera_dat,
    FILENAME = 'C:\BD\GestiónTrabajoFinCarrera.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = GestiónTrabajoFinCarrera_log,
    FILENAME = 'C:\BD\GestiónTrabajoFinCarrera.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE GestiónTrabajoFinCarrera;
GO

CREATE TABLE Grupo
(	
   idGrupo INT  IDENTITY (1,1),
   nombre VARCHAR(50) NOT NULL,
   noComponentes INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL
);
CREATE TABLE Profesor
(	
   idProfesor INT  IDENTITY (1,1),
   nombre VARCHAR(50) NOT NULL,
   apellidoPaterno VARCHAR(50) NOT NULL,
   apellidoMaterno VARCHAR(50) NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL
);
CREATE TABLE Tribunal
(	
   idTribunal INT  IDENTITY (1,1),
   numero INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL
);
CREATE TABLE Tfc
(	
   idTfc INT  IDENTITY (1,1),
   tema VARCHAR(50) NOT NULL,
   fechaComienzo DATETIME NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL
);
CREATE TABLE Alumno
(	
   idAlumno INT  IDENTITY (1,1),
   nombre VARCHAR(50) NOT NULL,
   apellidoPaterno VARCHAR(50) NOT NULL,
   apellidoMaterno VARCHAR(50) NOT NULL,
   rfc VARCHAR(50)NOT NULL,
   idProfesor INT NOT NULL,
   idGrupo INT NOT NULL,
   idTFC INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL
);
CREATE TABLE AlumnoProfesor
(	
   idAlumnoProfesor INT  IDENTITY (1,1),
   idAlumno INT NOT NULL,
   idProfesor INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL
);
CREATE TABLE ProfesorTribunal
(	
   idProfesorTribunal INT  IDENTITY (1,1),
   idTribunal INT NOT NULL,
   idProfesor INT NOT NULL,
   estatus BIT DEFAULT 1 NOT NULL
);

ALTER TABLE Alumno ADD CONSTRAINT PK_Alumno PRIMARY KEY(idAlumno)
ALTER TABLE Grupo ADD CONSTRAINT PK_Grupo PRIMARY KEY(idGrupo)
ALTER TABLE Profesor ADD CONSTRAINT PK_Profesor PRIMARY KEY(idProfesor)
ALTER TABLE Tribunal ADD CONSTRAINT PK_Cuerpo PRIMARY KEY(idTribunal)
ALTER TABLE Tfc ADD CONSTRAINT PK_Tfc PRIMARY KEY(idTfc)
ALTER TABLE AlumnoProfesor ADD CONSTRAINT PK_AlumnoProfesor PRIMARY KEY(idAlumnoProfesor)
ALTER TABLE ProfesorTribunal ADD CONSTRAINT PK_ProfesorTribunal PRIMARY KEY(idProfesorTribunal)
--Llaves Foraneas
--Tabla Alumno
ALTER TABLE Alumno ADD CONSTRAINT FK_AlumnoProfesor FOREIGN KEY(idProfesor) REFERENCES 
Profesor(idProfesor)
ALTER TABLE Alumno ADD CONSTRAINT FK_AlumnoGrupo FOREIGN KEY(idGrupo) REFERENCES 
Grupo(idGrupo)
ALTER TABLE Alumno ADD CONSTRAINT FK_AlumnoTfc FOREIGN KEY(idTfc) REFERENCES 
Tfc(idTfc)
--Tabla AlumnoProfesor
ALTER TABLE AlumnoProfesor ADD CONSTRAINT FK_AlumnoProfesorAlumno FOREIGN KEY(idAlumno) REFERENCES 
Alumno(idAlumno)
ALTER TABLE AlumnoProfesor ADD CONSTRAINT FK_AlumnoProfesorProfesor FOREIGN KEY(idProfesor) REFERENCES 
Profesor(idProfesor)
--Tabla AlumnoProfesor
ALTER TABLE ProfesorTribunal ADD CONSTRAINT FK_ProfesorTribunalTribunal FOREIGN KEY(idTribunal) REFERENCES 
Tribunal(idTribunal)
ALTER TABLE ProfesorTribunal ADD CONSTRAINT FK_ProfesorTribunalProfesor FOREIGN KEY(idProfesor) REFERENCES 
Profesor(idProfesor)
CREATE INDEX IX_Alumno ON Alumno(idAlumno)
CREATE INDEX IX_Profesor ON Profesor(idProfesor)
CREATE INDEX IX_Tribunal ON Tribunal(idTribunal)
CREATE INDEX IX_Tfc ON Tfc(idTfc)
CREATE INDEX IX_AlumnoProfesor ON AlumnoProfesor(idAlumnoProfesor)
CREATE INDEX IX_ProfesorTribunal ON ProfesorTribunal(idProfesorTribunal)

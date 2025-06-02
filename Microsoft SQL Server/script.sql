-- ============================
-- BASE DE DATOS
-- ============================

CREATE DATABASE ColegioDB
ON PRIMARY (
    NAME = 'ColegioDB_Data',
    FILENAME = 'C:\SQLData\ColegioDB_Data.mdf',
    SIZE = 50MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 10MB
)
LOG ON (
    NAME = 'ColegioDB_Log',
    FILENAME = 'C:\SQLData\ColegioDB_Log.ldf',
    SIZE = 20MB,
    MAXSIZE = 1GB,
    FILEGROWTH = 5MB
);
GO

USE ColegioDB;
GO

-- ============================
-- TABLA: Sedes
-- ============================

CREATE TABLE Sedes (
    SedeID INT IDENTITY(1,1) PRIMARY KEY, -- ID de sede
    Nombre VARCHAR(100) NOT NULL, -- Nombre de la sede
    Distrito VARCHAR(100) NOT NULL, -- Distrito en Lima
    Direccion NVARCHAR(250), -- Dirección completa
    Telefono VARCHAR(20),
    Email VARCHAR(100)
);
GO

-- ============================
-- TABLA: Turnos
-- ============================

CREATE TABLE Turnos (
    TurnoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL -- Ejemplo: Mañana, Tarde
);
GO

-- ============================
-- TABLA: Grados
-- ============================

CREATE TABLE Grados (
    GradoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);
GO

-- ============================
-- TABLA: Secciones
-- ============================

CREATE TABLE Secciones (
    SeccionID INT IDENTITY(1,1) PRIMARY KEY,
    Letra CHAR(1) NOT NULL
);
GO

-- ============================
-- TABLA: Alumnos
-- ============================

CREATE TABLE Alumnos (
    AlumnoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    DNI CHAR(8) UNIQUE,
    Sexo CHAR(1) CHECK (Sexo IN ('M','F')),
    Direccion NVARCHAR(250),
    TurnoID INT NOT NULL REFERENCES Turnos(TurnoID),
    GradoID INT NOT NULL REFERENCES Grados(GradoID),
    SeccionID INT NOT NULL REFERENCES Secciones(SeccionID),
    SedeID INT NOT NULL REFERENCES Sedes(SedeID),
    Estado BIT DEFAULT 1
);
GO

-- ============================
-- TABLA: Tutores
-- ============================

CREATE TABLE Tutores (
    TutorID INT IDENTITY(1,1) PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    DNI CHAR(8) UNIQUE,
    Direccion NVARCHAR(250)
);
GO

-- ============================
-- TABLA: AlumnoTutor
-- ============================

CREATE TABLE AlumnoTutor (
    AlumnoID INT NOT NULL REFERENCES Alumnos(AlumnoID),
    TutorID INT NOT NULL REFERENCES Tutores(TutorID),
    Parentesco VARCHAR(50),
    PRIMARY KEY (AlumnoID, TutorID)
);
GO

-- ============================
-- TABLA: Profesores
-- ============================

CREATE TABLE Profesores (
    ProfesorID INT IDENTITY(1,1) PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Especialidad VARCHAR(100),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    SedeID INT NOT NULL REFERENCES Sedes(SedeID)
);
GO

-- ============================
-- TABLA: Asistencias
-- ============================

CREATE TABLE Asistencias (
    AsistenciaID INT IDENTITY(1,1) PRIMARY KEY,
    AlumnoID INT NOT NULL REFERENCES Alumnos(AlumnoID),
    Fecha DATE NOT NULL,
    Estado CHAR(1) NOT NULL CHECK (Estado IN ('A', 'F', 'T')),
    Observacion NVARCHAR(200)
);
GO

-- ============================
-- TABLA: Pensiones
-- ============================

CREATE TABLE Pensiones (
    PencionID INT IDENTITY(1,1) PRIMARY KEY,
    AlumnoID INT NOT NULL REFERENCES Alumnos(AlumnoID),
    Mes INT NOT NULL CHECK (Mes BETWEEN 1 AND 12),
    Anio INT NOT NULL,
    MontoTotal MONEY NOT NULL,
    EstadoPago BIT NOT NULL DEFAULT 0,
    Comentario NVARCHAR(255)
);
GO

-- ============================
-- TABLA: PensionPagos
-- ============================

CREATE TABLE PensionPagos (
    PagoID INT IDENTITY(1,1) PRIMARY KEY,
    PencionID INT NOT NULL REFERENCES Pensiones(PencionID),
    FechaPago DATETIME NOT NULL DEFAULT GETDATE(),
    MontoPagado MONEY NOT NULL,
    MetodoPago VARCHAR(50),
    Comentario NVARCHAR(255)
);
GO

-- ============================
-- TABLA: Productos
-- ============================

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Precio MONEY NOT NULL,
    Stock INT NOT NULL
);
GO

-- ============================
-- TABLA: Ventas
-- ============================

CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    AlumnoID INT REFERENCES Alumnos(AlumnoID),
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    Total MONEY NOT NULL,
    Comentario NVARCHAR(255),
    SedeID INT NOT NULL REFERENCES Sedes(SedeID)
);
GO

-- ============================
-- TABLA: DetalleVenta
-- ============================

CREATE TABLE DetalleVenta (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT NOT NULL REFERENCES Ventas(VentaID),
    ProductoID INT NOT NULL REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL,
    PrecioUnitario MONEY NOT NULL
);
GO

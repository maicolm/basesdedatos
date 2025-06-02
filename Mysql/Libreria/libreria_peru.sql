-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS libreria_peru
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE libreria_peru;

-- ========================
-- TABLA: distritos
-- Lista de distritos de Lima donde la librería tiene sedes
-- ========================
CREATE TABLE distritos (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del distrito',
    nombre VARCHAR(100) NOT NULL COMMENT 'Nombre del distrito de Lima',
    UNIQUE(nombre)
) COMMENT='Distritos de Lima con presencia de la librería';

-- ========================
-- TABLA: sedes
-- Sedes físicas de la librería en distintos distritos
-- ========================
CREATE TABLE sedes (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID de la sede',
    nombre VARCHAR(100) NOT NULL COMMENT 'Nombre o identificador de la sede',
    direccion TEXT NOT NULL COMMENT 'Dirección exacta de la sede',
    distrito_id INT NOT NULL COMMENT 'Distrito donde se encuentra la sede',
    telefono VARCHAR(20) COMMENT 'Número telefónico de contacto',
    FOREIGN KEY (distrito_id) REFERENCES distritos(id)
) COMMENT='Sedes físicas de la librería';

-- ========================
-- TABLA: categorias_libros
-- Categorías o géneros de libros
-- ========================
CREATE TABLE categorias_libros (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID de la categoría',
    nombre VARCHAR(100) NOT NULL COMMENT 'Nombre de la categoría (ej. Ficción, Ciencia)',
    descripcion TEXT COMMENT 'Descripción detallada de la categoría'
) COMMENT='Categorías de libros disponibles en la librería';

-- ========================
-- TABLA: autores
-- Información de los autores de los libros
-- ========================
CREATE TABLE autores (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del autor',
    nombre_completo VARCHAR(150) NOT NULL COMMENT 'Nombre completo del autor',
    nacionalidad VARCHAR(100) COMMENT 'País o nacionalidad del autor',
    biografia TEXT COMMENT 'Biografía del autor'
) COMMENT='Autores de libros';

-- ========================
-- TABLA: libros
-- Catálogo de libros disponibles
-- ========================
CREATE TABLE libros (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del libro',
    titulo VARCHAR(200) NOT NULL COMMENT 'Título del libro',
    autor_id INT NOT NULL COMMENT 'ID del autor del libro',
    categoria_id INT NOT NULL COMMENT 'ID de la categoría del libro',
    isbn VARCHAR(20) UNIQUE COMMENT 'Código ISBN del libro',
    editorial VARCHAR(100) COMMENT 'Nombre de la editorial',
    anio_publicacion YEAR COMMENT 'Año de publicación',
    precio DECIMAL(10,2) NOT NULL COMMENT 'Precio del libro en soles (PEN)',
    stock INT NOT NULL DEFAULT 0 COMMENT 'Stock total disponible en todas las sedes',
    FOREIGN KEY (autor_id) REFERENCES autores(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias_libros(id)
) COMMENT='Catálogo de libros disponibles';

-- ========================
-- TABLA: stock_sede_libro
-- Relación de stock por libro y por sede
-- ========================
CREATE TABLE stock_sede_libro (
    sede_id INT NOT NULL COMMENT 'ID de la sede',
    libro_id INT NOT NULL COMMENT 'ID del libro',
    stock INT NOT NULL DEFAULT 0 COMMENT 'Cantidad disponible en la sede',
    PRIMARY KEY (sede_id, libro_id),
    FOREIGN KEY (sede_id) REFERENCES sedes(id),
    FOREIGN KEY (libro_id) REFERENCES libros(id)
) COMMENT='Stock de libros por sede';

-- ========================
-- TABLA: clientes
-- Registro de clientes de la librería
-- ========================
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del cliente',
    nombres VARCHAR(100) NOT NULL COMMENT 'Nombres del cliente',
    apellidos VARCHAR(100) NOT NULL COMMENT 'Apellidos del cliente',
    email VARCHAR(100) UNIQUE COMMENT 'Correo electrónico del cliente',
    telefono VARCHAR(20) COMMENT 'Teléfono del cliente',
    direccion TEXT COMMENT 'Dirección del cliente'
) COMMENT='Clientes registrados para compras y eventos';

-- ========================
-- TABLA: ventas
-- Registro de ventas realizadas
-- ========================
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID de la venta',
    cliente_id INT NOT NULL COMMENT 'Cliente que realizó la compra',
    sede_id INT NOT NULL COMMENT 'Sede donde se realizó la venta',
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la venta',
    total DECIMAL(10,2) NOT NULL COMMENT 'Monto total de la venta',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (sede_id) REFERENCES sedes(id)
) COMMENT='Ventas realizadas por sede';

-- ========================
-- TABLA: detalle_ventas
-- Detalle de libros en cada venta
-- ========================
CREATE TABLE detalle_ventas (
    venta_id INT NOT NULL COMMENT 'ID de la venta',
    libro_id INT NOT NULL COMMENT 'ID del libro vendido',
    cantidad INT NOT NULL COMMENT 'Cantidad vendida',
    precio_unitario DECIMAL(10,2) NOT NULL COMMENT 'Precio unitario en el momento de la venta',
    PRIMARY KEY (venta_id, libro_id),
    FOREIGN KEY (venta_id) REFERENCES ventas(id),
    FOREIGN KEY (libro_id) REFERENCES libros(id)
) COMMENT='Detalle de productos vendidos por venta';

-- ========================
-- TABLA: talleres
-- Talleres organizados por la librería
-- ========================
CREATE TABLE talleres (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del taller',
    titulo VARCHAR(150) NOT NULL COMMENT 'Nombre del taller',
    descripcion TEXT COMMENT 'Descripción del contenido del taller',
    fecha DATE NOT NULL COMMENT 'Fecha de realización',
    sede_id INT NOT NULL COMMENT 'Sede donde se realizará el taller',
    cupos INT NOT NULL COMMENT 'Cantidad máxima de participantes',
    FOREIGN KEY (sede_id) REFERENCES sedes(id)
) COMMENT='Talleres organizados por la librería';

-- ========================
-- TABLA: eventos
-- Eventos con autores y actividades especiales
-- ========================
CREATE TABLE eventos (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del evento',
    titulo VARCHAR(150) NOT NULL COMMENT 'Título del evento',
    descripcion TEXT COMMENT 'Descripción del evento',
    autor_id INT COMMENT 'Autor invitado (si aplica)',
    fecha DATE NOT NULL COMMENT 'Fecha del evento',
    sede_id INT NOT NULL COMMENT 'Sede donde se realizará el evento',
    FOREIGN KEY (autor_id) REFERENCES autores(id),
    FOREIGN KEY (sede_id) REFERENCES sedes(id)
) COMMENT='Eventos especiales con autores o actividades';

-- ========================
-- TABLA: inscripciones_taller
-- Registro de clientes inscritos a talleres
-- ========================
CREATE TABLE inscripciones_taller (
    taller_id INT NOT NULL COMMENT 'ID del taller',
    cliente_id INT NOT NULL COMMENT 'ID del cliente inscrito',
    fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de inscripción',
    PRIMARY KEY (taller_id, cliente_id),
    FOREIGN KEY (taller_id) REFERENCES talleres(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
) COMMENT='Clientes inscritos a talleres';

-- ========================
-- TABLA: asistencia_eventos
-- Registro de asistencia de clientes a eventos
-- ========================
CREATE TABLE asistencia_eventos (
    evento_id INT NOT NULL COMMENT 'ID del evento',
    cliente_id INT NOT NULL COMMENT 'ID del cliente asistente',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de confirmación o registro',
    PRIMARY KEY (evento_id, cliente_id),
    FOREIGN KEY (evento_id) REFERENCES eventos(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
) COMMENT='Registro de clientes asistentes a eventos';


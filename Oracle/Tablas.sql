-- ============================================
-- Script: Creación de tablas y relaciones para empresa de desarrollo de software
-- ============================================

-- Secuencias para PK autoincrementales
CREATE SEQUENCE seq_clientes START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_rubros START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_proyectos START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_usuarios START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_roles START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_auditoria_usuarios START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ============================================
-- Tabla: RUBROS
-- Descripción: Rubros o sectores a los que pertenecen los clientes
-- ============================================
CREATE TABLE rubros (
    id_rubro NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL UNIQUE,
    descripcion VARCHAR2(400)
);

COMMENT ON TABLE rubros IS 'Rubros o sectores a los que pertenecen los clientes';
COMMENT ON COLUMN rubros.id_rubro IS 'Identificador único del rubro';
COMMENT ON COLUMN rubros.nombre IS 'Nombre del rubro o sector';
COMMENT ON COLUMN rubros.descripcion IS 'Descripción del rubro';

-- ============================================
-- Tabla: CLIENTES
-- Descripción: Clientes de la empresa con sus datos básicos y su rubro
-- ============================================
CREATE TABLE clientes (
    id_cliente NUMBER PRIMARY KEY,
    nombre VARCHAR2(200) NOT NULL,
    razon_social VARCHAR2(200),
    id_rubro NUMBER NOT NULL,
    direccion VARCHAR2(300),
    telefono VARCHAR2(50),
    email VARCHAR2(100),
    fecha_registro DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_clientes_rubro FOREIGN KEY (id_rubro) REFERENCES rubros(id_rubro)
);

COMMENT ON TABLE clientes IS 'Clientes de la empresa';
COMMENT ON COLUMN clientes.id_cliente IS 'Identificador único del cliente';
COMMENT ON COLUMN clientes.nombre IS 'Nombre del cliente';
COMMENT ON COLUMN clientes.razon_social IS 'Razón social del cliente';
COMMENT ON COLUMN clientes.id_rubro IS 'FK al rubro del cliente';
COMMENT ON COLUMN clientes.direccion IS 'Dirección física del cliente';
COMMENT ON COLUMN clientes.telefono IS 'Teléfono de contacto';
COMMENT ON COLUMN clientes.email IS 'Correo electrónico del cliente';
COMMENT ON COLUMN clientes.fecha_registro IS 'Fecha de registro del cliente en el sistema';

-- ============================================
-- Tabla: PROYECTOS
-- Descripción: Proyectos desarrollados para los clientes
-- ============================================
CREATE TABLE proyectos (
    id_proyecto NUMBER PRIMARY KEY,
    id_cliente NUMBER NOT NULL,
    nombre VARCHAR2(200) NOT NULL,
    descripcion VARCHAR2(1000),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR2(50) DEFAULT 'EN PROCESO',
    presupuesto NUMBER(15,2),
    CONSTRAINT fk_proyectos_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

COMMENT ON TABLE proyectos IS 'Proyectos de desarrollo para clientes';
COMMENT ON COLUMN proyectos.id_proyecto IS 'Identificador único del proyecto';
COMMENT ON COLUMN proyectos.id_cliente IS 'FK al cliente propietario del proyecto';
COMMENT ON COLUMN proyectos.nombre IS 'Nombre del proyecto';
COMMENT ON COLUMN proyectos.descripcion IS 'Descripción detallada del proyecto';
COMMENT ON COLUMN proyectos.fecha_inicio IS 'Fecha de inicio del proyecto';
COMMENT ON COLUMN proyectos.fecha_fin IS 'Fecha de finalización (opcional)';
COMMENT ON COLUMN proyectos.estado IS 'Estado actual del proyecto';
COMMENT ON COLUMN proyectos.presupuesto IS 'Presupuesto asignado al proyecto';

-- ============================================
-- Tabla: ROLES
-- Descripción: Roles para control de acceso de usuarios
-- ============================================
CREATE TABLE roles (
    id_rol NUMBER PRIMARY KEY,
    nombre_rol VARCHAR2(100) NOT NULL UNIQUE,
    descripcion VARCHAR2(300)
);

COMMENT ON TABLE roles IS 'Roles para permisos y control de acceso';
COMMENT ON COLUMN roles.id_rol IS 'Identificador único del rol';
COMMENT ON COLUMN roles.nombre_rol IS 'Nombre del rol (ej. ADMIN, DEV, SOPORTE)';
COMMENT ON COLUMN roles.descripcion IS 'Descripción del rol';

-- ============================================
-- Tabla: USUARIOS
-- Descripción: Usuarios del sistema con roles y claves encriptadas
-- ============================================
CREATE TABLE usuarios (
    id_usuario NUMBER PRIMARY KEY,
    username VARCHAR2(100) NOT NULL UNIQUE,
    password_hash VARCHAR2(256) NOT NULL,
    salt VARCHAR2(64) NOT NULL,
    nombre_completo VARCHAR2(200) NOT NULL,
    email VARCHAR2(150) NOT NULL UNIQUE,
    id_rol NUMBER NOT NULL,
    fecha_creacion DATE DEFAULT SYSDATE NOT NULL,
    activo CHAR(1) DEFAULT 'Y' CHECK (activo IN ('Y','N')),
    CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

COMMENT ON TABLE usuarios IS 'Usuarios del sistema con autenticación y roles';
COMMENT ON COLUMN usuarios.id_usuario IS 'Identificador único del usuario';
COMMENT ON COLUMN usuarios.username IS 'Nombre de usuario para login';
COMMENT ON COLUMN usuarios.password_hash IS 'Hash seguro de la contraseña';
COMMENT ON COLUMN usuarios.salt IS 'Valor de salt para el hash de la contraseña';
COMMENT ON COLUMN usuarios.nombre_completo IS 'Nombre completo del usuario';
COMMENT ON COLUMN usuarios.email IS 'Correo electrónico del usuario';
COMMENT ON COLUMN usuarios.id_rol IS 'FK al rol del usuario';
COMMENT ON COLUMN usuarios.fecha_creacion IS 'Fecha en que se creó el usuario';
COMMENT ON COLUMN usuarios.activo IS 'Estado de cuenta activo (Y) o inactivo (N)';

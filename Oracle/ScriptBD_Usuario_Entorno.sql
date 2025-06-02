-- ============================================
-- Script para crear tablespaces, usuario y permisos
-- para la base de datos de empresa de desarrollo de software
-- ============================================

-- 1. Crear tablespace para datos
CREATE TABLESPACE ts_devsoft_data
DATAFILE '/u01/app/oracle/oradata/ORCL/ts_devsoft_data01.dbf' SIZE 100M
AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

-- 2. Crear tablespace para índices
CREATE TABLESPACE ts_devsoft_idx
DATAFILE '/u01/app/oracle/oradata/ORCL/ts_devsoft_idx01.dbf' SIZE 50M
AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

-- 3. Crear usuario de la aplicación
CREATE USER devsoft_user IDENTIFIED BY StrongPassword123
DEFAULT TABLESPACE ts_devsoft_data
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON ts_devsoft_data;

-- 4. Otorgar permisos mínimos necesarios
GRANT CONNECT, RESOURCE TO devsoft_user;

-- Para crear sesiones, objetos y usar el esquema
GRANT CREATE SESSION TO devsoft_user;
GRANT CREATE TABLE TO devsoft_user;
GRANT CREATE SEQUENCE TO devsoft_user;
GRANT CREATE PROCEDURE TO devsoft_user;
GRANT CREATE TRIGGER TO devsoft_user;
GRANT CREATE VIEW TO devsoft_user;

-- 5. Otorgar permisos para manejo de roles y seguridad (si se desea administrar dentro del esquema)
-- GRANT ALTER USER TO devsoft_user; -- Opcional, solo si se gestionan usuarios desde el esquema

-- 6. Opcional: Crear rol específico para desarrolladores o administradores
CREATE ROLE devsoft_admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON clientes TO devsoft_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON proyectos TO devsoft_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON usuarios TO devsoft_admin;

-- 7. Asignar rol al usuario
GRANT devsoft_admin TO devsoft_user;

-- ============================================
-- NOTA:
-- Ajustar rutas de DATAFILE según entorno Oracle real.
-- Cambiar 'StrongPassword123' por una contraseña segura.
-- Crear el schema de la base con los scripts de creación de tablas y objetos bajo este usuario.
-- ============================================
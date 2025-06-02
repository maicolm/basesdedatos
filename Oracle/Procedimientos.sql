-- ============================================
-- Procedimientos almacenados CRUD para tablas principales
-- ============================================

-- ============================================
-- PROCEDIMIENTOS PARA CLIENTES
-- ============================================

CREATE OR REPLACE PROCEDURE sp_cliente_insert (
    p_nombre IN VARCHAR2,
    p_razon_social IN VARCHAR2,
    p_id_rubro IN NUMBER,
    p_direccion IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_email IN VARCHAR2,
    p_id_cliente OUT NUMBER
) AS
BEGIN
    SELECT seq_clientes.NEXTVAL INTO p_id_cliente FROM dual;

    INSERT INTO clientes (
        id_cliente, nombre, razon_social, id_rubro, direccion, telefono, email, fecha_registro
    ) VALUES (
        p_id_cliente, p_nombre, p_razon_social, p_id_rubro, p_direccion, p_telefono, p_email, SYSDATE
    );
END;
/

CREATE OR REPLACE PROCEDURE sp_cliente_update (
    p_id_cliente IN NUMBER,
    p_nombre IN VARCHAR2,
    p_razon_social IN VARCHAR2,
    p_id_rubro IN NUMBER,
    p_direccion IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_email IN VARCHAR2
) AS
BEGIN
    UPDATE clientes SET
        nombre = p_nombre,
        razon_social = p_razon_social,
        id_rubro = p_id_rubro,
        direccion = p_direccion,
        telefono = p_telefono,
        email = p_email
    WHERE id_cliente = p_id_cliente;
END;
/

CREATE OR REPLACE PROCEDURE sp_cliente_delete (
    p_id_cliente IN NUMBER
) AS
BEGIN
    DELETE FROM clientes WHERE id_cliente = p_id_cliente;
END;
/

CREATE OR REPLACE PROCEDURE sp_cliente_get (
    p_id_cliente IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT * FROM clientes WHERE id_cliente = p_id_cliente;
END;
/

-- ============================================
-- PROCEDIMIENTOS PARA PROYECTOS
-- ============================================

CREATE OR REPLACE PROCEDURE sp_proyecto_insert (
    p_id_cliente IN NUMBER,
    p_nombre IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fecha_inicio IN DATE,
    p_fecha_fin IN DATE,
    p_estado IN VARCHAR2,
    p_presupuesto IN NUMBER,
    p_id_proyecto OUT NUMBER
) AS
BEGIN
    SELECT seq_proyectos.NEXTVAL INTO p_id_proyecto FROM dual;

    INSERT INTO proyectos (
        id_proyecto, id_cliente, nombre, descripcion, fecha_inicio, fecha_fin, estado, presupuesto
    ) VALUES (
        p_id_proyecto, p_id_cliente, p_nombre, p_descripcion, p_fecha_inicio, p_fecha_fin, p_estado, p_presupuesto
    );
END;
/

CREATE OR REPLACE PROCEDURE sp_proyecto_update (
    p_id_proyecto IN NUMBER,
    p_nombre IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fecha_inicio IN DATE,
    p_fecha_fin IN DATE,
    p_estado IN VARCHAR2,
    p_presupuesto IN NUMBER
) AS
BEGIN
    UPDATE proyectos SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        fecha_inicio = p_fecha_inicio,
        fecha_fin = p_fecha_fin,
        estado = p_estado,
        presupuesto = p_presupuesto
    WHERE id_proyecto = p_id_proyecto;
END;
/

CREATE OR REPLACE PROCEDURE sp_proyecto_delete (
    p_id_proyecto IN NUMBER
) AS
BEGIN
    DELETE FROM proyectos WHERE id_proyecto = p_id_proyecto;
END;
/

CREATE OR REPLACE PROCEDURE sp_proyecto_get (
    p_id_proyecto IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT * FROM proyectos WHERE id_proyecto = p_id_proyecto;
END;
/

-- ============================================
-- PROCEDIMIENTOS PARA USUARIOS
-- Nota: La contraseña debe enviarse ya encriptada y con su salt
-- ============================================

CREATE OR REPLACE PROCEDURE sp_usuario_insert (
    p_username IN VARCHAR2,
    p_password_hash IN VARCHAR2,
    p_salt IN VARCHAR2,
    p_nombre_completo IN VARCHAR2,
    p_email IN VARCHAR2,
    p_id_rol IN NUMBER,
    p_id_usuario OUT NUMBER
) AS
BEGIN
    SELECT seq_usuarios.NEXTVAL INTO p_id_usuario FROM dual;

    INSERT INTO usuarios (
        id_usuario, username, password_hash, salt, nombre_completo, email, id_rol, fecha_creacion, activo
    ) VALUES (
        p_id_usuario, p_username, p_password_hash, p_salt, p_nombre_completo, p_email, p_id_rol, SYSDATE, 'Y'
    );
END;
/

CREATE OR REPLACE PROCEDURE sp_usuario_update (
    p_id_usuario IN NUMBER,
    p_nombre_completo IN VARCHAR2,
    p_email IN VARCHAR2,
    p_id_rol IN NUMBER,
    p_activo IN CHAR
) AS
BEGIN
    UPDATE usuarios SET
        nombre_completo = p_nombre_completo,
        email = p_email,
        id_rol = p_id_rol,
        activo = p_activo
    WHERE id_usuario = p_id_usuario;
END;
/

CREATE OR REPLACE PROCEDURE sp_usuario_update_password (
    p_id_usuario IN NUMBER,
    p_password_hash IN VARCHAR2,
    p_salt IN VARCHAR2
) AS
BEGIN
    UPDATE usuarios SET
        password_hash = p_password_hash,
        salt = p_salt
    WHERE id_usuario = p_id_usuario;
END;
/

CREATE OR REPLACE PROCEDURE sp_usuario_delete (
    p_id_usuario IN NUMBER
) AS
BEGIN
    DELETE FROM usuarios WHERE id_usuario = p_id_usuario;
END;
/

CREATE OR REPLACE PROCEDURE sp_usuario_get_by_username (
    p_username IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT * FROM usuarios WHERE username = p_username AND activo = 'Y';
END;
/

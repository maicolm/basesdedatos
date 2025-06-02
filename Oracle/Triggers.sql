-- ============================================
-- Triggers para auditoría, validación y control de estado
-- ============================================

-- ============================================
-- Tabla auditoría para cambios en usuarios
-- ============================================
CREATE TABLE auditoria_usuarios (
    id_auditoria NUMBER PRIMARY KEY,
    id_usuario NUMBER,
    accion VARCHAR2(20),
    fecha_accion DATE,
    usuario_sistema VARCHAR2(100),
    detalles VARCHAR2(1000)
);

COMMENT ON TABLE auditoria_usuarios IS 'Registro de auditoría para inserciones y modificaciones en tabla usuarios';
COMMENT ON COLUMN auditoria_usuarios.id_auditoria IS 'ID único del registro de auditoría';
COMMENT ON COLUMN auditoria_usuarios.id_usuario IS 'ID del usuario modificado o creado';
COMMENT ON COLUMN auditoria_usuarios.accion IS 'Tipo de acción (INSERT o UPDATE)';
COMMENT ON COLUMN auditoria_usuarios.fecha_accion IS 'Fecha y hora de la acción';
COMMENT ON COLUMN auditoria_usuarios.usuario_sistema IS 'Usuario de la base de datos que realizó la acción';
COMMENT ON COLUMN auditoria_usuarios.detalles IS 'Descripción adicional';

-- ============================================
-- Trigger para auditoría en tabla USUARIOS
-- ============================================
CREATE OR REPLACE TRIGGER trg_auditoria_usuarios
AFTER INSERT OR UPDATE ON usuarios
FOR EACH ROW
DECLARE
    v_accion VARCHAR2(20);
BEGIN
    IF INSERTING THEN
        v_accion := 'INSERT';
    ELSIF UPDATING THEN
        v_accion := 'UPDATE';
    END IF;

    INSERT INTO auditoria_usuarios (
        id_auditoria, id_usuario, accion, fecha_accion, usuario_sistema, detalles
    ) VALUES (
        seq_auditoria_usuarios.NEXTVAL,
        :NEW.id_usuario,
        v_accion,
        SYSDATE,
        USER,
        'Datos usuario modificado o creado'
    );
END;
/

-- ============================================
-- Trigger para validar fecha_fin >= fecha_inicio en proyectos
-- ============================================
CREATE OR REPLACE TRIGGER trg_validar_fecha_proyecto
BEFORE INSERT OR UPDATE ON proyectos
FOR EACH ROW
BEGIN
    IF :NEW.fecha_fin IS NOT NULL AND :NEW.fecha_fin < :NEW.fecha_inicio THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha fin no puede ser anterior a la fecha de inicio.');
    END IF;
END;
/

-- ============================================
-- Trigger para cambiar estado de proyecto a TERMINADO al asignar fecha_fin
-- ============================================
CREATE OR REPLACE TRIGGER trg_actualizar_estado_proyecto
BEFORE UPDATE OF fecha_fin ON proyectos
FOR EACH ROW
BEGIN
    IF :NEW.fecha_fin IS NOT NULL THEN
        :NEW.estado := 'TERMINADO';
    END IF;
END;
/

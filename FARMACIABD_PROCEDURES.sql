-- ========================================
-- PROCEDIMIENTO: procedimientos
-- ========================================
USE FARMACIABD;
DELIMITER $$

-- ========================================
-- PROCEDIMIENTO: Registrar Usuario
-- ========================================
CREATE PROCEDURE RegistrarUsuario(
    IN pnombre VARCHAR(255),
    IN pcorreo VARCHAR(100),
    IN pusuario VARCHAR(50),
    IN pcontrasena VARCHAR(100)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM USUARIO
        WHERE CORREO = pcorreo OR USUARIO = pusuario
    ) THEN
        INSERT INTO USUARIO (NOMBRE, CORREO, USUARIO, CONTRASENA)
        VALUES (pnombre, pcorreo, pusuario, pcontrasena);
    END IF;
END $$

-- ========================================
-- PROCEDIMIENTO: Validar Correo
-- ========================================
CREATE PROCEDURE ValidarCorreo(IN pcorreo VARCHAR(100))
BEGIN
    SELECT * 
    FROM USUARIO
    WHERE CORREO = pcorreo;
END $$

-- ========================================
-- PROCEDIMIENTO: Validar Inicio de Sesión
-- ========================================
CREATE PROCEDURE ValidarInicioSesion(
    IN pcorreo VARCHAR(100),
    IN pcontrasena VARCHAR(100)
)
BEGIN
    SELECT 
        ID,
        NOMBRE,
        CORREO,
        USUARIO,
        CONTRASENA
    FROM USUARIO
    WHERE CORREO = pcorreo
      AND CONTRASENA = pcontrasena;
END $$

-- ========================================
-- PROCEDIMIENTO: Convertir Usuario en Cliente
-- ========================================
CREATE PROCEDURE convertir_usuario_en_cliente(
    IN p_usuario VARCHAR(50),
    IN p_cedula VARCHAR(20),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_fecha_nacimiento DATE,
    IN p_sexo VARCHAR(10),
    IN p_alergias TEXT
)
BEGIN
    DECLARE v_usuario_id BIGINT;
    DECLARE v_rol_cliente_id BIGINT DEFAULT 1;
    DECLARE v_rol_admin_id BIGINT DEFAULT 2;
    DECLARE v_existente INT;

    SELECT COUNT(*) INTO v_existente
    FROM USUARIO
    WHERE USUARIO = p_usuario;

    IF v_existente = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario no existe.';
    END IF;

    SELECT ID INTO v_usuario_id
    FROM USUARIO
    WHERE USUARIO = p_usuario;

    SELECT COUNT(*) INTO v_existente
    FROM USUARIO_ROL
    WHERE USUARIO_ID = v_usuario_id AND ROL_ID = v_rol_admin_id;

    IF v_existente > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario tiene rol ADMIN. No puede convertirse en CLIENTE.';
    END IF;

    SELECT COUNT(*) INTO v_existente
    FROM USUARIO_ROL
    WHERE USUARIO_ID = v_usuario_id AND ROL_ID = v_rol_cliente_id;

    IF v_existente = 0 THEN
        INSERT INTO USUARIO_ROL (USUARIO_ID, ROL_ID)
        VALUES (v_usuario_id, v_rol_cliente_id);
    END IF;

    SELECT COUNT(*) INTO v_existente
    FROM CLIENTE
    WHERE ID_USUARIO = v_usuario_id;

    IF v_existente = 0 THEN
        INSERT INTO CLIENTE (
            ID_USUARIO,
            CEDULA,
            TELEFONO,
            DIRECCION,
            FECHA_NACIMIENTO,
            SEXO,
            ALERGIAS
        ) VALUES (
            v_usuario_id,
            p_cedula,
            p_telefono,
            p_direccion,
            p_fecha_nacimiento,
            p_sexo,
            p_alergias
        );
    END IF;
END $$

DELIMITER ;

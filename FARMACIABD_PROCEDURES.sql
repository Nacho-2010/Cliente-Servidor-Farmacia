-- ========================================
-- PROCEDIMIENTO: procedimientos.
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
        INSERT INTO USUARIO (NOMBRE, CORREO, USUARIO, CONTRASENA)
        VALUES (pnombre, pcorreo, pusuario, pcontrasena);
END $$

-- ========================================
-- PROCEDIMIENTO: Validar Correo
-- ========================================

CREATE PROCEDURE ValidarCorreo(pcorreo VARCHAR(100))
BEGIN
    SELECT NOMBRE
           ID
    FROM   USUARIO
    WHERE  CORREO = pcorreo;
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
        u.ID,
        u.NOMBRE,
        u.CORREO,
        u.USUARIO,
        u.CONTRASENA,
        r.NOMBRE AS ROL
    FROM USUARIO u
    JOIN USUARIO_ROL ur ON u.ID = ur.USUARIO_ID
    JOIN ROL r ON r.ID = ur.ROL_ID
    WHERE u.CORREO = pcorreo
      AND u.CONTRASENA = pcontrasena;
END $$



-- ========================================
-- PROCEDIMIENTO: Actualizar Contrasenna
-- ========================================

CREATE PROCEDURE ActualizarContrasenna(pIdUsuario bigint(11),
     pContrasenna varchar(10))
BEGIN

	UPDATE 	USUARIO
	SET 	CONTRASENA = pContrasenna
    WHERE 	ID = pIdUsuario;

END $$




-- ========================================
-- PROCEDIMIENTO: Almacenar errores
-- ========================================



CREATE PROCEDURE RegistrarError (
    IN pDescripcion VARCHAR(5000)
)
BEGIN
    INSERT INTO TERROR (DESCRIPCION, FECHAHORA)
    VALUES (pDescripcion, NOW());
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

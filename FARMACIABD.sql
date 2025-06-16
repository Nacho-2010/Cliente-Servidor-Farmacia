-- ===========================
-- ELIMINAR BASE Y USUARIO SI EXISTEN
-- ===========================
DROP DATABASE IF EXISTS FARMACIABD;
DROP USER IF EXISTS 'usuario_farmacia'@'%';

-- ===========================
-- CREAR BASE Y USUARIO
-- ===========================
CREATE DATABASE FARMACIABD;
CREATE USER 'usuario_farmacia'@'%' IDENTIFIED BY 'ClaveFarmacia123.';
GRANT ALL PRIVILEGES ON FARMACIABD.* TO 'usuario_farmacia'@'%';
-- FLUSH PRIVILEGES;

-- ===========================
-- USAR BASE DE DATOS
-- ===========================
USE FARMACIABD;

-- ===========================
-- TABLA USUARIO (para autenticación general)
-- ===========================
CREATE TABLE USUARIO (
    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(255) NOT NULL,
    CORREO VARCHAR(100) NOT NULL,
    USUARIO VARCHAR(50) UNIQUE NOT NULL,
    CONTRASENA VARCHAR(100) NOT NULL
);

-- ===========================
-- TABLA ROL
-- ===========================
CREATE TABLE ROL (
    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(50) NOT NULL
);

-- ===========================
-- TABLA INTERMEDIA USUARIO_ROL (muchos a muchos)
-- ===========================
CREATE TABLE USUARIO_ROL (
    USUARIO_ID BIGINT,
    ROL_ID BIGINT,
    PRIMARY KEY (USUARIO_ID, ROL_ID),
    FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO(ID) ON DELETE CASCADE,
    FOREIGN KEY (ROL_ID) REFERENCES ROL(ID) ON DELETE CASCADE
);

-- ===========================
-- ROLES PREDEFINIDOS
-- ===========================
INSERT INTO ROL (ID, NOMBRE) VALUES (1, 'CLIENTE');
INSERT INTO ROL (ID, NOMBRE) VALUES (2, 'ADMIN');



-- ===========================
-- USUARIOS DE EJEMPLO
-- ===========================
INSERT INTO USUARIO (NOMBRE, CORREO, USUARIO, CONTRASENA)
VALUES ('Josue', 'josue@email.com', 'josue', '$2a$10$xaaReEFEh8.ulnY5QIKwFeTnaWcLmY7Zc128wdKq3jcOjcer1Sf92');

INSERT INTO USUARIO (NOMBRE, CORREO, USUARIO, CONTRASENA)
VALUES ('Abraham', 'abraham@email.com', 'abraham', '$2a$10$xaaReEFEh8.ulnY5QIKwFeTnaWcLmY7Zc128wdKq3jcOjcer1Sf92');



INSERT INTO USUARIO_ROL (USUARIO_ID, ROL_ID) VALUES (1, 2); -- AGREGAMOS A Josue COMO ADMIN DESDE LA BASE DATOS 


-- VERIFICACIÓN:
SELECT U.NOMBRE AS NOMBRE_USUARIO, R.NOMBRE AS TIPO
FROM USUARIO U 
JOIN USUARIO_ROL UR ON UR.USUARIO_ID = U.ID
JOIN ROL R ON R.ID = UR.ROL_ID;

-- ===========================
-- TABLA CLIENTE (perfil extendido para pacientes)
-- ===========================
CREATE TABLE CLIENTE (
    ID_CLIENTE BIGINT AUTO_INCREMENT PRIMARY KEY,
    ID_USUARIO BIGINT NOT NULL,
    CEDULA VARCHAR(20),
    TELEFONO VARCHAR(20),
    DIRECCION VARCHAR(255),
    FECHA_NACIMIENTO DATE,
    SEXO VARCHAR(10),
    ALERGIAS TEXT,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID) ON DELETE CASCADE
);

-- ===========================
-- PROCEDIMIENTO: Convertir un usuario en cliente
-- ===========================
DELIMITER $$

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
    DECLARE v_rol_cliente_id BIGINT DEFAULT 1; -- ID del rol CLIENTE
    DECLARE v_rol_admin_id BIGINT DEFAULT 2;   -- ID del rol ADMIN
    DECLARE v_existente INT;

    -- Verificar que el usuario existe
    SELECT COUNT(*) INTO v_existente
    FROM USUARIO
    WHERE USUARIO = p_usuario;

    IF v_existente = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario no existe.';
    END IF;

    -- Obtener el ID del usuario
    SELECT ID INTO v_usuario_id
    FROM USUARIO
    WHERE USUARIO = p_usuario;

    -- Verificar si ya es ADMIN
    SELECT COUNT(*) INTO v_existente
    FROM USUARIO_ROL
    WHERE USUARIO_ID = v_usuario_id AND ROL_ID = v_rol_admin_id;

    IF v_existente > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario tiene rol ADMIN. No puede convertirse en CLIENTE.';
    END IF;

    -- Asignar rol CLIENTE si no lo tiene
    SELECT COUNT(*) INTO v_existente
    FROM USUARIO_ROL
    WHERE USUARIO_ID = v_usuario_id AND ROL_ID = v_rol_cliente_id;

    IF v_existente = 0 THEN
        INSERT INTO USUARIO_ROL (USUARIO_ID, ROL_ID)
        VALUES (v_usuario_id, v_rol_cliente_id);
    END IF;

    -- Insertar en CLIENTE si aún no existe
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

-- USO:
CALL convertir_usuario_en_cliente(
    'Abraham',              -- nombre de usuario
    '117890123',          -- cédula
    '88889999',           -- teléfono
    'San Marcos',   -- dirección
    '1990-04-10',         -- fecha nacimiento
    'M',                  -- sexo
    'Ninguna'             -- alergias
);




-- VERIFICACIÓN:
SELECT u.*, c.*, r.NOMBRE AS ROL
FROM USUARIO u
JOIN USUARIO_ROL ur ON ur.USUARIO_ID = u.ID
JOIN ROL r ON r.ID = ur.ROL_ID
LEFT JOIN CLIENTE c ON c.ID_USUARIO = u.ID
WHERE u.USUARIO = 'Abraham';

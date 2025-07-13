-- ========================================
-- PROCEDIMIENTOS GENERALES DEL SISTEMA
-- ========================================
USE FARMACIABD;
DELIMITER $$

-- ========================================
-- PROCEDIMIENTO: Registrar Usuario
-- ========================================
DROP PROCEDURE IF EXISTS RegistrarUsuario;

DELIMITER $$

CREATE PROCEDURE RegistrarUsuario(
    IN pnombre VARCHAR(255),
    IN pcorreo VARCHAR(100),
    IN pusuario VARCHAR(50),
    IN pcontrasena VARCHAR(100)
)
BEGIN
    INSERT INTO USUARIO (NOMBRE, CORREO, USUARIO, CONTRASENA)
    VALUES (pnombre, pcorreo, pusuario, pcontrasena);
    -- Asignar rol por defecto (CLIENTE con ID = 1)
    INSERT INTO USUARIO_ROL (USUARIO_ID, ROL_ID)
    VALUES (LAST_INSERT_ID(),1);

END $$

DELIMITER ;
-- ========================================
-- PROCEDIMIENTO: Validar Correo
-- ========================================
DROP PROCEDURE IF EXISTS ValidarCorreo;

DELIMITER $$

CREATE PROCEDURE ValidarCorreo(pcorreo VARCHAR(100))
BEGIN
    SELECT NOMBRE, ID
    FROM USUARIO
    WHERE CORREO = pcorreo;
END $$

DELIMITER ;

-- ========================================
-- PROCEDIMIENTO: Validar Inicio de Sesión
-- ========================================
DROP PROCEDURE IF EXISTS ValidarInicioSesion;

DELIMITER $$
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

DELIMITER ;

-- ========================================
-- PROCEDIMIENTO: Actualizar Contraseña
-- ========================================
DROP PROCEDURE IF EXISTS ActualizarContrasenna;
DELIMITER $$
CREATE PROCEDURE ActualizarContrasenna(
    IN pIdUsuario BIGINT(11),
    IN pContrasenna VARCHAR(100)
)
BEGIN
    UPDATE USUARIO
    SET CONTRASENA = pContrasenna
    WHERE ID = pIdUsuario;
END $$
DELIMITER ;
-- ========================================
-- PROCEDIMIENTO: Almacenar errores
-- ========================================
DROP PROCEDURE IF EXISTS RegistrarError;
DELIMITER $$
CREATE PROCEDURE RegistrarError (
    IN pDescripcion VARCHAR(5000)
)
BEGIN
    INSERT INTO TERROR (DESCRIPCION, FECHAHORA)
    VALUES (pDescripcion, NOW());
END $$
DELIMITER ;
-- ========================================
-- PROCEDIMIENTO: Convertir Usuario en Cliente
-- ========================================
DROP PROCEDURE IF EXISTS convertir_usuario_en_cliente;
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
-- ========================================
-- PROCEDIMIENTO: Agregar Producto
-- ========================================
DROP PROCEDURE IF EXISTS FIDE_PRODUCTO_INSERTAR_SP;

DELIMITER $$
CREATE PROCEDURE FIDE_PRODUCTO_INSERTAR_SP (
    IN p_NOMBRE VARCHAR(100),
    IN p_CODIGO VARCHAR(20),
    IN p_PRECIO_UNITARIO DECIMAL(10,2),
    IN p_ID_CATEGORIA_PRODUCTO INT,
    IN p_ID_UNIDAD_MEDIDA INT,
    IN p_ID_ESTADO INT
)
BEGIN
    INSERT INTO FIDE_PRODUCTO_TB (
        NOMBRE, CODIGO, PRECIO_UNITARIO,
        ID_CATEGORIA_PRODUCTO, ID_UNIDAD_MEDIDA, ID_ESTADO
    )
    VALUES (
        p_NOMBRE, p_CODIGO, p_PRECIO_UNITARIO,
        p_ID_CATEGORIA_PRODUCTO, p_ID_UNIDAD_MEDIDA, p_ID_ESTADO
    );
END$$

DELIMITER ;


-- ========================================
-- PROCEDIMIENTO: InsertarMovimiento
-- ========================================
DROP PROCEDURE IF EXISTS InsertarMovimiento;
DELIMITER $$

DROP PROCEDURE IF EXISTS InsertarMovimiento $$
CREATE PROCEDURE InsertarMovimiento(
    IN p_codigo_producto VARCHAR(20),
    IN p_numero_lote VARCHAR(100),
    IN p_fecha_vencimiento DATE,
    IN p_fecha_movimiento DATE,
    IN p_tipo_movimiento VARCHAR(10),
    IN p_cantidad INT,
    IN p_descripcion VARCHAR(255),
    IN p_empresa VARCHAR(100),
    IN p_id_farmacia INT
)
BEGIN
    DECLARE v_id_lote INT;
    DECLARE v_id_inventario INT;
    DECLARE v_saldo_actual INT;

    -- Buscar lote
    SELECT ID_LOTE INTO v_id_lote
    FROM FIDE_LOTE_TB
    WHERE CODIGO = p_codigo_producto AND NUMERO_LOTE = p_numero_lote
    LIMIT 1;

    -- Si no existe el lote, se crea
    IF v_id_lote IS NULL THEN
        INSERT INTO FIDE_LOTE_TB (
            CODIGO, NUMERO_LOTE, FECHA_ELABORADO, FECHA_VENCIMIENTO, ID_ESTADO
        ) VALUES (
            p_codigo_producto, p_numero_lote, p_fecha_movimiento, p_fecha_vencimiento, 1
        );

        SET v_id_lote = LAST_INSERT_ID();
    END IF;

    -- Verificar si ya está en inventario de la farmacia
    SELECT ID_INVENTARIO, CANTIDAD_DISPONIBLE INTO v_id_inventario, v_saldo_actual
    FROM FIDE_INVENTARIO_TB
    WHERE CODIGO = p_codigo_producto AND ID_FARMACIA = p_id_farmacia
    LIMIT 1;

    -- Si no existe, lo insertamos con cantidad 0
    IF v_id_inventario IS NULL THEN
        INSERT INTO FIDE_INVENTARIO_TB (
            CODIGO, CANTIDAD_DISPONIBLE, STOCK_MINIMO, STOCK_MAXIMO,
            ID_FARMACIA, ID_ESTADO
        ) VALUES (
            p_codigo_producto, 0, 0, 0,
            p_id_farmacia, 1
        );

        SET v_id_inventario = LAST_INSERT_ID();
        SET v_saldo_actual = 0;
    END IF;

    -- Según el tipo de movimiento, se actualiza el inventario
    IF p_tipo_movimiento = 'Entrada' THEN
        UPDATE FIDE_INVENTARIO_TB
        SET CANTIDAD_DISPONIBLE = v_saldo_actual + p_cantidad
        WHERE ID_INVENTARIO = v_id_inventario;
    ELSE
        UPDATE FIDE_INVENTARIO_TB
        SET CANTIDAD_DISPONIBLE = v_saldo_actual - p_cantidad
        WHERE ID_INVENTARIO = v_id_inventario;
    END IF;

    -- Insertar movimiento
    INSERT INTO FIDE_MOVIMIENTO_TB (
        ID_INVENTARIO, ID_LOTE, FECHA_MOVIMIENTO, FECHA_VENCIMIENTO,
        TIPO_MOVIMIENTO, CANTIDAD, DESCRIPCION, EMPRESA, ID_FARMACIA
    ) VALUES (
        v_id_inventario, v_id_lote, p_fecha_movimiento, p_fecha_vencimiento,
        p_tipo_movimiento, p_cantidad, p_descripcion, p_empresa, p_id_farmacia
    );

END $$
DELIMITER ;





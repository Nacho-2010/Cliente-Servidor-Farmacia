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
-- PROCEDIMIENTO: InsertarMovimiento (con validación por fecha)
-- ========================================
DROP PROCEDURE IF EXISTS InsertarMovimiento;
DELIMITER $$

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
    DECLARE v_stock_a_fecha INT;

    -- Buscar lote por producto, número y vencimiento
    SELECT ID_LOTE INTO v_id_lote
    FROM FIDE_LOTE_TB
    WHERE CODIGO = p_codigo_producto
      AND NUMERO_LOTE = p_numero_lote
      AND FECHA_VENCIMIENTO = p_fecha_vencimiento
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

    -- Si no existe, se inserta el registro en inventario
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

    -- Validación: si tipo salida y hay menos cantidad disponible hasta esa fecha
    IF p_tipo_movimiento = 'Salida' THEN
        SELECT 
            IFNULL(SUM(CASE 
                WHEN TIPO_MOVIMIENTO = 'Entrada' THEN CANTIDAD
                WHEN TIPO_MOVIMIENTO = 'Salida' THEN -CANTIDAD
                ELSE 0
            END), 0)
        INTO v_stock_a_fecha
        FROM FIDE_MOVIMIENTO_TB
        WHERE ID_INVENTARIO = v_id_inventario
          AND ID_FARMACIA = p_id_farmacia
          AND FECHA_MOVIMIENTO <= p_fecha_movimiento;

        IF v_stock_a_fecha < p_cantidad THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No hay suficiente stock disponible para esa fecha de salida.';
        END IF;
    END IF;

    -- Actualizar inventario según tipo
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


-- ========================================
-- PROCEDIMIENTO: ObtenerHistorialMovimientos
-- ========================================

DROP PROCEDURE IF EXISTS ObtenerHistorialMovimientos;
DELIMITER $$

CREATE PROCEDURE ObtenerHistorialMovimientos(
    IN p_codigo_producto VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SET @saldo := 0;

    SELECT 
        Movs.FECHA_MOVIMIENTO,
        Movs.TIPO_MOVIMIENTO,
        CONCAT(
            IF(Movs.TIPO_MOVIMIENTO = 'Entrada', '+', '-'),
            Movs.CANTIDAD
        ) AS CANTIDAD,
        @saldo := @saldo + 
            (CASE 
                WHEN Movs.TIPO_MOVIMIENTO = 'Entrada' THEN Movs.CANTIDAD 
                ELSE -Movs.CANTIDAD 
            END) AS SALDO
    FROM (
        SELECT M.FECHA_MOVIMIENTO, M.TIPO_MOVIMIENTO, M.CANTIDAD
        FROM FIDE_MOVIMIENTO_TB M
        JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
        WHERE I.CODIGO = p_codigo_producto AND M.ID_FARMACIA = p_id_farmacia
        ORDER BY M.FECHA_MOVIMIENTO ASC
    ) AS Movs;
END $$
DELIMITER ;




-- ========================================
-- PROCEDIMIENTO: BuscarProductoPorCodigo
-- ========================================
DROP PROCEDURE IF EXISTS BuscarProductoPorCodigo;
DELIMITER $$

CREATE PROCEDURE BuscarProductoPorCodigo(IN p_codigo VARCHAR(20))
BEGIN
    SELECT 
        P.CODIGO, 
        P.NOMBRE, 
        U.NOMBRE AS UNIDAD, 
        I.CANTIDAD_DISPONIBLE
    FROM FIDE_PRODUCTO_TB P
    JOIN FIDE_UNIDAD_MEDIDA_TB U ON P.ID_UNIDAD_MEDIDA = U.ID_UNIDAD_MEDIDA
    JOIN FIDE_INVENTARIO_TB I ON P.CODIGO = I.CODIGO
    WHERE P.CODIGO = p_codigo;
END $$
DELIMITER ;


-- ========================================
-- PROCEDIMIENTO: ObtenerStockDisponible
-- ========================================
DROP PROCEDURE IF EXISTS ObtenerStockDisponible;
DELIMITER $$

CREATE PROCEDURE ObtenerStockDisponible(
    IN p_codigo_producto VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SELECT CANTIDAD_DISPONIBLE
    FROM FIDE_INVENTARIO_TB
    WHERE CODIGO = p_codigo_producto AND ID_FARMACIA = p_id_farmacia
    LIMIT 1;
END $$
DELIMITER ;


-- ========================================
-- PROCEDIMIENTO: ObtenerLotesDisponiblesPorProducto
-- ========================================
DROP PROCEDURE IF EXISTS ObtenerLotesDisponiblesPorProducto;
DELIMITER $$

CREATE PROCEDURE ObtenerLotesDisponiblesPorProducto(
    IN p_codigo_producto VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SELECT
        L.CODIGO,
        L.NUMERO_LOTE,
        L.FECHA_VENCIMIENTO,
        F.NOMBRE AS NOMBRE_FARMACIA,
        SUM(
            CASE
                WHEN M.TIPO_MOVIMIENTO = 'Entrada' THEN M.CANTIDAD
                WHEN M.TIPO_MOVIMIENTO = 'Salida' THEN -M.CANTIDAD
                ELSE 0
            END
        ) AS CANTIDAD_EN_LOTE
    FROM FIDE_MOVIMIENTO_TB M
    JOIN FIDE_LOTE_TB L ON M.ID_LOTE = L.ID_LOTE
    JOIN FIDE_FARMACIA_TB F ON M.ID_FARMACIA = F.ID_FARMACIA
    WHERE L.CODIGO = p_codigo_producto
      AND M.ID_FARMACIA = p_id_farmacia
    GROUP BY L.CODIGO, L.NUMERO_LOTE, L.FECHA_VENCIMIENTO, F.NOMBRE
    HAVING CANTIDAD_EN_LOTE > 0
    ORDER BY L.FECHA_VENCIMIENTO ASC;
END $$
DELIMITER ;



-- ========================================
-- PROCEDIMIENTO: salidas de productos por lotes 
-- ========================================
DELIMITER $$

DROP PROCEDURE IF EXISTS GenerarSalidaPorLotes $$
CREATE PROCEDURE GenerarSalidaPorLotes(
    IN p_codigo_producto VARCHAR(20),
    IN p_id_farmacia INT,
    IN p_cantidad_total INT,
    IN p_fecha_movimiento DATE,
    IN p_descripcion VARCHAR(255),
    IN p_empresa VARCHAR(100)
)
BEGIN
    DECLARE v_cantidad_restante INT DEFAULT 0;
    DECLARE v_id_inventario INT;
    DECLARE v_id_lote INT;
    DECLARE v_numero_lote VARCHAR(100);
    DECLARE v_fecha_venc DATE;
    DECLARE v_cantidad_en_lote INT;
    DECLARE v_stock_fecha INT;

    -- Cursor y handler deben declararse ANTES de cualquier otra lógica
    DECLARE lote_cursor CURSOR FOR
        SELECT 
            L.ID_LOTE, L.NUMERO_LOTE, L.FECHA_VENCIMIENTO,
            SUM(CASE 
                WHEN M.TIPO_MOVIMIENTO = 'Entrada' THEN M.CANTIDAD
                WHEN M.TIPO_MOVIMIENTO = 'Salida' THEN -M.CANTIDAD
                ELSE 0
            END) AS CANTIDAD_EN_LOTE
        FROM FIDE_MOVIMIENTO_TB M
        JOIN FIDE_LOTE_TB L ON M.ID_LOTE = L.ID_LOTE
        WHERE L.CODIGO = p_codigo_producto AND M.ID_FARMACIA = p_id_farmacia
          AND M.FECHA_MOVIMIENTO <= p_fecha_movimiento
        GROUP BY L.ID_LOTE, L.NUMERO_LOTE, L.FECHA_VENCIMIENTO
        HAVING CANTIDAD_EN_LOTE > 0
        ORDER BY L.FECHA_VENCIMIENTO ASC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_id_lote = NULL;

    -- Inicializamos valor restante
    SET v_cantidad_restante = p_cantidad_total;

    -- Validación previa: stock hasta la fecha del movimiento
    SELECT 
        IFNULL(SUM(CASE 
            WHEN TIPO_MOVIMIENTO = 'Entrada' THEN CANTIDAD
            WHEN TIPO_MOVIMIENTO = 'Salida' THEN -CANTIDAD
            ELSE 0
        END), 0)
    INTO v_stock_fecha
    FROM FIDE_MOVIMIENTO_TB M
    JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
    WHERE I.CODIGO = p_codigo_producto
      AND M.ID_FARMACIA = p_id_farmacia
      AND M.FECHA_MOVIMIENTO <= p_fecha_movimiento;

    IF v_stock_fecha < p_cantidad_total THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente stock acumulado hasta esa fecha para realizar la salida.';
    END IF;

    -- Obtener ID_INVENTARIO
    SELECT ID_INVENTARIO INTO v_id_inventario
    FROM FIDE_INVENTARIO_TB
    WHERE CODIGO = p_codigo_producto AND ID_FARMACIA = p_id_farmacia
    LIMIT 1;

    -- Cursor para aplicar la salida por lotes disponibles
    OPEN lote_cursor;

    lote_loop: LOOP
        FETCH lote_cursor INTO v_id_lote, v_numero_lote, v_fecha_venc, v_cantidad_en_lote;

        IF v_id_lote IS NULL OR v_cantidad_restante <= 0 THEN
            LEAVE lote_loop;
        END IF;

        IF v_cantidad_en_lote >= v_cantidad_restante THEN
            INSERT INTO FIDE_MOVIMIENTO_TB (
                ID_INVENTARIO, ID_LOTE, FECHA_MOVIMIENTO, FECHA_VENCIMIENTO,
                TIPO_MOVIMIENTO, CANTIDAD, DESCRIPCION, EMPRESA, ID_FARMACIA
            ) VALUES (
                v_id_inventario, v_id_lote, p_fecha_movimiento, v_fecha_venc,
                'Salida', v_cantidad_restante, p_descripcion, p_empresa, p_id_farmacia
            );

            UPDATE FIDE_INVENTARIO_TB
            SET CANTIDAD_DISPONIBLE = CANTIDAD_DISPONIBLE - v_cantidad_restante
            WHERE ID_INVENTARIO = v_id_inventario;

            SET v_cantidad_restante = 0;
        ELSE
            INSERT INTO FIDE_MOVIMIENTO_TB (
                ID_INVENTARIO, ID_LOTE, FECHA_MOVIMIENTO, FECHA_VENCIMIENTO,
                TIPO_MOVIMIENTO, CANTIDAD, DESCRIPCION, EMPRESA, ID_FARMACIA
            ) VALUES (
                v_id_inventario, v_id_lote, p_fecha_movimiento, v_fecha_venc,
                'Salida', v_cantidad_en_lote, p_descripcion, p_empresa, p_id_farmacia
            );

            UPDATE FIDE_INVENTARIO_TB
            SET CANTIDAD_DISPONIBLE = CANTIDAD_DISPONIBLE - v_cantidad_en_lote
            WHERE ID_INVENTARIO = v_id_inventario;

            SET v_cantidad_restante = v_cantidad_restante - v_cantidad_en_lote;
        END IF;
    END LOOP;

    CLOSE lote_cursor;
END $$
DELIMITER ;



SELECT 
    M.ID_MOVIMIENTO,
    L.CODIGO,
    L.NUMERO_LOTE,
    L.FECHA_VENCIMIENTO,
    M.FECHA_MOVIMIENTO,
    M.CANTIDAD,
    M.DESCRIPCION,
    F.NOMBRE AS NOMBRE_FARMACIA
FROM FIDE_MOVIMIENTO_TB M
JOIN FIDE_LOTE_TB L ON M.ID_LOTE = L.ID_LOTE
JOIN FIDE_FARMACIA_TB F ON M.ID_FARMACIA = F.ID_FARMACIA
WHERE M.TIPO_MOVIMIENTO = 'Salida'
  AND M.FECHA_MOVIMIENTO = '2025-07-13'
  AND L.CODIGO = '110010204'
  AND M.ID_FARMACIA = 1;



CALL ObtenerLotesDisponiblesPorProducto('110010204', 1);
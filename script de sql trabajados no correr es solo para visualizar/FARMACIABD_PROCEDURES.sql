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
DELIMITER $$

DROP PROCEDURE IF EXISTS BuscarProductoPorCodigo $$
CREATE PROCEDURE BuscarProductoPorCodigo(
    IN p_codigo VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SELECT 
        P.CODIGO, 
        P.NOMBRE, 
        cat.NOMBRE AS CATEGORIA,
        U.NOMBRE AS UNIDAD, 
        I.CANTIDAD_DISPONIBLE,
        P.ID_ESTADO,
        e.DESCRIPCION AS ESTADO,
        P.URL_IMAGEN
    FROM FIDE_PRODUCTO_TB P
    JOIN FIDE_UNIDAD_MEDIDA_TB U 
        ON P.ID_UNIDAD_MEDIDA = U.ID_UNIDAD_MEDIDA
    JOIN FIDE_INVENTARIO_TB I 
        ON P.CODIGO = I.CODIGO
    JOIN FIDE_CATEGORIA_PRODUCTO_TB cat
        ON cat.ID_CATEGORIA_PRODUCTO = P.ID_CATEGORIA_PRODUCTO
    JOIN FIDE_ESTADO_TB e
        ON e.ID_ESTADO = P.ID_ESTADO
    WHERE P.CODIGO = p_codigo
      AND I.ID_FARMACIA = p_id_farmacia
    LIMIT 1;
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
    DECLARE v_total_retirado INT DEFAULT 0; -- 👈 NUEVO

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

    SET v_cantidad_restante = p_cantidad_total;

    -- Validación previa
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

    SELECT ID_INVENTARIO INTO v_id_inventario
    FROM FIDE_INVENTARIO_TB
    WHERE CODIGO = p_codigo_producto AND ID_FARMACIA = p_id_farmacia
    LIMIT 1;

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

            SET v_total_retirado = v_total_retirado + v_cantidad_restante; -- 👈 NUEVO
            SET v_cantidad_restante = 0;
        ELSE
            INSERT INTO FIDE_MOVIMIENTO_TB (
                ID_INVENTARIO, ID_LOTE, FECHA_MOVIMIENTO, FECHA_VENCIMIENTO,
                TIPO_MOVIMIENTO, CANTIDAD, DESCRIPCION, EMPRESA, ID_FARMACIA
            ) VALUES (
                v_id_inventario, v_id_lote, p_fecha_movimiento, v_fecha_venc,
                'Salida', v_cantidad_en_lote, p_descripcion, p_empresa, p_id_farmacia
            );

            SET v_total_retirado = v_total_retirado + v_cantidad_en_lote; -- 👈 NUEVO
            SET v_cantidad_restante = v_cantidad_restante - v_cantidad_en_lote;
        END IF;
    END LOOP;

    CLOSE lote_cursor;

    -- 👇 NUEVO: actualizar solo una vez el saldo
    UPDATE FIDE_INVENTARIO_TB
    SET CANTIDAD_DISPONIBLE = CANTIDAD_DISPONIBLE - v_total_retirado
    WHERE ID_INVENTARIO = v_id_inventario;
END $$
DELIMITER ;

use FARMACIABD
-- ========================================
-- PROCEDIMIENTO: Obtener Historial Kardex
-- ========================================
DELIMITER $$

DROP PROCEDURE IF EXISTS ObtenerHistorialKardex $$
CREATE PROCEDURE ObtenerHistorialKardex(
    IN p_codigo VARCHAR(20),
    IN p_id_farmacia INT
)
BEGIN
    SELECT *
    FROM HISTORIAL_KARDEX_V
    WHERE CODIGO = p_codigo
      AND ID_FARMACIA = p_id_farmacia
    ORDER BY FECHA_MOVIMIENTO ASC;
END $$
DELIMITER ;
-- ========================================
-- TERMINA
-- ========================================



-- ========================================
-- PROCEDIMIENTO: ConsultarProductos
-- ========================================
DROP PROCEDURE IF EXISTS ConsultarProductos;
DELIMITER $$

CREATE PROCEDURE ConsultarProductos()
BEGIN
    SELECT 
        P.CODIGO,
        P.NOMBRE,
        P.PRECIO_UNITARIO,
        cat.NOMBRE AS CATEGORIA,
        um.NOMBRE AS UNIDAD_MEDIDA,
        e.DESCRIPCION AS ESTADO,
        P.ID_ESTADO, 
        P.URL_IMAGEN
    FROM FIDE_PRODUCTO_TB P
    JOIN FIDE_CATEGORIA_PRODUCTO_TB cat ON cat.ID_CATEGORIA_PRODUCTO = P.ID_CATEGORIA_PRODUCTO
    JOIN FIDE_UNIDAD_MEDIDA_TB um ON um.ID_UNIDAD_MEDIDA = P.ID_UNIDAD_MEDIDA
    JOIN FIDE_ESTADO_TB e ON e.ID_ESTADO = P.ID_ESTADO;
END $$
DELIMITER ;


-- ========================================
-- TERMINA
-- ========================================


CALL ObtenerStockDisponible('110010207', 1);

CALL ObtenerLotesDisponiblesPorProducto('110010205', 1);

-- para elimiar los movimientos de un codigo en una farma 
-- DESACTIVAR MODO SEGURO TEMPORALMENTE (opcional si estás en modo seguro)
SET SQL_SAFE_UPDATES = 0;

-- 1. ELIMINAR LOS MOVIMIENTOS DEL PRODUCTO EN ESA FARMACIA
DELETE M
FROM FIDE_MOVIMIENTO_TB M
JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
WHERE I.CODIGO = '110010204' AND I.ID_FARMACIA = 1;

-- 2. RESETEAR EL STOCK A CERO
UPDATE FIDE_INVENTARIO_TB
SET CANTIDAD_DISPONIBLE = 0
WHERE CODIGO = '110010204' AND ID_FARMACIA = 1;

-- REACTIVAR MODO SEGURO SI LO TENÍAS ANTES (opcional)
SET SQL_SAFE_UPDATES = 1;


-- ========================================
-- PROCEDIMIENTO: ELIMINAR PRODUCTO (PASAR A INACTIVO)
-- ========================================
DELIMITER $$
CREATE PROCEDURE FIDE_PRODUCTO_ELIMINAR_SP (
    IN P_CODIGO VARCHAR(20)
)
BEGIN
    UPDATE fide_producto_tb
    SET ID_ESTADO = 2
    WHERE CODIGO = P_CODIGO;
END $$
DELIMITER ;

-- ========================================
-- Procedimiento: Encapsuladores de vista OBTENER_CATEGORIAS
-- ========================================
DELIMITER //
CREATE PROCEDURE FIDE_OBTENER_CATEGORIAS_SP()
BEGIN
  SELECT ID_CATEGORIA_PRODUCTO, NOMBRE FROM CATEGORIA_PRODUCTO_ACTIVA_V;
END //
DELIMITER;

-- ========================================
-- Procedimiento: Encapsuladores de vista UNIDAD_MEDIDA_ACTIVA
-- ========================================
 
DELIMITER //
CREATE PROCEDURE FIDE_OBTENER_UNIDAD_MEDIDA_ACTIVA_SP()
BEGIN
  SELECT ID_UNIDAD_MEDIDA, NOMBRE FROM  UNIDAD_MEDIDA_ACTIVA_V;
END //
DELIMITER ;

-- ========================================
-- Procedimiento: Encapsuladores de vista PRODUCTO_POR_CODIGO
-- ========================================

DELIMITER //
CREATE PROCEDURE FIDE_OBTENER_PRODUCTO_POR_CODIGO_SP(IN p_codigo VARCHAR(50))
BEGIN
  SELECT CODIGO, NOMBRE, PRECIO_UNITARIO
  FROM PRODUCTOS_ACTIVOS_V
  WHERE CODIGO = p_codigo;
END //
DELIMITER ;

-- ========================================
-- Procedimiento: Encapsuladores de vista PRODUCTOS_ACTIVOS
-- ========================================

DELIMITER //
CREATE PROCEDURE FIDE_OBTENER_PRODUCTOS_ACTIVOS_SP()
BEGIN
  SELECT CODIGO, NOMBRE
  FROM CODIGOS_ACTIVOS_V;
END //
DELIMITER ;
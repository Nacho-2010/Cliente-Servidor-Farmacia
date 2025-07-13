USE FARMACIABD;

-- ========================================
-- VISTA: Categorías Activas
-- ========================================
CREATE OR REPLACE VIEW CATEGORIA_PRODUCTO_ACTIVA_V AS
SELECT 
    ID_CATEGORIA_PRODUCTO, 
    NOMBRE
FROM 
    FIDE_CATEGORIA_PRODUCTO_TB
WHERE 
    ID_ESTADO = 1;

-- ========================================
-- VISTA: Unidades de Medida Activas
-- ========================================
CREATE OR REPLACE VIEW UNIDAD_MEDIDA_ACTIVA_V AS
SELECT 
    ID_UNIDAD_MEDIDA, 
    NOMBRE
FROM 
    FIDE_UNIDAD_MEDIDA_TB
WHERE 
    ID_ESTADO = 1;
    
    
-- ========================================
-- VISTA: Farmacias Activas
-- ========================================
CREATE OR REPLACE VIEW FARMACIAS_V AS
SELECT ID_FARMACIA, NOMBRE
FROM FIDE_FARMACIA_TB
WHERE ID_ESTADO = 1;

 
-- ========================================
-- VISTA: Kardex 
-- ========================================

CREATE OR REPLACE VIEW HISTORIAL_KARDEX_V AS
SELECT
    M.FECHA_MOVIMIENTO,
    M.TIPO_MOVIMIENTO,
    CASE 
        WHEN M.TIPO_MOVIMIENTO = 'Entrada' THEN CONCAT('+', M.CANTIDAD)
        WHEN M.TIPO_MOVIMIENTO = 'Salida' THEN CONCAT('-', M.CANTIDAD)
        ELSE CONCAT('', M.CANTIDAD)
    END AS CANTIDAD,
    CONCAT(M.CANTIDAD, ' lot ', L.NUMERO_LOTE) AS LOTES_AFECTADOS,

    (
        SELECT IFNULL(SUM(
            CASE 
                WHEN M2.TIPO_MOVIMIENTO = 'Entrada' THEN M2.CANTIDAD
                WHEN M2.TIPO_MOVIMIENTO = 'Salida' THEN -M2.CANTIDAD
                ELSE 0
            END
        ), 0)
        FROM FIDE_MOVIMIENTO_TB M2
        WHERE M2.ID_INVENTARIO = M.ID_INVENTARIO
          AND M2.ID_FARMACIA = M.ID_FARMACIA
          AND (
               M2.FECHA_MOVIMIENTO < M.FECHA_MOVIMIENTO
            OR (M2.FECHA_MOVIMIENTO = M.FECHA_MOVIMIENTO AND M2.ID_MOVIMIENTO <= M.ID_MOVIMIENTO)
          )
    ) AS SALDO,

    I.CODIGO,
    M.ID_FARMACIA,
    M.ID_INVENTARIO
FROM FIDE_MOVIMIENTO_TB M
JOIN FIDE_LOTE_TB L ON M.ID_LOTE = L.ID_LOTE
JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
ORDER BY M.FECHA_MOVIMIENTO, M.ID_MOVIMIENTO;










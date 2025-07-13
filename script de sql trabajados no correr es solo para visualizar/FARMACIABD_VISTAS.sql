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
CREATE OR REPLACE VIEW FARMACIA_ACTIVA_V AS
SELECT 
    ID_FARMACIA, 
    NOMBRE
FROM 
    FIDE_FARMACIA_TB
WHERE 
    ID_ESTADO = 1;

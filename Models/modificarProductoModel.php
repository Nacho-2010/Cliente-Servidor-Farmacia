<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function ModificarProducto($codigoOriginal, $nombreNuevo, $precioNuevo, $idCategoriaNueva, $idUnidadNueva, $idEstado)
{
    try {
        $conexion = OpenDB();
        $sp = "CALL FIDE_PRODUCTO_MODIFICAR_SP_CODIGO('$codigoOriginal', '$nombreNuevo', $precioNuevo, $idCategoriaNueva, $idUnidadNueva, $idEstado)";
        $conexion->query($sp);
        CloseDB($conexion);
    } catch (Exception $error) {
        RegistrarError($error);
    }
}

function ObtenerProductosActivosPorCodigo()
{
    try {
        $conexion = OpenDB();
        $sql = "SELECT CODIGO, NOMBRE FROM CODIGOS_ACTIVOS_V";
        $resultado = $conexion->query($sql);
        CloseDB($conexion);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}


?>
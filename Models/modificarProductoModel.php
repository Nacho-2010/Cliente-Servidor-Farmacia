<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function ModificarProducto($codigoOriginal, $nombreNuevo, $precioNuevo, $idCategoriaNueva, $idUnidadNueva, $idEstado, $resultadoImagen = null)
{
    try {
        $conexion = OpenDB();
        if ($urlImagen !== null) {
            $sp = "CALL FIDE_PRODUCTO_MODIFICAR_SP('$codigo', '$nombre', $precio, $idCategoria, $idUnidad, $idEstado, '$urlImagen')";
        } else {
            // Si no hay nueva imagen, usa un SP que no actualice imagen o envía NULL y que el SP lo ignore si es NULL
            $sp = "CALL FIDE_PRODUCTO_MODIFICAR_SP('$codigo', '$nombre', $precio, $idCategoria, $idUnidad, $idEstado, NULL)";
        }
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
        $sp = "CALL FIDE_OBTENER_PRODUCTOS_ACTIVOS_SP()";
        $resultado = $conexion->query($sp);
        CloseDB($conexion);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}

?>
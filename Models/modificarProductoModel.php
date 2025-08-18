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

function ObtenerProductoPorCodigo(string $codigo)
{
    try {
        $cnn = OpenDB();

        $stmt = $cnn->prepare("CALL FIDE_OBTENER_PRODUCTO_POR_CODIGO_SP(?)");
        $stmt->bind_param("s", $codigo);
        $stmt->execute();
        $rs = $stmt->get_result();
        $row = $rs ? $rs->fetch_assoc() : null;
        if ($rs)
            $rs->free();
        while ($cnn->more_results() && $cnn->next_result()) {
        }
        $stmt->close();
        CloseDB($cnn);
        return $row;
    } catch (Exception $e) {
        RegistrarError($e);
        return null;
    }
}
?>
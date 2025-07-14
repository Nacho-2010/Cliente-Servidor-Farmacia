<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';



// ===================================
// SP: Insertar Movimiento Individual
// ===================================
function InsertarMovimientoModel($codigo, $lote, $fecha_vencimiento, $fecha, $tipo, $cantidad, $descripcion, $empresa, $id_farmacia)
{
    try {
        $conexion = OpenDB();

        $sp = "CALL InsertarMovimiento(
            '$codigo', '$lote', '$fecha_vencimiento', '$fecha', '$tipo',
            $cantidad, '$descripcion', '$empresa', $id_farmacia
        )";

        $respuesta = $conexion->query($sp);
        CloseDB($conexion);
        return $respuesta;
    } catch (Exception $error) {
        RegistrarError($error);
        return false;
    }
}

// ===================================
// SP: Buscar Producto con Stock
// ===================================
// ===================================
// SP: Buscar Producto con Stock
// ===================================
function BuscarProductoPorCodigo($codigo, $id_farmacia)
{
    try {
        $conexion = OpenDB();

        $codigo = mysqli_real_escape_string($conexion, $codigo);
        $id_farmacia = intval($id_farmacia);

        $sp = "CALL BuscarProductoPorCodigo('$codigo', $id_farmacia)";
        $resultado = $conexion->query($sp);

        if ($resultado && $resultado->num_rows > 0) {
            $producto = $resultado->fetch_assoc();
            CloseDB($conexion);
            return $producto;
        }

        CloseDB($conexion);
        return null;
    } catch (Exception $e) {
        RegistrarError($e);
        return null;
    }
}

// ===================================
// Vista: Obtener Farmacias Activas
// ===================================
function ObtenerFarmaciasActivas()
{
    try {
        $conexion = OpenDB();
        $query = "SELECT ID_FARMACIA, NOMBRE FROM FARMACIAS_V";
        $resultado = $conexion->query($query);
        $farmacias = [];

        while ($row = $resultado->fetch_assoc()) {
            $farmacias[] = $row;
        }

        CloseDB($conexion);
        return $farmacias;
    } catch (Exception $e) {
        RegistrarError($e);
        return [];
    }
}

// ===================================
// SP: Historial por Producto/Farmacia
// ===================================
function ObtenerHistorialMovimientos($codigo, $id_farmacia)
{
    try {
        $conexion = OpenDB();
        $codigo = mysqli_real_escape_string($conexion, $codigo);
        $id_farmacia = intval($id_farmacia);

        $sp = "CALL ObtenerHistorialMovimientos('$codigo', $id_farmacia)";
        $resultado = $conexion->query($sp);

        $movimientos = [];
        while ($fila = $resultado->fetch_assoc()) {
            $movimientos[] = $fila;
        }

        CloseDB($conexion);
        return $movimientos;
    } catch (Exception $e) {
        RegistrarError($e);
        return [];
    }
}

// ===================================
// SP: Consultar Stock Disponible
// ===================================
function ObtenerStockDisponible($codigo, $id_farmacia)
{
    try {
        $conexion = OpenDB();
        $codigo = mysqli_real_escape_string($conexion, $codigo);
        $id_farmacia = intval($id_farmacia);

        $sp = "CALL ObtenerStockDisponible('$codigo', $id_farmacia)";
        $resultado = $conexion->query($sp);

        if ($resultado && $resultado->num_rows > 0) {
            $row = $resultado->fetch_assoc();
            CloseDB($conexion);
            return $row["CANTIDAD_DISPONIBLE"];
        }

        CloseDB($conexion);
        return null;
    } catch (Exception $e) {
        RegistrarError($e);
        return null;
    }
}

// ===================================
// SP: Generar Salida Automática
// ===================================
function GenerarSalidaPorLotesModel($codigo, $id_farmacia, $cantidad_total, $fecha_movimiento, $descripcion, $empresa)
{
    try {
        $conexion = OpenDB();

        $codigo = mysqli_real_escape_string($conexion, $codigo);
        $id_farmacia = intval($id_farmacia);
        $cantidad_total = intval($cantidad_total);
        $fecha_movimiento = mysqli_real_escape_string($conexion, $fecha_movimiento);
        $descripcion = mysqli_real_escape_string($conexion, $descripcion);
        $empresa = mysqli_real_escape_string($conexion, $empresa);

        $sp = "CALL GenerarSalidaPorLotes(
            '$codigo',
            $id_farmacia,
            $cantidad_total,
            '$fecha_movimiento',
            '$descripcion',
            '$empresa'
        )";

        $resultado = $conexion->query($sp);

        CloseDB($conexion);
        return $resultado;
    } catch (Exception $e) {
        RegistrarError($e);
        return false;
    }
}



// ===================================
// Vista: Historial Kardex Detallado
// ===================================
function ObtenerHistorialKardex($codigo, $id_farmacia)
{
    try {
        $conexion = OpenDB();

        $codigo = mysqli_real_escape_string($conexion, $codigo);
        $id_farmacia = intval($id_farmacia);

        $sp = "CALL ObtenerHistorialKardex('$codigo', $id_farmacia)";

        $resultado = $conexion->query($sp);

        $movimientos = [];
        while ($fila = $resultado->fetch_assoc()) {
            $movimientos[] = $fila;
        }

        CloseDB($conexion);
        return $movimientos;
    } catch (Exception $e) {
        RegistrarError($e);
        return [];
    }
}

?>
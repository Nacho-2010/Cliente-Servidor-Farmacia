<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';



function InsertarMovimientoModel($codigo, $lote, $fecha_vencimiento, $fecha, $tipo, $cantidad, $descripcion, $empresa, $id_farmacia)
{
    try {
        $conexion = OpenDB();

        $sp = "CALL InsertarMovimiento(
            '$codigo', '$lote', '$fecha_vencimiento', '$fecha', '$tipo',
            $cantidad, '$descripcion', '$empresa', $id_farmacia)";

        $respuesta = $conexion->query($sp);
        CloseDB($conexion);
        return $respuesta;

    } catch (Exception $error) {
        RegistrarError($error);
        return false;
    }
}


function BuscarProductoPorCodigo($codigo)
{
    try {
        $conexion = OpenDB();
        $codigo = mysqli_real_escape_string($conexion, $codigo);

        $query = "SELECT P.CODIGO, P.NOMBRE, U.NOMBRE AS UNIDAD, I.CANTIDAD_DISPONIBLE
                  FROM FIDE_PRODUCTO_TB P
                  JOIN FIDE_UNIDAD_MEDIDA_TB U ON P.ID_UNIDAD_MEDIDA = U.ID_UNIDAD_MEDIDA
                  JOIN FIDE_INVENTARIO_TB I ON P.CODIGO = I.CODIGO
                  WHERE P.CODIGO = '$codigo'";

        $resultado = $conexion->query($query);
        CloseDB($conexion);
        return $resultado->fetch_assoc();

    } catch (Exception $e) {
        RegistrarError($e);
        return null;
    }
}


function ObtenerFarmaciasActivas()
{
    try {
        $conexion = OpenDB();
        $query = "SELECT ID_FARMACIA, NOMBRE FROM FARMACIA_ACTIVA_V";
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

function ObtenerHistorialMovimientos($codigo)
{
    try {
        $conexion = OpenDB();

        $codigo = mysqli_real_escape_string($conexion, $codigo);

        $query = "SELECT M.FECHA_MOVIMIENTO, M.TIPO_MOVIMIENTO, M.CANTIDAD,
                         IF(M.TIPO_MOVIMIENTO = 'Entrada', I.CANTIDAD_DISPONIBLE, I.CANTIDAD_DISPONIBLE - M.CANTIDAD) AS SALDO
                  FROM FIDE_MOVIMIENTO_TB M
                  JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
                  WHERE I.CODIGO = '$codigo'
                  ORDER BY M.FECHA_MOVIMIENTO DESC
                  LIMIT 5";

        $resultado = $conexion->query($query);

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
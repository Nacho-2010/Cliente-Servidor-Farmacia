<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function AgregarCarritoModel($IdUsuario, $CodigoProducto, $Cantidad = 1)
{
    try {
        $cn = OpenDB();
        $stmt = $cn->prepare("CALL AgregarAlCarrito(?, ?, ?)");
        $stmt->bind_param("isi", $IdUsuario, $CodigoProducto, $Cantidad);
        $ok = $stmt->execute();
        $stmt->close();
        CloseDB($cn);
        return $ok;
    } catch (Exception $error) {
        RegistrarError($error);
        return false;
    }
}


function ConsultarCarritoModel($idUsuario)
{
    try {
        $cn = OpenDB();
        $sp = "CALL ConsultarCarrito($idUsuario)";
        $rs = $cn->query($sp);

        return $rs;
    } catch (Exception $e) {
        RegistrarError($e);
        return false;
    }
}



function LiberarCarrito($conexion, $resultado)
{
    if ($resultado) {
        $resultado->free();
    }
    while ($conexion->more_results() && $conexion->next_result()) {
        $extraResult = $conexion->use_result();
        if ($extraResult instanceof mysqli_result) {
            $extraResult->free();
        }
    }
    CloseDB($conexion);
}




function ProcesarPagoCarritoModel($idUsuario, $descripcion = 'Venta General Clientes', $empresa = 'Venta Cliente', $fecha = null)
{
    try {
        $cn = OpenDB();
        if ($fecha === null) {
            $fecha = date('Y-m-d');
        }
        $desc = $cn->real_escape_string($descripcion);
        $emp = $cn->real_escape_string($empresa);
        $fec = $cn->real_escape_string($fecha);
        $sp = "CALL ProcesarPagoCarrito($idUsuario, '$fec', '$desc', '$emp')";
        $rs = $cn->query($sp);
        return $rs;
    } catch (Exception $e) {
        RegistrarError($e);
        return false;
    }
}



?>
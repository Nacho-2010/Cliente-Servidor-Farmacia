<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';
function ObtenerContrasennaModel($idUsuario)
{
    $conexion = OpenDB();
    $stmt = $conexion->prepare("CALL ConsultarInfoUsuario(?)");
    $stmt->bind_param("i", $idUsuario);
    $stmt->execute();
    $resultado = $stmt->get_result();

    $contrasenna = null;
    if ($resultado && $resultado->num_rows > 0) {
        $row = $resultado->fetch_assoc();
        $contrasenna = $row["CONTRASENA"];
    }

    $stmt->close();
    CloseDB($conexion);
    return $contrasenna;
}

function ActualizarContrasennaModel($idUsuario, $nueva)
{
    $conexion = OpenDB();
    $stmt = $conexion->prepare("CALL ActualizarContrasenna(?, ?)");
    $stmt->bind_param("is", $idUsuario, $nueva);
    $resultado = $stmt->execute();

    $stmt->close();
    CloseDB($conexion);
    return $resultado;
}


function ConsultarUsuariosModel()
{
    try {
        $conexion = OpenDB();
        $sql = "CALL ConsultarUsuariosFarmacia()";
        $resultado = $conexion->query($sql);
        CloseDB($conexion);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}

function CambiarEstadoUsuarioModel($idUsuario)
{
    try {
        $conexion = OpenDB();
        $sp = $conexion->prepare("CALL CambiarEstadoUsuarioFarmacia(?)");
        $sp->bind_param("i", $idUsuario);
        $resultado = $sp->execute();
        CloseDB($conexion);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return false;
    }
}


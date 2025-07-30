<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';
function ObtenerContrasennaModel($idUsuario) {
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

function ActualizarContrasennaModel($idUsuario, $nueva) {
    $conexion = OpenDB();
    $stmt = $conexion->prepare("CALL ActualizarContrasenna(?, ?)");
    $stmt->bind_param("is", $idUsuario, $nueva);
    $resultado = $stmt->execute();

    $stmt->close();
    CloseDB($conexion);
    return $resultado;
}



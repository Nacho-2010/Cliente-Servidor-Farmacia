<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

// Obtener contraseña actual
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

// Actualizar contraseña
function ActualizarContrasennaModel($idUsuario, $nueva) {
    $conexion = OpenDB();
    $stmt = $conexion->prepare("CALL ActualizarContrasenna(?, ?)");
    $stmt->bind_param("is", $idUsuario, $nueva);
    $resultado = $stmt->execute();
    $stmt->close();
    CloseDB($conexion);
    return $resultado;
}

// Consultar todos los usuarios (SP sin filtros)
function obtenerUsuarios() {
    $conexion = OpenDB();
    $resultado = $conexion->query("CALL FIDE_USUARIO_CONSULTAR_SP()");
    CloseDB($conexion);
    return $resultado;
}

function CambiarEstadoUsuarioModel($idUsuario) {
    try {
        $conexion = OpenDB();
        $stmt = $conexion->prepare("CALL CambiarEstadoUsuarioFarmacia(?)");
        $stmt->bind_param("i", $idUsuario);
        $resultado = $stmt->execute();
        $stmt->close();
        CloseDB($conexion);
        return $resultado;
    } catch (Exception $e) {
        RegistrarError($e);
        return false;
    }
}

function ObtenerUsuarioPorId($id) {
    $conexion = OpenDB();
    $stmt = $conexion->prepare("CALL FIDE_OBTENER_USUARIO_POR_ID_SP(?)");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $resultado = $stmt->get_result();
    $usuario = $resultado ? $resultado->fetch_assoc() : null;
    $stmt->close();
    CloseDB($conexion);

    return $usuario;
}

function ActualizarUsuario($id, $nombre, $correo, $usuario, $estado) {
    try {
        $conexion = OpenDB();
        $stmt = $conexion->prepare("CALL FIDE_ACTUALIZAR_USUARIOS_SP(?, ?, ?, ?, ?)");
        $stmt->bind_param("isssi", $id, $nombre, $correo, $usuario, $estado);
        $resultado = $stmt->execute();
        $stmt->close();
        CloseDB($conexion);
        return $resultado;
    } catch (Exception $e) {
        RegistrarError($e);
        return false;
    }
}


?>

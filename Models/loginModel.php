<?php

include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';
function ValidarInicioSesionModel($correo, $contrasena)
{
    try {
        $conexion = OpenDB();

        $sp = "CALL ValidarInicioSesion('$correo', '$contrasena')";
        $respuesta = $conexion->query($sp);

        CloseDB($conexion);
        return $respuesta;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}


function RegistrarUsuarioModel($nombre, $correo, $usuario, $contrasena)
{
    try {
        $conexion = OpenDB();

        $sp = "CALL RegistrarUsuario('$nombre', '$correo', '$usuario', '$contrasena')";
        $respuesta = $conexion->query($sp);

        CloseDB($conexion);
        return $respuesta;
    } catch (Exception $error) {
        RegistrarError($error);
        return false;
    }
}



function ValidarCorreoModel($correo)
{
    try {
        $conexion = OpenDB();

        $sp = "CALL ValidarCorreo('$correo')";
        $respuesta = $conexion->query($sp);

        CloseDB($conexion);
        return $respuesta;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}

function ObtenerRolesDelUsuario($usuarioId) {
    $conn = OpenDB();

    $sql = "SELECT R.NOMBRE 
            FROM USUARIO_ROL UR 
            INNER JOIN ROL R ON UR.ROL_ID = R.ID 
            WHERE UR.USUARIO_ID = ?";
    
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $usuarioId);
    $stmt->execute();
    $result = $stmt->get_result();

    $roles = [];
    while ($row = $result->fetch_assoc()) {
        $roles[] = $row['NOMBRE'];
    }

    CloseDB($conn);
    return $roles;
}


?>
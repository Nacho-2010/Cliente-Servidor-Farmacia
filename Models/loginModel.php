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


function ActualizarContrasennaModel($idUsuario, $contrasenna)
{
    try {
        $context = OpenDB();

        $sp = "CALL ActualizarContrasenna('$idUsuario', '$contrasenna')";
        $respuesta = $context->query($sp);

        CloseDB($context);
        return $respuesta;
    } catch (Exception $error) {
        RegistrarError($error);
        return false;
    }
}


?>
<?php

include_once $_SERVER["DOCUMENT_ROOT"] . '/Proyecto/Models/connect.php';
function ValidarInicioSesionModel($correo, $contrasena)
 {
        try
        {
            $conexion = OpenDB();

            $sp = "CALL ValidarInicioSesion('$correo', '$contrasena')";
            $respuesta = $conexion -> query($sp);

            CloseDB($conexion);            
            return $respuesta;
        }
        catch(Exception $error)
        {
            RegistrarError($error);
            return null;
        }
    }


     function RegistrarUsuarioModel($nombre, $correo, $identificacion, $contrasena)
    {
        try
        {
            $conexion = OpenDB();

            $sp = "CALL RegistrarUsuario('$nombre', '$correo', '$identificacion', '$contrasena')";
            $respuesta = $conexion -> query($sp);

            CloseDB($conexion);            
            return $respuesta;
        }
        catch(Exception $error)
        {
            RegistrarError($error);
            return false;
        }
    }



     function ValidarCorreoModel($correo)
    {
        try
        {
            $conexion = OpenDB();

            $sp = "CALL ValidarCorreo('$correo')";
            $respuesta = $conexion -> query($sp);

            CloseDB($conexion);            
            return $respuesta;
        }
        catch(Exception $error)
        {
            RegistrarError($error);
            return null;
        }
    }

?>








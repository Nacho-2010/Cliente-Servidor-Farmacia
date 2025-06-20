<?php

include_once $_SERVER["DOCUMENT_ROOT"] . '/Proyecto/Models/connect.php';
function ValidarInicioSesionModel($correo, $contrasena)
 {
        try
        {
            $context = OpenDB();

            $sp = "CALL ValidarInicioSesion('$correo', '$contrasena')";
            $respuesta = $context -> query($sp);

            CloseDB($context);            
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
            $context = OpenDB();

            $sp = "CALL RegistrarUsuario('$nombre', '$correo', '$identificacion', '$contrasena')";
            $respuesta = $context -> query($sp);

            CloseDB($context);            
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
            $context = OpenDB();

            $sp = "CALL ValidarCorreo('$correo')";
            $respuesta = $context -> query($sp);

            CloseDB($context);            
            return $respuesta;
        }
        catch(Exception $error)
        {
            RegistrarError($error);
            return null;
        }
    }

?>








<?php
    include_once $_SERVER["DOCUMENT_ROOT"] . '/Proyecto/Models/homeModel.php';

if(isset($_POST["btnIniciarSesion"]))
{
    $correo = $_POST["txtCorreo"];
    $contrasena = $_POST["txtContrasena"];

    $respuesta = ValidarInicioSesionModel($correo, $contrasena);

    if($respuesta != null && $respuesta -> num_rows > 0)
    {
        header("location: ../../Views/Home/principal.php");
    }
    else
    {
        $_POST["txtMensaje"] = "Su información no fue validada correctamente.";
    }
}

if(isset($_POST["btnRegistrarUsuario"]))
{
    $nombre = $_POST["txtNombre"];
    $correo = $_POST["txtCorreo"];
    $identificacion = $_POST["txtIdentificacion"];
    $contrasenna = $_POST["txtContrasena"];

    $respuesta = RegistrarUsuarioModel($nombre, $correo, $identificacion, $contrasena);

    if($respuesta)
    {
        header("location: ../../Views/Home/login.php");
    }
    else
    {
        $_POST["txtMensaje"] = "Su información no fue registrada correctamente.";
    }
}

if(isset($_POST["btnRecuperarAcceso"]))
{
    $correo = $_POST["txtCorreo"];

    $respuesta = ValidarCorreoModel($correo);

    if($respuesta != null && $respuesta -> num_rows > 0)
    {
        //Tomar los datos y enviar el correo electrónico al usuario

        header("location: ../../Views/Home/login.php");
    }
    else
    {
        $_POST["txtMensaje"] = "Su acceso no fue recuperado correctamente.";
    }
}
?>
<?php
session_start();
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/loginModel.php';
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/utilitariosController.php';



if (session_status() == PHP_SESSION_NONE) {
    session_start();
}


//-----------------------------------------------------------------//
if (isset($_POST["btnIniciarSesion"])) {
    $correo = $_POST["txtCorreo"];
    $contrasenna = $_POST["txtContrasenna"];

    $respuesta = ValidarInicioSesionModel($correo, $contrasenna);

    if ($respuesta != null && $respuesta->num_rows > 0) {
        $datos = mysqli_fetch_array($respuesta);
        $_SESSION["NOMBRE"] = $datos["NOMBRE"];
        $_SESSION["ID"] = $datos["ID"];
        $_SESSION["ROL"] = $datos["ROL"];
        header("Location: /Cliente-Servidor-Farmacia/Views/Home/principal.php");
    } else {
        $_POST["txtMensaje"] = "Su información no fue validada correctamente.";
    }
}

//-----------------------------------------------------------------//

if (isset($_POST["btnRegistrarUsuario"])) {
    $nombre = $_POST["txtNombre"];
    $correo = $_POST["txtCorreo"];
    $usuario = $_POST["txtUsuario"];
    $contrasenna = $_POST["txtContrasenna"];

    $respuesta = RegistrarUsuarioModel($nombre, $correo, $usuario, $contrasenna);

    if ($respuesta) {
        header("Location: /Cliente-Servidor-Farmacia/Views/Login/login.php");
        exit();
    } else {
        $_POST["txtMensaje"] = "Su información no fue registrada correctamente.";
    }
}

//-----------------------------------------------------------------//

if (isset($_POST["btnRecuperarAcceso"])) {
    $correo = $_POST["txtCorreo"];
    $respuesta = ValidarCorreoModel($correo);

    if ($respuesta != null && $respuesta->num_rows > 0) {
        $datos = mysqli_fetch_array($respuesta);

        $contrasenna = generarContrasena();

        $respuestaActualizacion = ActualizarContrasennaModel($datos["ID"], $contrasenna);

        if ($respuestaActualizacion) {
            $nombreUsuario = isset($datos["NOMBRE"]) ? $datos["NOMBRE"] : "usuario";

            $mensaje = "<html><body>
                Estimado(a) " . htmlspecialchars($nombreUsuario) . ",<br><br>
                Se ha generado el siguiente código de seguridad: <b>" . $contrasenna . "</b><br>
                Recuerde realizar el cambio de contraseña una vez que ingrese al sistema.
                </body></html>";

            $respuestaCorreo = EnviarCorreo('Recuperar Acceso', $mensaje, $correo);

            if ($respuestaCorreo) {
                header("Location: /Cliente-Servidor-Farmacia/Views/Login/login.php");
                exit();
            } else {
                $_POST["txtMensaje"] = "No se pudo enviar el correo. Intente más tarde.";
            }
        } else {
            $_POST["txtMensaje"] = "No se pudo actualizar la contraseña. Intente más tarde.";
        }
    } else {
        $_POST["txtMensaje"] = "El correo ingresado no está registrado.";
    }
}
?>

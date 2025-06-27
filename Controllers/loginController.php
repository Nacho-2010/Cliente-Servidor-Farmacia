<?php
session_start();
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/loginModel.php';
$_SESSION['error_btnRegistrarUsuario'] = null;

if (isset($_POST['btnIniciarSesion'])) {
    $correo = $_POST['correo'];
    $contrasena = $_POST['contrasena'];

    // Validar inicio de sesión
    $resultado = ValidarInicioSesionModel($correo, $contrasena);


    if ($resultado != null && $resultado->num_rows > 0) {
        $usuario = $resultado->fetch_assoc();

        $_SESSION['usuario_id'] = $usuario['ID'];
        $_SESSION['usuario'] = $usuario['USERNAME'];
        $_SESSION['nombre'] = $usuario['NOMBRE'];

        // Obtener roles desde la base de datos
        $roles = ObtenerRolesDelUsuario($usuario['ID']); // crea esta función en loginModel.php
        $_SESSION['roles'] = $roles;

        header("Location: ../../Views/Home/principal.php");
    } else {
        $_POST['mensaje'] = "⚠️ Usuario o contraseña incorrectos.";
    }

}
//-----------------------------------------------------------------//

if (isset($_POST['btnRegistrarUsuario'])) {
    $nombre = $_POST['nombre'];
    $correo = $_POST['correo'];
    $usuario = $_POST['usuario'];
    $contrasena = $_POST['contrasena'];

    // Validar que el correo no exista antes de registrar
    $correoExistente = ValidarCorreoModel($correo);

    if ($correoExistente && $correoExistente->num_rows > 0) {
        $_SESSION['error_btnRegistrarUsuario'] = "⚠️ El correo ya está registrado.";
        header("Location: ../Views/Login/login.php");
        exit();
    }

    // Registrar usuario
    $resultado = RegistrarUsuarioModel($nombre, $correo, $usuario, $contrasena);

    if ($resultado) {
        $_SESSION['usuario'] = $correo;
        $_SESSION['nombre'] = $nombre;
        header("Location: ../Views/Home/principal.php");
        exit();
    } else {
        $_SESSION['error_btnRegistrarUsuario'] = "⚠️ Error al registrar el usuario.";
        header("Location: ../Views/Login/login.php");
        exit();
    }

    if (isset($_POST['btnRegistrarUsuario'])) {
        error_log("✔ Llegó al controlador");
    } else {
        error_log("❌ No llegó al controlador");
    }


}
?>
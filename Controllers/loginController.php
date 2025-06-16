<?php




// ==================== CONEXIÓN A LA BASE DE DATOS ====================







session_start();
$_SESSION['error_login'] = null;
$_SESSION['error_registro'] = null;

if (isset($_POST['login'])) {
    $correo = $_POST['correo'];
    $contrasena = $_POST['contrasena'];
    $query = $conexion->query("SELECT * FROM usuarios WHERE correo='$correo'");

    if ($query->num_rows > 0) {
        $row = $query->fetch_assoc();
        if (password_verify($contrasena, $row['contrasena'])) {
            $_SESSION['usuario'] = $row['usuario'];
            header("Location: /Cliente-Servidor-Farmacia/Views/Home/principal.php");
            exit();
        } else {
            $_SESSION['error_login'] = "⚠️ Contraseña incorrecta.";
        }
    } else {
        $_SESSION['error_login'] = "⚠️ El correo no está registrado.";
    }

    header("Location: /Cliente-Servidor-Farmacia/Views/Home/principal.php#login");
    exit();
}

if (isset($_POST['registro'])) {
    $nombre = $_POST['nombre'];
    $correo = $_POST['correo'];
    $usuario = $_POST['usuario'];
    $contrasena = password_hash($_POST['contrasena'], PASSWORD_DEFAULT);

    $sql = "INSERT INTO usuarios(nombre, correo, usuario, contrasena)
          VALUES('$nombre','$correo','$usuario','$contrasena')";

    if ($conexion->query($sql)) {
        $_SESSION['usuario'] = $usuario;
        $_SESSION['nombre'] = $nombre;
        header("Location: /Cliente-Servidor-Farmacia/Views/Home/principal.php");
        exit();
    } else {
        $_SESSION['error_registro'] = "⚠️ Error al registrar. Puede que el correo ya exista.";
        header("Location: /Cliente-Servidor-Farmacia/Views/Home/principal.php#registro");
        exit();
    }
}



?>
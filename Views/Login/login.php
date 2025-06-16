<?php
// session_start();
//
// $conexion = new mysqli("localhost", "root", "", "login_register_db", 3306);
// if ($conexion->connect_error) {
//     die("❌ Error de conexión: " . $conexion->connect_error);
// }
//
// if (isset($_POST['registro'])) {
//     $nombre = $_POST['nombre'];
//     $correo = $_POST['correo'];
//     $usuario = $_POST['usuario'];
//     $contrasena = password_hash($_POST['contrasena'], PASSWORD_DEFAULT);
//     $sql = "INSERT INTO usuarios(nombre, correo, usuario, contrasena) VALUES('$nombre','$correo','$usuario','$contrasena')";
//     $conexion->query($sql);
//     echo "<script>alert('Usuario registrado con éxito');</script>";
// }
//
// if (isset($_POST['login'])) {
//     $correo = $_POST['correo'];
//     $contrasena = $_POST['contrasena'];
//     $query = $conexion->query("SELECT * FROM usuarios WHERE correo='$correo'");
//     if ($query->num_rows > 0) {
//         $row = $query->fetch_assoc();
//         if (password_verify($contrasena, $row['contrasena'])) {
//             $_SESSION['usuario'] = $row['usuario'];
//             echo "<script>alert('Bienvenido {$row['usuario']}');</script>";
//         } else {
//             echo "<script>alert('Contraseña incorrecta');</script>";
//         }
//     } else {
//         echo "<script>alert('Correo no registrado');</script>";
//     }
// }                          
?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Login y Registro</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../assets/Estilos/login.css">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">  
</head>

<body>
    <div class="contenedor" id="contenedor">
        <!-- Panel Izquierdo: Formularios -->
        <div class="panel izquierdo">
            <form class="formulario login" id="form-login" method="POST">
                <h2>Iniciar Sesión</h2>
                <input type="email" name="correo" placeholder="Correo Electrónico" required>
                <input type="password" name="contrasena" placeholder="Contraseña" required>
                <button type="submit" name="login">Entrar</button>
            </form>

            <button type="button" class="btn btn-success" onclick="window.location.href='../Home/principal.php'">
                Iniciar Sesión </i>
            </button>

            <form class="formulario registro" id="form-register" method="POST">
                <h2>Registrarse</h2>
                <input type="text" name="nombre" placeholder="Nombre completo" required>
                <input type="email" name="correo" placeholder="Correo Electrónico" required>
                <input type="text" name="usuario" placeholder="Usuario" required>
                <input type="password" name="contrasena" placeholder="Contraseña" required>
                <button type="submit" name="registro">Registrarse</button>
            </form>
        </div>

        <!-- Panel Derecho: Botón de cambio -->
        <div class="panel derecho">
            <h3 id="titulo-panel">¿Aún no tienes una cuenta?</h3>
            <p id="texto-panel">Regístrate para que puedas iniciar sesión</p>
            <button id="btn-cambiar">Registrarse</button>
        </div>
    </div>

    <script src="../assets/Funciones/login.js"></script>
</body>
 
</html>

<?php




// ==================== CONEXIÓN A LA BASE DE DATOS ====================







if (isset($_POST['registro'])) {
    $nombre = $_POST['nombre'];
    $correo = $_POST['correo'];
    $usuario = $_POST['usuario'];
    $contrasena = password_hash($_POST['contrasena'], PASSWORD_DEFAULT);
    $sql = "INSERT INTO usuarios(nombre, correo, usuario, contrasena) VALUES('$nombre','$correo','$usuario','$contrasena')";
    $conexion->query($sql);
    echo "<script>alert('Usuario registrado con éxito');</script>";
}

if (isset($_POST['login'])) {
    $correo = $_POST['correo'];
    $contrasena = $_POST['contrasena'];
    $query = $conexion->query("SELECT * FROM usuarios WHERE correo='$correo'");
    if ($query->num_rows > 0) {
        $row = $query->fetch_assoc();
        if (password_verify($contrasena, $row['contrasena'])) {
            $_SESSION['usuario'] = $row['usuario'];
            echo "<script>alert('Bienvenido {$row['usuario']}');</script>";
        } else {
            echo "<script>alert('Contraseña incorrecta');</script>";
        }
    } else {
        echo "<script>alert('Correo no registrado');</script>";
    }
}



?>








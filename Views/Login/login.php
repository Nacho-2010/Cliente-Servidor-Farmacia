<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/loginController.php';
?>
<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layoutLogin.php';
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Farmacia | Login</title>
    <!-- Estilos personalizados -->
    <link rel="stylesheet" href="../assets/Estilos/login.css" />
</head>

<body>
    <div class="contenedor" id="contenedor">
        <!-- Panel Izquierdo: Formularios -->


        <div class="panel izquierdo">
            <form class="formulario login" id="form-login" method="POST">
                <?php
                if (isset($_POST["txtMensaje"])) {
                    echo '<div class="alert alert-warning text-center">' . $_POST["txtMensaje"] . '</div>';
                }
                ?>
                <h2>Iniciar Sesión</h2>
                <input id="txtCorreo" name="txtCorreo" type="text" class="form-control form-control-lg"
                    placeholder="Correo">
                <input id="txtContrasenna" name="txtContrasenna" type="password" class="form-control form-control-lg"
                    placeholder="Contraseña">
                <button id="btnIniciarSesion" type="submit" name="btnIniciarSesion">Entrar</button>
                <div class="form-group m-b-0 m-t-10">

                    <br>
                    <div class="link-recuperar">
                        <a href="recuperarAcceso.php">¿Olvidaste tu contraseña?</a>
                    </div>

                </div>
            </form>

            <form class="formulario registro" id="form-register" method="POST">
                <?php
                if (isset($_POST["txtMensaje"])) {
                    echo '<div class="alert alert-warning text-center">' . $_POST["txtMensaje"] . '</div>';
                }
                ?>

                <h2>Registrarse</h2>
                <input id="txtNombre" name="txtNombre" type="text" class="form-control form-control-lg"
                    placeholder="Nombre">
                <input id="txtCorreo" name="txtCorreo" type="email" class="form-control form-control-lg"
                    placeholder="Correo">
                <input id="txtUsuario" name="txtUsuario" type="text" class="form-control form-control-lg"
                    placeholder="Usuario">
                <input id="txtContrasenna" name="txtContrasenna" type="password" class="form-control form-control-lg"
                    placeholder="Contraseña">
                <button id="btnRegistrarUsuario" name="btnRegistrarUsuario" type="submit">Registrarse</button>

            </form>
        </div>


        <!-- Panel Derecho: Botón de cambio -->
        <div class="panel derecho">
            <h3 id="titulo-panel">¿Aún no tienes una cuenta?</h3>
            <p id="texto-panel">Regístrate para que puedas iniciar sesión</p>
            <button id="btn-cambiar">Registrarse</button>
        </div>
    </div>


    <?php
    añadirScripts(); //scripts
    ?>


</body>

</html>
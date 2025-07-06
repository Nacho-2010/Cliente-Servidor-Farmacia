<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/loginController.php';
?>
<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layoutLogin.php';
?>

<!DOCTYPE html>
<html lang="es">

<?php
añadirCSS(); //<head> con CSS
?>

<?php
// session_start();
?>

<body>
    <div class="contenedor" id="contenedor">
        <!-- Panel Izquierdo: Formularios -->


        <button type="button" class="btn btn-success" onclick="window.location.href='../Home/principal.php'">
            Iniciar Sesión sin registrarme</i>
        </button>




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
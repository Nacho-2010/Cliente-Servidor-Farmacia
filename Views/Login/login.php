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
                <h2>Iniciar Sesión</h2>
                <input type="email" name="correo" placeholder="Correo Electrónico" required>
                <input type="password" name="contrasena" placeholder="Contraseña" required>
                <button type="submit" name="login">Entrar</button>
            </form>


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

    <?php
    añadirScripts(); //scripts
    ?>


</body>

</html>
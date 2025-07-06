<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/loginController.php';
?>
<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layoutLogin.php';
?>

<!DOCTYPE html>
<html>
<?php
añadirCSS();
?>

<body>

    <div class="contenedor">
        <!-- Panel izquierdo con el formulario -->
        <div class="panel izquierdo">
            <form class="formulario" action="" method="POST">
                <h2>Recuperar Acceso</h2>

                <?php
                if (isset($_POST["txtMensaje"])) {
                    echo '<div class="alert alert-warning text-center">' . $_POST["txtMensaje"] . '</div>';
                }
                ?>

                <input type="text" name="txtCorreo" placeholder="Correo" required>
                <button type="submit" name="btnRecuperarAcceso">Procesar</button>

                <p class="text-center mt-3">
                    ¿Ya tienes una cuenta? <a href="login.php"><b>Inicia Sesión</b></a>
                </p>
            </form>
        </div>

        <!-- Panel derecho solo decorativo -->
        <div class="panel derecho">
            <h3>Proyecto Farmacia</h3>
            <p>Grupo 4</p>
        </div>
    </div>




    <?php
    añadirScripts(); //scripts
    ?>


</body>


</html>
<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/usuarioModel.php';

if (isset($_POST["btnActualizarContrasenna"])) {
    $idUsuario = $_SESSION["ID"] ?? null;

    if (!$idUsuario) {
        $_POST["txtMensaje"] = "⚠️ Sesión expirada. Inicie sesión de nuevo.";
    } else {
        $anterior = $_POST["txtContrasennaAnterior"];
        $nueva = $_POST["txtContrasennaNueva"];
        $confirmar = $_POST["txtConfirmar"];

        $conexion = OpenDB();
        $sql = "SELECT CONTRASENA FROM USUARIO WHERE ID = ?";
        $stmt = $conexion->prepare($sql);
        $stmt->bind_param("i", $idUsuario);
        $stmt->execute();
        $resultado = $stmt->get_result();

        if ($resultado && $resultado->num_rows > 0) {
            $row = $resultado->fetch_assoc();
            $contrasenaActualBD = $row["CONTRASENA"];

            if ($contrasenaActualBD !== $anterior) {
                $_POST["txtMensaje"] = "Valide su contraseña anterior.";
            } elseif ($nueva !== $confirmar) {
                $_POST["txtMensaje"] = "Valide la confirmación de su nueva contraseña.";
            } else {
                $respuesta = ActualizarContrasennaModel($idUsuario, $nueva);

                if ($respuesta) {
                    $_SESSION["Contrasenna"] = $nueva;
                    $_POST["txtMensaje"] = "Contraseña actualizada correctamente.";
                } else {
                    $_POST["txtMensaje"] = "Error al actualizar la contraseña.";
                }
            }
        } else {
            $_POST["txtMensaje"] = "No se encontró el usuario.";
        }

        $stmt->close();
        CloseDB($conexion);
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>
<body>
<?php verheader(); sidebar(); ?>
<main class="contenido-principal main-formulario-centrado">
    <h2 class="mb-4">🔐 Actualizar Contraseña</h2>

    <?php
    if (isset($_POST["txtMensaje"])) {
        echo '<div class="alert alert-warning text-center">' . htmlspecialchars($_POST["txtMensaje"]) . '</div>';
    }
    ?>

    <form class="form" method="POST">
        <div class="mb-3">
            <label>Contraseña actual</label>
            <input type="password" name="txtContrasennaAnterior" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Nueva contraseña</label>
            <input type="password" name="txtContrasennaNueva" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Confirmar nueva contraseña</label>
            <input type="password" name="txtConfirmar" class="form-control" required>
        </div>

        <button type="submit" name="btnActualizarContrasenna" class="btn btn-actualizar">Actualizar</button>
    </form>
</main>
<?php añadirScripts(); ?>
</body>
</html>

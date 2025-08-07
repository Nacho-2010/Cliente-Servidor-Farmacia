<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/usuarioModel.php';
session_start();

// CAMBIO DE CONTRASEÑA
if (isset($_POST["btnActualizarContrasenna"])) {
    if (!isset($_SESSION["ID"])) {
        $_SESSION["txtMensaje"] = "⚠️ Sesión expirada. Inicie sesión de nuevo.";
        return;
    }

    $idUsuario = $_SESSION["ID"];
    $anterior = $_POST["txtContrasennaAnterior"];
    $nueva = $_POST["txtContrasennaNueva"];
    $confirmar = $_POST["txtConfirmar"];

    $contrasennaActualBD = ObtenerContrasennaModel($idUsuario);

    if ($contrasennaActualBD === null) {
        $_SESSION["txtMensaje"] = "No se encontró el usuario.";
        return;
    }

    if ($contrasennaActualBD !== $anterior) {
        $_SESSION["txtMensaje"] = "Valide su contraseña anterior.";
        return;
    }

    if ($nueva !== $confirmar) {
        $_SESSION["txtMensaje"] = "Valide la confirmación de su nueva contraseña.";
        return;
    }

    $respuesta = ActualizarContrasennaModel($idUsuario, $nueva);

    $_SESSION["txtMensaje"] = $respuesta ? "✅ Contraseña actualizada correctamente." : "❌ Error al actualizar la contraseña.";
    return;
}

if (isset($_POST["btnCambiarEstadoUsuario"])) {
    $idUsuario = intval($_POST["IdUsuario"]); // Forzar a número

    if ($idUsuario <= 0) {
        $_SESSION["txtMensaje"] = "❌ El ID del usuario no es válido.";
        header("Location: ../../Views/pages/consultarUsuarios.php");
        exit;
    }

    $respuesta = CambiarEstadoUsuarioModel($idUsuario);


    header("Location: ../../Views/pages/consultarUsuarios.php");
    exit;
}

function ConsultarUsuarios() {
    return obtenerUsuarios(); 
}
?>

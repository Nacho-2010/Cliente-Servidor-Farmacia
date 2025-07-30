<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/usuarioModel.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';
session_start();

if (isset($_POST["btnActualizarContrasenna"])) {
    if (!isset($_SESSION["ID"])) {
        $_POST["txtMensaje"] = "⚠️ Sesión expirada. Inicie sesión de nuevo.";
        return;
    }

    $idUsuario = $_SESSION["ID"];
    $anterior = $_POST["txtContrasennaAnterior"];
    $nueva = $_POST["txtContrasennaNueva"];
    $confirmar = $_POST["txtConfirmar"];

    $contrasennaActualBD = ObtenerContrasennaModel($idUsuario);

    if ($contrasennaActualBD === null) {
        $_POST["txtMensaje"] = "No se encontró el usuario.";
        return;
    }

    if ($contrasennaActualBD !== $anterior) {
        $_POST["txtMensaje"] = "Valide su contraseña anterior.";
        return;
    }

    if ($nueva !== $confirmar) {
        $_POST["txtMensaje"] = "Valide la confirmación de su nueva contraseña.";
        return;
    }

    $respuesta = ActualizarContrasennaModel($idUsuario, $nueva);

    if ($respuesta) {
        $_SESSION["Contrasenna"] = $nueva;
        $_POST["txtMensaje"] = "Contraseña actualizada correctamente.";
    } else {
        $_POST["txtMensaje"] = "Error al actualizar la contraseña.";
    }
}

?>

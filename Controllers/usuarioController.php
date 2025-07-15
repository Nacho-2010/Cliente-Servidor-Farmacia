<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/usuarioModel.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

session_start();

if (isset($_POST["btnActualizarContrasenna"])) {
  if (!isset($_SESSION["ID"])) {
    $_POST["txtMensaje"] = "⚠️ Sesión expirada. Inicie sesión de nuevo.";
    return;
}
// asegúrate que sea "ID" y no "IdUsuario"
    $anterior = $_POST["txtContrasennaAnterior"];
    $nueva = $_POST["txtContrasennaNueva"];
    $confirmar = $_POST["txtConfirmar"];

    // Validar contraseña anterior contra la BD
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
            return;
        }

        if ($nueva !== $confirmar) {
            $_POST["txtMensaje"] = "Valide la confirmación de su nueva contraseña.";
            return;
        }

        // Cambiar contraseña
        $respuesta = ActualizarContrasennaModel($idUsuario, $nueva);

        if ($respuesta) {
            $_SESSION["Contrasenna"] = $nueva; // opcional
            $_POST["txtMensaje"] = "Contraseña actualizada correctamente.";
        } else {
            $_POST["txtMensaje"] = "Error al actualizar la contraseña.";
        }

    } else {
        $_POST["txtMensaje"] = "No se encontró el usuario.";
    }

    $stmt->close();
    CloseDB($conexion);
}
?>

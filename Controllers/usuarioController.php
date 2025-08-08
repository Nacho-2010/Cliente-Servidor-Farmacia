<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/usuarioModel.php';
session_start();

if (isset($_GET["accion"])) {
    if ($_GET["accion"] === "editarUsuario") {
        editarUsuario();
    }
}

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

function editarUsuario() {
    //se valida que se recibio un id valido y si no lo redirige a la pantalla de consultar usuario
    if (!isset($_GET["q"]) || !is_numeric($_GET["q"])) {
        $_SESSION["txtMensaje"] = "ID de usuario inválido";
        header("Location: consultarUsuarios.php");
        exit();
    }
    //se obtiene el usuario de la bd
    $id = (int) $_GET["q"];
    $usuario = ObtenerUsuarioPorId($id);

    //formulario para editar
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        $nombre = $_POST["Nombre"];
        $correo = $_POST["Correo"];
        $usuarioSistema = $_POST["Usuario"];
        $estado = $_POST["Estado"];

        //se agrega el id como primer argumento
        $ok = ActualizarUsuario($id, $nombre, $correo, $usuarioSistema, $estado);

        $_SESSION["txtMensaje"] = $ok ? "Usuario actualizado correctamente" : "Error al actualizar usuario";
        header("Location: /Cliente-Servidor-Farmacia/Views/pages/consultarUsuarios.php");
        exit();
    }

    //carga la vista
    require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/pages/actualizarUsuario.php";
}


?>

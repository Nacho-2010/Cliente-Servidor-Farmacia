<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function ActualizarContrasennaModel($idUsuario, $nuevaContrasenna) {
    try {
        $conexion = OpenDB(); // Debe retornar un objeto mysqli válido

        $sql = "CALL ActualizarContrasenna(?, ?)";
        $stmt = $conexion->prepare($sql);

        if (!$stmt) {
            echo "❌ Error al preparar: " . $conexion->error;
            return false;
        }

        $stmt->bind_param("is", $idUsuario, $nuevaContrasenna);

        if (!$stmt->execute()) {
            echo "❌ Error al ejecutar: " . $stmt->error;
            return false;
        }

        $stmt->close();
        $conexion->close();

        return true;
    } catch (Exception $e) {
        echo "❌ Excepción atrapada: " . $e->getMessage();
        return false;
    }
}


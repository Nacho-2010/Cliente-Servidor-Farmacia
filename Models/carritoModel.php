<?php

include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function AgregarAlCarritoModel($idUsuario, $codigoProducto, $cantidad)
{
    try {
        $conexion = OpenDB();
        error_log("Llamando SP con: usuario={$idUsuario}, producto={$codigoProducto}, cantidad={$cantidad}");
        $sp = $conexion->prepare("CALL FIDE_AGREGAR_AL_CARRITO_SP(?, ?, ?)");
        $sp->bind_param("isi", $idUsuario, $codigoProducto, $cantidad);
        $sp->execute();
        $sp->close();

        CloseDB($conexion);
        return true;
    } catch (Exception $e) {
        error_log("Error en AgregarAlCarritoModel: " . $e->getMessage());
        return false;
    }
}

function ObtenerCarritoModel($idUsuario)
{
    try {
        $conexion = OpenDB();
        $sp = $conexion->prepare("CALL FIDE_OBTENER_CARRITO_SP(?)");
        $sp->bind_param("i", $idUsuario);
        $sp->execute();

        $resultado = $sp->get_result();
        $datos = $resultado->fetch_all(MYSQLI_ASSOC);

        $sp->close();
        CloseDB($conexion);

        return $datos;
    } catch (Exception $error) {
        error_log("Error en ObtenerCarritoModel: " . $error->getMessage());
        return [];
    }
}

function QuitarDelCarritoModel($idDetalle)
{
    try {
        $conexion = OpenDB();

        $sp = $conexion->prepare("CALL FIDE_QUITAR_DEL_CARRITO_SP(?)");
        $sp->bind_param("i", $idDetalle);
        $sp->execute();
        $sp->close();

        CloseDB($conexion);
        return true;
    } catch (Exception $error) {
        error_log("Error en QuitarDelCarritoModel: " . $error->getMessage());
        return false;
    }
}

function ActualizarCantidadCarritoModel($idDetalle, $cantidad)
{
    try {
        $conexion = OpenDB();

        $sp = $conexion->prepare("CALL FIDE_ACTUALIZAR_CANTIDAD_CARRITO_SP(?, ?)");
        $sp->bind_param("ii", $idDetalle, $cantidad);
        $sp->execute();
        $sp->close();

        CloseDB($conexion);
        return true;
    } catch (Exception $error) {
        error_log("Error en ActualizarCantidadCarritoModel: " . $error->getMessage());
        return false;
    }
}
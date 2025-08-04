<?php

require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/carritoModel.php';

session_start();

$accion = $_POST["accion"] ?? '';

if ($accion === 'agregar') {
    $idUsuario = $_SESSION["ID"] ?? null;
    $codigo = $_POST["codigo"] ?? '';
    $cantidad = $_POST["cantidad"] ?? 1;

    if (!$idUsuario || !$codigo) {
        echo json_encode(["success" => false, "message" => "Datos incompletos."]);
        exit;
    }

    $exito = AgregarAlCarritoModel($idUsuario, $codigo, $cantidad);

    if ($exito) {
        echo json_encode(["success" => true, "message" => "Producto agregado al carrito."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al agregar al carrito."]);
    }
    exit;
}

if ($accion === 'actualizar') {
    $idDetalle = $_POST["id_detalle"] ?? 0;
    $cantidad = $_POST["cantidad"] ?? 1;

    $exito = ActualizarCantidadCarrito($idDetalle, $cantidad);
    echo json_encode([
        "success" => $exito,
        "message" => $exito ? "Cantidad actualizada." : "No se pudo actualizar."
    ]);
    exit;
}

if ($accion === 'eliminar') {
    $idDetalle = $_POST["id_detalle"] ?? 0;

    $exito = QuitarDelCarrito($idDetalle);
    echo json_encode([
        "success" => $exito,
        "message" => $exito ? "Producto eliminado." : "No se pudo eliminar."
    ]);
    exit;
}

// Para otras llamadas internas
function ObtenerCarrito($idUsuario)
{
    return ObtenerCarritoModel($idUsuario);
}

function QuitarDelCarrito($idDetalle)
{
    return QuitarDelCarritoModel($idDetalle);
}

function ActualizarCantidadCarrito($idDetalle, $cantidad)
{
    return ActualizarCantidadCarritoModel($idDetalle, $cantidad);
}
<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/carritoModel.php";

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (isset($_POST["Accion"]) && $_POST["Accion"] === "AgregarCarrito") {
    AgregarCarrito($_POST["IdProducto"] ?? '', $_POST["Cantidad"] ?? 1);
}

if (isset($_POST["Accion"]) && $_POST["Accion"] === "ProcesarPagoCarrito") {
    ProcesarPagoCarrito();
}


function AgregarCarrito($IdProducto, $Cantidad = 1)
{
    $idUsuario = $_SESSION["ID"] ?? null;
    if (!$idUsuario) {
        echo "No autenticado.";
        return;
    }

    $ok = AgregarCarritoModel((int) $idUsuario, (string) $IdProducto, (int) $Cantidad);

    echo $ok ? "OK" : "El producto no fue agregado a su carrito.";
}




function ConsultarCarrito()
{
    $idUsuario = $_SESSION["ID"] ?? null;
    if (!$idUsuario)
        return false;

    $resultado = ConsultarCarritoModel((int) $idUsuario);


    $_SESSION["Total"] = 0.00;
    if ($resultado && $resultado->num_rows > 0) {
        $first = $resultado->fetch_assoc();
        $_SESSION["Total"] = (float) $first['TotalCarrito'];
        $resultado->data_seek(0);
    }
    return $resultado;
}




function ProcesarPagoCarrito()
{
    $idUsuario = $_SESSION["ID"] ?? null;
    if (!$idUsuario) {
        echo "No autenticado.";
        return;
    }

    $rs = ProcesarPagoCarritoModel((int) $idUsuario, 'Venta General Clientes', 'Venta Cliente');

    echo $rs ? "OK" : "No se pudo procesar el pago.";
}



?>
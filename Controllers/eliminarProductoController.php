<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/eliminarProductoModel.php";


$producto = null;
$mensaje = "";

// Buscar producto por código
if (isset($_POST["btnBuscarProducto"])) {
    $codigo = trim($_POST["txtCodigo"]);
    $producto = BuscarProducto($codigo);

    if (!$producto) {
        $mensaje = "Producto no encontrado o ya está inactivo.";
    }
}

//Eliminar (cambiar estado a inactivo)
if (isset($_POST["btnEliminarProducto"])) {
    $codigo = trim($_POST["txtCodigo"]);
    EliminarProducto($codigo);

    header("Location: /Cliente-Servidor-Farmacia/Views/pages/eliminarProducto.php?mensaje=Producto eliminado correctamente");
    exit(); //detener ejecución
}




?>
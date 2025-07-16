<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/registrarProductoModel.php";

if (isset($_POST["btnRegistrarProducto"])) {
    $nombre = $_POST["txtNombre"];
    $codigo = $_POST["txtCodigo"];
    $precio = $_POST["txtPrecio"];
    $idCategoria = $_POST["cmbCategoria"];
    $idUnidad = $_POST["cmbUnidad"];
    $idEstado = 1; //producto activo

    InsertarProducto($nombre, $codigo, $precio, $idCategoria, $idUnidad, $idEstado);

    header("Location: /Cliente-Servidor-Farmacia/Views/pages/registrarProducto.php?mensaje=Producto registrado correctamente");
    exit(); //se detiene la ejecucion
}

?>
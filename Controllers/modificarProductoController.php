<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/modificarProductoModel.php";

if (isset($_POST["btnModificarProducto"])) {
    $codigoOriginal = $_POST["cmbProducto"]; 
    $nombreNuevo    = $_POST["txtNombreNuevo"];
    $precioNuevo    = $_POST["txtPrecioNuevo"];
    $idCategoria    = $_POST["cmbCategoriaNueva"];
    $idUnidad       = $_POST["cmbUnidadNueva"];
    $idEstado       = 1; // activo

    ModificarProducto($codigoOriginal, $nombreNuevo, $precioNuevo, $idCategoria, $idUnidad, $idEstado);

    header("Location: /Cliente-Servidor-Farmacia/Views/pages/modificarProducto.php?mensaje=Producto modificado correctamente");
    exit();
}
?>

<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/modificarProductoModel.php";


if (isset($_POST["btnModificarProducto"])) {
    $codigoOriginal = $_POST["cmbProducto"]; // código elegido (NO se cambia)
    $nombreNuevo = $_POST["txtNombreNuevo"];
    $precioNuevo = $_POST["txtPrecioNuevo"];
    $idCategoria = $_POST["cmbCategoriaNueva"];
    $idUnidad = $_POST["cmbUnidadNueva"];
    $idEstado = 1; // activo

    if (isset($_FILES["txtImagen"]) && $_FILES["txtImagen"]["name"] !== "") {
        $imagenNombre = $_FILES["txtImagen"]["name"];
        $rutaRelativa = "/Cliente-Servidor-Farmacia/Views/ImagenProductos/" . $imagenNombre;
        $origen = $_FILES["txtImagen"]["tmp_name"];
        $destino = $_SERVER["DOCUMENT_ROOT"] . $rutaRelativa;

        if (copy($origen, $destino)) {
            $imagen = $rutaRelativa;
        }
    }


    ModificarProducto($codigoOriginal, $nombreNuevo, $precioNuevo, $idCategoria, $idUnidad, $idEstado, $imagen);

    header("Location: /Cliente-Servidor-Farmacia/Views/pages/registrarProducto.php?mensaje=Producto modificado correctamente");
    exit();
}





// Este controller solo PRE-CARGA. Crea la variable $productoModificar para la vista.
$productoModificar = null;

if (isset($_POST["btnCargarProducto"])) {
    $codigo = trim($_POST["cmbProducto"] ?? "");
    if ($codigo !== "") {
        // Llama a tu SP con parámetro
        $productoModificar = ObtenerProductoPorCodigo($codigo); // array o null
    }
}



?>
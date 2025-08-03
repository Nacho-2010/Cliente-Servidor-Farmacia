<?php

require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/productoModel.php';

function ConsultarProductos()
{
    return ConsultarProductosModel();
}

function ConsultarProductosFiltrados($nombre = '', $categoria = '')
{
    return ConsultarProductosFiltradosModel($nombre, $categoria);
}

function ObtenerCategorias()
{
    return ObtenerCategoriasModel();
}


function ObtenerStockTotalGlobal($codigo)
{
    $resultado = ObtenerStockTotalPorCodigoModel($codigo);
    if ($resultado && $fila = $resultado->fetch_assoc()) {
        return (int) $fila["STOCK_DISPONIBLE_TOTAL"];
    }
    return 0;
}

?>
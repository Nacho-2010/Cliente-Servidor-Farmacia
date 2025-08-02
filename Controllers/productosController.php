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
?>
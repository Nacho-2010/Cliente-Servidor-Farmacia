<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function ConsultarProductosModel()
{
    try {
        $context = OpenDB();
        $sp = "CALL ConsultarProductos()";
        $respuesta = $context->query($sp);
        CloseDB($context);
        return $respuesta;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}

function ConsultarProductosFiltradosModel($nombre = '', $categoria = '')
{
    try {
        $context = OpenDB();
        $stmt = $context->prepare("CALL ConsultarProductosFiltrados(?, ?)");
        $stmt->bind_param("ss", $nombre, $categoria);
        $stmt->execute();
        $resultado = $stmt->get_result();
        CloseDB($context);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}

function ObtenerCategoriasModel()
{
    try {
        $context = OpenDB();
        $stmt = $context->prepare("CALL ObtenerCategorias()");
        $stmt->execute();
        $resultado = $stmt->get_result();
        CloseDB($context);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}



function ObtenerStockTotalPorCodigoModel($codigo)
{
    try {
        $context = OpenDB();
        $stmt = $context->prepare("CALL ObtenerStockTotalDisponibleDeTodasLasSedes(?)");
        $stmt->bind_param("s", $codigo);
        $stmt->execute();
        $resultado = $stmt->get_result();
        CloseDB($context);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}

?>
<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function BuscarProducto($codigo)
{
    try {
        $conexion = OpenDB();
        $sp = "CALL FIDE_OBTENER_PRODUCTO_POR_CODIGO_SP('$codigo')";
        $resultado = $conexion->query($sp);
        $producto = null;

        if ($resultado && $resultado->num_rows > 0) {
            $producto = $resultado->fetch_assoc();
        }

        CloseDB($conexion);
        return $producto;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}

function EliminarProducto($codigo)
{
    try {
        $conexion = OpenDB();
        $sp = "CALL FIDE_PRODUCTO_ELIMINAR_SP('$codigo')";
        $conexion->query($sp);
        CloseDB($conexion);
    } catch (Exception $error) {
        RegistrarError($error);
    }
}
?>
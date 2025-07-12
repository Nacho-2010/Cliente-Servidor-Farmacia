<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function InsertarProducto($nombre, $codigo, $precio, $idCategoria, $idUnidad, $idEstado)
{
    try {
        $conexion = OpenDB();

        $sp = "CALL FIDE_PRODUCTO_INSERTAR_SP('$nombre', '$codigo', $precio, $idCategoria, $idUnidad, $idEstado)";
        $conexion->query($sp);

        CloseDB($conexion);
    } catch (Exception $error) {
        RegistrarError($error);
    }
}

function ObtenerCategoriasProducto()
{
    try {
        $conexion = OpenDB();
        $sql = "SELECT ID_CATEGORIA_PRODUCTO, NOMBRE FROM CATEGORIA_PRODUCTO_ACTIVA_V";
        $resultado = $conexion->query($sql);
        CloseDB($conexion);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}

function ObtenerUnidadesMedida()
{
    try {
        $conexion = OpenDB();
        $sql = "SELECT ID_UNIDAD_MEDIDA, NOMBRE FROM UNIDAD_MEDIDA_ACTIVA_V";
        $resultado = $conexion->query($sql);
        CloseDB($conexion);
        return $resultado;
    } catch (Exception $error) {
        RegistrarError($error);
        return null;
    }
}
?>
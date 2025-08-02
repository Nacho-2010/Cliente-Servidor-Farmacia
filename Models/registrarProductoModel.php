<?php
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Models/connect.php';

function InsertarProducto($nombre, $codigo, $precio, $idCategoria, $idUnidad, $idEstado, $urlImagen)
{
    try {
        $conexion = OpenDB();

        $sp = "CALL FIDE_PRODUCTO_INSERTAR_SP('$nombre', '$codigo', $precio, $idCategoria, $idUnidad, $idEstado,'$urlImagen')";
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
        $sp = "CALL FIDE_OBTENER_CATEGORIAS_SP()";
        //capturamos el resultado
        $resultado = $conexion->query($sp); 

        CloseDB($conexion);
        //devolvemos resultado para que se pueda usar
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
        $sp = "CALL FIDE_OBTENER_UNIDAD_MEDIDA_ACTIVA_SP()";
         //capturamos el resultado
        $resultado = $conexion->query($sp); 

        CloseDB($conexion);
        return $resultado;  
    } catch (Exception $error) {
        RegistrarError($error);
        return null; 
    }
}
?>
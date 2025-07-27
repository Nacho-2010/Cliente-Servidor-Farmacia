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
?>
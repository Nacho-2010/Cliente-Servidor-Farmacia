<?php

function validarInicioSesionModel($USUARIO, $CONTRASENA)
{


    // ABRIR BD
    $conexion = mysql_connect("127.0.0.1:3307", "root", "", "FARMACIABD");



    //INTERACTUAR CON BD



    // CERRAR BD
    mysql_close($conexion);



}


function registrarUsuarioModel($NOMBRE, $CORREO, $USUARIO, $CONTRASENA)
{

    // ABRIR BD
    $conexion = mysql_connect("127.0.0.1:3307", "root", "", "FARMACIABD");



    //INTERACTUAR CON BD



    // CERRAR BD
    mysql_close($conexion);

    


}

?>
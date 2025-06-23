<?php

    function OpenDB()
    {
        return mysqli_connect("127.0.0.1:3307","root","","FARMACIABD");
    }

    function CloseDB($conexion)
    {
        mysqli_close($conexion);
    }

    function RegistrarError($error)
    {
        $conexion = OpenDB();
           
        $message = mysqli_real_escape_string($conexion, $error -> getMessage());

        $sp = "CALL RegistrarError('$message')";
        $conexion -> query($sp);

        CloseDB($conexion);
    }

?>


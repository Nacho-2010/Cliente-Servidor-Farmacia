<?php
class GeneradorHash
{
    private $contrasenna;

    public function __construct($contrasenna)
    {
        $this->contrasenna = $contrasenna;
    }

    public function generarHash()
    {
        $hash = password_hash($this->contrasenna, PASSWORD_BCRYPT);
        echo "Hash generado para '{$this->contrasenna}':<br>$hash";
        return $hash;
    }
}

// meterse en esta direccion en el navegador para ver el resultado
// http://localhost:81/Cliente-Servidor-Farmacia/Utilidades/GeneradorHash.php

$miClave = "123";

$generador = new GeneradorHash($miClave);
$hashGenerado = $generador->generarHash();

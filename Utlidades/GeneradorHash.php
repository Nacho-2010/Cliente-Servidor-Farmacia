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


$miClave = "admin123";

$generador = new GeneradorHash($miClave);
$hashGenerado = $generador->generarHash();

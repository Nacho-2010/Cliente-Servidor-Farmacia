<?php

require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/PHPMailer/src/PHPMailer.php';
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/PHPMailer/src/SMTP.php';
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/PHPMailer/src/Exception.php';

function generarContrasena($longitud = 8) 
{
    $caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    $contrasena = '';
    for ($i = 0; $i < $longitud; $i++) {
        $indice = rand(0, strlen($caracteres) - 1);
        $contrasena .= $caracteres[$indice];
    }
    return $contrasena;
}

function EnviarCorreo($asunto, $contenido, $destinatario)
{
    $correoSalida = "nacugamer20@gmail.com";
    $contrasennaSalida = "cthildscsooaqsxv";

    $mail = new PHPMailer(true);

    try {
        $mail->CharSet = 'UTF-8';
        $mail->isSMTP();
        $mail->isHTML(true);
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPSecure = 'ssl';
        $mail->Port = 465;
        $mail->SMTPAuth = true;
        $mail->Username = $correoSalida;
        $mail->Password = $contrasennaSalida;

        $mail->SMTPOptions = [
            'ssl' => [
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true,
            ]
        ];

        $mail->setFrom($correoSalida, 'Soporte Farmacia');
        $mail->Subject = $asunto;
        $mail->MsgHTML($contenido);
        $mail->addAddress($destinatario);

        return $mail->send();
    } catch (Exception $e) {
        // log error si lo deseas
        return false;
    }
}

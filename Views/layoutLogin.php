<?php
// ==================== HEAD ====================
function añadirCSS()
{
  echo '
 
 <head>
    <meta charset="UTF-8">
    <title>Login y Registro</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../assets/Estilos/login.css">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
 
  ';
}
// ==================== SCRIPTS ====================
function añadirScripts()
{
  echo '
  <script src="../assets/Funciones/login.js"></script>
  ';
}
?>
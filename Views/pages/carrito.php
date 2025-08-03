<?php
// Incluye tu layout y controlador
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/productosController.php';

// Llamada al controlador para obtener los datos
$resultado = ConsultarProductos();
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>

<body>

  <?php
  verheader();
  sidebar();
  ?>


  <?php
  añadirScripts(); // Todos los scripts JS 
  ?>


</body>

</html>
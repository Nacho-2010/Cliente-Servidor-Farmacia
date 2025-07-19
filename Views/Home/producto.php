<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
?>

<!DOCTYPE html>
<html lang="es">

<?php
añadirCSS(); //<head> con CSS
?>

<body>

  <?php
  verheader();
  ?>

  <?php
  sidebar();
  ?>

  <main style="margin-left: 13%">

  </main>

  <?php

  verfooter();
  ?>

  <?php
  añadirScripts(); // Todos los scripts JS 
  ?>

</body>

</html>
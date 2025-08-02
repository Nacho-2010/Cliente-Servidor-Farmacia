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
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <?php
  // Capturar filtros si vienen por GET
  $filtroNombre = $_GET['producto'] ?? '';
  $filtroCategoria = $_GET['categoria'] ?? '';
  ?>
<!-- Buscador -->
<div class="search-bar" style="margin-left:13%; padding: 1rem;">
  <form action="" method="GET" class="search-group" style="display: flex; gap: 0.5rem; max-width: 800px;">
    <input type="text" name="producto" placeholder="Buscar producto..." value="<?= htmlspecialchars($filtroNombre) ?>" class="form-control">
    <select name="categoria" class="form-select">
      <option value="">Todas las categorías</option>
      <option value="Analgésico" <?= $filtroCategoria == "Analgésico" ? 'selected' : '' ?>>Analgésico</option>
      <option value="Antialérgico" <?= $filtroCategoria == "Antialérgico" ? 'selected' : '' ?>>Antialérgico</option>
      <option value="Ansiolítico" <?= $filtroCategoria == "Ansiolítico" ? 'selected' : '' ?>>Ansiolítico</option>
      <option value="Antihipertensivo" <?= $filtroCategoria == "Antihipertensivo" ? 'selected' : '' ?>>Antihipertensivo</option>
    </select>
    <button type="submit" class="btn btn-primary">Buscar</button>
  </form>
</div>
  <main style="margin-left:13%; padding: 2rem;">
   <!-- Productos -->
    <section class="menu">
      <div class="container-fluid">
                <div class="row">
                    <?php
                    while($fila = mysqli_fetch_array($resultado)) {
                        echo '<div class="col-lg-4 col-md-6 col-sm-12 mb-4">';
                        echo '    <div class="card h-100">';
                        echo '        <img class="card-img-top mt-3" src="' . $fila["URL_IMAGEN"] . '" alt="Imagen del producto" style="height: 200px; object-fit: contain;">';
                        echo '        <div class="card-body">';
                        echo '            <h5 class="card-title">' . $fila["NOMBRE"] . '</h5>';
                        echo '            <p class="card-text">' . $fila["CATEGORIA"] . '</p>';
                        echo '            <p class="card-text"><strong>₡' . number_format($fila["PRECIO_UNITARIO"], 2) . '</strong></p>';
                        echo '            <div class="mt-auto text-center">';
                        echo '                <button class="btn btn-primary" onclick="AgregarCarrito(' . $fila["CODIGO"] .')">Agregar al carrito</button>';
                        echo '            </div>';
                        echo '        </div>';
                        echo '    </div>';
                        echo '</div>';
                    }
                    ?>
                </div>
            </div>

        </div>

  </main>

  <?php verfooter(); ?>
  <?php añadirScripts(); ?>

  

</body>

</html>
<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/productosController.php';

// Capturar filtros si vienen por GET
$filtroNombre = isset($_GET['producto']) ? $_GET['producto'] : '';
$filtroCategoria = isset($_GET['categoria']) ? $_GET['categoria'] : '';

// Obtener listado de categorías desde SP
$categorias = ObtenerCategorias();

// Elegir qué procedimiento llamar
if (!empty($filtroNombre) || !empty($filtroCategoria)) {
    $resultado = ConsultarProductosFiltrados($filtroNombre, $filtroCategoria);
} else {
    $resultado = ConsultarProductos();
}
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>

<body>

<?php
verheader();
sidebar();
?>

<br><br><br><br><br><br>

<!-- Buscador -->
<div class="search-bar" style="margin-left:13%; padding: 1rem;">
  <form method="GET" class="search-group" style="display: flex; gap: 0.5rem; max-width: 800px;">
    <input type="text" name="producto" placeholder="Buscar producto..." value="<?= htmlspecialchars($filtroNombre) ?>" class="form-control">
    <select name="categoria" class="form-select">
      <option value="">Todas las categorías</option>
      <?php
      if ($categorias) {
        while ($cat = mysqli_fetch_assoc($categorias)) {
          $nombreCat = $cat["NOMBRE"];
          $selected = ($filtroCategoria == $nombreCat) ? 'selected' : '';
          echo "<option value=\"$nombreCat\" $selected>$nombreCat</option>";
        }
      }
      ?>
    </select>
    <button type="submit" class="btn btn-primary">Buscar</button>
  </form>
</div>

<main style="margin-left:13%; padding: 2rem;">
  <!-- Productos -->
  <section class="menu">
    <div class="container-fluid">
      <div class="row">
        <?php if ($resultado && mysqli_num_rows($resultado) > 0): ?>
          <?php while ($fila = mysqli_fetch_array($resultado)) { ?>
            <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
              <div class="card h-100">
                <img class="card-img-top mt-3" src="<?= $fila["URL_IMAGEN"] ?>" alt="Imagen del producto" style="height: 200px; object-fit: contain;">
                <div class="card-body">
                  <h5 class="card-title"><?= $fila["NOMBRE"] ?></h5>
                  <p class="card-text"><?= $fila["CATEGORIA"] ?></p>
                  <p class="card-text"><strong>₡<?= number_format($fila["PRECIO_UNITARIO"], 2) ?></strong></p>
                  <div class="mt-auto text-center">
                    <button class="btn btn-primary" onclick="AgregarCarrito('<?= $fila["CODIGO"] ?>')">Agregar al carrito</button>
                  </div>
                </div>
              </div>
            </div>
          <?php } ?>
        <?php else: ?>
          <div class="col-12 text-center">
            <div class="alert alert-warning">No se encontraron productos con ese filtro.</div>
          </div>
        <?php endif; ?>
      </div>
    </div>
  </section>
</main>

<?php verfooter(); ?>
<?php añadirScripts(); ?>

</body>
</html>
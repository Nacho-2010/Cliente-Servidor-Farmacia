<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Controllers/eliminarProductoController.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/layout.php";
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>
<head>
  <link rel="stylesheet" href="/Cliente-Servidor-Farmacia/Views/assets/Estilos/eliminarProductos.css">
</head>

<body>

<a href="/Cliente-Servidor-Farmacia/Views/Home/principal.php"
   class="btn btn-dark border-0 shadow-none boton-salir">
  Salir
</a>

<main class="main-content container mt-5">
  <h2 class="text-center mb-4">Eliminar Producto</h2>

  <?php if (isset($_GET["mensaje"])): ?>
    <div class="alert alert-success text-center">
      <?= htmlspecialchars($_GET["mensaje"]) ?>
    </div>
  <?php elseif (!empty($mensaje)): ?>
    <div class="alert alert-danger text-center">
      <?= htmlspecialchars($mensaje) ?>
    </div>
  <?php endif; ?>

  <form method="post" action="/Cliente-Servidor-Farmacia/Views/pages/eliminarProducto.php" class="mx-auto" style="max-width: 700px;">
    <div class="row g-3 align-items-end">
      <div class="col-md-6">
        <label for="txtCodigo" class="form-label">Código del Producto</label>
        <input type="text" id="txtCodigo" name="txtCodigo" class="form-control"
          value="<?= isset($_POST["txtCodigo"]) ? htmlspecialchars($_POST["txtCodigo"]) : '' ?>" required>
      </div>
      <div class="col-md-3 d-grid">
        <button type="submit" name="btnBuscarProducto" class="btn btn-primary border-0">
          <i class="fa-solid fa-magnifying-glass"></i> Buscar
        </button>
      </div>
      <div class="col-md-3 d-grid">
         <button type="submit" name="btnEliminarProducto" class="btn btn-danger border-0">
    <i class="fa-solid fa-trash"></i> Eliminar
  </button>
</div>
    </div>
  </form>

  <?php if ($producto): ?>
    <div class="card mx-auto mt-4" style="max-width: 700px; box-shadow: 0 0 25px rgba(0, 0, 0, 0.25);">
      <div class="card-body">
        <h5 class="card-title">Detalles del Producto</h5>
        <p><strong>Nombre:</strong> <?= htmlspecialchars($producto["NOMBRE"]) ?></p>
        <p><strong>Precio:</strong> ₡<?= number_format($producto["PRECIO_UNITARIO"], 2) ?></p>
      </div>
    </div>
  <?php endif; ?>
</main>
</body>
</html>
<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/productoModel.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/layout.php";

$categorias = ObtenerCategoriasProducto();
$unidades = ObtenerUnidadesMedida();
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>
<body>
 

  <main class="main-content container mt-5">
    <h2 class="text-center mb-4">Registrar Producto</h2>

    <?php if (isset($_GET["mensaje"])): ?>
      <div class="alert alert-success text-center">
        <?= htmlspecialchars($_GET["mensaje"]) ?>
      </div>
    <?php endif; ?>

    <form method="post" action="/Cliente-Servidor-Farmacia/Controllers/productoController.php" class="mx-auto" style="max-width: 600px;">
      <div class="mb-3">
        <label for="txtNombre" class="form-label">Nombre</label>
        <input type="text" id="txtNombre" name="txtNombre" class="form-control" required>
      </div>

      <div class="mb-3">
        <label for="txtCodigo" class="form-label">Código</label>
        <input type="text" id="txtCodigo" name="txtCodigo" class="form-control" required>
      </div>

      <div class="mb-3">
        <label for="txtPrecio" class="form-label">Precio Unitario</label>
        <input type="number" id="txtPrecio" name="txtPrecio" step="0.01" class="form-control" required>
      </div>

      <div class="mb-3">
        <label for="cmbCategoria" class="form-label">Categoría</label>
        <select id="cmbCategoria" name="cmbCategoria" class="form-select" required>
          <option value="">Seleccione una categoría</option>
          <?php while($cat = mysqli_fetch_array($categorias)): ?>
            <option value="<?= $cat["ID_CATEGORIA_PRODUCTO"] ?>">
              <?= htmlspecialchars($cat["NOMBRE"]) ?>
            </option>
          <?php endwhile; ?>
        </select>
      </div>

      <div class="mb-3">
        <label for="cmbUnidad" class="form-label">Unidad de Medida</label>
        <select id="cmbUnidad" name="cmbUnidad" class="form-select" required>
          <option value="">Seleccione una unidad</option>
          <?php while($uni = mysqli_fetch_array($unidades)): ?>
            <option value="<?= $uni["ID_UNIDAD_MEDIDA"] ?>">
              <?= htmlspecialchars($uni["NOMBRE"]) ?>
            </option>
          <?php endwhile; ?>
        </select>
      </div>

      <div class="text-center">
        <button type="submit" name="btnRegistrarProducto" class="btn btn-primary">Registrar Producto</button>
      </div>
    </form>
  </main>
</body>
</html>

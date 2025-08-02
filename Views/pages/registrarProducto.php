<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/registrarProductoModel.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/modificarProductoModel.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Controllers/eliminarProductoController.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/layout.php";


$categorias = ObtenerCategoriasProducto();
$unidades = ObtenerUnidadesMedida();
$productosActivos = ObtenerProductosActivosPorCodigo();
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>
<head>
  <link rel="stylesheet" href="/Cliente-Servidor-Farmacia/Views/assets/Estilos/gestionProductos.css">
  <style>
   
  </style>
</head>
<body>

<a href="/Cliente-Servidor-Farmacia/Views/Home/principal.php"
   class="btn btn-dark border-0 shadow-none boton-salir">
  Salir
</a>

<?php
  sidebar();
?>

<main class="main-content container mt-5">
  <h2 class="text-center mb-4">Gestión de Productos</h2>

  <!-- ====== Menú de opciones ====== -->
  <div class="menu-opciones">
    <button class="btn btn-success" onclick="mostrarSeccion('registrar')">
      Registrar Producto
    </button>
    <button class="btn btn-danger" onclick="mostrarSeccion('eliminar')">
      Eliminar Producto
    </button>
    <button class="btn  btn-primary" onclick="mostrarSeccion('modificar')">
      Modificar Producto
    </button>

  </div>

  <!-- ====== Sección Registrar ====== -->
  <section id="seccion-registrar" class="seccion-formulario">
    <h3 class="text-center mb-3">Registrar Producto</h3>
    <form method="post" action="/Cliente-Servidor-Farmacia/Controllers/registrarProductoController.php" class="mx-auto" style="max-width:600px;" enctype="multipart/form-data">
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
        <input type="number" id="txtPrecio" name="txtPrecio" step="50" class="form-control" required>
      </div>
      <div class="mb-3">
        <label for="cmbCategoria" class="form-label">Categoría</label>
        <select id="cmbCategoria" name="cmbCategoria" class="form-select" required>
          <option value="">Seleccione una categoría</option>
          <?php while ($cat = mysqli_fetch_array($categorias)): ?>
            <option value="<?= $cat["ID_CATEGORIA_PRODUCTO"] ?>"><?= htmlspecialchars($cat["NOMBRE"]) ?></option>
          <?php endwhile; ?>
        </select>
      </div>
      <div class="mb-3">
        <label for="cmbUnidad" class="form-label">Unidad de Medida</label>
        <select id="cmbUnidad" name="cmbUnidad" class="form-select" required>
          <option value="">Seleccione una unidad</option>
          <?php while ($uni = mysqli_fetch_array($unidades)): ?>
            <option value="<?= $uni["ID_UNIDAD_MEDIDA"] ?>"><?= htmlspecialchars($uni["NOMBRE"]) ?></option>
          <?php endwhile; ?>
        </select>
      </div>
      <!-- Imagen -->
      <div class="mb-3">
        <label for="txtImagen" class="form-label">Imagen (formato PNG)</label>
        <input type="file" id="txtImagen" name="txtImagen" accept="image/png" class="form-control" required>
      </div>
      <div class="text-center">
        <button type="submit" name="btnRegistrarProducto" class="btn btn-primary">Registrar Producto</button>
      </div>
    </form>
  </section>

  <!-- ====== Sección Eliminar ====== -->
  <section id="seccion-eliminar" class="seccion-formulario">
    <h3 class="text-center mb-3">Eliminar Producto</h3>
    <form method="post" action="/Cliente-Servidor-Farmacia/Views/pages/eliminarProducto.php" class="mx-auto" style="max-width:700px;">
      <div class="row g-3 align-items-end">
        <div class="col-md-6">
          <label for="txtCodigoEliminar" class="form-label">Código del Producto</label>
          <input type="text" id="txtCodigoEliminar" name="txtCodigo" class="form-control"
                 value="<?= isset($_POST["txtCodigo"]) ? htmlspecialchars($_POST["txtCodigo"]) : '' ?>" required>
        </div>
        <div class="col-md-3 d-grid">
          <button type="submit" name="btnBuscarProducto" class="btn btn-primary">
            <i class="fa-solid fa-magnifying-glass"></i> Buscar
          </button>
        </div>
        <div class="col-md-3 d-grid">
          <button type="submit" name="btnEliminarProducto" class="btn btn-danger">
            <i class="fa-solid fa-trash"></i> Eliminar
          </button>
        </div>
      </div>
    </form>

    <?php if (!empty($producto)): ?>
      <div class="card mx-auto mt-4" style="max-width: 700px; box-shadow: 0 0 25px rgba(0, 0, 0, 0.25);">
        <div class="card-body">
          <h5 class="card-title">Detalles del Producto</h5>
          <p><strong>Nombre:</strong> <?= htmlspecialchars($producto["NOMBRE"]) ?></p>
          <p><strong>Precio:</strong> ₡<?= number_format($producto["PRECIO_UNITARIO"], 2) ?></p>
        </div>
      </div>
    <?php endif; ?>
  </section>

  <section id="seccion-modificar" class="seccion-formulario">
  <h3 class="text-center mb-3">Modificar Producto</h3>
  <form method="post" action="/Cliente-Servidor-Farmacia/Controllers/modificarProductoController.php" class="mx-auto" style="max-width:600px;" enctype="multipart/form-data">

    <!-- Seleccionar el producto por código -->
    <div class="mb-3">
      <label for="cmbProducto" class="form-label">Seleccione Producto (Código)</label>
      <select id="cmbProducto" name="cmbProducto" class="form-select" required>
        <option value="">Seleccione un producto</option>
        <?php while ($prod = mysqli_fetch_array($productosActivos)): ?>
          <option value="<?= $prod["CODIGO"] ?>"><?= htmlspecialchars($prod["CODIGO"]) ?> - <?= htmlspecialchars($prod["NOMBRE"]) ?>
          </option>
        <?php endwhile; ?>
      </select>
    </div>

    <!-- Seccion modificar -->
    <div class="mb-3">
      <label for="txtNombreNuevo" class="form-label">Nuevo Nombre</label>
      <input type="text" id="txtNombreNuevo" name="txtNombreNuevo" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="txtPrecioNuevo" class="form-label">Nuevo Precio Unitario</label>
      <input type="number" id="txtPrecioNuevo" name="txtPrecioNuevo" step="50" class="form-control" required>
    </div>

   <div class="mb-3">
  <label for="cmbCategoriaNueva" class="form-label">Nueva Categoría</label>
  <select id="cmbCategoriaNueva" name="cmbCategoriaNueva" class="form-select" required>
    <option value="">Seleccione una categoría</option>
    <?php mysqli_data_seek($categorias, 0); ?>
    <?php while ($cat = mysqli_fetch_array($categorias)): ?>
        <option value="<?= $cat["ID_CATEGORIA_PRODUCTO"] ?>"><?= htmlspecialchars($cat["NOMBRE"]) ?></option>
    <?php endwhile; ?>
  </select>
</div>

    <div class="mb-3">
      <label for="cmbUnidadNueva" class="form-label">Nueva Unidad de Medida</label>
      <select id="cmbUnidadNueva" name="cmbUnidadNueva" class="form-select" required>
        <option value="">Seleccione una unidad</option>
        <?php mysqli_data_seek($unidades, 0); ?>
        <?php while ($uni = mysqli_fetch_array($unidades)): ?>
          <option value="<?= $uni["ID_UNIDAD_MEDIDA"] ?>"><?= htmlspecialchars($uni["NOMBRE"]) ?>
          </option>
        <?php endwhile; ?>
      </select>
    </div>

    <div class="mb-3">
      <label for="txtImagen" class="form-label">Nueva Imagen (opcional, formato PNG)</label>
      <input type="file" id="txtImagen" name="txtImagen" accept="image/png" class="form-control">
    </div>

    <div class="text-center">
      <button type="submit" name="btnModificarProducto" class="btn btn-primary text-white">
        Modificar Producto
      </button>
    </div>
  </form>
</section>



</main>

<script src="../assets/Funciones/gestionarProductos.js"></script>

</body>
</html>

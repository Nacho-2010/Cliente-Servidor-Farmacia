<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/carritoController.php';

// Asegúrate de que el usuario haya iniciado sesión
session_start();
if (!isset($_SESSION["ID"])) {
  header("Location: /Cliente-Servidor-Farmacia/Views/Login/login.php");
  exit();
}

$idUsuario = $_SESSION["ID"];
$carrito = ObtenerCarrito($idUsuario);
$total = 0;
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>
<body>

<?php
verheader();
sidebar();
?>

<main style="margin-left: 13%; padding: 2rem;">
  <h2 class="mb-4">🛒 Mi Carrito</h2>

  <?php if (empty($carrito)): ?>
    <div class="alert alert-info">Tu carrito está vacío.</div>
  <?php else: ?>
    <div class="table-responsive">
      <table class="table table-bordered table-striped align-middle">
        <thead class="table-dark text-center">
          <tr>
            <th>Producto</th>
            <th>Imagen</th>
            <th>Precio Unitario</th>
            <th>Cantidad</th>
            <th>Total</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody class="text-center">
          <?php foreach ($carrito as $item): 
            $subtotal = $item["CANTIDAD"] * $item["PRECIO_UNITARIO"];
            $total += $subtotal;
          ?>
            <tr>
              <td><?= $item["NOMBRE"] ?></td>
              <td><img src="<?= $item["URL_IMAGEN"] ?>" alt="imagen" width="60" height="60" style="object-fit: contain;"></td>
              <td>₡<?= number_format($item["PRECIO_UNITARIO"], 2) ?></td>
              <td>
                <input type="number" min="1" value="<?= $item["CANTIDAD"] ?>" 
                       onchange="actualizarCantidad(<?= $item['ID_DETALLE'] ?>, this.value)"
                       class="form-control text-center" style="width:80px;">
              </td>
              <td>₡<?= number_format($subtotal, 2) ?></td>
              <td>
                <button class="btn btn-danger btn-sm" onclick="quitarProducto(<?= $item['ID_DETALLE'] ?>)">
                  🗑 Quitar
                </button>
              </td>
            </tr>
          <?php endforeach; ?>
        </tbody>
        <tfoot class="text-end">
          <tr>
            <td colspan="4"><strong>Total:</strong></td>
            <td colspan="2"><strong>₡<?= number_format($total, 2) ?></strong></td>
          </tr>
        </tfoot>
      </table>
    </div>

    <div class="text-end mt-3">
      <button class="btn btn-success" onclick="procesarCompra()">Finalizar compra</button>
    </div>
  <?php endif; ?>
</main>

<?php verfooter(); ?>
<?php añadirScripts(); ?>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/Cliente-Servidor-Farmacia/Views/assets/Funciones/carrito.js"></script>

</body>
</html>
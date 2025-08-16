<?php
session_start();
require_once __DIR__ . '/../layout.php';
require_once __DIR__ . '/../../Controllers/dashboardController.php';

// Si tu app requiere login:
if (!isset($_SESSION["ID"])) {
  header("Location: /Cliente-Servidor-Farmacia/Views/Login/login.php");
  exit();
}

$topProd = ConsultarProductosTop(8);   // array o mysqli_result según tu controller/model
$topCli  = ConsultarClientesTop(8);
$resumen = ConsultarResumenTop();
?>
<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>
<body>

<?php verheader(); sidebar(); ?>

<main style="margin-left: 13%; padding: 2rem; margin-top: 80px;">
  <h2 class="mb-4">📊 Dashboard</h2>

  <div class="card-group mb-4">
    <div class="card"><div class="card-body d-flex justify-content-between">
      <div><i class="mdi mdi-account-check"></i><p>Clientes Activos</p></div>
      <h3><?= (int)$resumen["ClientesActivos"] ?></h3>
    </div></div>
    <div class="card"><div class="card-body d-flex justify-content-between">
      <div><i class="mdi mdi-account-off"></i><p>Clientes Inactivos</p></div>
      <h3><?= (int)$resumen["ClientesInactivos"] ?></h3>
    </div></div>
    <div class="card"><div class="card-body d-flex justify-content-between">
      <div><i class="mdi mdi-pill"></i><p>Productos Activos</p></div>
      <h3><?= (int)$resumen["ProductosActivos"] ?></h3>
    </div></div>
    <div class="card"><div class="card-body d-flex justify-content-between">
      <div><i class="mdi mdi-pill-off"></i><p>Productos Inactivos</p></div>
      <h3><?= (int)$resumen["ProductosInactivos"] ?></h3>
    </div></div>
  </div>

  <div class="row">
    <div class="col-lg-6">
      <div class="card"><div class="card-body">
        <h4>Top Productos</h4>
        <div class="table-responsive">
          <table class="table table-hover">
            <thead><tr><th>ID</th><th>Producto</th><th>Precio</th><th>Total</th></tr></thead>
            <tbody>
            <?php if (!empty($topProd)) {
              // si $topProd es mysqli_result
              if ($topProd instanceof mysqli_result) { while($r = $topProd->fetch_assoc()) { ?>
                <tr>
                  <td><?= $r["IdProducto"] ?></td>
                  <td><?= htmlspecialchars($r["Nombre"]) ?></td>
                  <td>₡ <?= number_format((float)$r["Precio"],2) ?></td>
                  <td>₡ <?= number_format((float)$r["Total"],2) ?></td>
                </tr>
            <?php } } else { foreach ($topProd as $r) { ?>
                <tr>
                  <td><?= $r["IdProducto"] ?></td>
                  <td><?= htmlspecialchars($r["Nombre"]) ?></td>
                  <td>₡ <?= number_format((float)$r["Precio"],2) ?></td>
                  <td>₡ <?= number_format((float)$r["Total"],2) ?></td>
                </tr>
            <?php } } } else { ?>
                <tr><td colspan="4" class="text-center text-muted">Sin datos.</td></tr>
            <?php } ?>
            </tbody>
          </table>
        </div>
      </div></div>
    </div>

    <div class="col-lg-6">
      <div class="card"><div class="card-body">
        <h4>Top Clientes</h4>
        <div class="table-responsive">
          <table class="table table-hover">
            <thead><tr><th>Cédula</th><th>Nombre</th><th>Monto</th><th># Facturas</th></tr></thead>
            <tbody>
            <?php if (!empty($topCli)) {
              if ($topCli instanceof mysqli_result) { while($c = $topCli->fetch_assoc()) { ?>
                <tr>
                  <td><?= htmlspecialchars($c["Identificacion"]) ?></td>
                  <td><?= htmlspecialchars($c["Nombre"]) ?></td>
                  <td>₡ <?= number_format((float)$c["Total"],2) ?></td>
                  <td><?= (int)$c["Cantidad"] ?></td>
                </tr>
            <?php } } else { foreach ($topCli as $c) { ?>
                <tr>
                  <td><?= htmlspecialchars($c["Identificacion"]) ?></td>
                  <td><?= htmlspecialchars($c["Nombre"]) ?></td>
                  <td>₡ <?= number_format((float)$c["Total"],2) ?></td>
                  <td><?= (int)$c["Cantidad"] ?></td>
                </tr>
            <?php } } } else { ?>
                <tr><td colspan="4" class="text-center text-muted">Sin datos.</td></tr>
            <?php } ?>
            </tbody>
          </table>
        </div>
      </div></div>
    </div>
  </div>
</main>

<?php verfooter(); ?>
<?php añadirScripts(); ?>
</body>
</html>

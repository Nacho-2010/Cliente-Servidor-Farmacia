<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/carritoController.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$resultado = ConsultarCarrito();
$totalSesion = isset($_SESSION["Total"]) ? (float) $_SESSION["Total"] : 0.00;
?>
<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>

<body>

    <?php verheader(); ?>
    <?php sidebar(); ?>

    <main style="margin-left: 11%">
        <section class="menu">
            <div class="menu__container">

                <h2 class="menu__title">Mi Carrito</h2>

                <div class="card">
                    <div class="card-body">

                        <?php if (isset($_POST["txtMensaje"])): ?>
                            <div class="alert alert-warning text-center"><?= $_POST["txtMensaje"] ?></div>
                        <?php endif; ?>

                        <div class="table-responsive">
                            <table id="tablaDatos" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Nombre</th>
                                        <th>Cantidad</th>
                                        <th>Precio</th>
                                        <th>SubTotal</th>
                                        <th>Impuesto</th>
                                        <th>Total</th>
                                        <th>Fecha</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if ($resultado && mysqli_num_rows($resultado) > 0): ?>
                                        <?php while ($fila = mysqli_fetch_array($resultado)): ?>
                                            <tr>
                                                <td><?= $fila["IdCarrito"] ?></td>
                                                <td><?= htmlspecialchars($fila["Nombre"]) ?></td>
                                                <td><?= (int) $fila["Cantidad"] ?></td>
                                                <td>$ <?= number_format((float) $fila["Precio"], 2) ?></td>
                                                <td>$ <?= number_format((float) $fila["SubTotal"], 2) ?></td>
                                                <td>$ <?= number_format((float) $fila["Impuesto"], 2) ?></td>
                                                <td>$ <?= number_format((float) $fila["Total"], 2) ?></td>
                                                <td><?= $fila["FechaCarrito"] ?></td>
                                                <td>
                                                    <a href="#" class="btn btnEliminar" 
                                                        data-id="<?= $fila["IdProducto"] ?>" 
                                                        title="Eliminar">
                                                        <i class="fa fa-trash" style="font-size:1.5em;"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        <?php endwhile; ?>
                                    <?php else: ?>
                                        <tr>
                                            <td colspan="9" class="text-center text-muted">Tu carrito está vacío.</td>
                                        </tr>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>

                        <div class="row mt-4 align-items-center">
                            <div class="col-md-6">
                                <p class="mt-2" style="font-size:12pt">
                                    El monto a cancelar es de: <b>$ <?= number_format($totalSesion, 2) ?></b>
                                </p>
                            </div>
                            <div class="col-md-6 text-md-right">
                                <?php if ($totalSesion > 0): ?>
                                    <input type="button" onclick="ProcesarPago();" class="btn btn-primary"
                                        value="Procesar Pago">
                                <?php endif; ?>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </section>
    </main>

    <?php verfooter(); ?>

    <!-- Modal Gracias -->
    <div class="modal fade" id="modalGracias" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center">
          <div class="modal-header bg-success text-white">
            <h5 class="modal-title w-100">¡Gracias por su compra!</h5>
          </div>
          <div class="modal-body">
            <i class="fa fa-check-circle" style="font-size:4em; color:green;"></i>
            <p class="mt-3" style="font-size: 16pt;">Su pago fue procesado con éxito.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary w-100" data-bs-dismiss="modal">Aceptar</button>
          </div>
        </div>
      </div>
    </div>

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS (para que funcione el modal) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <?php añadirScripts(); ?>
    <script>
        $(function () {
            if (typeof DataTable !== 'undefined') {
                new DataTable('#tablaDatos', {
                    language: { url: 'https://cdn.datatables.net/plug-ins/2.3.2/i18n/es-ES.json' },
                });
            }

            $(document).on('click', '.btnEliminar', function (e) {
                e.preventDefault();
                const idProducto = $(this).data('id');
                if (!idProducto) { alert('Sin identificador de producto'); return; }
                EliminarProductoCarrito(idProducto);
            });
        });

        function EliminarProductoCarrito(idProducto) {
            $.ajax({
                url: "../../Controllers/carritoController.php",
                type: "POST",
                dataType: 'text',
                data: { Accion: "EliminarDelCarrito", IdProducto: idProducto },
                success: function (response) {
                    if ((response || '').trim() === "OK") {
                        window.location.reload();
                    } else {
                        alert(response);
                    }
                },
                error: function (xhr) {
                    alert("Error eliminando el producto: " + xhr.status + " " + xhr.statusText);
                }
            });
        }

        function ProcesarPago() {
            $.ajax({
                url: "../../Controllers/carritoController.php",
                type: "POST",
                dataType: 'text',
                data: { Accion: "ProcesarPagoCarrito" },
                success: function (response) {
                    if ((response || '').trim() === "OK") {
                        // Mostrar modal en vez de mostrar "OK"
                        var modal = new bootstrap.Modal(document.getElementById('modalGracias'));
                        modal.show();

                        // Opcional: limpiar carrito o redirigir después de 3 seg.
                        setTimeout(() => { window.location.href = "/Cliente-Servidor-Farmacia/Views/Home/principal.php"; }, 3000);
                    } else {
                        alert(response);
                    }
                }
            });
        }
    </script>
</body>
</html>
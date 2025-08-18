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

    <!-- Usamos el mismo patrón de Home: main con margin-left -->
    <main style="margin-left: 11%">

        <!-- Sección contenedora estilo "menu" de tu Home -->
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
                                                    <a class="btn btnAbrirModal" data-toggle="modal"
                                                        data-target="#EliminarProductoCarrito"
                                                        data-id="<?= $fila["IdProducto"] ?>"
                                                        data-nombre="<?= htmlspecialchars($fila["Nombre"]) ?>">
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

        <!-- Modal de confirmación -->
        <div class="modal fade" id="EliminarProductoCarrito" tabindex="-1" role="dialog" aria-labelledby="tituloModal"
            aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="tituloModal">Confirmación</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <input type="hidden" id="IdProducto" name="IdProducto" class="form-control">
                        <label id="lblNombre" name="lblNombre"></label>
                    </div>

                    <div class="modal-footer">
                        <button type="button" id="btnEliminarProductoCarrito" name="btnEliminarProductoCarrito"
                            class="btn btn-primary" onclick="EliminarProductoCarrito($('#IdProducto').val())">
                            Procesar
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </main>

    <!-- Footer fuera del main, como en tu Home -->
    <?php verfooter(); ?>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <?php añadirScripts(); ?>
    <script>
        $(function () {
            new DataTable('#tablaDatos', {
                language: { url: 'https://cdn.datatables.net/plug-ins/2.3.2/i18n/es-ES.json' },
            });

            $('.btnAbrirModal').on('click', function () {
                const id = $(this).data('id');
                const nombre = $(this).data('nombre');

                $('#IdProducto').val(id);
                $('#lblNombre').text("¿Desea eliminar el producto " + nombre + " del carrito?");
            });
        });

        function EliminarProductoCarrito(idProducto) {
            $.ajax({
                url: "../../Controllers/carritoController.php",
                type: "POST",
                dataType: 'text',
                data: { Accion: "EliminarProductoCarrito", IdProducto: idProducto },
                success: function (response) {
                    if (response === "OK") { window.location.reload(); }
                    else { alert(response); }
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
                    if (response === "OK") { window.location.reload(); }
                    else { alert(response); }
                }
            });
        }
    </script>
</body>

</html>
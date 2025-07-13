<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/MovimientoModel.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/layout.php";

$id_farmacia = ObtenerFarmaciasActivas();
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>

<body>
    <?php verheader(); ?>
    <?php sidebar(); ?>

    <main class="main-kardex">
        <section class="kardex-container">

            <!-- Formulario de búsqueda por código -->
            <div class="formulario-kardex">
                <h2>Consultar Producto</h2>
                <form method="POST" action="../../Controllers/MovimientoController.php" class="form-movimiento">
                    <input type="text" name="txtCodigo" placeholder="Código del producto" required>
                    <button type="submit" name="btnBuscarProducto">Buscar</button>
                </form>
            </div>

            <?php if (isset($_SESSION["CODIGO_BUSCADO"])): ?>
                <div class="formulario-kardex">
                    <h3>Producto: <?= $_SESSION["CODIGO_BUSCADO"] ?></h3>
                    <p><strong>Cantidad Disponible:</strong> <?= $_SESSION["CANT_DISPONIBLE"] ?? 'No disponible' ?></p>

                    <!-- Formulario de movimiento -->
                    <h2>Registrar Movimiento</h2>
                    <form method="POST" action="../../Controllers/MovimientoController.php" class="form-movimiento">
                        <input type="text" name="txtCodigo" value="<?= $_SESSION["CODIGO_BUSCADO"] ?>" readonly>
                        <input type="text" name="txtLote" placeholder="Número de lote" required>
                        <input type="date" name="txtFechaVencimiento" required>
                        <input type="date" name="txtFecha" required>

                        <select name="ddlTipo" required>
                            <option value="">Seleccione tipo</option>
                            <option value="Entrada">Entrada</option>
                            <option value="Salida">Salida</option>
                        </select>

                        <input type="number" name="txtCantidad" placeholder="Cantidad" required>
                        <input type="text" name="txtDescripcion" placeholder="Descripción">

                        <label><input type="checkbox" name="chkEmpresa" id="chkEmpresa"> Incluir Empresa</label>
                        <input type="text" name="txtEmpresa" id="txtEmpresa" placeholder="Empresa" disabled>

                        <select name="ddlFarmacia" required>
                            <option value="">Seleccione una farmacia</option>
                            <?php foreach ($id_farmacia as $FARM): ?>
                                <option value="<?= $FARM["ID_FARMACIA"] ?>">
                                    <?= htmlspecialchars($FARM["NOMBRE"]) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>


                        <button type="submit" name="btnRegistrarMovimiento">Registrar</button>
                    </form>

                    <?php if (isset($_SESSION["txtMensaje"])): ?>
                        <div class="mensaje-sistema">
                            <?= $_SESSION["txtMensaje"];
                            unset($_SESSION["txtMensaje"]); ?>
                        </div>
                    <?php endif; ?>
                </div>

                <!-- Historial dinámico -->
                <?php if (!empty($_SESSION["MOVIMIENTOS"])): ?>
                    <div class="historial-kardex">
                        <h2>Historial de Movimientos</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Tipo</th>
                                    <th>Cantidad</th>
                                    <th>Saldo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($_SESSION["MOVIMIENTOS"] as $mov): ?>
                                    <tr>
                                        <td><?= $mov["FECHA_MOVIMIENTO"] ?></td>
                                        <td><?= $mov["TIPO_MOVIMIENTO"] ?></td>
                                        <td><?= ($mov["TIPO_MOVIMIENTO"] === 'Entrada' ? '+' : '-') . $mov["CANTIDAD"] ?></td>
                                        <td><?= $mov["SALDO"] ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php endif; ?>
            <?php endif; ?>
        </section>
    </main>

    <script>
        document.getElementById('chkEmpresa')?.addEventListener('change', function () {
            document.getElementById('txtEmpresa').disabled = !this.checked;
        });
    </script>
</body>

</html>
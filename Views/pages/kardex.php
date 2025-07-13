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

                    <select name="ddlFarmaciaBuscar" required>
                        <option value="">Seleccione una farmacia</option>
                        <?php foreach ($id_farmacia as $FARM): ?>
                            <option value="<?= $FARM["ID_FARMACIA"] ?>">
                                <?= htmlspecialchars($FARM["NOMBRE"]) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>

                    <button type="submit" name="btnBuscarProducto">Buscar</button>
                </form>
            </div>

            <?php if (isset($_SESSION["CODIGO_BUSCADO"])): ?>
                <div class="formulario-kardex">
                    <div class="info-producto">
                        <h3><?= $_SESSION["NOMBRE_PRODUCTO"] ?? "Producto Desconocido" ?></h3>
                        <p><strong>Unidad de medida:</strong> <?= $_SESSION["UNIDAD_MEDIDA"] ?? "No definida" ?></p>
                        <p><strong>Código:</strong> <?= $_SESSION["CODIGO_BUSCADO"] ?></p>
                        <p><strong>Stock disponible:</strong> <?= $_SESSION["CANT_DISPONIBLE"] ?? 'No disponible' ?></p>
                        <p><strong>Farmacia:</strong>
                            <?php
                            $idFarm = $_SESSION["FARMACIA_BUSCADA"] ?? null;
                            $nombreFarm = "No definida";
                            foreach ($id_farmacia as $farm) {
                                if ($farm["ID_FARMACIA"] == $idFarm) {
                                    $nombreFarm = $farm["NOMBRE"];
                                    break;
                                }
                            }
                            echo $nombreFarm;
                            ?>
                        </p>
                    </div>

                    <!-- Formulario de movimiento -->
                    <h2>Registrar Movimiento Ingreso</h2>
                    <form method="POST" action="../../Controllers/MovimientoController.php" class="form-movimiento">
                        <input type="text" name="txtCodigo" value="<?= $_SESSION["CODIGO_BUSCADO"] ?>" readonly>
                        <input type="text" name="txtLote" placeholder="Número de lote" required>
                        <h4>Ingrese fecha de vencimiento del producto</h4>
                        <input type="date" name="txtFechaVencimiento" required>
                        <h4>Ingrese fecha de movimiento</h4>
                        <input type="date" name="txtFecha" required>

                        <select name="ddlTipo" required>
                            <option value="">Seleccione tipo</option>
                            <option value="Entrada">Entrada</option>
                            <option value="Salida">Salida</option>
                        </select>

                        <input type="number" name="txtCantidad" placeholder="Cantidad" required>

                        <label>
                            <input type="checkbox" id="chkDescripcion" data-target="txtDescripcion"> Incluir descripción
                        </label>
                        <input type="text" id="txtDescripcion" name="txtDescripcion" placeholder="Descripción" disabled>

                        <label>
                            <input type="checkbox" id="chkEmpresa" name="chkEmpresa" data-target="txtEmpresa"> Incluir
                            Empresa
                        </label>
                        <input type="text" id="txtEmpresa" name="txtEmpresa" placeholder="Empresa" disabled>

                        <select name="ddlFarmacia" required>
                            <option value="">Seleccione una farmacia</option>
                            <?php foreach ($id_farmacia as $FARM): ?>
                                <option value="<?= $FARM["ID_FARMACIA"] ?>"
                                    <?= ($FARM["ID_FARMACIA"] == ($_SESSION["FARMACIA_BUSCADA"] ?? '')) ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($FARM["NOMBRE"]) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>

                        <button type="submit" name="btnRegistrarMovimiento">Registrar</button>
                    </form>

                    <!-- Formulario para salida automática por lotes -->
                    <h2>Salida Automática por Lotes</h2>
                    <form method="POST" action="../../Controllers/MovimientoController.php" class="form-movimiento">
                        <input type="text" name="txtCodigo" value="<?= $_SESSION["CODIGO_BUSCADO"] ?>" readonly>

                        <h4>Ingrese la cantidad que desea retirar</h4>
                        <input type="number" name="txtCantidad" placeholder="Cantidad total a retirar" required>

                        <h4>Ingrese fecha de movimiento</h4>
                        <input type="date" name="txtFecha" required>

                        <label>
                            <input type="checkbox" id="chkDescripcionLotes" data-target="txtDescripcionLotes">
                            Incluir descripción
                        </label>
                        <input type="text" id="txtDescripcionLotes" name="txtDescripcion" placeholder="Descripción"
                            disabled>

                        <label>
                            <input type="checkbox" id="chkEmpresaLotes" name="chkEmpresa" data-target="txtEmpresaLotes">
                            Incluir empresa
                        </label>
                        <input type="text" id="txtEmpresaLotes" name="txtEmpresa" placeholder="Empresa" disabled>

                        <input type="hidden" name="ddlFarmaciaBuscar" value="<?= $_SESSION["FARMACIA_BUSCADA"] ?>">

                        <button type="submit" name="btnSeleccionarLotes" class="btn btn-warning">
                            Seleccionar lotes disponibles
                        </button>
                    </form>





                    <?php if (isset($_SESSION["txtMensaje"])): ?>
                        <div class="mensaje-sistema">
                            <?= $_SESSION["txtMensaje"];
                            unset($_SESSION["txtMensaje"]); ?>
                        </div>
                    <?php endif; ?>
                </div>

                <!-- Historial dinámico -->
                <?php
                $historial = $_SESSION["MOVIMIENTOS"] ?? [];
                ?>
                <?php if (!empty($historial)): ?>
                    <div class="historial-kardex">
                        <h2>Historial de Movimientos</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Tipo</th>
                                    <th>Cantidad</th>
                                    <th>Lotes Afectados</th>
                                    <th>Saldo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($historial as $mov): ?>
                                    <tr>
                                        <td><?= $mov["FECHA_MOVIMIENTO"] ?></td>
                                        <td><?= $mov["TIPO_MOVIMIENTO"] ?></td>
                                        <td><?= $mov["CANTIDAD"] ?></td>
                                        <td><?= $mov["LOTES_AFECTADOS"] ?? '-' ?></td>
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
        document.querySelectorAll('input[type="checkbox"][data-target]').forEach(function (checkbox) {
            checkbox.addEventListener('change', function () {
                const targetId = this.getAttribute('data-target');
                const targetInput = document.getElementById(targetId);
                if (targetInput) {
                    targetInput.disabled = !this.checked;
                }
            });
        });
    </script>
</body>

</html>
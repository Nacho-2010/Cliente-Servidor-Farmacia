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
    <br><br><br>

    <main class="main-kardex">
        <section class="kardex-container">
            <br>
            <br>
            <!-- BOTÓN PARA MOSTRAR/OCULTAR CONSULTA -->
            <div style="margin: 10px 50px;">
                <button onclick="toggleConsulta()" id="consultaProductoToggle" class="btn btn-info">
                    🔍 Consultar Producto
                </button>

            </div>

            <!-- COLUMNA DE CONSULTA PRODUCTO -->
            <div id="consultaProducto" class="formulario-kardex" style="display: none;">
                <h2>Consultar Producto</h2>
                <form method="POST" action="../../Controllers/MovimientoController.php" class="form-movimiento">
                    <input type="text" name="txtCodigo" placeholder="Código del producto" required>
                    <select name="ddlFarmaciaBuscar" required>
                        <option value="">Seleccione una farmacia</option>
                        <?php foreach ($id_farmacia as $FARM): ?>
                            <option value="<?= $FARM["ID_FARMACIA"] ?>"><?= htmlspecialchars($FARM["NOMBRE"]) ?></option>
                        <?php endforeach; ?>
                    </select>
                    <button type="submit" name="btnBuscarProducto">Buscar</button>
                </form>
            </div>

            <!-- INFORMACIÓN Y FORMULARIOS -->
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

                    <!-- FORMULARIO DE INGRESO -->
                    <h2>Registrar Ingreso</h2>
                    <form method="POST" action="../../Controllers/MovimientoController.php" class="form-movimiento">
                        <input type="text" name="txtCodigo" value="<?= $_SESSION["CODIGO_BUSCADO"] ?>" readonly>
                        <input type="text" name="txtLote" placeholder="Número de lote" required>
                        <h4>Fecha del movimiento</h4>
                        <input type="date" name="txtFecha" required max="<?= date('Y-m-d') ?>">
                        <h4>Fecha de vencimiento</h4>
                        <input type="date" name="txtFechaVencimiento" required>
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
                        <button type="submit" name="btnRegistrarMovimiento" class="btn btn-registrar">Registrar</button>
                    </form>

                    <!-- SALIDA AUTOMÁTICA -->
                    <h2>Salida Automática por Lotes</h2>
                    <form method="POST" action="../../Controllers/MovimientoController.php" class="form-movimiento">
                        <input type="text" name="txtCodigo" value="<?= $_SESSION["CODIGO_BUSCADO"] ?>" readonly>
                        <h4>Cantidad total a retirar</h4>
                        <input type="number" name="txtCantidad" placeholder="Cantidad" required>

                        <label>
                            <input type="checkbox" id="chkDescripcionLotes" data-target="txtDescripcionLotes"> Incluir
                            descripción
                        </label>
                        <input type="text" id="txtDescripcionLotes" name="txtDescripcion" placeholder="Descripción"
                            disabled>

                        <label>
                            <input type="checkbox" id="chkEmpresaLotes" name="chkEmpresa" data-target="txtEmpresaLotes">
                            Incluir empresa
                        </label>
                        <input type="text" id="txtEmpresaLotes" name="txtEmpresa" placeholder="Empresa" disabled>

                        <input type="hidden" name="ddlFarmaciaBuscar" value="<?= $_SESSION["FARMACIA_BUSCADA"] ?>">

                        <button type="submit" name="btnSeleccionarLotes" class="btn btn-warning">Seleccionar lotes
                            disponibles</button>
                    </form>

                    <!-- MENSAJE DEL SISTEMA -->
                    <?php if (isset($_SESSION["txtMensaje"])): ?>
                        <div class="mensaje-sistema">
                            <?= $_SESSION["txtMensaje"];
                            unset($_SESSION["txtMensaje"]); ?>
                        </div>
                    <?php endif; ?>
                </div>
            <?php endif; ?>

            <!-- HISTORIAL DE MOVIMIENTOS -->
            <?php
            $paginaActual = $_SESSION["PAGINA_ACTUAL"] ?? 0;
            $movimientosPaginados = $_SESSION["MOVIMIENTOS_PAGINADOS"] ?? [];
            $totalPaginas = count($movimientosPaginados);
            $historial = $movimientosPaginados[$paginaActual] ?? [];
            ?>

            <div class="historial-kardex">
                <h2>Historial de Movimientos</h2>
                <h4 style="margin-top: -10px; color: #444;">Página <?= $paginaActual + 1 ?> de
                    <?= max($totalPaginas, 1) ?>
                </h4>

                <?php if (!empty($historial)): ?>
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
                <?php else: ?>
                    <p style="margin-top: 20px; color: #777;">No hay movimientos en esta página.</p>
                <?php endif; ?>

                <form method="POST" action="../../Controllers/MovimientoController.php" class="navegacion-kardex">
                    <button type="submit" name="btnPaginaAnterior" <?= $paginaActual == 0 ? 'disabled' : '' ?>>←
                        Anterior</button>
                    <span>Página <?= $paginaActual + 1 ?> de <?= max($totalPaginas, 1) ?></span>
                    <button type="submit" name="btnPaginaSiguiente" <?= $paginaActual >= $totalPaginas - 1 ? 'disabled' : '' ?>>Siguiente →</button>
                </form>
            </div>
        </section>
    </main>

    <script>
        // Habilita o deshabilita campos por checkbox
        document.querySelectorAll('input[type="checkbox"][data-target]').forEach(function (checkbox) {
            checkbox.addEventListener('change', function () {
                const targetId = this.getAttribute('data-target');
                const targetInput = document.getElementById(targetId);
                if (targetInput) {
                    targetInput.disabled = !this.checked;
                }
            });
        });

        // Mostrar/Ocultar panel de consulta
        function toggleConsulta() {
            const panel = document.getElementById("consultaProducto");
            panel.style.display = panel.style.display === "none" ? "block" : "none";
        }
    </script>


</body>

</html>
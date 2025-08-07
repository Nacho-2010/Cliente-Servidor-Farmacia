<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Controllers/usuarioController.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/layout.php";

$resultado = ConsultarUsuarios();
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>

<body>
    <?php verheader(); ?>
    <?php sidebar(); ?>
    <br><br><br>

    <main class="main-consultar">
        <section class="consultar-container">
            <h2>Consultar Usuarios</h2>
            <form method="POST" class="form-movimiento">
                <?php
                if (isset($_POST["txtMensaje"])) {
                    echo '<div class="alert alert-warning text-center">' . $_POST["txtMensaje"] . '</div>';
                }
                ?>

                <table id="tablaDatos" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Identificación</th>
                            <th>Nombre</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        if ($resultado) {
                            while ($fila = mysqli_fetch_array($resultado)) {
                                echo "<tr>";
                                echo "<td>" . $fila["IdUsuario"] . "</td>";
                                echo "<td>" . $fila["Identificacion"] . "</td>";
                                echo "<td>" . $fila["Nombre"] . "</td>";
                                echo "<td>" . $fila["Correo"] . "</td>";
                                echo "<td>" . $fila["NombreRol"] . "</td>";
                                echo "<td>" . $fila["EstadoDescripcion"] . "</td>";
                                echo '<td>
                                <a class="btn btnAbrirModal" data-bs-toggle="modal" data-bs-target="#CambiarEstadoUsuario"
                                data-id="' . $fila["IdUsuario"] . '" data-nombre="' . $fila["Nombre"] . '">
                                <i class="fa ' . ($fila["ID_ESTADO"] == 1 ? 'fa-toggle-on text-success' : 'fa-toggle-off text-danger') . '" style="font-size:1.5em;"></i>
                                </a>
                                <a href="actualizarUsuario.php?q=' . $fila["IdUsuario"] . '" class="btn">
                                <i class="fa fa-edit" style="font-size:1.5em;"></i>
                                </a>
                                </td>';
                                echo "</tr>";
                            }
                        } else {
                            echo "<tr><td colspan='7' class='text-center text-danger'>No se pudo cargar la lista de usuarios.</td></tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </form>
        </section>
    </main>

    <!-- Modal -->
    <div class="modal fade" id="CambiarEstadoUsuario" tabindex="-1" role="dialog" aria-labelledby="tituloModal"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="tituloModal">Confirmación</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="" method="POST">
                    <div class="modal-body">
                        <input type="hidden" id="IdUsuario" name="IdUsuario" class="form-control">
                        <label id="lblNombre" name="lblNombre"></label>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" id="btnCambiarEstadoUsuario" name="btnCambiarEstadoUsuario"
                            class="btn btn-primary">Procesar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        $(function () {
            new DataTable('#tablaDatos', {
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/2.3.2/i18n/es-ES.json',
                },
            });

            $('.btnAbrirModal').on('click', function () {
                const id = $(this).data('id');
                const nombre = $(this).data('nombre');
                $('#IdUsuario').val(id);
                $('#lblNombre').text("¿Desea cambiar el estado del usuario " + nombre + "?");
            });
        });
    </script>

    <?php añadirScripts(); ?>
</body>

</html>
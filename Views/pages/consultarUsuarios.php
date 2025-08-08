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
<br><br>
    <main class="main-consultar">
        <section class="consultar-container">
            <h2>Consultar Usuarios</h2>

           <?php if (isset($_SESSION["txtMensaje"])): ?>
    <div class="alert alert-warning text-center">
        <?= htmlspecialchars($_SESSION["txtMensaje"]); ?>
        <?php unset($_SESSION["txtMensaje"]); ?>
    </div>
<?php endif; ?>


            <form method="POST" class="form-movimiento">
                <table id="tablaDatos" class="table table-bordered table-hover">
                    <thead class="table-light text-center">
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
                        <?php if ($resultado && mysqli_num_rows($resultado) > 0): ?>
                            <?php while ($fila = mysqli_fetch_array($resultado)): ?>
                                <tr>
                                    <td><?= $fila["IdUsuario"]; ?></td>
                                    <td><?= $fila["Identificacion"]; ?></td>
                                    <td><?= $fila["Nombre"]; ?></td>
                                    <td><?= $fila["Correo"]; ?></td>
                                    <td><?= $fila["NombreRol"]; ?></td>
                                    <td><?= $fila["EstadoDescripcion"]; ?></td>
                                    <td class="text-center">
                                        <a class="btn btnAbrirModal" 
   data-bs-toggle="modal" 
   data-bs-target="#CambiarEstadoUsuario"
   data-id="<?= $fila["IdUsuario"]; ?>" 
   data-nombre="<?= $fila["Nombre"]; ?>">
   <i class="fa <?= $fila["ID_ESTADO"] == 1 ? 'fa-toggle-on text-success' : 'fa-toggle-off text-danger'; ?>" style="font-size:1.5em;"></i>
</a>

                                        <a href="/Cliente-Servidor-Farmacia/Controllers/usuarioController.php?accion=editarUsuario&q=<?= $fila["IdUsuario"]; ?>" class="btn">
                                            <i class="fa fa-edit" style="font-size:1.5em;"></i>
                                        </a>
                                    </td>
                                </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="7" class="text-center text-danger">No se pudo cargar la lista de usuarios.</td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </form>
        </section>
    </main>

    <!-- Modal para cambiar estado -->
    <div class="modal fade" id="CambiarEstadoUsuario" tabindex="-1" aria-labelledby="tituloModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md">
            <div class="modal-content">
                <form method="POST">
                    <div class="modal-header">
                        <h5 class="modal-title" id="tituloModal">Confirmación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="IdUsuario" name="IdUsuario">
                        <p id="lblNombre" class="text-center fw-bold"></p>
                    </div>
                    <div class="modal-footer"><button type="submit" name="btnCambiarEstadoUsuario" class="btn btn-primary">Procesar</button>

                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/2.3.2/js/dataTables.min.js"></script>
<script>
  $(function () {
      new DataTable('#tablaDatos', {
          language: {
              url: 'https://cdn.datatables.net/plug-ins/2.3.2/i18n/es-ES.json'
          },
          responsive: true
      });

      $('.btnAbrirModal').on('click', function () {
          const id = $(this).data('id');
          const nombre = $(this).data('nombre');


          $('#IdUsuario').val(id);
          $('#lblNombre').text("¿Desea cambiar el estado del usuario \"" + nombre + "\"?");
      });
  });
</script>


    <?php añadirScripts(); ?>
</body>
</html>

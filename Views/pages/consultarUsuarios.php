<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Controllers/usuarioController.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/layout.php";

if (session_status() === PHP_SESSION_NONE) session_start();

$resultado = ConsultarUsuarios();
?>
<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>

<head>
  <link rel="stylesheet" href="/Cliente-Servidor-Farmacia/Views/assets/Estilos/consultarUsuarios.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap5.min.css">
</head>

<body>

  <!-- Botón salir (mismo estilo) -->
  <a href="/Cliente-Servidor-Farmacia/Views/Home/principal.php" class="btn btn-dark border-0 shadow-none boton-salir">
    Salir
  </a>

  <?php verheader(); ?>
  <?php sidebar(); ?>
<br><br><br><br><br><br><br><br>
  <main class="main-content container mt-5">
    <header class="page-header">
        <div class="title-pill"><i class="fa fa-users"></i></div>
        <h2 class="page-title">Consultar Usuarios</h2>
        <p class="page-kicker">Lista, estados y modificación de usuarios</p>
    </header>


    <?php if (isset($_SESSION["txtMensaje"])): ?>
      <div class="alert alert-warning text-center mx-auto" style="max-width: 900px;">
        <?= htmlspecialchars($_SESSION["txtMensaje"]); ?>
      </div>
      <?php unset($_SESSION["txtMensaje"]); ?>
    <?php endif; ?>

    <!-- Card con sombra como en Gestión de Productos -->
    <div class="card mx-auto">
      <div class="card-body">
        <div class="table-responsive">
          <table id="tablaDatos" class="table table-bordered table-hover align-middle mb-0">
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
                    <td><?= htmlspecialchars($fila["Identificacion"]); ?></td>
                    <td><?= htmlspecialchars($fila["Nombre"]); ?></td>
                    <td><?= htmlspecialchars($fila["Correo"]); ?></td>
                    <td><?= htmlspecialchars($fila["NombreRol"]); ?></td>
                    <td><?= htmlspecialchars($fila["EstadoDescripcion"]); ?></td>
                    <td class="text-center">
                      <a class="btn btnAbrirModal"
                         data-bs-toggle="modal"
                         data-bs-target="#CambiarEstadoUsuario"
                         data-id="<?= $fila["IdUsuario"]; ?>"
                         data-nombre="<?= htmlspecialchars($fila["Nombre"]); ?>">
                        <i class="fa <?= (int)$fila["ID_ESTADO"] === 1 ? 'fa-toggle-on text-success' : 'fa-toggle-off text-danger'; ?>"
                           style="font-size:1.5em;"></i>
                      </a>

                      <a href="/Cliente-Servidor-Farmacia/Controllers/usuarioController.php?accion=editarUsuario&q=<?= urlencode($fila["IdUsuario"]); ?>"
                         class="btn" title="Editar">
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
        </div>
      </div>
    </div>
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
            <p id="lblNombre" class="text-center fw-bold mb-0"></p>
          </div>
          <div class="modal-footer">
            <button type="submit" name="btnCambiarEstadoUsuario" class="btn btn-primary">Procesar</button>
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
        const dt = new DataTable('#tablaDatos', {
        language: {
            url: 'https://cdn.datatables.net/plug-ins/2.3.2/i18n/es-ES.json',
            search: ''                 // quita el texto "Buscar:"
        },
        responsive: true,
        lengthChange: false,         // quita "Mostrar N"
        info: false,                 // quita "Mostrando X…"
        paging: false,               // quita la paginación
        dom: 'ft'                    // solo filtro (f) + tabla (t)
        });

        // placeholder bonito para el buscador
        $('#tablaDatos_filter input').attr('placeholder', 'Buscar usuario…');

        $(document).on('click', '.btnAbrirModal', function () {
        const id = $(this).data('id');
        const nombre = $(this).data('nombre');
        $('#IdUsuario').val(id);
        $('#lblNombre').text('¿Desea cambiar el estado del usuario "' + nombre + '"?');
        });
    });
    </script>


  <?php añadirScripts(); ?>
</body>
</html>

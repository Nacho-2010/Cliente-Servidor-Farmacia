<?php
// Incluye tu layout y controlador
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/productosController.php';

// Llamada al controlador para obtener los datos
$resultado = ConsultarProductos();
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>

<body>

  <?php
  verheader();
  sidebar();
  ?>

  <main style="margin-left:13%; padding: 2rem;">
    <div class="page-wrapper">
      <div class="container-fluid">

        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-body">
                <h4 class="card-title">Consulta de Productos</h4>
              </div>
              <hr>
              <form class="form-horizontal" action="" method="POST">
                <div class="card-body">

                  <?php
                  if (isset($_POST["txtMensaje"])) {
                    echo '<div class="alert alert-warning text-center">' . $_POST["txtMensaje"] . '</div>';
                  }
                  ?>

                  <div class="row">
                    <div class="col-md-12 text-right pb-4">
                      <a href="registrarProducto.php" class="btn btn-info">Agregar</a>
                    </div>
                  </div>

                  <table id="tablaDatos" class="table table-bordered table-hover">
                    <thead>
                      <tr>
                        <th>Código</th>
                        <th>Nombre</th>
                        <th>Precio Unitario</th>
                        <th>Categoría</th>
                        <th>Unidad Medida</th>
                        <th>Imagen</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      <?php
                      if ($resultado) {
                        while ($fila = mysqli_fetch_array($resultado)) {
                          echo "<tr>";
                          echo "<td>" . $fila["CODIGO"] . "</td>";
                          echo "<td>" . $fila["NOMBRE"] . "</td>";
                          echo "<td>" . $fila["PRECIO_UNITARIO"] . "</td>";
                          echo "<td>" . $fila["CATEGORIA"] . "</td>";
                          echo "<td>" . $fila["UNIDAD_MEDIDA"] . "</td>";


                          // Imagen
                          echo "<td>";
                          if (!empty($fila["URL_IMAGEN"])) {
                            echo "<img src='" . $fila["URL_IMAGEN"] . "' width='125' height='125'>";
                          } else {
                            echo "Sin imagen";
                          }
                          echo "</td>";

                          // Estado
                      
                          if ($fila["ID_ESTADO"] == 1) {

                            echo "<td><span class='badge badge-success'>Activo</span></td>";
                          } else {

                            echo "<td><span class='badge badge-danger'>" . $fila["ESTADO"] . "</span></td>";
                          }

                          // Acciones
                          echo "<td>
                            <a class='btn btnAbrirModal' data-toggle='modal' data-target='#CambiarEstadoProducto'
                              data-id='" . $fila["CODIGO"] . "' data-nombre='" . $fila["NOMBRE"] . "'>
                              <i class='fa " . ($fila["ID_ESTADO"] == 1 ? 'fa-toggle-on text-success' : 'fa-toggle-off text-danger') . "' style='font-size:1.5em;'></i>
                            </a>
                            <a class='btn' href='editarProducto.php?id=" . $fila["CODIGO"] . "'>
                              <i class='fa fa-edit' style='font-size:1.5em;'></i>
                            </a>
                          </td>";

                          echo "</tr>";
                        }
                      }
                      ?>
                    </tbody>
                  </table>
                </div>
              </form>
            </div>
          </div>
        </div>

      </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="CambiarEstadoProducto" tabindex="-1" role="dialog" aria-labelledby="tituloModal"
      aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="tituloModal">Confirmación</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>

          <form action="" method="POST">
            <div class="modal-body">
              <input type="hidden" id="IdProducto" name="IdProducto" class="form-control">
              <label id="lblNombre" name="lblNombre"></label>
            </div>
            <div class="modal-footer">
              <button type="submit" id="btnCambiarEstadoProducto" name="btnCambiarEstadoProducto"
                class="btn btn-primary">Procesar</button>
            </div>
          </form>

        </div>
      </div>
    </div>
  </main>

  <?php verfooter(); ?>
  <?php añadirScripts(); ?>

  <script>
    $(document).ready(function () {
      new DataTable('#tablaDatos', {
        language: {
          url: 'https://cdn.datatables.net/plug-ins/2.3.2/i18n/es-ES.json',
        },
      });

      $('.btnAbrirModal').on('click', function () {
        const id = $(this).data('id');
        const nombre = $(this).data('nombre');
        $('#IdProducto').val(id);
        $('#lblNombre').text("¿Desea cambiar el estado del producto " + nombre + "?");
      });
    });
  </script>

</body>

</html>
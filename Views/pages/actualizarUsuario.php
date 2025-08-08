<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/layout.php";
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>
<!-- CSS específico de esta vista -->
<link rel="stylesheet" href="/Cliente-Servidor-Farmacia/Views/assets/Estilos/modificarUsuario.css">

<body>
    <!-- Capa oscurecida para el fondo -->
    <div class="overlay"></div>

    <main class="main-consultar d-flex justify-content-center align-items-center vh-100">
        <section class="consultar-container card shadow p-4" style="max-width: 500px; width: 100%;">
            <h2 class="text-center mb-4">Modificar Usuario</h2>

            <form method="POST">
                <!--NOMBRE-->
                <div class="mb-3">
                    <label for="Nombre" class="form-label fw-bold">Nombre</label>
                    <input type="text" class="form-control" name="Nombre" id="Nombre"
                           value="<?= htmlspecialchars($usuario["NOMBRE"] ?? '') ?>" required>
                </div>

                <!--CORREO-->
                <div class="mb-3">
                    <label for="Correo" class="form-label fw-bold">Correo</label>
                    <input type="email" class="form-control" name="Correo" id="Correo"
                           value="<?= htmlspecialchars($usuario["CORREO"] ?? '') ?>" required>
                </div>

                <!--USUARIO-->
                <div class="mb-3">
                    <label for="Usuario" class="form-label fw-bold">Usuario</label>
                    <input type="text" class="form-control" name="Usuario" id="Usuario"
                           value="<?= htmlspecialchars($usuario["USUARIO"] ?? '') ?>" required>
                </div>

                <!--ESTADO-->
                <div class="mb-4">
                    <label for="Estado" class="form-label fw-bold">Estado</label>
                    <select name="Estado" id="Estado" class="form-select" required>
                        <option value="1" <?= ($usuario["ID_ESTADO"] ?? '') == 1 ? 'selected' : '' ?>>Activo</option>
                        <option value="2" <?= ($usuario["ID_ESTADO"] ?? '') == 2 ? 'selected' : '' ?>>Inactivo</option>
                    </select>
                </div>

                <!--BOTONES-->
                <div class="d-flex justify-content-between">
                    <a href="/Cliente-Servidor-Farmacia/Views/pages/consultarUsuarios.php" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-success">Guardar Cambios</button>
                </div>
            </form>
        </section>
    </main>

    <?php añadirScripts(); ?>
</body>
</html>
<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Views/layout.php";
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>

<br>


<main class="main-consultar">
    <section class="consultar-container">
        <h2>Modificar Usuario</h2>

        <form method="POST">
            

<!-- NOMBRE -->
<div class="mb-3">
    <label for="Nombre" class="form-label">Nombre</label>
    <input type="text" class="form-control" name="Nombre" id="Nombre"
           value="<?= htmlspecialchars($usuario["NOMBRE"] ?? '') ?>" required>
</div>

<!-- CORREO -->
<div class="mb-3">
    <label for="Correo" class="form-label">Correo</label>
    <input type="email" class="form-control" name="Correo" id="Correo"
           value="<?= htmlspecialchars($usuario["CORREO"] ?? '') ?>" required>
</div>

<!-- USUARIO -->
<div class="mb-3">
    <label for="Usuario" class="form-label">Usuario</label>
    <input type="text" class="form-control" name="Usuario" id="Usuario"
           value="<?= htmlspecialchars($usuario["USUARIO"] ?? '') ?>" required>
</div>

<!-- ESTADO -->
<div class="mb-3">
    <label for="Estado" class="form-label">Estado</label>
    <select name="Estado" id="Estado" class="form-select" required>
        <option value="1" <?= ($usuario["ID_ESTADO"] ?? '') == 1 ? 'selected' : '' ?>>Activo</option>
        <option value="2" <?= ($usuario["ID_ESTADO"] ?? '') == 2 ? 'selected' : '' ?>>Inactivo</option>
    </select>
</div>

<!-- BOTONES -->
<button type="submit" class="btn btn-success">Guardar Cambios</button>
<a href="/Cliente-Servidor-Farmacia/Views/pages/consultarUsuarios.php" class="btn btn-secondary">Cancelar</a>


<?php añadirScripts(); ?>
</body>
</html>
<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

include_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
?>

<!DOCTYPE html>
<html lang="es">
<?php añadirCSS(); ?>
<body>
<?php verheader(); sidebar(); ?>

<main class="contenido-principal main-formulario-centrado">
    <h2 class="mb-4">🧾 Información del Usuario</h2>

    <div class="card p-4">
        <p><strong>👤 Nombre:</strong> <?php echo htmlspecialchars($_SESSION["NOMBRE"] ?? 'No disponible'); ?></p>
        <p><strong>📧 Correo:</strong> <?php echo htmlspecialchars($_SESSION["CORREO"] ?? 'No disponible'); ?></p>
       
    </div>
</main>

<?php añadirScripts(); ?>
</body>
</html>

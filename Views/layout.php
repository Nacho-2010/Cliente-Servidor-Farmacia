<?php
// ==================== INICIO SESIÓN Y LOGOUT ====================
if (session_status() == PHP_SESSION_NONE) {
  session_start();
}

if (isset($_GET["logout"]) && $_GET["logout"] === "true") {
  session_unset();
  session_destroy();
  header("Location: /Cliente-Servidor-Farmacia/Views/Login/login.php");
  exit();
}

// ==================== FUNCIÓN: HEAD ====================
function añadirCSS()
{
  echo '
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Farmacia | Home</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Fredoka:wght@300..700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" crossorigin="anonymous" />

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />

    <!-- Estilos personalizados -->
    <link rel="stylesheet" href="../assets/Estilos/principal.css" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/5/w3.css" />
  </head>';
}

// ==================== FUNCIÓN: HEADER ====================
function verheader()
{
  $usuarioLogueado = isset($_SESSION["NOMBRE"]);
  $nombreUsuario = $usuarioLogueado ? $_SESSION["NOMBRE"] : "";

  if (isset($_SESSION["ROL"])) {
    echo "<p style='color:red; text-align:center;'>ROL ACTUAL: " . $_SESSION["ROL"] . "</p>";
  }

  echo '
  <header class="header">
    <div class="header__container">
      <img src="../assets/Imagenes/logo.jpg" alt="logo" class="header__logo-image" />
      <nav class="header__nav">
        <ul class="header__nav-links">
          <li><a href="../Home/principal.php" class="header__nav-link">Inicio</a></li>
          <li><a href="#" class="header__nav-link">Productos</a></li>
          <li><a href="#" class="header__nav-link">Quiénes somos</a></li>
          <li><a href="#" class="header__nav-link">Pide en línea</a></li>
          <li><a href="#" class="header__nav-link">Contacto</a></li>
        </ul>
      </nav>
      <div class="header__right">';

  if ($usuarioLogueado) {
    echo '
        <div class="profile-dis scrollable">
          <span class="user-name">Hola, ' . htmlspecialchars($nombreUsuario) . '</span>

          <a class="dropdown-item" href="?logout=true"><i class="ti-power-off m-r-5 m-1-5"></i> Cerrar Sesión</a>
        </div>';
  }
  echo '</div></div></header>';
}

// ==================== FUNCIÓN: FOOTER ====================
function verfooter()
{
  echo '
  <footer class="footer">
    <div class="footer__container">
      <div class="footer__content">
        <div class="footer__social-block">
          <p class="footer__legend">Síguenos en nuestras redes:</p>
          <div class="footer__social">
            <i class="fa-brands fa-facebook"></i>
            <a href="https://www.instagram.com/nacho___a" target="_blank"><i class="fa-brands fa-instagram"></i></a>
            <i class="fa-brands fa-square-x-twitter"></i>
          </div>
        </div>

        <div class="footer__col f__about-us">
          <h3>Farmacia GRUPO 4</h3>
          <a href="#">Sobre la Farmacia</a>
          <a href="#">Trabaja con nosotros</a>
        </div>

        <div class="footer__col f__contact">
          <h3>Contacto</h3>
          <a href="#">Contáctenos</a>
          <a href="#">Factura Electrónica</a>
          <a href="#">Preguntas frecuentes</a>
        </div>

        <div class="footer__col f__faq">
          <h3>Términos y condiciones</h3>
          <a href="#">Políticas de tratamiento de datos personales</a>
          <a href="#">Canal de transparencia</a>
        </div>
      </div>

      <div class="footer__copyright">
        <p>Gaining hands-on coding experience.</p>
        <p><span>&copy; 2025 Farmacia Grupo 4.</span> Code and Design by Grupo 4. All rights reserved.</p>
      </div>
    </div>
  </footer>';
}

// ==================== FUNCIÓN: SIDEBAR ====================
function sidebar()
{
  if (session_status() == PHP_SESSION_NONE) {
    session_start();
  }

  $nombreUsuario = isset($_SESSION["NOMBRE"]) ? $_SESSION["NOMBRE"] : "Invitado";

  echo '
  <aside class="sidebar">
    <div class="sidebar__logo">
      <i class="fa-solid fa-prescription-bottle-medical"></i>';

  if (isset($_SESSION['ROL']) && $_SESSION['ROL'] === 'ADMIN') {
    echo '<h2>Sistema Administrador</h2>';
    echo '<small class="nombre-usuario">👤 ' . htmlspecialchars($nombreUsuario) . '</small>';
  }

  echo '
    </div>

    <nav class="sidebar__nav">
      <ul>
        <li><a href="#"><i class="fa-solid fa-user-gear"></i> <span class="texto-menu">Manejo de Usuario</span></a></li>';

  if (isset($_SESSION['ROL']) && $_SESSION['ROL'] === 'ADMIN') {
    echo '<li><a href="#"><i class="fa-solid fa-boxes-stacked"></i> <span class="texto-menu">Kardex</span></a></li>';
  }

  echo '
        <li><a href="#"><i class="fa-solid fa-chart-bar"></i> <span class="texto-menu">Reportes</span></a></li>
      </ul>
    </nav>
  </aside>';
}



// ==================== FUNCIÓN: SCRIPTS ====================
function añadirScripts()
{
  echo '
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/Funciones/scrollReveal.js"></script>
  <script src="../assets/Funciones/customScrollReveal.js"></script>
  <script src="../assets/Funciones/app.js"></script>
  <script src="../assets/Funciones/principal.js"></script>';
}
?>
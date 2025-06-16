<?php
// ==================== HEAD ====================
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

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" crossorigin="anonymous" />

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />

    <!-- Estilos personalizados -->
    <link rel="stylesheet" href="../assets/Estilos/principal.css" />
  </head>  ';
}
// ==================== HEADER ====================
function verheader()
{
  if (session_status() === PHP_SESSION_NONE) {
    session_start();
  }

  $usuarioLogueado = isset($_SESSION['usuario']);

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
          <span class="user-name">Hola, ' . htmlspecialchars($_SESSION['usuario']) . '</span>
          <a class="dropdown-item" href="#">
            <i class="ti-user m-r-5 m-1-5"></i> Mi Perfil
          </a>
          <a class="dropdown-item" href="#">
            <i class="ti-settings m-r-5 m-1-5"></i> Configuración
          </a>
          <a class="dropdown-item" href="?logout=true">
            <i class="ti-power-off m-r-5 m-1-5"></i> Cerrar Sesión
          </a>
        </div>';
  } else {
    echo '
        <button class="btn btn__reserve" onclick="openModal()">
          Login <i class="fa-solid fa-capsules"></i>
        </button>

        <!-- Modal -->
        <div id="modalOverlay" class="overlay default" onclick="closeModal()"></div>
        <div id="modalDialog" class="dialog default" onclick="event.stopPropagation()">
        
          <!-- Login -->
          <div id="formulario-login" style="display: block;">
            <header>
              <h2>Iniciar Sesión</h2>
            </header>
            <form class="modal__form" method="POST" action="/Cliente-Servidor-Farmacia/Views/Home/principal.php">
              <input type="email" name="correo" placeholder="Correo Electrónico" class="modal__input" required />
              <input type="password" name="contrasena" placeholder="Contraseña" class="modal__input" required />
              <button type="submit" name="login" class="modal__submit">
                Entrar <i class="fa-solid fa-arrow-right"></i>
              </button>
            </form>
            <p class="modal__info">¿No tenés cuenta? <a href="#" onclick="mostrarRegistro()">Registrarse</a></p>
          </div>

          <!-- Registro -->
          <div id="formulario-registro" style="display: none;">
            <header>
              <h2>Registrarse</h2>
            </header>
            <form class="modal__form" method="POST" action="/Cliente-Servidor-Farmacia/Views/Home/principal.php">
              <input type="text" name="nombre" placeholder="Nombre completo" class="modal__input" required />
              <input type="email" name="correo" placeholder="Correo Electrónico" class="modal__input" required />
              <input type="text" name="usuario" placeholder="Usuario" class="modal__input" required />
              <input type="password" name="contrasena" placeholder="Contraseña" class="modal__input" required />
              <button type="submit" name="registro" class="modal__submit">
                Registrarse
              </button>
            </form>
            <p class="modal__info">¿Ya tenés cuenta? <a href="#" onclick="mostrarLogin()">Iniciar Sesión</a></p>
          </div>
        </div>';
  }
  echo '
  <script>
function mostrarRegistro() {
  document.getElementById("formulario-login").style.display = "none";
  document.getElementById("formulario-registro").style.display = "block";
}

function mostrarLogin() {
  document.getElementById("formulario-login").style.display = "block";
  document.getElementById("formulario-registro").style.display = "none";
}
  </script>
  ';

  echo '
      </div>
    </div>
  </header>
';
}
// ==================== FOOTER ====================
function verfooter()
{
  echo '
  <footer class="footer">
    <div class="footer__container">
      <div class="footer__content">

        <!-- Redes sociales -->
        <div class="footer__social-block">
          <p class="footer__legend">Síguenos en nuestras redes:</p>
          <div class="footer__social">
            <i class="fa-brands fa-facebook"></i>
            <a href="https://www.instagram.com/nacho___a?igsh=NDhvZWpnZ2JqbHdz" target="_blank">
              <i class="fa-brands fa-instagram"></i>
            </a>
            <i class="fa-brands fa-square-x-twitter"></i>
          </div>
        </div>

        <!-- Enlaces -->
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

      <!-- Derechos -->
      <div class="footer__copyright">
        <p>Gaining hands-on coding experience.</p>
        <p>
          <span>&copy; 2025 Farmacia Grupo 4.</span> Code and Design by Grupo 4. All rights reserved.
        </p>
      </div>
    </div>
  </footer>
  ';
}
// ==================== SCRIPTS ====================
function añadirScripts()
{
  echo '
  <!-- Bootstrap Bundle con Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- ScrollReveal y scripts personalizados -->
  <script src="../assets/Funciones/scrollReveal.js"></script>
  <script src="../assets/Funciones/customScrollReveal.js"></script>
  <script src="../assets/Funciones/app.js"></script>
  <script src="../assets/Funciones/principal.js"></script>
  ';
}
?>
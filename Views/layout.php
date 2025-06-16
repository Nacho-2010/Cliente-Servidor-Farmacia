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
    <link rel="stylesheet" type="text/css" href="assets/Estilos/normalize.css" />
    <link rel="stylesheet" href="../assets/Estilos/principal.css" />
  </head>  ';
}

// ==================== HEADER ====================
function verheader()
{
  echo '
  <header class="header">
    <div class="header__container">
      <img src="../assets/Imagenes/logo.jpg" alt="logo" class="header__logo-image" />
      <nav class="header__nav">
        <ul class="header__nav-links">
          <li><a href="#" class="header__nav-link">Inicio</a></li>
          <li><a href="#" class="header__nav-link">Productos</a></li>
          <li><a href="#" class="header__nav-link">Quiénes somos</a></li>
          <li><a href="#" class="header__nav-link">Pide en línea</a></li>
          <li><a href="#" class="header__nav-link">Contacto</a></li>
        </ul>
      </nav>
      <div class="header__right">
        <!-- Botón Login -->
        <button class="btn btn__reserve" onclick="openModal()">
          Login <i class="fa-solid fa-capsules"></i>
        </button>

        <!-- Modal -->
        <div id="modalOverlay" class="overlay default" onclick="closeModal()"></div>

        <div id="modalDialog" class="dialog default" onclick="event.stopPropagation()">
          <header>
            <h2>Sign Up</h2>
            <h3>Try Hologram today.</h3>
          </header>
          <form class="modal__form">
            <input type="email" placeholder="Email" class="modal__input" />
            <input type="password" placeholder="Password" class="modal__input" />
            <button type="submit" class="modal__submit">
              Sign up free <i class="fa-solid fa-arrow-right"></i>
            </button>
            <p class="modal__info">No credit card information required</p>
          </form>
        </div>

        <i class="fa-solid fa-bars" id="menu__icon"></i>
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

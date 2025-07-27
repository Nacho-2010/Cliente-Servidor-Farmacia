<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
?>

<!DOCTYPE html>
<html lang="es">

<?php
añadirCSS(); //<head> con CSS
?>

<body>

  <?php
  verheader();
  ?>

  <?php
  sidebar();
  ?>

  <main style="margin-left: 13%">



    <!-- Sección Hero -->
    <section class="hero">
      <div class="hero__container">
        <div class="hero__info">
          <h1 class="hero__title">Comunicate con <span> nosotros</span>, conocé nuestras apps.</h1>
          <br>
          <div class="booking__places3">
              <figure class="figure">
                <a href="tel:+50687241717" class="btn__place3">
                  <i class="fa-solid fa-phone"></i> Teléfono
                </a>
                <figcaption class="figure-caption">Llámanos cuando lo necesites</figcaption>
              </figure>

              <figure class="figure">
                <a href="mailto:correo@tufarmacia.com" class="btn__place3">
                  <i class="fa-solid fa-envelope"></i> Correo
                </a>
                <figcaption class="figure-caption">Escríbenos a nuestro email</figcaption>
              </figure>

              <figure class="figure">
                <a href="https://wa.me/50687241717" target="_blank" class="btn__place3">
                  <i class="fa-brands fa-whatsapp"></i> Whatsapp
                </a>
                <figcaption class="figure-caption">Chatea con nosotros</figcaption>
              </figure>

              <figure class="figure">
                <a href="https://facebook.com/TuFarmacia" target="_blank" class="btn__place3">
                  <i class="fa-brands fa-facebook"></i> Facebook
                </a>
                <figcaption class="figure-caption">Síguenos en Facebook</figcaption>
              </figure>

              <figure class="figure">
                <a href="https://www.instagram.com/nacho___a" target="_blank" class="btn__place3">
                  <i class="fa-brands fa-instagram"></i> Instagram
                </a>
                <figcaption class="figure-caption">Míranos en Instagram</figcaption>
              </figure>
          </div>
       
          </div>
        </div>
      </div>
    </section>

    <!-- Banner decorativo -->
    <div class="banner">
      <div class="banner__content"></div>
    </div>

    <!-- Ubicacion -->
    
       
  </main>

  <?php

  verfooter();
  ?>

  <?php
  añadirScripts(); // Todos los scripts JS 
  ?>

</body>

</html>
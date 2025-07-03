<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Views/layout.php';
?>
<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/Cliente-Servidor-Farmacia/Controllers/homeController.php';
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
        <div class="image-container">
          <img src="../assets/Imagenes/farmacia2.jpg" alt="Imagen de pastillas" class="hero__image" />
        </div>
        <div class="hero__info">
          <h1 class="hero__title">Bienvenido a <span>Farmacia</span>, tu bienestar es nuestra prioridad.</h1>
          <p class="hero__legend">Ofrecemos atención personalizada, productos de calidad y el compromiso de cuidar tu
            salud en todo momento.</p>
          <div class="hero__btn">
            <button class="btn btn__invite">
              <i class="fa-solid fa-arrow-right"></i> Ver productos disponibles
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Sección About -->
    <section class="about">
      <div class="about__container">
        <img src="../assets/Imagenes/farmacia4.jpg" alt="Foto farmacia" class="about__image" />
        <div class="about__info">
          <h2 class="about__title">Lo que hacemos</h2>
          <p class="about__text">
            En <span>Farmacia Salud</span>, no solo entregamos medicamentos, somos una familia comprometida con tu
            bienestar y el de quienes más querés...
          </p>
          <p class="about__text">
            Más que una farmacia, somos un espacio de confianza donde recibís atención cercana, orientación profesional
            y productos de calidad...
          </p>
        </div>
      </div>
    </section>

    <!-- Banner decorativo -->
    <div class="banner">
      <div class="banner__content"></div>
    </div>

    <!-- Productos -->
    <section class="menu">
      <div class="menu__container">
        <h2 class="menu__title">Algunos Productos</h2>
        <div class="menu__content">

          <!-- Tarjeta Producto 1 -->
          <div class="card">
            <img class="acetaminofen__image" src="../assets/Imagenes/acetaminofen.jpg" alt="acetaminofen" />
            <div class="menu__info">
              <h3 class="card__title">Pastilla Acetaminofen</h3>
              <p class="card__text">La acetaminofén, también conocido como paracetamol...</p>
              <div class="cart__price">
                <p class="price">₡1.350</p>
                <i class="fa-solid fa-cart-plus"></i>
              </div>
            </div>
          </div>

          <!-- Tarjeta Producto 2 -->
          <div class="card">
            <img class="card__image" src="../assets/Imagenes/colgate2.jpg" alt="COLGATE" />
            <div class="menu__info">
              <h3 class="card__title">Pasta Dental Colgate Triple Acción</h3>
              <p class="card__text">Ayuda a prevenir las caries, combate el mal aliento...</p>
              <div class="cart__price">
                <p class="price">₡2.050</p>
                <i class="fa-solid fa-cart-plus"></i>
              </div>
            </div>
          </div>

          <!-- Tarjeta Producto 3 -->
          <div class="card">
            <img class="card__image" src="../assets/Imagenes/dolo.jpg" alt="DOLO-NEUROBIÓN" />
            <div class="menu__info">
              <h3 class="card__title">DOLO-NEUROBIÓN N TABLETAS</h3>
              <p class="card__text">Se usa para aliviar el dolor e inflamación asociados a problemas musculares...</p>
              <div class="cart__price">
                <p class="price">₡1.500</p>
                <i class="fa-solid fa-cart-plus"></i>
              </div>
            </div>
          </div>

        </div>


        <!-- Sucursales -->
        <section class="booking">
          <div class="booking__container">
            <h2 class="booking__title">Encuentra lo que necesitas</h2>
            <p class="booking__text">
              Visitá cualquiera de nuestras 3 sucursales para adquirir tus medicamentos... <span>Elegí la sede de tu
                interés.</span>
            </p>
            <div class="booking__places">
              <button class="btn btn__place"><i class="fa-solid fa-location-dot"></i> Norte</button>
              <button class="btn btn__place"><i class="fa-solid fa-location-dot"></i> Centro</button>
              <button class="btn btn__place"><i class="fa-solid fa-location-dot"></i> Sur</button>
            </div>
          </div>
        </section>

        <!-- Enfermedades -->
        <section class="Enfermedades">
          <div class="Enfermedades__container">
            <h2 class="Enfermedades__title">Enfermedades actuales</h2>
            <div class="Enfermedades__content">

              <!-- Artículo 1 -->
              <article class="entry">
                <div class="entry__img-container">
                  <img src="../assets/Imagenes/virus.jpg" alt="Imagen de virus" class="entry__image" />
                </div>
                <div class="entry__info">
                  <p class="entry__date">Junio 1, 2025</p>
                  <h3 class="entry__title">¿Hay riesgo de pandemia por gripe aviar en 2025?</h3>
                  <p class="entry__description">Virus de la gripe: Es un virus ARN...</p>
                  <a href="#" class="entry__btn">Continua leyendo... <i class="fa-solid fa-book-open-reader"></i></a>
                </div>
              </article>

              <!-- Artículo 2 -->
              <article class="entry">
                <div class="entry__img-container">
                  <img src="../assets/Imagenes/coronavirus.jpg" alt="Imagen coronavirus" class="entry__image" />
                </div>
                <div class="entry__info">
                  <p class="entry__date">Junio 1, 2025</p>
                  <h3 class="entry__title">¿Habrá una pandemia en 2025?</h3>
                  <p class="entry__description">La COVID-19 surgió de repente, se propagó rápidamente...</p>
                  <a href="#" class="entry__btn">Continua leyendo... <i class="fa-solid fa-book-open-reader"></i></a>
                </div>
              </article>

              <!-- Artículo 3 -->
              <article class="entry">
                <div class="entry__img-container">
                  <img src="../assets/Imagenes/fiebre.jpg" alt="Imagen fiebre amarilla" class="entry__image" />
                </div>
                <div class="entry__info">
                  <p class="entry__date">Junio 1, 2025</p>
                  <h3 class="entry__title">OPS emite nueva alerta por fiebre amarilla</h3>
                  <p class="entry__description">La OPS ha emitido una nueva alerta debido al incremento de casos...</p>
                  <a href="#" class="entry__btn">Continua leyendo... <i class="fa-solid fa-book-open-reader"></i></a>
                </div>
              </article>

            </div>
          </div>
        </section>
  </main>

  <?php

  verfooter();
  ?>

  <?php
  añadirScripts(); // Todos los scripts JS 
  ?>

</body>

</html>
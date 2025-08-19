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

  <main style="margin-left: 11%">



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
            <a href="compra.php" class="btn btn__invite">
              <i class="fa-solid fa-arrow-right"></i> Ver productos disponibles
            </a>
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
        <h2 class="menu__title">Consejos de Salud</h2>
        <div class="menu__content">

          <!-- Consejo 1 -->
          <div class="card">
            <img class="card__image" src="../assets/Imagenes/hidratacion.jpg" alt="Hidratación diaria" />
            <div class="menu__info">
              <h3 class="card__title">Hidratación diaria</h3>
              <p class="card__text">
                Toma 6–8 vasos de agua al día. Evita el exceso de bebidas azucaradas y
                fíjate en señales de deshidratación: labios secos, dolor de cabeza o cansancio.
              </p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Bienestar general</small>
                <a href="/Cliente-Servidor-Farmacia/Views/pages/consejos.php#hidratacion" class="btn btn-primary btn-sm">Leer más</a>
              </div>
            </div>
          </div>

          <!-- Consejo 2 -->
          <div class="card">
            <img class="card__image" src="../assets/Imagenes/medicacion.jpg" alt="Uso responsable de medicamentos" />
            <div class="menu__info">
              <h3 class="card__title">Uso responsable de medicamentos</h3>
              <p class="card__text">
                No te automediques. Lee la etiqueta, respeta las dosis y horarios. Si tomas
                más de un fármaco, consulta por posibles interacciones.
              </p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Seguridad del paciente</small>
                <a href="/Cliente-Servidor-Farmacia/Views/pages/consejos.php#medicacion" class="btn btn-primary btn-sm">Leer más</a>
              </div>
            </div>
          </div>

          <!-- Consejo 3 -->
          <div class="card">
            <img class="card__image" src="../assets/Imagenes/preventivo.jpg" alt="Prevención y chequeos" />
            <div class="menu__info">
              <h3 class="card__title">Prevención y chequeos</h3>
              <p class="card__text">
                Mantén tus vacunas al día, usa protector solar (SPF 30+), duerme bien y realiza
                chequeos médicos periódicos: prevenir es cuidar tu futuro.
              </p>
              <div class="d-flex justify-content-between align-items-center">
                <small class="text-muted">Prevención</small>
                <a href="/Cliente-Servidor-Farmacia/Views/pages/consejos.php#preventivo" class="btn btn-primary btn-sm">Leer más</a>
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
                    <a href="https://maps.app.goo.gl/xKk3V6pbdiUXSqd6A" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Central San José
                    </a>
                    <a href="https://maps.app.goo.gl/d6z3snMzR1q72F1e6" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Heredia Norte
                    </a>
                    <a href="https://maps.app.goo.gl/RCeYzeKLkquhHGzL7" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Cartago Este
                    </a>
                    <a href="https://maps.app.goo.gl/bo2MZFnDnsoGgBqx6" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Alajuela Centro
                    </a>
                    <a href="https://maps.app.goo.gl/DPQU2cWQspiWstzP6" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Liberia Oeste
                    </a>
                    <a href="https://maps.app.goo.gl/bvgx2vMm8JfEfhPr7" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Pérez Zeledón
                    </a>
                    <a href="https://maps.app.goo.gl/9QsQiRwBinFj4nun9" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia San Ramón
                    </a>
                    <a href="https://maps.app.goo.gl/9rigjkirjTLiVrJj9" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Central San José
                    </a>
                    <a href="https://maps.app.goo.gl/iUAn2xhc9qx826Ns9" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Heredia Norte
                    </a>
                    <a href="https://maps.app.goo.gl/U9ARZspGAyJysgkr5" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Cartago Este
                    </a>
                    <a href="https://maps.app.goo.gl/1gayHTCyDUHZhWxD6" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Liberia Oeste
                    </a>
                    <a href="https://maps.app.goo.gl/gMCJu9Ga4W73bbXv5" class="btn btn__place">
                      <i class="fa-solid fa-location-dot"></i> Farmacia Pérez Zeledón Oeste
                    </a>
            </div>
          </div>
        </section>

        <!-- Enfermedades - Estilo Aporte JD -->
        <section class="Enfermedades">
          <h2 class="titulo-enfermedades">Enfermedades actuales</h2>
          <div class="wrapper">
            <div class="container-cartas">
              <input type="radio" name="slide" id="c1" checked>
              <label for="c1" class="card-info virus">
                <div class="vertical-title">Virus</div>
                <div class="row">
                  <div class="icon">1</div>
                  <div class="description">
                    <h4>Virus</h4>
                    <p>¿Hay riesgo de pandemia por gripe aviar en 2025?</p>
                  </div>
                </div>
              </label>

              <input type="radio" name="slide" id="c2">
              <label for="c2" class="card-info coronavirus">
                <div class="vertical-title">Coronavirus</div>
                <div class="row">
                  <div class="icon">2</div>
                  <div class="description">
                    <h4>Coronavirus</h4>
                    <p>¿Habrá una pandemia en 2025?</p>
                  </div>
                </div>
              </label>

              <input type="radio" name="slide" id="c3">
              <label for="c3" class="card-info fiebre">
                <div class="vertical-title">Fiebre</div>
                <div class="row">
                  <div class="icon">3</div>
                  <div class="description">
                    <h4>Fiebre Amarilla</h4>
                    <p>OPS emite nueva alerta por fiebre amarilla</p>
                  </div>
                </div>
              </label>
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
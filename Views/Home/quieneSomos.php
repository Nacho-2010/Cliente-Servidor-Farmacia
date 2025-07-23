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
        <div class="image-container">
          <img src="../assets/Imagenes/quienesomos.jpg" alt="Imagen de pastillas" class="hero__image" />
        </div>
        <div class="hero__info">
          <h1 class="hero__title">Tu <span>salud </span>y la de tus seres queridos es lo más importante.</h1>
          <p class="hero__legend">¡Estamos acá cuando lo necesités!</p>
          <div class="hero__btn">
          </div>
        </div>
      </div>
    </section>

    <!-- Banner decorativo -->
    <div class="banner">
      <div class="banner__content"></div>
    </div>

    <!-- Ubicacion -->
    <section class="menu">
      <div class="menu__container">
        <h1 class="menu__title">Nuestras Sucursales</h1>
        <div class="menu__content">
        <section class="booking2">
                <div class="booking__container">
                  <h2 class="booking__title">Encuentra lo que necesitas</h2>
                  <p class="booking__text">
                    Visitá cualquiera de nuestras sucursales para adquirir tus medicamentos... <span>Elegí la sede de tu
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
        </div>
         <!-- Nuestro equipo -->
        <section class="menu">
          <div class="menu__container">
            <h1 class="menu__title">Nuestros Equipo de Medicos</h1>
            <div class="menu__content">
            <section class="booking3">
                    <div class="booking__container">
                      <h2 class="booking__title">Conocé los medicos de la empresa</h2>
                      <p class="booking__text">
                        Visitá cualquiera de nuestras sucursales para poder hablar con ellos... <span>Elegí la sede de tu
                          interés.</span>
                      </p>
                      <div class="booking__places2">
                        <div class="btn-wrapper">
                            <button class="btn btn__placeD foto-btn">
                              <img src="../assets/Imagenes/JuanPablo.jpg" alt="Foto" class="foto-persona">
                            </button>
                            <div class="btn-label">
                              <strong>Juan Pablo Vega</strong><br>
                              2006
                            </div>
                        </div>
                        <div class="btn-wrapper">
                            <button class="btn btn__placeD foto-btn">
                              <img src="../assets/Imagenes/Abraham.jpg" alt="Foto" class="foto-persona">
                            </button>
                            <div class="btn-label">
                              <strong>Abraham Cascante</strong><br>
                              2005
                            </div>
                        </div>
                        <div class="btn-wrapper">
                            <button class="btn btn__placeD foto-btn">
                              <img src="../assets/Imagenes/JoseDavid.jpg" alt="Foto" class="foto-persona">
                            </button>
                            <div class="btn-label">
                              <strong>Jose David Vargas</strong><br>
                              2005
                            </div>
                        </div>
                        <div class="btn-wrapper">
                            <button class="btn btn__placeD foto-btn">
                              <img src="../assets/Imagenes/Nacho.jpg" alt="Foto" class="foto-persona">
                            </button>
                            <div class="btn-label">
                              <strong>Nacho Aguilar</strong><br>
                              2006
                            </div>
                        </div>
                       <div class="btn-wrapper">
                            <button class="btn btn__placeD foto-btn">
                              <img src="../assets/Imagenes/Josue.jpg" alt="Foto" class="foto-persona">
                            </button>
                            <div class="btn-label">
                              <strong>Josue Navarro</strong><br>
                              1998
                            </div>
                        </div>         
                      </div>
                    </div>
              </section>
          </div>
  </main>

  <?php

  verfooter();
  ?>

  <?php
  añadirScripts(); // Todos los scripts JS 
  ?>

</body>

</html>

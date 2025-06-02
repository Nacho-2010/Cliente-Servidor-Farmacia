<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Farmacia | Home</title>
    <!-- google font link-->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Fredoka:wght@300..700&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap"
      rel="stylesheet"
    />
    <!-- fontawesome link -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
      integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <!-- custom css link -->
    <link rel="stylesheet" type="text/css" href="assets/Estilos/normalize.css" />
   <link rel="stylesheet" href="../assets/Estilos/principal.css" />

    <!-- script scrollreveal -->
    <script src="../assets/Funciones/scrollReveal.js"></script>
  </head>
  <body>
    <header class="header">
      <div class="header__container">
        <img
          src="../assets/Imagenes/logo.jpg"
          alt="logo"
          class="header__logo-image"
        />
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
        <button class="btn btn__reserve">
  Login <i class="fa-solid fa-capsules"></i>
</button>


          <i class="fa-solid fa-bars" id="menu__icon"></i>
        </div>
      </div>
    </header>

    <main>
     <section class="hero">
  <div class="hero__container">
    <div class="image-container">
      <img src="../assets/Imagenes/farmacia2.jpg" alt="Imagen de pastillas" class="hero__image" />
          </div>
          <div class="hero__info">
          <h1 class="hero__title">
  Bienvenido a <span>Farmacia</span>, tu bienestar es nuestra prioridad.
</h1>
<p class="hero__legend">
  Ofrecemos atención personalizada, productos de calidad y el compromiso de cuidar tu salud en todo momento.
</p>
<div class="hero__btn">
  <button class="btn btn__invite">
    <i class="fa-solid fa-arrow-right"></i> Ver productos disponibles
  </button>
</div>

          </div>
        </div>
      </section>
      <section class="about">
        <div class="about__container">
          <img
            src="../assets/Imagenes/farmacia4.jpg"
            alt="Foto farmacia"
            class="about__image"
          />
          <div class="about__info">
            <h2 class="about__title">Lo que hacemos</h2>
           <p class="about__text">
  En <span>Farmacia Salud</span>, no solo entregamos medicamentos, 
  somos una familia comprometida con tu bienestar y el de quienes más querés. 
  Nuestra historia se construye con empatía, vocación de servicio y el deseo constante de cuidar tu salud día a día.
</p>
<p class="about__text">
  Más que una farmacia, somos un espacio de confianza donde recibís atención cercana,
   orientación profesional y productos de calidad. Queremos que te sientas acompañado desde el primer momento.
</p>

        </div>
      </section>
      <div class="banner">
        <div class="banner__content"></div>
      </div>
      <section class="menu">
        <div class="menu__container">
          <h2 class="menu__title">Algunos Productos</h2>
          <div class="menu__content">
            <div class="card">
              <img
                class="acetaminofen__image"
                src="../assets/Imagenes/acetaminofen.jpg"
                alt="acetaminofen"
              />

            <!-- Productos de la farmacia  -->
              <div class="menu__info">
                <h3 class="card__title">Pastilla Acetaminofen</h3>
                <p class="card__text">
                  La acetaminofén, también conocido como paracetamol, es un medicamento ampliamente utilizado por sus propiedades analgésicas y antipiréticas.
                </p>
                <div class="cart__price">
                  <p class="price"> ₡1.350</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>
            <!-- end card -->
            <div class="card">
              <img
                class="card__image"
                src="../assets/Imagenes/colgate2.jpg"
                alt="COLGATE"
              />
              <div class="menu__info">
                <h3 class="card__title">Pasta Dental Colgate Triple Acción</h3>
                <p class="card__text">
                  Ayuda a prevenir las caries, combate el mal aliento y deja una sensación de frescura.
                </p>
                <div class="cart__price">
                  <p class="price">₡2.050</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>
            <!-- end card -->
            <div class="card">
              <img
                class="card__image"
                src="../assets/Imagenes/dolo.jpg"
                alt="DOLO-NEUROBIÓN"
              />
              <div class="menu__info">
                <h3 class="card__title">DOLO-NEUROBIÓN N TABLETAS</h3>
                <p class="card__text">
                  Se usa para aliviar el dolor e
                  inflamación asociados a problemas musculares, articulares
                  o nerviosos, como lumbalgias o ciática. Ayuda a reducir 
                  el dolor y a mejorar la función nerviosa.
                </p>
                <div class="cart__price">
                  <p class="price">₡1.500</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>
            <!-- end card -->
            <!-- Termina la categoria de productos q se ven :)-->
            <!-- end card -->
          </div>
          <button class="btn btn__menu">
            Conoce más <i class="fa-solid fa-cookie-bite"></i>
          </button>
        </div>
      </section>
      <section class="booking">
        <div class="booking__container">
         <h2 class="booking__title">Encuentra lo que necesitas</h2>
<p class="booking__text">
  Visitá cualquiera de nuestras 3 sucursales para adquirir tus medicamentos,
   productos de cuidado personal o recibir atención farmacéutica. 
  <span>Elegí la sede de tu interés.</span>
</p>

          <div class="booking__places">
            <button class="btn btn__place">
              <i class="fa-solid fa-location-dot"></i> Norte
            </button>
            <button class="btn btn__place">
              <i class="fa-solid fa-location-dot"></i> Centro
            </button>
            <button class="btn btn__place">
              <i class="fa-solid fa-location-dot"></i> Sur
            </button>
          </div>
        </div>
      </section>
       
   <section class="Enfermedades">
  <div class="Enfermedades__container">
    <h2 class="Enfermedades__title">Enfermedades actuales</h2>
    <div class="Enfermedades__content">
      <article class="entry">
        <div class="entry__img-container">
          <img
            src="../assets/Imagenes/virus.jpg"
            alt="Imagen de virus"
            class="entry__image"
          />
        </div>
        <div class="entry__info">
          <p class="entry__date">Junio 1, 2025</p>
          <h3 class="entry__title">
            ¿Hay riesgo de pandemia por gripe aviar en 2025?
          </h3>
          <p class="entry__description">
            Virus de la gripe: Es un virus ARN, como el del COVID-19, el SIDA, el Ébola o la hepatitis C. Tiene su genoma dividido en 8 fragmentos, lo que aumenta su capacidad de mutación. La gripe aviar es una enfermedad respiratoria que generalmente afecta a las aves. La variante D1 fue identificada por primera vez en el sudeste asiático en 1996 y ha sido responsable de la epidemia más grave registrada, afectando a poblaciones de aves en todo el mundo.
          </p>
          <a href="#" class="entry__btn">
            Continua leyendo...<i class="fa-solid fa-book-open-reader"></i>
          </a>
        </div>
      </article>


            <!-- blog entry-->
            <article class="entry">
              <div class="entry__img-container">
                <img
                  src="../assets/Imagenes/coronavirus.jpg"
                  alt="Imagen coronavirus"
                  class="entry__image"
                />
              </div>
              <div class="entry__info">
                <p class="entry__date">Junio 1, 2025</p>
                <h3 class="entry__title">
                  ¿Habrá una pandemia en 2025? Esta es la enfermedad que más preocupa a los expertos
                </h3>
                <p class="entry__description">
               La COVID-19 surgió de repente, se propagó rápidamente y mató a millones de personas en todo el mundo. Desde entonces,
               es justo decir que la mayoría de la gente se ha puesto nerviosa ante la aparición de la próxima gran enfermedad infecciosa,
               ya sea un virus, una bacteria, un hongo o un parásito.
                </p>
                <a href="#" class="entry__btn"
                  >Continua leyendo...
                  <i class="fa-solid fa-book-open-reader"></i
                ></a>
              </div>
            </article>
            <!-- blog entry-->
            <article class="entry">
              <div class="entry__img-container">
                <img
                  src="../assets/Imagenes/fiebre.jpg"
                  alt="Imagen de desayuno saludable"
                  class="entry__image"
                />
              </div>
              <div class="entry__info">
                <p class="entry__date">Junio 1, 2025</p>
                <h3 class="entry__title">
                  OPS emite nueva alerta epidemiológica ante el aumento de los casos de fiebre amarilla en las Américas
                </h3>
                <p class="entry__description">
               Washington, D.C., 31 de marzo de 2025 (OPS) – La Organización Panamericana de la Salud 
                (OPS) ha emitido una nueva alerta epidemiológica debido al incremento de casos de fiebre amarilla en las Américas 
               durante los primeros meses de 2025. El número de casos humanos confirmados hasta el 22 de marzo ha más que duplicado 
               el total registrado en todo 2024, lo que genera preocupación por una posible expansión de la enfermedad.
                En los primeros casi tres meses de 2025, se han confirmado 131 casos humanos, con 53 fallecimientos. En comparación, en todo 
               el 2024 se reportaron 61 casos, de los cuales 30 fueron fatales. Los casos se reportaron en Bolivia (1 caso, 1 fallecimiento), 
               Brasil (81 casos, 31 fatales), Colombia (31 casos, 13 fallecimientos) y Perú (18 casos, 8 fatales), con casos notificados fuera de la región 
               amazónica, tradicionalmente afectada.
                </p>
                <a href="#" class="entry__btn"
                  >Continua leyendo...
                  <i class="fa-solid fa-book-open-reader"></i
                ></a>
              </div>
            </article>
            <!-- blog entry-->
          </div>
        </div>
      </section>
    </main>

    <footer class="footer">
      <div class="footer__container">
        <div class="footer__content">
          <div class="footer__logo">
            <img src="../assets/Imagenes/logo.jpg" alt="foodlover logo" />
            <p class="footer__legend">Síguenos en nuestras redes:</p>
            <div class="footer__social">
              <i class="fa-brands fa-facebook"></i>

          <a href="https://www.instagram.com/nacho___a?igsh=NDhvZWpnZ2JqbHdz" target="_blank">
  <i class="fa-brands fa-instagram"></i>
</a>

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
          <p>
            <span>&copy; 2025 Farmacia Grupo 4.</span> Code and Design by
            Grupo 4. All rights reserved.
          </p>
        </div>
      </div>
    </footer>

    <!-- custom script -->
    <script type="text/javascript" src="../assets/Funciones/app.js"></script>
    <script src="../assets/Funciones/customScrollReveal.js"></script>
  </body>
</html>

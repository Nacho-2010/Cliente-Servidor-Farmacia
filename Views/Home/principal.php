<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>FoodLover | Home</title>
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
          src="assets/img/logo.png"
          alt="foodlover logo"
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
            <img
              src="assets/img/hero__left.jpg"
              alt="Mujer desayunando"
              class="hero__image"
            />
          </div>
          <div class="hero__info">
          <h1 class="hero__title">
  Bienvenido a <span>Farmacia Salud</span>, tu bienestar es nuestra prioridad.
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
            src="assets/img/about.jpg"
            alt="foodlover store"
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
        </div>
      </section>
      <section class="promise">
        <div class="promise__container">
          <img
            src="assets/img/promise2.png"
            alt="foodlover store"
            class="promise__image"
          />
         <div class="promise__info">
  <h2 class="promise__title">Compromiso con tu Salud</h2>
  <p class="promise__text">
    Seleccionamos cuidadosamente cada uno de nuestros productos, priorizando la calidad, 
    seguridad y respaldo de marcas confiables. Trabajamos con proveedores certificados para asegurar que los medicamentos, 
    suplementos y artículos de cuidado personal cumplan con los más altos estándares.
  </p>
</div>

        </div>
      </section>
      <div class="banner">
        <div class="banner__content"></div>
      </div>
      <section class="menu">
        <div class="menu__container">
          <h2 class="menu__title">Nuestras delicias</h2>
          <div class="menu__content">
            <div class="card">
              <img
                class="card__image"
                src="assets/img/gallery1.png"
                alt="Huevo Primavera"
              />

            <!-- Quitar esto cambiarlo a productos de la farmacia  -->
              <div class="menu__info">
                <h3 class="card__title">Huevo Primavera</h3>
                <p class="card__text">
                  Dos huevos al vapor servidos sobre una cama de lechuga fresca
                  y tomates cherry cortados por la mitad, acompañados de una
                  salsa especial de la casa.
                </p>
                <div class="cart__price">
                  <p class="price">$20.000</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>
            <!-- end card -->
            <div class="card">
              <img
                class="card__image"
                src="assets/img/gallery2.png"
                alt="Huevo Primavera"
              />
              <div class="menu__info">
                <h3 class="card__title">Mieli Waffles</h3>
                <p class="card__text">
                  Deliciosos waffles caseros acompañados de uvas Isabel y fresas
                  frescas, bañados en miel dorada para un toque de dulzura
                  irresistible.
                </p>
                <div class="cart__price">
                  <p class="price">$22.000</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>
            <!-- end card -->
            <div class="card">
              <img
                class="card__image"
                src="assets/img/gallery3.png"
                alt="Huevo Primavera"
              />
              <div class="menu__info">
                <h3 class="card__title">Desayuno Tradicional</h3>
                <p class="card__text">
                  Un clásico desayuno con un toque gourmet: huevo al vapor
                  servido con pan tostado crujiente y una taza humeante de café
                  recién hecho.
                </p>
                <div class="cart__price">
                  <p class="price">$15.000</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>
            <!-- end card -->
            <div class="card">
              <img
                class="card__image"
                src="assets/img/gallery4.png"
                alt="Huevo Primavera"
              />
              <div class="menu__info">
                <h3 class="card__title">Waffles Frutales</h3>
                <p class="card__text">
                  Waffles esponjosos acompañados de uvas Isabel y fresas
                  frescas, una combinación refrescante y dulce para empezar el
                  día con energía.
                </p>
                <div class="cart__price">
                  <p class="price">$19.000</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>
            <!-- end card -->
            <div class="card">
              <img
                class="card__image"
                src="assets/img/gallery5.png"
                alt="Huevo Primavera"
              />
              <div class="menu__info">
                <h3 class="card__title">Desayuno Mediterráneo</h3>
                <p class="card__text">
                  Dos huevos al vapor acompañados de espárragos frescos, tomates
                  cherry, y pan árabe integral, todo bañado en nuestras salsas
                  caseras para una explosión de sabores.
                </p>
                <div class="cart__price">
                  <p class="price">$25.000</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>
            <!-- end card -->
            <div class="card">
              <img
                class="card__image"
                src="assets/img/gallery6.png"
                alt="Huevo Primavera"
              />
              <div class="menu__info">
                <h3 class="card__title">Pancake Fiesta</h3>
                <p class="card__text">
                  Pancakes esponjosos servidos con uvas Isabel, frijoles en
                  salsa de la casa y verduras frescas bañadas en crema casera,
                  una combinación única y deliciosa.
                </p>
                <div class="cart__price">
                  <p class="price">$23.000</p>
                  <i class="fa-solid fa-cart-plus"></i>
                </div>
              </div>
            </div>


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
      <section class="blog">
        <div class="blog__container">
          <h2 class="blog__title">Nuestros últimos blogs</h2>
          <div class="blog__content">
            <article class="entry">
              <div class="entry__img-container">
                <img
                  src="assets/img/blog1.jpg"
                  alt="Imagen de desayuno saludable"
                  class="entry__image"
                />
              </div>
              <div class="entry__info">
                <p class="entry__date">Febrero 5, 2024</p>
                <h3 class="entry__title">
                  Los Beneficios de un Desayuno Saludable
                </h3>
                <p class="entry__description">
                  Exploramos los numerosos beneficios para la salud de comenzar
                  el día con un desayuno nutritivo y equilibrado. Desde aumentar
                  la energía y la concentración hasta controlar el peso y
                  mejorar el estado de ánimo, descubrirás por qué el desayuno es
                  la comida más importante del día.
                </p>
                <a href="#" class="entry__btn"
                  >Continua leyendo...<i
                    class="fa-solid fa-book-open-reader"
                  ></i
                ></a>
              </div>
            </article>
            <!-- blog entry-->
            <article class="entry">
              <div class="entry__img-container">
                <img
                  src="assets/img/blog2.jpg"
                  alt="Imagen de desayuno saludable"
                  class="entry__image"
                />
              </div>
              <div class="entry__info">
                <p class="entry__date">Febrero 10, 2024</p>
                <h3 class="entry__title">
                  Explorando Nuevas Tendencias en Desayunos
                </h3>
                <p class="entry__description">
               Exploramos las últimas tendencias en salud y bienestar.
                Desde nuevas alternativas en suplementos y medicina natural,
                 hasta recomendaciones prácticas para mejorar tu calidad de vida. 
                 Inspirate a cuidar de vos mismo con información confiable y actualizada.

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
                  src="assets/img/blog3.jpg"
                  alt="Imagen de desayuno saludable"
                  class="entry__image"
                />
              </div>
              <div class="entry__info">
                <p class="entry__date">Febrero 15, 2024</p>
                <h3 class="entry__title">
                  Secretos de la mejor farmacia del mundo 
                </h3>
                <p class="entry__description">
              Recorremos el mundo para descubrir las prácticas de salud más destacadas en distintas culturas.  
Desde el uso ancestral de plantas medicinales hasta los hábitos modernos de autocuidado,  
te sorprenderá la diversidad de enfoques para mantenerse sano, prevenir enfermedades y vivir con bienestar en cada rincón del planeta.


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
            <img src="assets/img/footerlogo.png" alt="foodlover logo" />
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
            <h3>Restaurante</h3>
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
            <span>&copy; 2024 FoodLover.</span> Code and Design by
            JCodeCraftsman. All rights reserved.
          </p>
        </div>
      </div>
    </footer>

    <!-- custom script -->
    <script type="text/javascript" src="../assets/Funciones/app.js"></script>
    <script src="../assets/Funciones/customScrollReveal.js"></script>
  </body>
</html>

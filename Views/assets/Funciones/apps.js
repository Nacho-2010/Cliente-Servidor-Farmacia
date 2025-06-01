const header = document.querySelector('header');

window.addEventListener('scroll', () => {
  header.classList.toggle('sticky', window.scrollY > 10);
});


const menuIcon = document.querySelector('.fa-bars');
const menuLinks = document.querySelector('.header__nav-links');

menuIcon.addEventListener('click', () => {
  menuIcon.classList.toggle('fa-xmark');
  menuLinks.classList.toggle('open');
});
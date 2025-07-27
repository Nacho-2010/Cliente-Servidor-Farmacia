function mostrarSeccion(opcion) {
  // Oculta todas
  document.getElementById('seccion-registrar').classList.remove('seccion-activa');
  document.getElementById('seccion-eliminar').classList.remove('seccion-activa');
  document.getElementById('seccion-modificar').classList.remove('seccion-activa');

  // Muestra la seleccionada
  if (opcion === 'registrar') {
    document.getElementById('seccion-registrar').classList.add('seccion-activa');
  } else if (opcion === 'eliminar') {
    document.getElementById('seccion-eliminar').classList.add('seccion-activa');
  } else if (opcion === 'modificar') {
    document.getElementById('seccion-modificar').classList.add('seccion-activa');
  }
}
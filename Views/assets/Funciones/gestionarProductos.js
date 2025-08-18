function mostrarSeccion(opcion) {
  // Oculta todas
  document
    .getElementById("seccion-registrar")
    .classList.remove("seccion-activa");
  document
    .getElementById("seccion-eliminar")
    .classList.remove("seccion-activa");
  document
    .getElementById("seccion-modificar")
    .classList.remove("seccion-activa");

  // Muestra la seleccionada
  if (opcion === "registrar") {
    document
      .getElementById("seccion-registrar")
      .classList.add("seccion-activa");
  } else if (opcion === "eliminar") {
    document.getElementById("seccion-eliminar").classList.add("seccion-activa");
  } else if (opcion === "modificar") {
    document
      .getElementById("seccion-modificar")
      .classList.add("seccion-activa");
  }

  // para precargar el producto seleccionado
  document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("formCargarProducto");
    const cmb = document.getElementById("cmbProducto");

    if (!form || !cmb) return;

    cmb.addEventListener("change", () => {
      // inyecta el botón/flag para que el controller sepa que es precarga
      const h = document.createElement("input");
      h.type = "hidden";
      h.name = "btnCargarProducto";
      h.value = "1";
      form.appendChild(h);

      form.submit();
    });
  });
}

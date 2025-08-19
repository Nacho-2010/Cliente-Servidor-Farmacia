/***********************
 * Controles de cantidad
 ***********************/
function incQty(btn, max) {
  const input = btn.parentElement.querySelector('.qty-input');
  let v = parseInt(input.value || 1, 10);
  v = isNaN(v) ? 1 : v + 1;
  if (typeof max === 'number' && v > max) v = max;
  input.value = v;
}

function decQty(btn) {
  const input = btn.parentElement.querySelector('.qty-input');
  let v = parseInt(input.value || 1, 10);
  v = isNaN(v) ? 1 : v - 1;
  if (v < 1) v = 1;
  input.value = v;
}

function agregarDesdeCard(btn, codigoProducto, stockMax) {
  const input = btn.closest('.card').querySelector('.qty-input');
  let cantidad = parseInt(input?.value || 1, 10);
  if (isNaN(cantidad) || cantidad < 1) cantidad = 1;
  if (typeof stockMax === 'number' && cantidad > stockMax) {
    Swal.fire("Cantidad inválida", `Solo hay ${stockMax} disponibles.`, "warning");
    input.value = stockMax;
    return;
  }
  AgregarCarrito(codigoProducto, cantidad);
}


//Añade al carrito
function AgregarCarrito(codigoProducto, cantidad = 1) {
  cantidad = parseInt(cantidad, 10);
  if (!cantidad || cantidad < 1) {
    Swal.fire("Cantidad inválida", "La cantidad debe ser mayor a 0.", "warning");
    return;
  }

  const body = `Accion=AgregarCarrito&IdProducto=${encodeURIComponent(codigoProducto)}&Cantidad=${encodeURIComponent(cantidad)}`;

  fetch("/Cliente-Servidor-Farmacia/Controllers/carritoController.php", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    credentials: "same-origin",
    body,
  })
    .then((r) => r.text())
    .then((t) => {
      if ((t || "").trim() === "OK") {
        Swal.fire("Agregado", "El producto se agregó al carrito.", "success");
      } else {
        Swal.fire("Error", t || "El producto no fue agregado a su carrito.", "error");
      }
    })
    .catch(() => Swal.fire("Error", "Error al agregar producto", "error"));
}

// Actualiza la cantidad de un producto en el carrito
function actualizarCantidad(idDetalle, nuevaCantidad) {
  if (nuevaCantidad < 1) {
    Swal.fire("Error", "La cantidad debe ser mayor a cero.", "warning");
    return;
  }

  fetch("/Cliente-Servidor-Farmacia/Controllers/carritoController.php", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `accion=actualizar&id_detalle=${idDetalle}&cantidad=${nuevaCantidad}`,
  })
    .then((res) => res.json())
    .then((data) => {
      if (data.success) {
        Swal.fire("Actualizado", data.message, "success").then(() => {
          location.reload();
        });
      } else {
        Swal.fire("Error", data.message, "error");
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      Swal.fire("Error", "Ocurrió un error al actualizar.", "error");
    });
}

// Elimina un producto del carrito
function quitarProducto(idProducto) {
  Swal.fire({
    title: "¿Eliminar producto?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Sí, eliminar",
    cancelButtonText: "Cancelar",
  }).then((result) => {
    if (!result.isConfirmed) return;

    fetch("/Cliente-Servidor-Farmacia/Controllers/carritoController.php", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: `Accion=EliminarDelCarrito&IdProducto=${encodeURIComponent(idProducto)}`, 
    })
      .then((res) => res.text())   // <-- tu controller devuelve TEXTO
      .then((t) => {
        const r = (t || "").trim();
        if (r === "OK") {
          Swal.fire("Eliminado", "Producto eliminado del carrito.", "success")
            .then(() => location.reload());
        } else {
          Swal.fire("Error", r || "No se pudo eliminar.", "error");
        }
      })
      .catch((error) => {
        console.error("Error:", error);
        Swal.fire("Error", "Ocurrió un error al eliminar.", "error");
      });
  });
}

// Procesar la compra (aquí luego se conectará el SP de finalizar)
function procesarCompra() {
  Swal.fire({
    title: "¿Confirmar compra?",
    text: "Se procesará tu pedido.",
    icon: "question",
    showCancelButton: true,
    confirmButtonText: "Sí, comprar",
    cancelButtonText: "Cancelar",
  }).then((result) => {
    if (result.isConfirmed) {
      // Aquí luego se invocará el SP correspondiente
      Swal.fire("Compra procesada", "Gracias por tu compra.", "success").then(
        () => {
          location.reload();
        }
      );
    }
  });
}

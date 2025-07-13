<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/MovimientoModel.php";

date_default_timezone_set('America/Costa_Rica');

session_start();


// ===================================
// REGISTRAR MOVIMIENTO
// ===================================
if (isset($_POST["btnRegistrarMovimiento"])) {
    $codigo = $_POST["txtCodigo"];
    $lote = $_POST["txtLote"];
    $fecha_vencimiento = $_POST["txtFechaVencimiento"];
    $fecha = $_POST["txtFecha"];
    $tipo = 'Entrada';
    $cantidad = intval($_POST["txtCantidad"]);
    $descripcion = $_POST["txtDescripcion"];
    $empresa = isset($_POST["chkEmpresa"]) ? $_POST["txtEmpresa"] : '';

    if (empty($_POST["ddlFarmacia"])) {
        $_SESSION["txtMensaje"] = "❌ Debe seleccionar una farmacia válida.";
        header("Location: /Cliente-Servidor-Farmacia/Views/pages/kardex.php");
        exit();
    }

    $id_farmacia = intval($_POST["ddlFarmacia"]);

    $respuesta = InsertarMovimientoModel(
        $codigo,
        $lote,
        $fecha_vencimiento,
        $fecha,
        $tipo,
        $cantidad,
        $descripcion,
        $empresa,
        $id_farmacia
    );

    $_SESSION["CANT_DISPONIBLE"] = ObtenerStockDisponible($codigo, $id_farmacia);
    $_SESSION["MOVIMIENTOS"] = ObtenerHistorialKardex($codigo, $id_farmacia); // ✅ NUEVO
    $_SESSION["CODIGO_BUSCADO"] = $codigo;
    $_SESSION["FARMACIA_BUSCADA"] = $id_farmacia;

    $_SESSION["txtMensaje"] = $respuesta
        ? "✅ Movimiento registrado correctamente."
        : "❌ Error al registrar el movimiento.";

    header("Location: /Cliente-Servidor-Farmacia/Views/pages/kardex.php");
    exit();
}

// ===================================
// BUSCAR PRODUCTO
// ===================================
if (isset($_POST["btnBuscarProducto"])) {
    $codigo = $_POST["txtCodigo"];
    $id_farmacia = intval($_POST["ddlFarmaciaBuscar"]);

    $producto = BuscarProductoPorCodigo($codigo, $id_farmacia);

    if ($producto) {
        $_SESSION["CANT_DISPONIBLE"] = $producto["CANTIDAD_DISPONIBLE"];
        $_SESSION["NOMBRE_PRODUCTO"] = $producto["NOMBRE"];
        $_SESSION["UNIDAD_MEDIDA"] = $producto["UNIDAD"];
    } else {
        $_SESSION["CANT_DISPONIBLE"] = null;
        $_SESSION["NOMBRE_PRODUCTO"] = "Producto no encontrado";
        $_SESSION["UNIDAD_MEDIDA"] = "No definida";
    }

    $_SESSION["MOVIMIENTOS"] = ObtenerHistorialKardex($codigo, $id_farmacia); // ✅ NUEVO
    $_SESSION["CODIGO_BUSCADO"] = $codigo;
    $_SESSION["FARMACIA_BUSCADA"] = $id_farmacia;

    header("Location: /Cliente-Servidor-Farmacia/Views/pages/kardex.php");
    exit();
}

// ===================================
// SELECCIONAR LOTES DISPONIBLES PARA SALIDA AUTOMÁTICA
// ===================================
if (isset($_POST["btnSeleccionarLotes"])) {
    $codigo = $_POST["txtCodigo"];
    $id_farmacia = intval($_POST["ddlFarmaciaBuscar"]);
    $cantidad_solicitada = intval($_POST["txtCantidad"]);
    $fecha = date('Y-m-d');
    $descripcion = $_POST["txtDescripcion"];
    $empresa = isset($_POST["chkEmpresa"]) ? $_POST["txtEmpresa"] : '';

    $resultado = GenerarSalidaPorLotesModel(
        $codigo,
        $id_farmacia,
        $cantidad_solicitada,
        $fecha,
        $descripcion,
        $empresa
    );

    $_SESSION["CANT_DISPONIBLE"] = ObtenerStockDisponible($codigo, $id_farmacia);
    $_SESSION["MOVIMIENTOS"] = ObtenerHistorialKardex($codigo, $id_farmacia); // ✅ NUEVO
    $_SESSION["CODIGO_BUSCADO"] = $codigo;
    $_SESSION["FARMACIA_BUSCADA"] = $id_farmacia;

    $_SESSION["txtMensaje"] = $resultado
        ? "✅ Se aplicó correctamente la salida automática por lotes."
        : "❌ Error al aplicar salida automática. Verifique stock y datos.";

    header("Location: /Cliente-Servidor-Farmacia/Views/pages/kardex.php");
    exit();
}
?>
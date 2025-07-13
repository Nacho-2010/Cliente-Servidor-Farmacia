<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/Cliente-Servidor-Farmacia/Models/MovimientoModel.php";



session_start();


// ===================================
// REGISTRAR MOVIMIENTO
// ===================================
if (isset($_POST["btnRegistrarMovimiento"])) {
    $codigo = $_POST["txtCodigo"];
    $lote = $_POST["txtLote"];
    $fecha_vencimiento = $_POST["txtFechaVencimiento"];
    $fecha = $_POST["txtFecha"];
    $tipo = $_POST["ddlTipo"];
    $cantidad = intval($_POST["txtCantidad"]);
    $descripcion = $_POST["txtDescripcion"];
    $empresa = isset($_POST["chkEmpresa"]) ? $_POST["txtEmpresa"] : '';

    if (!isset($_POST["ddlFarmacia"]) || $_POST["ddlFarmacia"] == "") {
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

    // Actualizar stock
    $conexion = OpenDB();
    $queryInv = "SELECT CANTIDAD_DISPONIBLE 
                 FROM FIDE_INVENTARIO_TB 
                 WHERE CODIGO = '$codigo' AND ID_FARMACIA = $id_farmacia";
    $resInv = $conexion->query($queryInv);
    $_SESSION["CANT_DISPONIBLE"] = $resInv && $resInv->num_rows > 0
        ? $resInv->fetch_assoc()["CANTIDAD_DISPONIBLE"]
        : null;

    // Actualizar historial
    $queryMovs = "
        SELECT 
            Movs.FECHA_MOVIMIENTO,
            Movs.TIPO_MOVIMIENTO,
            CONCAT(IF(Movs.TIPO_MOVIMIENTO = 'Entrada', '+', '-'), Movs.CANTIDAD) AS CANTIDAD,
            @saldo := IFNULL(@saldo, 0) + 
                (CASE 
                    WHEN Movs.TIPO_MOVIMIENTO = 'Entrada' THEN Movs.CANTIDAD 
                    ELSE -Movs.CANTIDAD 
                END) AS SALDO
        FROM (
            SELECT M.FECHA_MOVIMIENTO, M.TIPO_MOVIMIENTO, M.CANTIDAD
            FROM FIDE_MOVIMIENTO_TB M
            JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
            WHERE I.CODIGO = '$codigo' AND M.ID_FARMACIA = $id_farmacia
            ORDER BY M.FECHA_MOVIMIENTO ASC
        ) AS Movs,
        (SELECT @saldo := 0) AS init
    ";
    $resMovs = $conexion->query($queryMovs);
    $historial = [];
    while ($row = $resMovs->fetch_assoc()) {
        $historial[] = $row;
    }

    $_SESSION["MOVIMIENTOS"] = $historial;
    $_SESSION["CODIGO_BUSCADO"] = $codigo;
    $_SESSION["FARMACIA_BUSCADA"] = $id_farmacia;

    CloseDB($conexion);

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

    $conexion = OpenDB();

    // Obtener inventario y datos del producto
    $queryInv = "
        SELECT 
            I.CANTIDAD_DISPONIBLE, 
            P.NOMBRE, 
            U.NOMBRE AS UNIDAD_MEDIDA
        FROM FIDE_INVENTARIO_TB I
        JOIN FIDE_PRODUCTO_TB P ON I.CODIGO = P.CODIGO
        JOIN FIDE_UNIDAD_MEDIDA_TB U ON P.ID_UNIDAD_MEDIDA = U.ID_UNIDAD_MEDIDA
        WHERE I.CODIGO = '$codigo' AND I.ID_FARMACIA = $id_farmacia
    ";
    $resInv = $conexion->query($queryInv);

    if ($resInv && $resInv->num_rows > 0) {
        $row = $resInv->fetch_assoc();
        $_SESSION["CANT_DISPONIBLE"] = $row["CANTIDAD_DISPONIBLE"];
        $_SESSION["NOMBRE_PRODUCTO"] = $row["NOMBRE"];
        $_SESSION["UNIDAD_MEDIDA"] = $row["UNIDAD_MEDIDA"];
    } else {
        $_SESSION["CANT_DISPONIBLE"] = null;
        $_SESSION["NOMBRE_PRODUCTO"] = "Producto no encontrado";
        $_SESSION["UNIDAD_MEDIDA"] = "No definida";
    }

    // Obtener historial
    $queryMovs = "
        SELECT 
            Movs.FECHA_MOVIMIENTO,
            Movs.TIPO_MOVIMIENTO,
            CONCAT(IF(Movs.TIPO_MOVIMIENTO = 'Entrada', '+', '-'), Movs.CANTIDAD) AS CANTIDAD,
            @saldo := IFNULL(@saldo, 0) + 
                (CASE 
                    WHEN Movs.TIPO_MOVIMIENTO = 'Entrada' THEN Movs.CANTIDAD 
                    ELSE -Movs.CANTIDAD 
                END) AS SALDO
        FROM (
            SELECT M.FECHA_MOVIMIENTO, M.TIPO_MOVIMIENTO, M.CANTIDAD
            FROM FIDE_MOVIMIENTO_TB M
            JOIN FIDE_INVENTARIO_TB I ON M.ID_INVENTARIO = I.ID_INVENTARIO
            WHERE I.CODIGO = '$codigo' AND M.ID_FARMACIA = $id_farmacia
            ORDER BY M.FECHA_MOVIMIENTO ASC
        ) AS Movs,
        (SELECT @saldo := 0) AS init
    ";
    $resMovs = $conexion->query($queryMovs);
    $historial = [];
    while ($row = $resMovs->fetch_assoc()) {
        $historial[] = $row;
    }

    $_SESSION["MOVIMIENTOS"] = $historial;
    $_SESSION["CODIGO_BUSCADO"] = $codigo;
    $_SESSION["FARMACIA_BUSCADA"] = $id_farmacia;

    CloseDB($conexion);
    header("Location: /Cliente-Servidor-Farmacia/Views/pages/kardex.php");
    exit();
}
?>
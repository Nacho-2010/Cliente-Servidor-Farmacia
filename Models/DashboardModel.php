<?php
require_once __DIR__ . '/connect.php';

function limpiarResultados($cn) {
    while (mysqli_more_results($cn)) {
        mysqli_next_result($cn);
        if ($tmp = mysqli_store_result($cn)) { mysqli_free_result($tmp); }
    }
}

function ConsultarProductosTopModel($limit = 8) {
    try {
        $cn = OpenDB();
        // Si tu SP NO recibe parámetro, usa: $res = $cn->query("CALL ConsultarProductosTop()");
        $stmt = mysqli_prepare($cn, "CALL ConsultarProductosTop(?)");
        mysqli_stmt_bind_param($stmt, "i", $limit);
        mysqli_stmt_execute($stmt);
        $rs = mysqli_stmt_get_result($stmt);
        $rows = $rs ? $rs->fetch_all(MYSQLI_ASSOC) : [];
        if ($rs) $rs->free();
        limpiarResultados($cn);
        mysqli_stmt_close($stmt);
        return $rows;             // <-- array
    } finally { CloseDB($cn); }
}

function ConsultarClientesTopModel($limit = 8) {
    try {
        $cn = OpenDB();
        $stmt = mysqli_prepare($cn, "CALL ConsultarClientesTop(?)");
        mysqli_stmt_bind_param($stmt, "i", $limit);
        mysqli_stmt_execute($stmt);
        $rs = mysqli_stmt_get_result($stmt);
        $rows = $rs ? $rs->fetch_all(MYSQLI_ASSOC) : [];
        if ($rs) $rs->free();
        limpiarResultados($cn);
        mysqli_stmt_close($stmt);
        return $rows;             // <-- array
    } finally { CloseDB($cn); }
}

function ConsultarResumenTopModel() {
    try {
        $cn = OpenDB();
        $rs = $cn->query("CALL ConsultarResumenTop()");
        $row = $rs ? $rs->fetch_assoc() : null;
        if ($rs) $rs->free();
        limpiarResultados($cn);
        return $row ?: [
            "ClientesActivos"=>0,"ClientesInactivos"=>0,
            "ProductosActivos"=>0,"ProductosInactivos"=>0
        ];
    } finally { CloseDB($cn); }
}

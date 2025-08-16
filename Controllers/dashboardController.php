<?php
require_once __DIR__ . '/../Models/DashboardModel.php';

function ConsultarProductosTop($limit = 8) {
    return ConsultarProductosTopModel($limit);
}

function ConsultarClientesTop($limit = 8) {
    return ConsultarClientesTopModel($limit);
}

function ConsultarResumenTop() {
    $row = ConsultarResumenTopModel();
    return $row ?: [
        "ClientesActivos"    => 0,
        "ClientesInactivos"  => 0,
        "ProductosActivos"   => 0,
        "ProductosInactivos" => 0
    ];
}

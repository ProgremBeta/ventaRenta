import * as respository from './detalles_ventas.repository.js';

export const obtenerDetallesVentas = async (req, res) => {
    const result = await respository.obtenerDetallesVentas();
    
    console.log("resultado de detalle de venta en service: ", result);

    return result;
};

export const obtenerDetalleVentaPorId = async (id) => {
    const result = await respository.obtenerDetalleVentaPorId(id);
    return result.rows;
};

export const crearDetalleVenta = async (data) => {
    const result = await respository.crearDetalleVenta(data.id_venta, data.id_producto, data.cantidad, data.precio_unitario);
    return result.rows;
};

export const actualizarDetalleVenta = async (id, data) => {
    const result = await respository.actualizarDetalleVenta(id, data.id_venta, data.id_producto, data.cantidad, data.precio_unitario);
    return result.rows;
};

export const eliminarDetalleVenta = async (id) => {
    const result = await respository.eliminarDetalleVenta(id);
    return result.rows;
};
import * as respository from './detalles_ventas.repository.js';

export const obtenerDetallesVentas = async (req, res) => {
    const result = await respository.obtenerDetallesVentas();
    return result[0];
};

export const obtenerDetalleVentaPorId = async (id) => {
    const result = await respository.obtenerDetalleVentaPorId(id);
    return result[0];
};

export const crearDetalleVenta = async (data) => {
    const result = await respository.crearDetalleVenta(data.id_venta, data.id_producto, data.cantidad, data.precio_unitario);
    return result[0];
};

export const actualizarDetalleVenta = async (id, data) => {
    const result = await respository.actualizarDetalleVenta(id, data.id_venta, data.id_producto, data.cantidad, data.precio_unitario);
    return result[0];
};

export const eliminarDetalleVenta = async (id) => {
    const result = await respository.eliminarDetalleVenta(id);
    return result[0];
};
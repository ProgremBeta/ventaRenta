import * as respository from './detalles_ventas.repository.js';

export const obtenerDetallesVentas = async (req, res) => {
    const result = await respository.obtenerDetallesVentas();
    return result.rows;
};

export const obtenerDetalleVentaPorId = async (id) => {
    const result = await respository.obtenerDetalleVentaPorId(id);
    return result.rows;
};

export const crearDetalleVenta = async (datos) => {
    const result = await respository.crearDetalleVenta(datos);
    return result.rows;
};

export const actualizarDetalleVenta = async (id, datos) => {
    const result = await respository.actualizarDetalleVenta(id,datos);
    return result.rows;
};

export const eliminarDetalleVenta = async (id) => {
    const result = await respository.eliminarDetalleVenta(id);
    return result.rows;
};
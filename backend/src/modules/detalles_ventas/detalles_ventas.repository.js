import pool from './../../config/db.config.js';

export const obtenerDetallesVentas = async () => {
  return await pool.query('SELECT * FROM detalle_ventas');
};

export const obtenerDetalleVentaPorId = async (id) => {
  return await pool.query('SELECT * FROM detalle_ventas WHERE id =$1', [id]);
};

export const crearDetalleVenta = async (datos) => {
  return await pool.query('INSERT INTO detalle_ventas (venta_id, producto_id, cantidad, precio_unitario) VALUES ($1, $2, $3, $4) RETURNING *', [datos.venta_id, datos.producto_id, datos.cantidad, datos.precio_unitario]);
};

export const actualizarDetalleVenta = async (id, datos) => {
  return await pool.query('UPDATE detalle_ventas SET venta_id=$1, producto_id=$2, cantidad=$3, precio_unitario=$4 WHERE id=$5 RETURNING *', [datos.venta_id, datos.producto_id, datos.cantidad, datos.precio_unitario, id]);
};

export const eliminarDetalleVenta = async (id) => {
  return await pool.query('DELETE FROM detalle_ventas WHERE id=$1 RETURNING *', [id]);
};
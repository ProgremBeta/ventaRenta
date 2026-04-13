import pool from './../../config/db.config.js';

export const obtenerDetallesVentas = async () => {
  return await pool.query('SELECT * FROM detalles_ventas');
};

export const obtenerDetalleVentaPorId = async (id) => {
  return await pool.query('SELECT * FROM detalles_ventas WHERE id =$1', [id]);
};

export const crearDetalleVenta = async (datos) => {
  return await pool.query(`
    INSERT INTO detalles_ventas (
      venta_id,
      producto_id,
      cantidad,
      precio_unitario,
      sub_total
    ) VALUES ($1, $2, $3, $4, $5) RETURNING *`,
    [
      datos.venta_id,
      datos.producto_id,
      datos.cantidad,
      datos.precio_unitario,
      datos.sub_total
    ]);
};

export const actualizarDetalleVenta = async (id, datos) => {
  return await pool.query(`
    UPDATE detalles_ventas SET 
      venta_id=$1,
      producto_id=$2,
      cantidad=$3,
      precio_unitario=$4,
      sub_total=$5 
    WHERE id=$6 RETURNING *`,
    [
      datos.venta_id,
      datos.producto_id,
      datos.cantidad,
      datos.precio_unitario,
      datos.sub_total,
      id
    ]);
};

export const eliminarDetalleVenta = async (id) => {
  return await pool.query('DELETE FROM detalles_ventas WHERE id=$1 RETURNING *', [id]);
};
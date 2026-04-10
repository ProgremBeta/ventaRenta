import pool from '../../config/db.config.js';

export const obtenerVentas = async () => {
  return await pool.query('SELECT * FROM ventas');
};

export const obtenerVentaPorId = async (id) => {
  return await pool.query('SELECT * FROM ventas WHERE id = $1', [id]);
};

export const crearVenta = async (datos) => {
  return await pool.query('INSERT INTO ventas (usuario_id ,cliente_id, total, metodo_pago) VALUES ($1, $2, $3, $4) RETURNING *', [datos.usuario_id, datos.cliente_id, datos.total, datos.metodo_pago]);
};

export const actualizarVenta = async (id, datos) => {
  return await pool.query('UPDATE ventas SET usuario_id=$1, cliente_id=$2, total=$3, metodo_pago=$4 WHERE id=$5 RETURNING *', [datos.usuario_id, datos.cliente_id, datos.total, datos.metodo_pago, id]);
};

export const eliminarVenta = async (id) => {
  return await pool.query('DELETE FROM ventas WHERE id=$1', [id]);
}
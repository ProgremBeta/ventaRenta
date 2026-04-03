import pool from './../../config/db.config.js';

export const obtenerRentas = async () => {
  return await pool.query('SELECT * FROM rentas');
};

export const obtenerRentaPorId = async (id) => {
  return await pool.query('SELECT * FROM rentas WHERE id =$1', [id]);
};

export const crearRenta = async (datos) => {
  return await pool.query('INSERT INTO rentas (cliente_id, usuario_id, fecha_inicio, fecha_fin, tiempo_total, metodo_pago, estado) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *', [datos.cliente_id, datos.usuario_id, datos.fecha_inicio, datos.fecha_fin, datos.tiempo_total, datos.metodo_pago, datos.estado]);
};

export const actualizarRenta = async (id, datos) => {
  return await pool.query('UPDATE rentas SET cliente_id=$1, usuario_id=$2, fecha_inicio=$3, fecha_fin=$4, tiempo_total=$5, metodo_pago=$6, estado=$7 WHERE id=$8 RETURNING *', [datos.cliente_id, datos.usuario_id, datos.fecha_inicio, datos.fecha_fin, datos.tiempo_total, datos.metodo_pago, datos.estado, id]);
};

export const eliminarRenta = async (id) => {
  return await pool.query('DELETE FROM rentas WHERE id=$1 RETURNING *', [id]);
};
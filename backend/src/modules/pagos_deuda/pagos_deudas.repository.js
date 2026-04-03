import pool from './../../config/db.config.js';

export const obtenerPagosDeudas = async () => {
  return await pool.query('SELECT * FROM pagos_deuda');
};

export const obtenerPagoDeudaPorId = async (id) => {
  return await pool.query('SELECT * FROM pagos_deuda WHERE id =$1', [id]);
};

export const crearPagoDeuda = async (datos) => {
  return await pool.query('INSERT INTO pagos_deuda (deuda_id, monto, metodo_pago) VALUES ($1, $2, $3) RETURNING *', [datos.deuda_id, datos.monto, datos.metodo_pago]);
};

export const actualizarPagoDeuda = async (id, datos) => {
  return await pool.query('UPDATE pagos_deuda SET deuda_id=$1, monto=$2, metodo_pago=$3 WHERE id=$4 RETURNING *', [datos.deuda_id, datos.monto, datos.metodo_pago, id]);
};

export const eliminarPagoDeuda = async (id) => {
  return await pool.query('DELETE FROM pagos_deuda WHERE id=$1 RETURNING *', [id]);
};
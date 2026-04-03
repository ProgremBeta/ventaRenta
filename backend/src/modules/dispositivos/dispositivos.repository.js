import pool from './../../config/db.config.js';

export const obtenerDispositivos = async () => {
  return await pool.query('SELECT * FROM dispositivos');
};

export const obtenerDispositivoPorId = async (id) => {
  return await pool.query('SELECT * FROM dispositivos WHERE id =$1', [id]);
};

export const crearDispositivo = async (datos) => {
  return await pool.query('INSERT INTO dispositivos (nombre, categoria_id, estado) VALUES ($1, $2, $3) RETURNING *', [datos.nombre, datos.categoria_id, datos.estado]);
};

export const actualizarDispositivo = async (id, datos) => {
  return await pool.query('UPDATE dispositivos SET nombre=$1, categoria_id=$2, estado=$3 WHERE id=$4 RETURNING *', [datos.nombre, datos.categoria_id, datos.estado, id]);
};

export const eliminarDispositivo = async (id) => {
  return await pool.query('DELETE FROM dispositivos WHERE id=$1 RETURNING *', [id]);
};
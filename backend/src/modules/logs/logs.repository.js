import pool from './../../config/db.config.js';

export const obtenerLogs = async () => {
  return await pool.query('SELECT * FROM logs');
};

export const obtenerLogPorId = async (id) => {
  return await pool.query('SELECT * FROM logs WHERE id =$1', [id]);
};

export const crearLog = async (datos) => {
  return await pool.query('INSERT INTO logs (usuario_id,accion,descripcion) VALUES ($1, $2, $3) RETURNING *', [datos.usuario_id, datos.accion, datos.descripcion]);
};

export const actualizarLog = async (id, datos) => {
  return await pool.query('UPDATE logs SET accion=$1, usuario_id=$2, descripcion=$3 WHERE id=$4 RETURNING *', [datos.accion, datos.usuario_id, datos.descripcion, id]);
};

export const eliminarLog = async (id) => {
  return await pool.query('DELETE FROM logs WHERE id=$1 RETURNING *', [id]);
};
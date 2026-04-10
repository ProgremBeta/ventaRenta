import pool from './../../config/db.config.js';

/*peticiones para obtener los datos de la base de datos*/

export const obtenerAlertas = async () => {
  return await pool.query('SELECT * FROM alertas');
};

export const obtenerAlertasPorId = async (id) => {
  return await pool.query('SELECT * FROM alertas WHERE id =$1', [id]);
};

export const crearAlertas = async (datos) => {
  return await pool.query('INSERT INTO alertas (usuario_id, tipo, descripcion, leida) VALUES ($1,$2,$3,$4) RETURNING *', [datos.usuario_id, datos.tipo, datos.descripcion, datos.leida]);
};

export const actualizarAlerta = async (id, datos) => {
  return await pool.query('UPDATE alertas SET usuario_id=$1, tipo=$2, descripcion=$3, leida=$4 WHERE id=$5 RETURNING *', [datos.usuario_id, datos.tipo, datos.descripcion, datos.leida, id]);
};

export const eliminarAlerta = async (id) => {
  return await pool.query('DELETE FROM alertas WHERE id=$1 RETURNING *', [id]);
};
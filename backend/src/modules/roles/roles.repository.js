import pool from './../../config/db.config.js';

export const obtenerRoles = async () => {
  return await pool.query('SELECT * FROM roles');
};

export const obtenerRolPorId = async (id) => {
  return await pool.query('SELECT * FROM roles WHERE id =$1', [id]);
};

export const crearRol = async (datos) => {
  return await pool.query('INSERT INTO roles (nombre) VALUES ($1) RETURNING *', [datos.nombre]);
};

export const actualizarRol = async (id, datos) => {
  return await pool.query('UPDATE roles SET nombre=$1 WHERE id=$2 RETURNING *', [datos.nombre, id]);
};

export const eliminarRol = async (id) => {
  return await pool.query('DELETE FROM roles WHERE id=$1 RETURNING *', [id]);
};
import pool from './../../config/db.config.js';

export const obtenerProductos = async () => {
  return await pool.query('SELECT * FROM productos');
};

export const obtenerProductoPorId = async (id) => {
  return await pool.query('SELECT * FROM productos WHERE id =$1', [id]);
};

export const crearProducto = async (datos) => {
  return await pool.query('INSERT INTO productos (nombre,descripcion, precio, categoria_id) VALUES ($1, $2, $3, $4) RETURNING *', [datos.nombre, datos.descripcion, datos.precio, datos.categoria_id]);
};

export const actualizarProducto = async (id, datos) => {
  return await pool.query('UPDATE productos SET nombre=$1, descripcion=$2, precio=$3, categoria_id=$4 WHERE id=$5 RETURNING *', [datos.nombre, datos.descripcion, datos.precio, datos.categoria_id, id]);
};

export const eliminarProducto = async (id) => {
  return await pool.query('DELETE FROM productos WHERE id=$1 RETURNING *', [id]);
};
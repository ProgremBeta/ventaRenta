import pool from './../../config/db.config.js';

export const obtenerCategoriasProductos = async () => {
  return await pool.query('SELECT * FROM categorias_producto');
};

export const obtenerCategoriaProductoPorId = async (id) => {
  return await pool.query('SELECT * FROM categorias_producto WHERE id =$1', [id]);
};

export const crearCategoriaProducto = async (datos) => {
  return await pool.query('INSERT INTO categorias_producto (nombre) VALUES ($1) RETURNING *', [datos.nombre]);
};

export const actualizarCategoriaProducto = async (id, datos) => {
  return await pool.query('UPDATE categorias_producto SET nombre=$1 WHERE id=$2 RETURNING *', [datos.nombre, id]);
};

export const eliminarCategoriaProducto = async (id) => {
  return await pool.query('DELETE FROM categorias_producto WHERE id=$1 RETURNING *', [id]);
};
import pool from './../../config/db.config.js';

export const obtenerCategoriasProductos = async () => {
  return await pool.query('SELECT * FROM categorias_productos');
};

export const obtenerCategoriaProductoPorId = async (id) => {
  return await pool.query('SELECT * FROM categorias_productos WHERE id=$1', [id]);
};

export const crearCategoriaProducto = async (datos) => {
  return await pool.query(`
    INSERT INTO categorias_productos(
      nombre,
      descripcion,
      activo
    ) VALUES ($1,$2,$3) RETURNING *`,
    [
      datos.nombre,
      datos.descripcion,
      datos.activo
    ]);
};

export const actualizarCategoriaProducto = async (id, datos) => {
  return await pool.query(`
    UPDATE categorias_productos SET 
      nombre=$1,
      descripcion=$2,
      activo=$3
    WHERE id=$4 RETURNING *`,
    [
      datos.nombre,
      datos.descripcion,
      datos.activo,
      id
    ]);
};

export const eliminarCategoriaProducto = async (id) => {
  return await pool.query('DELETE FROM categorias_productos WHERE id=$1 RETURNING *', [id]);
};
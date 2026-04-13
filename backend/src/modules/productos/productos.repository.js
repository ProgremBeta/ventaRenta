import pool from './../../config/db.config.js';

export const obtenerProductos = async () => {
  return await pool.query('SELECT * FROM productos');
};

export const obtenerProductoPorId = async (id) => {
  return await pool.query('SELECT * FROM productos WHERE id =$1', [id]);
};

export const crearProducto = async (datos) => {
  return await pool.query(`
    INSERT INTO productos (
      nombre,
      descripcion,
      precio,
      categoria_id,
      activo
    ) VALUES ($1, $2, $3, $4) RETURNING *`,
    [
      datos.nombre,
      datos.descripcion,
      datos.precio,
      datos.categoria_id,
      datos.activo
    ]);
};

export const actualizarProducto = async (id, datos) => {
  return await pool.query(`
    UPDATE productos SET 
      nombre=$1, 
      descripcion=$2, 
      precio=$3, 
      categoria_id=$4,
      activo=$5
    WHERE id=$6 RETURNING *`,
    [
      datos.nombre,
      datos.descripcion,
      datos.precio,
      datos.categoria_id,
      datos.activo,
      id
    ]);
};

export const eliminarProducto = async (id) => {
  return await pool.query('DELETE FROM productos WHERE id=$1 RETURNING *', [id]);
};
import pool from '../../config/db.config.js';

export const obtenerInventarioProductos = async () => {
  return await pool.query('SELECT * FROM inventario_productos');
};

export const obtenerInventarioProductoPorId = async (id) => {
  return await pool.query('SELECT * FROM inventario_productos WHERE id = $1', [id]);
};

export const obtenerInventarioPorProductoId = async (producto_id) => {
  return await pool.query('SELECT * FROM inventario_productos WHERE producto_id = $1', [producto_id]);
};

export const descontarStock = async (id, cantidad) => {
  return await pool.query(`
    UPDATE inventario_productos SET 
      stock = $1 
    WHERE producto_id = $2 RETURNING *`,
    [
      cantidad,
      id
    ]);
};

export const crearInventarioProducto = async (datos) => {
  return await pool.query(`
    INSERT INTO inventario_productos (
      producto_id,
      stock,
      stock_minimo,
      activo
    ) VALUES ($1, $2, $3, $4) RETURNING *`,
    [
      datos.producto_id,
      datos.stock,
      datos.stock_minimo,
      datos.activo
    ]);
};

export const actualizarInventarioProducto = async (id, datos) => {
  return await pool.query(`
    UPDATE inventario_productos SET 
      producto_id=$1,
      stock=$2,
      stock_minimo=$3,
      activo=$4
    WHERE id=$5 RETURNING *`,
    [
      datos.producto_id,
      datos.stock,
      datos.stock_minimo,
      datos.activo,
      id
    ]);
};

export const eliminarInventarioProducto = async (id) => {
  return await pool.query('DELETE FROM inventario_productos WHERE id=$1', [id]);
}
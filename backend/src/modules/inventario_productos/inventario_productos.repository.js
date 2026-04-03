import pool from '../../config/db.config.js';

console.log("Cargando repositorio de inventario...");

export const obtenerInventarioProductos = async () => {
  return await pool.query('SELECT * FROM inventario_productos');
};

export const obtenerInventarioProductoPorId = async (id) => {
  return await pool.query('SELECT * FROM inventario_productos WHERE id = $1', [id]);
};

export const crearInventarioProducto = async (datos) => {
  return await pool.query('INSERT INTO inventario_productos (producto_id, stock) VALUES ($1, $2) RETURNING *', [datos.producto_id, datos.stock]);
};

export const actualizarInventarioProducto = async (id, datos) => {
  return await pool.query('UPDATE inventario_productos SET producto_id=$1, stock=$2 WHERE id=$3 RETURNING *', [datos.producto_id, datos.stock, id]);
};

export const eliminarInventarioProducto = async (id) => {
  return await pool.query('DELETE FROM inventario_productos WHERE id=$1', [id]);
}
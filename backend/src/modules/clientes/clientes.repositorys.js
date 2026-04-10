import pool from './../../config/db.config.js';

export const obtenerClientes = async () => {
  return await pool.query('SELECT * FROM clientes');
};

export const obtenerClientePorId = async (id) => {
  return await pool.query('SELECT * FROM clientes WHERE id =$1', [id]);
};

export const sumarPuntosCliente = async (cliente_id, puntos) => {
  return await pool.query('UPDATE clientes SET puntos = puntos + $1 WHERE id = $2 RETURNING *', [puntos, cliente_id]);
};

export const crearCliente = async (datos) => {
  return await pool.query('INSERT INTO clientes (nombre, email, telefono) VALUES ($1, $2, $3) RETURNING *', [datos.nombre, datos.email, datos.telefono]);
};

export const actualizarCliente = async (id, datos) => {
  return await pool.query('UPDATE clientes SET nombre=$1, email=$2, telefono=$3 WHERE id=$4 RETURNING *', [datos.nombre, datos.email, datos.telefono, id]);
};

export const eliminarCliente = async (id) => {
  return await pool.query('DELETE FROM clientes WHERE id=$1 RETURNING *', [id]);
};
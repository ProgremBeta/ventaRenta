import pool from './../../config/db.config.js';

export const obtenerRentaDispositivos = async () => {
  return await pool.query('SELECT * FROM renta_dispositivos');
};

export const obtenerRentaDispositivoPorId = async (id) => {
  return await pool.query('SELECT * FROM renta_dispositivos WHERE id =$1', [id]);
};

export const crearRentaDispositivo = async (datos) => {
  return await pool.query('INSERT INTO renta_dispositivos (renta_id, dispositivo_id, precio_hora) VALUES ($1, $2, $3) RETURNING *', [datos.cliente_id, datos.dispositivo_id, datos.precio_hora]);
};

export const actualizarRentaDispositivo = async (id, datos) => {
  return await pool.query('UPDATE renta_dispositivos SET renta_id=$1, dispositivo_id=$2, precio_hora=$3 WHERE id=$4 RETURNING *', [datos.cliente_id, datos.dispositivo_id, datos.precio_hora, id]);
};

export const eliminarRentaDispositivo = async (id) => {
  return await pool.query('DELETE FROM renta_dispositivos WHERE id=$1 RETURNING *', [id]);
};
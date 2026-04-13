import pool from './../../config/db.config.js';

export const obtenerDispositivos = async () => {
  return await pool.query('SELECT * FROM dispositivos');
};

export const obtenerDispositivoPorId = async (id) => {
  return await pool.query('SELECT * FROM dispositivos WHERE id =$1', [id]);
};

export const crearDispositivo = async (datos) => {
  return await pool.query(`
    INSERT INTO dispositivos (
      nombre,
      categoria_id,
      precio_hora,
      estado,
      activo
    ) VALUES ($1, $2, $3, $4, $5) RETURNING *`,
    [
      datos.nombre,
      datos.categoria_id,
      datos.precio_hora,
      datos.estado,
      datos.activo
    ]);
};

export const actualizarDispositivo = async (id, datos) => {
  return await pool.query(`
    UPDATE dispositivos SET 
      nombre=$1,
      categoria_id=$2,
      precio_hora=$3,
      estado=$4,
      activo=$5
    WHERE id=$6 RETURNING *`,
    [
      datos.nombre,
      datos.categoria_id,
      datos.precio_hora,
      datos.estado,
      datos.activo,
      id
    ]);
};

export const eliminarDispositivo = async (id) => {
  return await pool.query('DELETE FROM dispositivos WHERE id=$1 RETURNING *', [id]);
};
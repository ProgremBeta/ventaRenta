import pool from '../../config/db.config.js';

export const obtenerRenta = async () => {
  return await pool.query('SELECT * FROM detalles_rentas');
};

export const obtenerRentaPorId = async (id) => {
  return await pool.query('SELECT * FROM detalles_rentas WHERE id =$1', [id]);
};

export const crearRenta = async (datos) => {
  return await pool.query(`
    INSERT INTO detalles_rentas (
      renta_id,
      dispositivo_id,
      precio_hora,
      tiempo_total,
      sub_total
    ) VALUES ($1, $2, $3, $4, $5) RETURNING *`,
    [
      datos.renta_id,
      datos.dispositivo_id,
      datos.precio_hora,
      datos.tiempo_total,
      datos.sub_total
    ]);
};

export const actualizarRenta = async (id, datos) => {
  return await pool.query(`
    UPDATE detalles_rentas SET 
      renta_id=$1,
      dispositivo_id=$2,
      precio_hora=$3 
    WHERE id=$4 RETURNING *`,
    [
      datos.renta_id,
      datos.dispositivo_id,
      datos.precio_hora,
      id
    ]);
};

export const eliminarRenta = async (id) => {
  return await pool.query('DELETE FROM detalles_rentas WHERE id=$1 RETURNING *', [id]);
};